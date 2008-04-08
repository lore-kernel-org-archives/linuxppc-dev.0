Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id E28E3DDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:27:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 jyoung5@us.ibm.com
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for 44x
	platforms
Date: Tue, 8 Apr 2008 04:21:44 +0200
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
	<835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
	<1207323761.6634.6.camel@thinkpadL>
In-Reply-To: <1207323761.6634.6.camel@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080421.45447.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net, Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 April 2008, Jerone Young wrote:
> > > +int __init ppc44x_idle_init(void)
> > > +{
> > > +=A0=A0=A0void *func =3D modes[current_mode].entry;
> > > +=A0=A0=A0struct device_node *node;
> > > +
> > > +=A0=A0=A0node =3D of_find_node_by_path("/hypervisor");
> > > +=A0=A0=A0if (node) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* if we find /hypervisor node is i=
n device tree,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 set idle mode to wait */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0func =3D &ppc44x_idle; /* wait */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0of_node_put(node);
> > > +=A0=A0=A0}
> > > +
> > > +=A0=A0=A0ppc_md.power_save =3D func;
> > > +=A0=A0=A0return 0;
> > > +}
> > > +
> > > +arch_initcall(ppc44x_idle_init);
> >=20
> > IIRC, this would over-ride the idle_param() below, is that the =A0
> > intended behavior?
>=20
> Yes. At the moment if it detects a hypervisor in the kernel tree it
> overrides what the command line says.
>=20

This is unusual behavior. Normally, we try to come up with reasonable
defaults and give the user the chance to override it.

	Arnd <><
