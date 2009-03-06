Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id 8A610DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 02:49:28 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so353508ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 07:49:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090227235456.4DED2448057@mail135-wa4.bigfish.com>
References: <20090227235456.4DED2448057@mail135-wa4.bigfish.com>
Date: Fri, 6 Mar 2009 08:49:26 -0700
Message-ID: <fa686aa40903060749l422386f0p5a720cbabc07ff74@mail.gmail.com>
Subject: Re: [PATCH] Xilinx: SPI: driver not releasing memory
From: Grant Likely <grant.likely@secretlab.ca>
To: David Brownell <dbrownell@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akonovalov@ru.mvista.com,
	John Linn <John.Linn@xilinx.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,

Are you okay with this patch and okay with it going in via Ben's
powerpc tree?  Ben wants to ensure that changes outside arch/powerpc/
are properly acked before going into his tree.

Thanks,
g.

On Sat, Feb 28, 2009 at 9:09 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Fri, Feb 27, 2009 at 4:54 PM, John Linn <john.linn@xilinx.com> wrote:
>> The driver was not releasing memory when it was removed or
>> when there was a failure during probe. This fixes it.
>>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>
> Looks good.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> I'll pick this up into my -next branch and ask Ben to pull it in the
> next week or so.

> ---
> This is an incremental patch to the patch (updated driver
> for device tree) that is in the next branch.
> ---
> =A0drivers/spi/xilinx_spi.c | =A0 =A09 +++++++--
> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index fe7e5f3..494d3f7 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -354,7 +354,7 @@ static int __init xilinx_spi_of_probe(struct of_devic=
e *ofdev,
> =A0 =A0 =A0 =A0if (xspi->regs =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&ofdev->dev, "ioremap failure\n")=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_mem;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0xspi->irq =3D r_irq->start;
>
> @@ -365,7 +365,7 @@ static int __init xilinx_spi_of_probe(struct of_devic=
e *ofdev,
> =A0 =A0 =A0 =A0prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits", =
&len);
> =A0 =A0 =A0 =A0if (!prop || len < sizeof(*prop)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bit=
s' property\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto put_master;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unmap_io;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0master->num_chipselect =3D *prop;
>
> @@ -397,6 +397,8 @@ free_irq:
> =A0 =A0 =A0 =A0free_irq(xspi->irq, xspi);
> =A0unmap_io:
> =A0 =A0 =A0 =A0iounmap(xspi->regs);
> +release_mem:
> + =A0 =A0 =A0 release_mem_region(r_mem->start, resource_size(r_mem));
> =A0put_master:
> =A0 =A0 =A0 =A0spi_master_put(master);
> =A0 =A0 =A0 =A0return rc;
> @@ -406,6 +408,7 @@ static int __devexit xilinx_spi_remove(struct of_devi=
ce *ofdev)
> =A0{
> =A0 =A0 =A0 =A0struct xilinx_spi *xspi;
> =A0 =A0 =A0 =A0struct spi_master *master;
> + =A0 =A0 =A0 struct resource r_mem;
>
> =A0 =A0 =A0 =A0master =3D platform_get_drvdata(ofdev);
> =A0 =A0 =A0 =A0xspi =3D spi_master_get_devdata(master);
> @@ -413,6 +416,8 @@ static int __devexit xilinx_spi_remove(struct of_devi=
ce *ofdev)
> =A0 =A0 =A0 =A0spi_bitbang_stop(&xspi->bitbang);
> =A0 =A0 =A0 =A0free_irq(xspi->irq, xspi);
> =A0 =A0 =A0 =A0iounmap(xspi->regs);
> + =A0 =A0 =A0 if (!of_address_to_resource(ofdev->node, 0, &r_mem))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(r_mem.start, resource_si=
ze(&r_mem));
> =A0 =A0 =A0 =A0dev_set_drvdata(&ofdev->dev, 0);
> =A0 =A0 =A0 =A0spi_master_put(xspi->bitbang.master);
>
> --
> 1.5.3.4
>
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
