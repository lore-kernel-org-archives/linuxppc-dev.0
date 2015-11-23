Return-Path: <mru@mansr.com>
Received: from unicorn.mansr.com (unicorn.mansr.com
 [IPv6:2001:8b0:ca0d:8d8e::2])
 by lists.ozlabs.org (Postfix) with ESMTP id CE26D1A1E61
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 22:58:20 +1100 (AEDT)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <yw1xwptab2zs.fsf@unicorn.mansr.com>
 <1448273441.31665.186.camel@linux.intel.com>
Date: Mon, 23 Nov 2015 11:58:12 +0000
In-Reply-To: <1448273441.31665.186.camel@linux.intel.com> (Andy Shevchenko's
 message of "Mon, 23 Nov 2015 12:10:41 +0200")
Message-ID: <yw1x610tapwr.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Sun, 2015-11-22 at 13:03 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>=20
>> > The SATA implementation based on two actually different devices,
>> > i.e. SATA and
>> > DMA controllers.
>> >=20
>> > For Synopsys DesignWare DMA we have already a generic
>> > implementation of the
>> > driver. Thus, the patch converts the code to use DMAEngine
>> > framework and
>> > dw_dmac driver.
>> >=20
>> > In future it will be better to split the devices inside DTS as well
>> > like it's
>> > done on other platforms.
>
>> > @@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct
>> > platform_device *ofdev)
>> >  		   idr, ver[0], ver[1], ver[2]);
>> >=20
>> >  	/* Get SATA DMA interrupt number */
>> > -	irq =3D irq_of_parse_and_map(np, 1);
>> > -	if (irq =3D=3D NO_IRQ) {
>> > +	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
>>=20
>> This doesn't look like it has been more than compile-tested.
>
> Yes, that's true, my question [1] was a crying in the wilderness.
>
>>   Nothing
>> ever allocates hsdev->dma, so it can't possibly work.
>
> You are right.
>
>>=20
>> Also, has anyone given any thought to getting rid of the dependency
>> on the DW DMA controller?
>
> How? Before it was even more harder link to it (embedded routines).

It already uses the dmaengine API to do the transfers.  To make it
generic, two things need to change:

1. The DMA controller should get its own DT node instead of the SATA
   driver calling dw_dma_probe() directly.

2. The SATA driver can then use dma_request_slave_channel() and a "dmas"
   DT property instead of dma_request_channel() and filter function.

The changes are easy to make as such.  The only problem is that we need
to preserve compatibility with old device trees.

> On the other hand you may introduce dma_ops and use them like it's
> done, for example, in spi-dw*.c
>
>>   Presumably support for old device trees would
>> need to be retained for compatibility.  Maybe checking for a "dmas"
>> property and falling back on the current behaviour if it's missing.=20=20
>
> I didn't get how DT is related to DW or any other DMAC used with this
> SATA controller.

See Documentation/devicetree/bindings/dma/dma.txt

>> My goal is to get this driver working with another chip using the
>> same SATA controller but a different DMA engine.
>
> It would be nice to eventually bring this working with generic DMA
> Engine API. Please, keep me in Cc list regarding this driver.

What's your interest in this driver if you don't have the hardware?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
