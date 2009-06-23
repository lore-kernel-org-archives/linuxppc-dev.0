Return-Path: <pku.leo@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E32B7B7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 20:24:54 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 3CB87DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 20:24:53 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1761723anc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 03:24:51 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1245705647.937.2.camel@dwillia2-linux.ch.intel.com>
References: <20090619193134.GC30992@ovro.caltech.edu>
	<1245705647.937.2.camel@dwillia2-linux.ch.intel.com>
Date: Tue, 23 Jun 2009 18:18:05 +0800
Message-ID: <2a27d3730906230318g7103a890ic85d1678425ac2c9@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fsldma: Add DMA_SLAVE support
From: Li Yang <leoli@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2009 at 5:20 AM, Dan Williams<dan.j.williams@intel.com> wro=
te:
> On Fri, 2009-06-19 at 12:31 -0700, Ira Snyder wrote:
>> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
>> scatterlist into an arbitrary list of hardware address/length pairs.
>>
>> This allows a single DMA transaction to copy data from several different
>> devices into a scatterlist at the same time.
>>
>> This also adds support to enable some controller-specific features such =
as
>> external start and external pause for a DMA transaction.
>>
>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>> ---
>>
>> This patch depends on the "fsldma: split apart external pause and
>> request count features" patch.
>>
>> After discussion with Dan Williams, this is the third version of the
>> DMA_SLAVE API for the Freescale DMA controller. I've tested it heavily
>> with both drivers I have written against this API, an FPGA programmer
>> and an FPGA data grabber.
>>
>> Kumar, Dan asked me to add you to the CC list, so you can have a look at
>> this patch before he adds it to his tree.
>>
>> The other two small patches I posted earlier are very helpful in testing
>> this functionality. They make the fsldma driver leave the BWC (bandwidth
>> control) bits alone on the 83xx controller, as well as making the
>> external start feature available on 83xx.
>>
>
> Kumar, Leo,
>
> Can I get your acked-by's for the current state of async_tx.git/next? =C2=
=A0I
> just pushed out Ira's latest so it may take a moment to mirror out.

Acked-by: Li Yang <leoli@freescale.com>

However, the addition of arch/powerpc/include/asm/fsldma.h still needs
the ack from Kumar.  It doesn't seem to be a common practice though.

- Leo
