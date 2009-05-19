Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 759E8DE0FB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 00:41:50 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2024069ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 07:41:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1232559685-2268-2-git-send-email-w.sang@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
	<1232559685-2268-2-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 08:41:29 -0600
Message-ID: <fa686aa40905190741x35ab92eeybf1574bcbdf57bda@mail.gmail.com>
Subject: Re: [PATCH 1/2] maps/mtd-ram: refactor probe and remove
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 11:41 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
> Refactor the probe and remove routines of the mtd-ram driver to export
> a generic part which can later be accessed by an of-counterpart of this
> driver. Tested with a phyCORE-MPC5200B-IO.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

On brief review, looks okay by me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/mtd/maps/plat-ram.c =A0| =A0123 +++++++++++++++++++++---------=
------------
> =A0include/linux/mtd/plat-ram.h | =A0 =A04 ++
> =A02 files changed, 66 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mtd/maps/plat-ram.c b/drivers/mtd/maps/plat-ram.c
> index e7dd9c8..1582cd6 100644
> --- a/drivers/mtd/maps/plat-ram.c
> +++ b/drivers/mtd/maps/plat-ram.c
> @@ -50,16 +50,6 @@ struct platram_info {
> =A0 =A0 =A0 =A0struct platdata_mtd_ram *pdata;
> =A0};
>
> -/* to_platram_info()
> - *
> - * device private data to struct platram_info conversion
> -*/
> -
> -static inline struct platram_info *to_platram_info(struct platform_devic=
e *dev)
> -{
> - =A0 =A0 =A0 return (struct platram_info *)platform_get_drvdata(dev);
> -}
> -
> =A0/* platram_setrw
> =A0*
> =A0* call the platform device's set rw/ro control
> @@ -77,18 +67,14 @@ static inline void platram_setrw(struct platram_info =
*info, int to)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(info->pdata->set_rw)(info->dev, to);
> =A0}
>
> -/* platram_remove
> - *
> - * called to remove the device from the driver's control
> -*/
> -
> -static int platram_remove(struct platform_device *pdev)
> +int __platram_remove(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct platram_info *info =3D to_platram_info(pdev);
> + =A0 =A0 =A0 struct platram_info *info;
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 dev_dbg(dev, "removing device\n");
>
> - =A0 =A0 =A0 dev_dbg(&pdev->dev, "removing device\n");
> + =A0 =A0 =A0 info =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 dev_set_drvdata(dev, NULL);
>
> =A0 =A0 =A0 =A0if (info =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -123,68 +109,49 @@ static int platram_remove(struct platform_device *p=
dev)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +EXPORT_SYMBOL_GPL(__platram_remove);
>
> -/* platram_probe
> +/* platram_remove
> =A0*
> - * called from device drive system when a device matching our
> - * driver is found.
> + * called to remove the device from the driver's control
> =A0*/
>
> -static int platram_probe(struct platform_device *pdev)
> +static int platram_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 return __platram_remove(&pdev->dev);
> +}
> +
> +int __platram_probe(struct device *dev, const char *name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res, struc=
t platdata_mtd_ram *pdata)
> =A0{
> - =A0 =A0 =A0 struct platdata_mtd_ram *pdata;
> =A0 =A0 =A0 =A0struct platram_info *info;
> - =A0 =A0 =A0 struct resource *res;
> =A0 =A0 =A0 =A0int err =3D 0;
>
> - =A0 =A0 =A0 dev_dbg(&pdev->dev, "probe entered\n");
> -
> - =A0 =A0 =A0 if (pdev->dev.platform_data =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data suppl=
ied\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOENT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> -
> =A0 =A0 =A0 =A0info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (info =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no memory for flash in=
fo\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory for flash info\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, info);
> + =A0 =A0 =A0 dev_set_drvdata(dev, info);
>
> - =A0 =A0 =A0 info->dev =3D &pdev->dev;
> + =A0 =A0 =A0 info->dev =3D dev;
> =A0 =A0 =A0 =A0info->pdata =3D pdata;
>
> - =A0 =A0 =A0 /* get the resource for the memory mapping */
> -
> - =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> - =A0 =A0 =A0 if (res =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no memory resource spe=
cified\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOENT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_free;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 dev_dbg(&pdev->dev, "got platform resource %p (0x%llx)\n", =
res,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->start);
> -
> =A0 =A0 =A0 =A0/* setup map parameters */
>
> =A0 =A0 =A0 =A0info->map.phys =3D res->start;
> =A0 =A0 =A0 =A0info->map.size =3D (res->end - res->start) + 1;
> =A0 =A0 =A0 =A0info->map.name =3D pdata->mapname !=3D NULL ?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (char *)pdata->mapname : (c=
har *)pdev->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (char *)pdata->mapname : (c=
har *)name;
> =A0 =A0 =A0 =A0info->map.bankwidth =3D pdata->bankwidth;
>
> =A0 =A0 =A0 =A0/* register our usage of the memory area */
>
> - =A0 =A0 =A0 info->area =3D request_mem_region(res->start, info->map.siz=
e, pdev->name);
> + =A0 =A0 =A0 info->area =3D request_mem_region(res->start, info->map.siz=
e, name);
> =A0 =A0 =A0 =A0if (info->area =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request memo=
ry region\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to request memory regi=
on\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_free;
> =A0 =A0 =A0 =A0}
> @@ -192,17 +159,17 @@ static int platram_probe(struct platform_device *pd=
ev)
> =A0 =A0 =A0 =A0/* remap the memory area */
>
> =A0 =A0 =A0 =A0info->map.virt =3D ioremap(res->start, info->map.size);
> - =A0 =A0 =A0 dev_dbg(&pdev->dev, "virt %p, %lu bytes\n", info->map.virt,=
 info->map.size);
> + =A0 =A0 =A0 dev_dbg(dev, "virt %p, %lu bytes\n", info->map.virt, info->=
map.size);
>
> =A0 =A0 =A0 =A0if (info->map.virt =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to ioremap() re=
gion\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to ioremap() region\n"=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_free;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0simple_map_init(&info->map);
>
> - =A0 =A0 =A0 dev_dbg(&pdev->dev, "initialised map, probing for mtd\n");
> + =A0 =A0 =A0 dev_dbg(dev, "initialised map, probing for mtd\n");
>
> =A0 =A0 =A0 =A0/* probe for the right mtd map driver
> =A0 =A0 =A0 =A0 * supplied by the platform_data struct */
> @@ -218,7 +185,7 @@ static int platram_probe(struct platform_device *pdev=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->mtd =3D do_map_probe("map_ram", &inf=
o->map);
>
> =A0 =A0 =A0 =A0if (info->mtd =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to probe for ma=
p_ram\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to probe for map_ram\n=
");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_free;
> =A0 =A0 =A0 =A0}
> @@ -249,20 +216,54 @@ static int platram_probe(struct platform_device *pd=
ev)
> =A0#endif /* CONFIG_MTD_PARTITIONS */
>
> =A0 =A0 =A0 =A0if (add_mtd_device(info->mtd)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "add_mtd_device() faile=
d\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "add_mtd_device() failed\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "registered mtd device=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "registered mtd device\n");
>
> =A0 =A0 =A0 =A0return err;
>
> =A0exit_free:
> - =A0 =A0 =A0 platram_remove(pdev);
> + =A0 =A0 =A0 __platram_remove(dev);
> =A0exit_error:
> =A0 =A0 =A0 =A0return err;
> =A0}
> +EXPORT_SYMBOL_GPL(__platram_probe);
> +
> +/* platram_probe
> + *
> + * called from device drive system when a device matching our
> + * driver is found.
> +*/
> +
> +static int platram_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct platdata_mtd_ram *pdata;
> + =A0 =A0 =A0 struct resource *res;
> +
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "probe entered\n");
> +
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data suppl=
ied\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* get the resource for the memory mapping */
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no memory resource spe=
cified\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "got platform resource %p (0x%llx)\n", =
res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res->start);
> +
> + =A0 =A0 =A0 return __platram_probe(&pdev->dev, pdev->name, res, pdata);
> +}
>
> =A0/* device driver info */
>
> diff --git a/include/linux/mtd/plat-ram.h b/include/linux/mtd/plat-ram.h
> index e07890a..c522562 100644
> --- a/include/linux/mtd/plat-ram.h
> +++ b/include/linux/mtd/plat-ram.h
> @@ -31,4 +31,8 @@ struct platdata_mtd_ram {
> =A0 =A0 =A0 =A0void =A0 =A0(*set_rw)(struct device *dev, int to);
> =A0};
>
> +extern int __platram_probe(struct device *dev, const char *name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res, struc=
t platdata_mtd_ram *pdata);
> +extern int __platram_remove(struct device *dev);
> +
> =A0#endif /* __LINUX_MTD_PLATRAM_H */
> --
> 1.5.6.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
