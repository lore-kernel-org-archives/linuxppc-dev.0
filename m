Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BBDBB70AE
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 08:27:22 +1100 (EST)
Message-ID: <4D6C134C.4070407@embedded-sol.com>
Date: Mon, 28 Feb 2011 23:27:40 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
In-Reply-To: <20110228211103.GB31428@ovro.caltech.edu>
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

On 02/28/2011 11:11 PM, Ira W. Snyder wrote:
> On Mon, Feb 28, 2011 at 10:15:49PM +0200, Felix Radensky wrote:
>> Hi Ira,
>>
>>> Thank you very much Felix. The dmesg output shows that the controller
>>> never got an interrupt for the second transaction. The patch below has
>>> extra debugging information that may help determine why this happens.
>>> Please apply it and re-run the test.
>>>
>>> The last section of dmesg (after "Freeing unused kernel memory") is all
>>> I need.
>>>
>> Attached relevant dmesg portion.
>>
> Ok, try this patch on top of the last one.
>
> It looks like you used the dmatest module in multi-channel mode last
> time. One channel makes it easier to debug:
>
> modprobe dmatest max_channels=1 threads_per_chan=2 iterations=1
>
> Thanks for your help in debugging this. Hopefully this is the last
> patch to test. :)
>
> Ira
>

Looks like this was not the last one. The test still fails, see below

__dma_request_channel: success (dma0chan0)
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380000 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380060 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3800c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3801e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=6
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
dmatest: Started 2 threads using dma0chan0
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=6
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380000 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380000 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380060 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3800c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380120 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380180 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3801e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #0: No errors with src_off=0xf92 dst_off=0xf46 len=0x14ad
dma0chan0-copy0: terminating after 1 tests, 0 failures (status 0)
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef3801e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef380120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=6
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=9
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
dma0chan0-copy1: #0: test timed out
dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)

Felix.
