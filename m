Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5F64B714D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 16:52:13 +1100 (EST)
Message-ID: <4D6C89A7.8010803@embedded-sol.com>
Date: Tue, 01 Mar 2011 07:52:39 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
	<4D6C134C.4070407@embedded-sol.com>
	<20110301002156.GC31428@ovro.caltech.edu>
In-Reply-To: <20110301002156.GC31428@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

On 03/01/2011 02:21 AM, Ira W. Snyder wrote:
> On Mon, Feb 28, 2011 at 11:27:40PM +0200, Felix Radensky wrote:
>> Hi Ira,
>>
>> On 02/28/2011 11:11 PM, Ira W. Snyder wrote:
>>> On Mon, Feb 28, 2011 at 10:15:49PM +0200, Felix Radensky wrote:
>>>> Hi Ira,
>>>>
>>>>> Thank you very much Felix. The dmesg output shows that the controller
>>>>> never got an interrupt for the second transaction. The patch below has
>>>>> extra debugging information that may help determine why this happens.
>>>>> Please apply it and re-run the test.
>>>>>
>>>>> The last section of dmesg (after "Freeing unused kernel memory") is all
>>>>> I need.
>>>>>
>>>> Attached relevant dmesg portion.
>>>>
>>> Ok, try this patch on top of the last one.
>>>
>>> It looks like you used the dmatest module in multi-channel mode last
>>> time. One channel makes it easier to debug:
>>>
>>> modprobe dmatest max_channels=1 threads_per_chan=2 iterations=1
>>>
>>> Thanks for your help in debugging this. Hopefully this is the last
>>> patch to test. :)
>>>
>>> Ira
>>>
>> Looks like this was not the last one. The test still fails, see below
>>
>  From this log, it looks like the DMA controller is not generating an
> interrupt after the second chain is started. The first chain is finished
> before the second thread runs and starts its chain.
>
> The end-of-segments interrupt is completely missing. The part is not
> behaving as the datasheet explains it should. Are you sure you applied
> the patch and rebuilt the kernel? (Just checking to be sure. I'm very
> appreciative of the amount of help you've given me debugging this!)
>
> Can you run this for me:
>
> modprobe dmatest max_channels=1 threads_per_chan=1 iterations=4
>
> Thanks again,
> Ira

Without your patches applied the output of the test above looks
like this:

__dma_request_channel: success (dma0chan0)
dmatest: Started 1 threads using dma0chan0
of:fsl-elo-dma ffe0c300.dma: irq: channel 0, stat = 0xa
of:fsl-elo-dma ffe0c300.dma: irq: End-of-segments INT
of:fsl-elo-dma ffe0c300.dma: irq: clndar 0x2f34d000, nlndar 0x100000000
of:fsl-elo-dma ffe0c300.dma: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: no pending LDs
of:fsl-elo-dma ffe0c300.dma: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 1
of:fsl-elo-dma ffe0c300.dma: LD ef34d000 callback
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 1
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #0: No errors with src_off=0xb90 dst_off=0x101c 
len=0x2aea
of:fsl-elo-dma ffe0c300.dma: irq: channel 0, stat = 0xa
of:fsl-elo-dma ffe0c300.dma: irq: End-of-segments INT
of:fsl-elo-dma ffe0c300.dma: irq: clndar 0x2f34d000, nlndar 0x100000000
of:fsl-elo-dma ffe0c300.dma: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: no pending LDs
of:fsl-elo-dma ffe0c300.dma: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 2
of:fsl-elo-dma ffe0c300.dma: LD ef34d000 callback
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 2
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #1: No errors with src_off=0x74a dst_off=0x54d len=0x35f5
of:fsl-elo-dma ffe0c300.dma: irq: channel 0, stat = 0xa
of:fsl-elo-dma ffe0c300.dma: irq: End-of-segments INT
of:fsl-elo-dma ffe0c300.dma: irq: clndar 0x2f34d000, nlndar 0x100000000
of:fsl-elo-dma ffe0c300.dma: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: no pending LDs
of:fsl-elo-dma ffe0c300.dma: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 3
of:fsl-elo-dma ffe0c300.dma: LD ef34d000 callback
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 3
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #2: No errors with src_off=0x2ad dst_off=0x557 len=0x35e1
of:fsl-elo-dma ffe0c300.dma: irq: channel 0, stat = 0xa
of:fsl-elo-dma ffe0c300.dma: irq: End-of-segments INT
of:fsl-elo-dma ffe0c300.dma: irq: clndar 0x2f34d000, nlndar 0x100000000
of:fsl-elo-dma ffe0c300.dma: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: no pending LDs
of:fsl-elo-dma ffe0c300.dma: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 4
of:fsl-elo-dma ffe0c300.dma: LD ef34d000 callback
of:fsl-elo-dma ffe0c300.dma: chan completed_cookie = 4
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #3: No errors with src_off=0x0 dst_off=0x0 len=0x4000
dma0chan0-copy0: terminating after 4 tests, 0 failures (status 0)

Felix.
