Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1239883845-17804-1-git-send-email-sr@denx.de>
References: <1239883845-17804-1-git-send-email-sr@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 07:26:53 -0600
Message-ID: <fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 6:10 AM, Stefan Roese <sr@denx.de> wrote:
> This patch adds support to handle multiple non-identical chips in one
> flash device tree node. It also adds concat support to physmap_of. This
> makes it possible to support e.g. the Intel P30 48F4400 chips which
> internally consists of 2 non-identical NOR chips on one die. Additionally
> partitions now can span over multiple chips.
>
> To describe such a chip's, multiple "reg" tuples are now supported in one
> flash device tree node. Here an dts example:
>
> =A0 =A0 =A0 =A0flash@f0000000,0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "cfi-flash";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x00000000 0x02000000
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0x02000000 0x02000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank-width =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0partition@0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0label =3D "test-part1";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x04000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewd-by: Grant Likely <grant.likely@secretlab.ca>

Yup, still looks good to me.  What boards has this been tested on?

g.

> ---
> Changes in ver3:
> - s/4/sizeof(u32)
>
> Changes in ver2 (as suggested by Grant Likely):
> - Removed MAX_RESOURCES introduced in ver1. Now we don't have a hard limi=
t
> =A0for "reg" tuples anymore.
> - Used of_n_addr_cells() and of_n_size_cells() to determine size of each =
tuple.
>
> =A0drivers/mtd/maps/physmap_of.c | =A0199 +++++++++++++++++++++++++++++--=
----------
> =A01 files changed, 143 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.=
c
> index c83a60f..39d357b 100644
> --- a/drivers/mtd/maps/physmap_of.c
> +++ b/drivers/mtd/maps/physmap_of.c
> @@ -20,16 +20,23 @@
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/map.h>
> =A0#include <linux/mtd/partitions.h>
> +#include <linux/mtd/concat.h>
> =A0#include <linux/of.h>
> =A0#include <linux/of_platform.h>
>
> +struct of_flash_list {
> + =A0 =A0 =A0 struct mtd_info *mtd;
> + =A0 =A0 =A0 struct map_info map;
> + =A0 =A0 =A0 struct resource *res;
> +};
> +
> =A0struct of_flash {
> - =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 *mtd;
> - =A0 =A0 =A0 struct map_info =A0 =A0 =A0 =A0 map;
> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res;
> + =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 *cmtd;
> =A0#ifdef CONFIG_MTD_PARTITIONS
> =A0 =A0 =A0 =A0struct mtd_partition =A0 =A0*parts;
> =A0#endif
> + =A0 =A0 =A0 int list_size; /* number of elements in of_flash_list */
> + =A0 =A0 =A0 struct of_flash_list =A0 =A0list[0];
> =A0};
>
> =A0#ifdef CONFIG_MTD_PARTITIONS
> @@ -88,30 +95,44 @@ static int parse_obsolete_partitions(struct of_device=
 *dev,
> =A0static int of_flash_remove(struct of_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct of_flash *info;
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0info =3D dev_get_drvdata(&dev->dev);
> =A0 =A0 =A0 =A0if (!info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0dev_set_drvdata(&dev->dev, NULL);
>
> - =A0 =A0 =A0 if (info->mtd) {
> +#ifdef CONFIG_MTD_CONCAT
> + =A0 =A0 =A0 if (info->cmtd !=3D info->list[0].mtd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->cmtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtd_concat_destroy(info->cmtd);
> + =A0 =A0 =A0 }
> +#endif
> +
> + =A0 =A0 =A0 if (info->cmtd) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (OF_FLASH_PARTS(info)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_partitions(info->mt=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_partitions(info->cm=
td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(OF_FLASH_PARTS(info)=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->cmtd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_destroy(info->mtd);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (info->map.virt)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(info->map.virt);
> + =A0 =A0 =A0 for (i =3D 0; i < info->list_size; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->list[i].mtd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_destroy(info->list[i].m=
td);
>
> - =A0 =A0 =A0 if (info->res) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(info->res);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->list[i].map.virt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(info->list[i].map.v=
irt);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->list[i].res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(info->list=
[i].res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->list[i].res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 kfree(info);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -164,68 +185,130 @@ static int __devinit of_flash_probe(struct of_devi=
ce *dev,
> =A0 =A0 =A0 =A0const char *probe_type =3D match->data;
> =A0 =A0 =A0 =A0const u32 *width;
> =A0 =A0 =A0 =A0int err;
> -
> - =A0 =A0 =A0 err =3D -ENXIO;
> - =A0 =A0 =A0 if (of_address_to_resource(dp, 0, &res)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Can't get IO address fr=
om device tree\n");
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int count;
> + =A0 =A0 =A0 const u32 *p;
> + =A0 =A0 =A0 int reg_tuple_size;
> + =A0 =A0 =A0 struct mtd_info **mtd_list =3D NULL;
> +
> + =A0 =A0 =A0 reg_tuple_size =3D (of_n_addr_cells(dp) + of_n_size_cells(d=
p)) * sizeof(u32);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Get number of "reg" tuples. Scan for MTD devices on ar=
ea's
> + =A0 =A0 =A0 =A0* described by each "reg" region. This makes it possible=
 (including
> + =A0 =A0 =A0 =A0* the concat support) to support the Intel P30 48F4400 c=
hips which
> + =A0 =A0 =A0 =A0* consists internally of 2 non-identical NOR chips on on=
e die.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 p =3D of_get_property(dp, "reg", &count);
> + =A0 =A0 =A0 if (count % reg_tuple_size !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Malformed reg property =
on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->node->=
full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "of_flash device: %.8llx=
-%.8llx\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res.start, (unsigned lo=
ng long)res.end);
> + =A0 =A0 =A0 count /=3D reg_tuple_size;
>
> =A0 =A0 =A0 =A0err =3D -ENOMEM;
> - =A0 =A0 =A0 info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> + =A0 =A0 =A0 info =3D kzalloc(sizeof(struct of_flash) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct of_flash_list)=
 * count, GFP_KERNEL);
> + =A0 =A0 =A0 if (!info)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> +
> + =A0 =A0 =A0 mtd_list =3D kzalloc(sizeof(struct mtd_info) * count, GFP_K=
ERNEL);
> =A0 =A0 =A0 =A0if (!info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&dev->dev, info);
>
> - =A0 =A0 =A0 err =3D -EBUSY;
> - =A0 =A0 =A0 info->res =3D request_mem_region(res.start, res.end - res.s=
tart + 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0dev_name(&dev->dev));
> - =A0 =A0 =A0 if (!info->res)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 for (i =3D 0; i < count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_address_to_resource(dp, i, &res)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Can't g=
et IO address from device"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " tree\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D -ENXIO;
> - =A0 =A0 =A0 width =3D of_get_property(dp, "bank-width", NULL);
> - =A0 =A0 =A0 if (!width) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Can't get bank width fr=
om device tree\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "of_flash device: %.8llx=
-%.8llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res.sta=
rt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res.end=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].res =3D request_mem_region(re=
s.start, res.end -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res.start + 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(&dev->dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info->list[i].res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 width =3D of_get_property(dp, "bank-width",=
 NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!width) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Can't g=
et bank width from device"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " tree\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 info->map.name =3D dev_name(&dev->dev);
> - =A0 =A0 =A0 info->map.phys =3D res.start;
> - =A0 =A0 =A0 info->map.size =3D res.end - res.start + 1;
> - =A0 =A0 =A0 info->map.bankwidth =3D *width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].map.name =3D dev_name(&dev->d=
ev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].map.phys =3D res.start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].map.size =3D res.end - res.st=
art + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].map.bankwidth =3D *width;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].map.virt =3D ioremap(info->li=
st[i].map.phys,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0info->list[i].map.size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info->list[i].map.virt) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Failed =
to ioremap() flash"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " region\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D -ENOMEM;
> - =A0 =A0 =A0 info->map.virt =3D ioremap(info->map.phys, info->map.size);
> - =A0 =A0 =A0 if (!info->map.virt) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Failed to ioremap() fla=
sh region\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 simple_map_init(&info->list[i].map);
>
> - =A0 =A0 =A0 simple_map_init(&info->map);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (probe_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].mtd =3D do_ma=
p_probe(probe_type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&info->list[i].map);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].mtd =3D obsol=
ete_probe(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&info->list[i].map);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtd_list[i] =3D info->list[i].mtd;
>
> - =A0 =A0 =A0 if (probe_type)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->mtd =3D do_map_probe(probe_type, &inf=
o->map);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->mtd =3D obsolete_probe(dev, &info->ma=
p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info->list[i].mtd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "do_map_=
probe() failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list_size++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].mtd->owner =3D THIS_MODULE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->list[i].mtd->dev.parent =3D &dev->dev=
;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D -ENXIO;
> - =A0 =A0 =A0 if (!info->mtd) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "do_map_probe() failed\n=
");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> + =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 if (info->list_size =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->cmtd =3D info->list[0].mtd;
> + =A0 =A0 =A0 } else if (info->list_size > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We detected multiple devices. Concaten=
ate them together.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +#ifdef CONFIG_MTD_CONCAT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->cmtd =3D mtd_concat_create(mtd_list, =
info->list_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0dev_name(&dev->dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->cmtd =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "physmap_of: multiple devic=
es "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"found but MTD concat suppor=
t disabled.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
> +#endif
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 info->mtd->owner =3D THIS_MODULE;
> - =A0 =A0 =A0 info->mtd->dev.parent =3D &dev->dev;
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>
> =A0#ifdef CONFIG_MTD_PARTITIONS
> =A0 =A0 =A0 =A0/* First look for RedBoot table or partitions on the comma=
nd
> =A0 =A0 =A0 =A0 * line, these take precedence over device tree informatio=
n */
> - =A0 =A0 =A0 err =3D parse_mtd_partitions(info->mtd, part_probe_types,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&inf=
o->parts, 0);
> + =A0 =A0 =A0 err =3D parse_mtd_partitions(info->cmtd, part_probe_types,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&inf=
o->parts, 0);
> =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> @@ -244,15 +327,19 @@ static int __devinit of_flash_probe(struct of_devic=
e *dev,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (err > 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_mtd_partitions(info->mtd, info->parts, =
err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_mtd_partitions(info->cmtd, info->parts,=
 err);
> =A0 =A0 =A0 =A0else
> =A0#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_mtd_device(info->mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_mtd_device(info->cmtd);
> +
> + =A0 =A0 =A0 kfree(mtd_list);
>
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_out:
> + =A0 =A0 =A0 kfree(mtd_list);
> =A0 =A0 =A0 =A0of_flash_remove(dev);
> +
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> --
> 1.6.2.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
