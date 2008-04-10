Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 386A3DE62B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 23:50:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
Date: Thu, 10 Apr 2008 15:44:43 +0200
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
In-Reply-To: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804101544.44457.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008, Jerone Young wrote:
> +static struct sleep_mode modes[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{ .name =3D "wait", .entry =3D &ppc44x_idle },
> +=A0=A0=A0=A0=A0=A0=A0{ .name =3D "spin", .entry =3D NULL },
> +};
> +
> +int __init ppc44x_idle_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0void *func =3D modes[current_mode].entry;
> +=A0=A0=A0=A0=A0=A0=A0ppc_md.power_save =3D func;
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +
> +arch_initcall(ppc44x_idle_init);
> +
> +static int __init idle_param(char *p)
> +{=20
> +=A0=A0=A0=A0=A0=A0=A0int i;
> +
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!strcmp(modes[i].name, =
p)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cur=
rent_mode =3D i;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bre=
ak;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +
> +early_param("idle", idle_param);

ok, sorry to steal the show again, now that everyone seems to be happy
with the current code, but isn't this equivalent to the simpler

static int __init idle_param(char *p)
{
	if (!strcmp(modes[i].name, "spin"))
		ppc_md.power_save =3D NULL;
}
early_param("idle", idle_param);

if you statically initialize the ppc_md.power_save function to ppc44x_idle
in the platform setup files?

	Arnd <><
