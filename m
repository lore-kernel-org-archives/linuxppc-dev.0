Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1312228986-32307-11-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-11-git-send-email-a.heider@gmail.com>
Date: Mon, 1 Aug 2011 22:35:07 +0200
Message-ID: <CAMuHMdXJWTw33ehLAPq00WjsebBHtQd5B9nM5Y-Z5JtevzmVqA@mail.gmail.com>
Subject: Re: [PATCH 10/15] ps3stor_lib: Add support for multiple regions
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2011 at 22:03, Andre Heider <a.heider@gmail.com> wrote:
> Users (ps3disk, ps3flash and ps3rom) retain the old behavior. That is:
> they still only provide access to the first accessible region.
>
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> =C2=A0arch/powerpc/include/asm/ps3stor.h | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/block/ps3disk.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 15 +++++++++++++--
> =C2=A0drivers/char/ps3flash.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 23 +++++++++++++++++------
> =C2=A0drivers/ps3/ps3stor_lib.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 25 ++++++++++++-------------
> =C2=A0drivers/scsi/ps3rom.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 11 +++++++----
> =C2=A05 files changed, 51 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/as=
m/ps3stor.h
> index d51e53c..9871c05 100644
> --- a/arch/powerpc/include/asm/ps3stor.h
> +++ b/arch/powerpc/include/asm/ps3stor.h
> @@ -51,7 +51,6 @@ struct ps3_storage_device {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int num_regions;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long accessible_regions;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int region_idx; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* first accessible region */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ps3_storage_region regions[0]; =C2=A0 /=
* Must be last */
> =C2=A0};
>
> @@ -63,7 +62,8 @@ static inline struct ps3_storage_device *to_ps3_storage=
_device(struct device *de
> =C2=A0extern int ps3stor_setup(struct ps3_storage_device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 irq_handler_t handler);
> =C2=A0extern void ps3stor_teardown(struct ps3_storage_device *dev);
> -extern u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u6=
4 lpar,
> +extern u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int region=
_idx, u64 lpar,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start_sector=
, u64 sectors,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int write);
> =C2=A0extern u64 ps3stor_send_command(struct ps3_storage_device *dev, u64=
 cmd,
> diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
> index 8e1ce2e..96e00ff 100644
> --- a/drivers/block/ps3disk.c
> +++ b/drivers/block/ps3disk.c
> @@ -42,6 +42,7 @@ struct ps3disk_private {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Request queue spinlock */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct request_queue *queue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gendisk *gendisk;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int region_idx; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* first accessible region */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int blocking_factor;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct request *req;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 raw_capacity;
> @@ -125,7 +126,7 @@ static int ps3disk_submit_request_sg(struct ps3_stora=
ge_device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int write =3D rq_data_dir(req), res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *op =3D write ? "write" : "read";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start_sector, sectors;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int region_id =3D dev->regions[dev->regio=
n_idx].id;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int region_id =3D dev->regions[priv->regi=
on_idx].id;
>
> =C2=A0#ifdef DEBUG
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int n =3D 0;
> @@ -408,6 +409,7 @@ static int __devinit ps3disk_probe(struct ps3_system_=
bus_device *_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int devidx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct request_queue *queue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gendisk *gendisk;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int region_idx;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->blk_size < 512) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&dev->sbd.=
core,
> @@ -482,6 +484,14 @@ static int __devinit ps3disk_probe(struct ps3_system=
_bus_device *_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0priv->gendisk =3D gendisk;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* find first accessible region */
> + =C2=A0 =C2=A0 =C2=A0 for (region_idx =3D 0; region_idx < dev->num_regio=
ns; region_idx++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_bit(region_id=
x, &dev->accessible_regions)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 priv->region_idx =3D region_idx;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +

Why not

priv->region_idx =3D __ffs(dev->accessible_regions);

like the original code in ps3stor_probe_access() used? Cfr. the code
you removed:

> diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
> index af0afa1..5bbc023 100644
> --- a/drivers/ps3/ps3stor_lib.c
> +++ b/drivers/ps3/ps3stor_lib.c
> @@ -124,15 +128,8 @@ static int ps3stor_probe_access(struct ps3_storage_d=
evice *dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D hweight_long(dev->accessible_regions);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n > 1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&dev->sbd=
.core,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"%s:%u: %lu accessible regions found. Only the first "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"one will be used\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"%s:%u: %lu accessible regions found\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, __LINE__, n);
> - =C2=A0 =C2=A0 =C2=A0 dev->region_idx =3D __ffs(dev->accessible_regions)=
;
> - =C2=A0 =C2=A0 =C2=A0 dev_info(&dev->sbd.core,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"First accessibl=
e region has index %u start %llu size %llu\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->region_idx,=
 dev->regions[dev->region_idx].start,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->regions[dev=
->region_idx].size);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>

Same in the other drivers.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
