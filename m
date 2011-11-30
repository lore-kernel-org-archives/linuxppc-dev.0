Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <0b0c0efa6cca6e5e169b4b3e81373a3bab75716a.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
 <0b0c0efa6cca6e5e169b4b3e81373a3bab75716a.1322615824.git.geoff@infradead.org>
Date: Wed, 30 Nov 2011 21:57:48 +0100
Message-ID: <CAMuHMdUjOXLskrRXYYO1Esd75W4Z=WS3srT0+qFF66DfLeQQmA@mail.gmail.com>
Subject: Re: [PATCH 6/8] powerpc/ps3: Fix pr_debug build warnings
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geoff,

On Wed, Nov 30, 2011 at 02:38, Geoff Levand <geoff@infradead.org> wrote:
> Fix some PS3 build warnings when DEBUG is defined.
>
> Fixes warnings like these:
>
> =C2=A0format '%lx' expects type 'long unsigned int', but argument 7 has t=
ype 'u64'
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> =C2=A0arch/powerpc/platforms/ps3/repository.c | =C2=A0 14 ++++++++------
> =C2=A01 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platf=
orms/ps3/repository.c
> index cb68729..2ce2782 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -1050,7 +1050,7 @@ int ps3_repository_dump_resource_info(const struct =
ps3_repository_device *repo)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("%s:%d (%=
u:%u) reg_type %u, bus_addr %lxh, len %lxh\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, __LINE__, repo->bus_index, repo->dev_index,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reg_type, bus_addr, len);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reg_type, (unsigned long)bus_addr, (unsigned long)len);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug(" <- %s:%d\n", __func__, __LINE__);

The correct way to format u64 is using the "ll" length modifier. That way y=
ou
don't need casts.

The code above was originally written before the u64 uniformization, when p=
pc64
was still using "unsigned long" for u64.

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
