Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mtd: physmap_of: Add multiple regions and concatenation
	support
Date: Mon, 6 Apr 2009 09:43:28 +0200
References: <1238752534-7718-1-git-send-email-sr@denx.de>
	<fa686aa40904030704t5bd1debfk5a23aeed3ccae2ed@mail.gmail.com>
In-Reply-To: <fa686aa40904030704t5bd1debfk5a23aeed3ccae2ed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904060943.29189.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 03 April 2009, Grant Likely wrote:
> > =A0 =A0 =A0 =A0flash@f0000000,0 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "cfi-flash";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x00000000 0x02000000
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0x02000000 0x02000000>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank-width =3D <2>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0partition@0 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0label =3D "test-part1";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x04000000>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> > =A0 =A0 =A0 =A0};
>
> Binding looks good to me.  Add a variant of this blurb to
> Documentation/powerpc/booting-without-of.txt.  For extra credit,
> factor out the MTD stuff and move it to
> Documentation/powerpc/dts-bindings/.  Remember to cc: the
> devicetree-discuss@ozlabs.org list when you post the binding
> documentation.

OK, will do.

> > Signed-off-by: Stefan Roese <sr@denx.de>
> > CC: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > =A0drivers/mtd/maps/physmap_of.c | =A0174
> > ++++++++++++++++++++++++++++------------- 1 files changed, 120
> > insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/mtd/maps/physmap_of.c
> > b/drivers/mtd/maps/physmap_of.c index 5fcfec0..c1c2d08 100644
> > --- a/drivers/mtd/maps/physmap_of.c
> > +++ b/drivers/mtd/maps/physmap_of.c
> > @@ -20,13 +20,17 @@
> > =A0#include <linux/mtd/mtd.h>
> > =A0#include <linux/mtd/map.h>
> > =A0#include <linux/mtd/partitions.h>
> > +#include <linux/mtd/concat.h>
> > =A0#include <linux/of.h>
> > =A0#include <linux/of_platform.h>
> >
> > +#define MAX_RESOURCES =A0 =A0 =A0 =A0 =A04
> > +
>
> Why is this static?

Because I cloned it from physmap.c.

> Instead you could define:=20
>
> struct of_flash_list {
>         struct mtd_info *mtd;
>         struct map_info map;
>         struct resource *res;
> };
>
> struct of_flash {
>         struct mtd_info         *cmtd;
> #ifdef CONFIG_MTD_PARTITIONS
>         struct mtd_partition    *parts;
> #endif
>         int list_size; /* number of elements in of_flash_list */
>         struct of_flash_list     list[0];
> };
>
> Using a zero length array at the end of the structure allows you to do
> this after counting the number of reg tuples:
>
> f =3D kzalloc(sizeof(struct of_flash) + sizeof(struct
> of_flash_list)*num_chips);
>
> That eliminates a needless hard limit to the number of flash chips.

Good idea. Will update. Thanks.

> > =A0struct of_flash {
> > - =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 *mtd;
> > - =A0 =A0 =A0 struct map_info =A0 =A0 =A0 =A0 map;
> > - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res;
> > + =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 *mtd[MAX_RESOURCES];
> > + =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 *cmtd;
> > + =A0 =A0 =A0 struct map_info =A0 =A0 =A0 =A0 map[MAX_RESOURCES];
> > + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res[MAX_RESOURCES];
> > =A0#ifdef CONFIG_MTD_PARTITIONS
> > =A0 =A0 =A0 =A0struct mtd_partition =A0 =A0*parts;
> > =A0#endif
> > @@ -88,28 +92,40 @@ static int parse_obsolete_partitions(struct of_devi=
ce
> > *dev, static int of_flash_remove(struct of_device *dev)
> > =A0{
> > =A0 =A0 =A0 =A0struct of_flash *info;
> > + =A0 =A0 =A0 int i;
> >
> > =A0 =A0 =A0 =A0info =3D dev_get_drvdata(&dev->dev);
> > =A0 =A0 =A0 =A0if (!info)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> > =A0 =A0 =A0 =A0dev_set_drvdata(&dev->dev, NULL);
> >
> > - =A0 =A0 =A0 if (info->mtd) {
> > +#ifdef CONFIG_MTD_CONCAT
> > + =A0 =A0 =A0 if (info->cmtd !=3D info->mtd[0]) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->cmtd);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtd_concat_destroy(info->cmtd);
> > + =A0 =A0 =A0 }
> > +#endif
> > +
> > + =A0 =A0 =A0 if (info->cmtd) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (OF_FLASH_PARTS(info)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_partitions(info->=
mtd);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_partitions(info->=
cmtd);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(OF_FLASH_PARTS(inf=
o));
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->mtd);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_mtd_device(info->cmtd=
);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_destroy(info->mtd);
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (info->map.virt)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(info->map.virt);
> > + =A0 =A0 =A0 for (i =3D 0; i < MAX_RESOURCES; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->mtd[i])
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map_destroy(info->mtd[i]);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->map[i].virt)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(info->map[i].virt=
);
> >
> > - =A0 =A0 =A0 if (info->res) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(info->res);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->res);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->res[i]) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(info->re=
s[i]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->res[i]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0return 0;
> > @@ -164,15 +180,25 @@ static int __devinit of_flash_probe(struct
> > of_device *dev, const char *probe_type =3D match->data;
> > =A0 =A0 =A0 =A0const u32 *width;
> > =A0 =A0 =A0 =A0int err;
> > -
> > - =A0 =A0 =A0 err =3D -ENXIO;
> > - =A0 =A0 =A0 if (of_address_to_resource(dp, 0, &res)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "Can't get IO address =
from device
> > tree\n"); + =A0 =A0 =A0 int i;
> > + =A0 =A0 =A0 int count;
> > + =A0 =A0 =A0 const u32 *p;
> > + =A0 =A0 =A0 int devices_found =3D 0;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Get number of "reg" tuples. Scan for MTD devices on =
area's
> > + =A0 =A0 =A0 =A0* described by each "reg" region. This makes it possib=
le
> > (including + =A0 =A0 =A0 =A0* the concat support) to support the Intel =
P30
> > 48F4400 chips which + =A0 =A0 =A0 =A0* consists internally of 2 non-ide=
ntical NOR
> > chips on one die. + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 p =3D of_get_property(dp, "reg", &count);
> > + =A0 =A0 =A0 if (count % 12 !=3D 0) {
>
> This doesn't work.  You cannot know the size of each reg tuple until
> #address-cells/#size-cells is parsed for the parent node.  It won't
> always be 12.  Use of_n_addr_cells() + of_n_size_cells() to determine
> size of each tuple.

OK, I'll change it in the next patch version.

Thanks.

Best regards,
Stefan
