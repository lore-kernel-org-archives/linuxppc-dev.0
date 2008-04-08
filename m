Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 158C0DDEF4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:37:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m382bWVW020753
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:37:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m382bWl1154056
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:37:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m382bVsg018637
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:37:32 -0600
Date: Mon, 7 Apr 2008 21:35:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for 44x
	platforms
Message-ID: <20080407213558.786910bc@zod.rchland.ibm.com>
In-Reply-To: <200804080421.45447.arnd@arndb.de>
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
	<835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
	<1207323761.6634.6.camel@thinkpadL>
	<200804080421.45447.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Apr 2008 04:21:44 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 04 April 2008, Jerone Young wrote:
> > > > +int __init ppc44x_idle_init(void)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0void *func =3D modes[current_mode].entry;
> > > > +=C2=A0=C2=A0=C2=A0struct device_node *node;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0node =3D of_find_node_by_path("/hypervisor");
> > > > +=C2=A0=C2=A0=C2=A0if (node) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/* if we find /hypervisor node is in device tree,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0 set idle mode to wait */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
func =3D &ppc44x_idle; /* wait */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
of_node_put(node);
> > > > +=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0ppc_md.power_save =3D func;
> > > > +=C2=A0=C2=A0=C2=A0return 0;
> > > > +}
> > > > +
> > > > +arch_initcall(ppc44x_idle_init);
> > >=20
> > > IIRC, this would over-ride the idle_param() below, is that the =C2=A0
> > > intended behavior?
> >=20
> > Yes. At the moment if it detects a hypervisor in the kernel tree it
> > overrides what the command line says.
> >=20
>=20
> This is unusual behavior. Normally, we try to come up with reasonable
> defaults and give the user the chance to override it.

The /hypervisor check is going away completely in the next version of
the patch.  I've spoken to the HW guys and am more comfortable with
wait being the default.  The spin version should still be an option,
specified by the kernel parameter.

josh
