Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zql342ndbzDqZs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:44:28 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id g60so18982188qtd.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 06:44:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:44:25 +0200
Message-ID: <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote=
:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, t=
he
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=3D1):
>
>   CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c: In function =E2=80=98check_cpu_feature_proper=
ties=E2=80=99:
> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expressi=
on < 0 is always false [-Werror=3Dtype-limits]
>   for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 ^
> cc1: all warnings being treated as errors
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/kernel/prom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4dffef947b8a..6e8e4122820e 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -291,11 +291,10 @@ static inline void identical_pvr_fixup(unsigned lon=
g node)
>
>  static void __init check_cpu_feature_properties(unsigned long node)
>  {
> -       unsigned long i;
>         struct feature_property *fp =3D feature_properties;
>         const __be32 *prop;
>

Much simpler is just add

if (ARRAY_SIZE() =3D=3D 0)
 return;

> -       for (i =3D 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +       for (; fp !=3D feature_properties + ARRAY_SIZE(feature_properties=
); ++fp) {
>                 prop =3D of_get_flat_dt_prop(node, fp->name, NULL);
>                 if (prop && be32_to_cpup(prop) >=3D fp->min_value) {
>                         cur_cpu_spec->cpu_features |=3D fp->cpu_feature;
> --
> 2.11.0
>



--=20
With Best Regards,
Andy Shevchenko
