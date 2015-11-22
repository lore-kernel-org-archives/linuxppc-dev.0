Return-Path: <mru@mansr.com>
Received: from unicorn.mansr.com (unicorn.mansr.com
 [IPv6:2001:8b0:ca0d:8d8e::2])
 by lists.ozlabs.org (Postfix) with ESMTP id E21EB1A0076
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 00:10:50 +1100 (AEDT)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
Date: Sun, 22 Nov 2015 13:03:19 +0000
In-Reply-To: <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
 (Andy Shevchenko's message of "Tue, 3 Mar 2015 22:41:21 +0200")
Message-ID: <yw1xwptab2zs.fsf@unicorn.mansr.com>
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

> The SATA implementation based on two actually different devices, i.e. SAT=
A and
> DMA controllers.
>
> For Synopsys DesignWare DMA we have already a generic implementation of t=
he
> driver. Thus, the patch converts the code to use DMAEngine framework and
> dw_dmac driver.
>
> In future it will be better to split the devices inside DTS as well like =
it's
> done on other platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 736 +++++++------------------------------=
------
>  1 file changed, 122 insertions(+), 614 deletions(-)
>

[...]

> @@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
>  		   idr, ver[0], ver[1], ver[2]);
>
>  	/* Get SATA DMA interrupt number */
> -	irq =3D irq_of_parse_and_map(np, 1);
> -	if (irq =3D=3D NO_IRQ) {
> +	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);

This doesn't look like it has been more than compile-tested.  Nothing
ever allocates hsdev->dma, so it can't possibly work.

Also, has anyone given any thought to getting rid of the dependency on
the DW DMA controller?  Presumably support for old device trees would
need to be retained for compatibility.  Maybe checking for a "dmas"
property and falling back on the current behaviour if it's missing.  My
goal is to get this driver working with another chip using the same SATA
controller but a different DMA engine.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
