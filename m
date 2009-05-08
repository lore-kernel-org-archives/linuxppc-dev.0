Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 27DB9DDF9D
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 01:40:30 +1000 (EST)
Received: by gxk20 with SMTP id 20so2982326gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 08 May 2009 08:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090508123413.GC3100@pengutronix.de>
References: <20090508123413.GC3100@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 May 2009 09:40:08 -0600
Message-ID: <fa686aa40905080840x308c1addld75b1ec5df386c13@mail.gmail.com>
Subject: Re: [PATCH] mpc5121/clocks: make debug output more readable
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 8, 2009 at 6:34 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> - Drop KERN_ levels for printks which print to the same line
> - use '=3D' in output to connect key/value pairs

Personally, I'd rather see the printks converted to pr_info()/pr_cont().

g.

>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: John Rigby <jcrigby@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
>
> ---
> =A0arch/powerpc/platforms/512x/clock.c | =A0 =A07 +++----
> =A01 file changed, 3 insertions(+), 4 deletions(-)
>
> Index: .kernel/arch/powerpc/platforms/512x/clock.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- .kernel.orig/arch/powerpc/platforms/512x/clock.c
> +++ .kernel/arch/powerpc/platforms/512x/clock.c
> @@ -83,12 +83,11 @@ static void dump_clocks(void)
> =A0 =A0 =A0 =A0mutex_lock(&clocks_mutex);
> =A0 =A0 =A0 =A0printk(KERN_INFO "CLOCKS:\n");
> =A0 =A0 =A0 =A0list_for_each_entry(p, &clocks, node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO " =A0%s %ld", p->name, p->=
rate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO " =A0%s=3D%ld", p->name, p=
->rate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO " %s %ld",=
 p->parent->name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p->parent->r=
ate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(" %s=3D%ld", p->pare=
nt->name, p->parent->rate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->flags & CLK_HAS_CTRL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO " reg/bit =
%d/%d", p->reg, p->bit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(" reg/bit=3D%d/%d", =
p->reg, p->bit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("\n");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&clocks_mutex);
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoEJsUACgkQD27XaX1/VRuQggCgm7auPJpCpTVleUD30B86X/jW
> lZsAnR91XB0YVCBp95aGyEqUU8+LXaHv
> =3D6IcQ
> -----END PGP SIGNATURE-----
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
