Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1312228986-32307-7-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-7-git-send-email-a.heider@gmail.com>
Date: Mon, 1 Aug 2011 22:29:23 +0200
Message-ID: <CAMuHMdUgK7ZkaNA+DVg0_TL8fz+AfEOTZqW5WdOY5ybwSP=hcA@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 06/15] ps3flash: Fix region align checks
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

On Mon, Aug 1, 2011 at 22:02, Andre Heider <a.heider@gmail.com> wrote:
> The region fields used by the align checks are set in
> ps3stor_setup(), so move those after that call.

Are you sure?
Aren't they set in
arch/powerpc/platforms/ps3/device-init.c:ps3_setup_storage_dev()?

> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> =C2=A0drivers/char/ps3flash.c | =C2=A0 30 +++++++++++++++---------------
> =C2=A01 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
> index 85c004a..69c734a 100644
> --- a/drivers/char/ps3flash.c
> +++ b/drivers/char/ps3flash.c
> @@ -360,21 +360,6 @@ static int __devinit ps3flash_probe(struct ps3_syste=
m_bus_device *_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int error;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long tmp;
>
> - =C2=A0 =C2=A0 =C2=A0 tmp =3D dev->regions[dev->region_idx].start*dev->b=
lk_size;
> - =C2=A0 =C2=A0 =C2=A0 if (tmp % FLASH_BLOCK_SIZE) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&dev->sbd.core=
,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "%s:%u region start %lu is not aligned\n", __func__,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __LINE__, tmp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 tmp =3D dev->regions[dev->region_idx].size*dev->bl=
k_size;
> - =C2=A0 =C2=A0 =C2=A0 if (tmp % FLASH_BLOCK_SIZE) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&dev->sbd.core=
,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "%s:%u region size %lu is not aligned\n", __func__,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __LINE__, tmp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* use static buffer, kmalloc cannot allocate =
256 KiB */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ps3flash_bounce_buffer.address)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> @@ -405,6 +390,21 @@ static int __devinit ps3flash_probe(struct ps3_syste=
m_bus_device *_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail_free_pri=
v;
>
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D dev->regions[dev->region_idx].start*dev->b=
lk_size;
> + =C2=A0 =C2=A0 =C2=A0 if (tmp % FLASH_BLOCK_SIZE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&dev->sbd.core=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "%s:%u region start %lu is not aligned\n", __func__,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __LINE__, tmp);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 tmp =3D dev->regions[dev->region_idx].size*dev->bl=
k_size;
> + =C2=A0 =C2=A0 =C2=A0 if (tmp % FLASH_BLOCK_SIZE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&dev->sbd.core=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "%s:%u region size %lu is not aligned\n", __func__,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __LINE__, tmp);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ps3flash_misc.parent =3D &dev->sbd.core;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D misc_register(&ps3flash_misc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error) {

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
