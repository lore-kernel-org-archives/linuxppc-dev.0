Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id E6C8ADDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 19:29:31 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Tue, 5 Jun 2007 11:29:25 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706050900.54022.jdubois@mc.com>
	<200706051116.13863.arnd@arndb.de>
In-Reply-To: <200706051116.13863.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706051129.25832.jdubois@mc.com>
Cc: linuxppc-dev@ozlabs.org, Christian Rund <crund@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 June 2007 11:16:13 Arnd Bergmann wrote:
> On Tuesday 05 June 2007, Jean-Christophe Dubois wrote:
> > On Monday 04 June 2007 15:00:05 Michael Ellerman wrote:
> > > +=A0=A0=A0=A0=A0=A0=A0pr_debug("axon_msi: initialising ...\n");
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(node, NULL, "ibm,axon-=
msic") {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (axon_msi_setup_one(=
of_node_get(node)) =3D=3D 0)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0found++;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0of_node_put(node);
> >
> > 2 comments:
> >
> > 1) There is no "ibm,axon-msic" compatible property in the SLOF tree
> > provided by IBM on the CAB (or other such platforms). Therefore this co=
de
> > will not work on these platforms.
>
> Right, the firmware needs to support msi so we can use it. I guess taht's
> true for every device: If the firmware decies to hide it from us, we bett=
er
> don't try to touch it.

The SLOF firmware we have has an MSI node, just not one that=20
is "ibm,axon-msic" compatible. So nothing is hidden, quite the opposite.

> > 2) you should somehow check for the Axon version. Axon 1.1 (and prior)
> > are know to be loosing MSI/MBX interrupts (but not the data part
> > associated to them). Therefore this should be enabled only on Axon 2.1
> > (or later).
>
> Good point, thanks for mentioning it. Christian, can you confirm that the
> ibm,axon-msic node is only created on systems with axon 2.1 or later?
>
> 	Arnd <><
