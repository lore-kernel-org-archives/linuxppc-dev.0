Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9B4AADDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 10:18:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: jyoung5@us.ibm.com
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
Date: Fri, 11 Apr 2008 02:18:22 +0200
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
	<200804101544.44457.arnd@arndb.de>
	<1207858131.26428.4.camel@thinkpadL>
In-Reply-To: <1207858131.26428.4.camel@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804110218.23912.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008, Jerone Young wrote:
> Well it could be this simple. But the current code leaves a lot more
> room to add different type waits or spins if need be (if they are ever
> needed ... though none off the top of my head at the moment)...but it
> does allow you to create another wait state for whatever reason a lot
> easier.
>=20
> So I really don't think this needs to change. Unless everyone really
> feels that it just has to be.

No, it doesn't need to change, the current patch is entirely correct,
just a little bit more complicated than it needs to be, and I try
not to have code in anticipation of something getting more complicated
in the future, you can always add the complexity at the point where you
need it.

> >=20
> > static int __init idle_param(char *p)
> > {
> > =A0=A0=A0=A0=A0=A0if (!strcmp(modes[i].name, "spin"))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_md.power_save =3D NULL;
> > }
> > early_param("idle", idle_param);
> >=20
> > if you statically initialize the ppc_md.power_save function to ppc44x_i=
dle
> > in the platform setup files?
>=20
> The idea is to not statically initialize ppc_md.power_save to
> ppc44x_idle in each platform setup file.
>=20

Why not? Unlike the platform_initcall, it wouldn't cost anything and your
current code has the same effect in the end, but in a less obvious way.

	Arnd <><
