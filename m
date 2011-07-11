Return-Path: <B08248@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6E11B6F68
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 00:34:52 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: RFC: top level compatibles for virtual platforms
Date: Mon, 11 Jul 2011 14:34:44 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
In-Reply-To: <CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Tabi Timur-B04825
> Sent: Friday, July 08, 2011 8:39 PM
> To: Yoder Stuart-B08248
> Cc: Grant Likely; Benjamin Herrenschmidt; Gala Kumar-B11780; Wood Scott-B=
07421; Alexander
> Graf; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: top level compatibles for virtual platforms
>=20
> On Fri, Jul 8, 2011 at 1:43 PM, Yoder Stuart-B08248 <B08248@freescale.com=
> wrote:
>=20
> > =A0 "MPC85xxDS" - for a virtual machine for the e500v2 type platforms
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and would support 85xx targets, plus P2=
020, P1022,etc
> >
> > =A0 "corenet-32-ds" - for a virtual machine similar to the 32-bit P4080
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platforms
> >
> > =A0 "corenet-64-ds" - for a virtual machine based on a 64-bit corenet
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform
>=20
> I think we should drop the "DS" because that's a name applied to certain =
Freescale reference
> boards.
>=20
> Is being a CoreNet board really something meaningful with respect to KVM?=
  I don't see the
> connection.

We're talking about what would be meaningful to Linux as a guest on
this platform here--  Corenet-based SoCs are similar=20
in various ways, like using msgsnd for IPIs, having external proxy
support, etc.

A corenet platform created by a QEMU/KVM looks similar
to other corenet SoCs.   So, I'm trying to find some generic
compatible string that describes this platform.

> Also, if these are KVM creations, shouldn't there be a "kvm" in the compa=
tible string
> somewhere?

There is nothing KVM specific about these platforms.  Any hypervisor
could create a similar virtual machine.

A guest OS can determine specific info about the hypervisor it is
running on by looking at the /hypervisor node on the device
tree.

We could put a generic -hv extension to indicate that this is
a virtual platform.

 "mpc85xx-hv"
 "corenet-32-hv"
 "corenet-64-hv"

Stuart
