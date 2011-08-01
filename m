Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1312228986-32307-10-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-10-git-send-email-a.heider@gmail.com>
Date: Mon, 1 Aug 2011 22:30:39 +0200
Message-ID: <CAMuHMdVq+WSjZKVZk1riEFX6NgW6Y+8EhCc0MqMtuDK5KAD7dw@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 09/15] ps3: Limit the number of regions per
	storage device
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
> There can be only 8 regions, add a sanity check

Why can there be only 8 regions?

> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> =C2=A0arch/powerpc/include/asm/ps3stor.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A01 +
> =C2=A0arch/powerpc/platforms/ps3/device-init.c | =C2=A0 =C2=A08 ++++++++
> =C2=A02 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/as=
m/ps3stor.h
> index 6fcaf71..d51e53c 100644
> --- a/arch/powerpc/include/asm/ps3stor.h
> +++ b/arch/powerpc/include/asm/ps3stor.h
> @@ -25,6 +25,7 @@
>
> =C2=A0#include <asm/ps3.h>
>
> +#define PS3_STORAGE_MAX_REGIONS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(8)
>
> =C2=A0struct ps3_storage_region {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int id;
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/plat=
forms/ps3/device-init.c
> index 6c4b583..830d741 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -349,6 +349,14 @@ static int ps3_setup_storage_dev(const struct ps3_re=
pository_device *repo,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (num_regions > PS3_STORAGE_MAX_REGIONS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("%s:%u: dev=
ice %u:%u reported %u regions, "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0"limiting to %u\n", __func__, __LINE__,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0num_regions, repo->bus_index, repo->dev_index,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0PS3_STORAGE_MAX_REGIONS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_regions =3D PS3_ST=
ORAGE_MAX_REGIONS;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("%s:%u: (%u:%u:%u): port %llu blk_siz=
e %llu num_blocks %llu "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "num_regions %u\n=
", __func__, __LINE__, repo->bus_index,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo->dev_index, =
repo->dev_type, port, blk_size, num_blocks,

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
