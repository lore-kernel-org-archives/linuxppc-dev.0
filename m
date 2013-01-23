Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEE2A2C008D
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 09:15:32 +1100 (EST)
Date: Wed, 23 Jan 2013 16:15:19 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: describe the PAMU topology in the
 device tree
To: Gala Kumar-B11780 <B11780@freescale.com>
References: <1358462073-2558-1-git-send-email-timur@tabi.org>
 <1358462073-2558-2-git-send-email-timur@tabi.org>
 <CF1EE7AED478CD48A05574C8E2DA142D6DA7A5@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <CF1EE7AED478CD48A05574C8E2DA142D6DA7A5@039-SN1MPN1-005.039d.mgd.msft.net>
 (from B11780@freescale.com on Wed Jan 23 11:27:29 2013)
Message-ID: <1358979319.9710.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, Timur Tabi <timur@tabi.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2013 11:27:29 AM, Gala Kumar-B11780 wrote:
>=20
> On Jan 17, 2013, at 4:34 PM, Timur Tabi wrote:
>=20
> > From: Timur Tabi <timur@freescale.com>
> >
> > The PAMU caches use the LIODNs to determine which cache lines hold =20
> the
> > entries for the corresponding LIODs.  The LIODNs must therefore be
> > carefully assigned to avoid cache thrashing -- two active LIODs with
> > LIODNs that put them in the same cache line.
> >
> > Currently, LIODNs are statically assigned by U-Boot, but this has
> > limitations.  LIODNs are assigned even for devices that may be =20
> disabled
> > or unused by the kernel.  Static assignments also do not allow for =20
> device
> > drivers which may know which LIODs can be used simultaneously.  In
> > other words, we really should assign LIODNs dynamically in Linux.
> >
> > To do that, we need to describe the PAMU device and cache =20
> topologies in
> > the device trees.
> >
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> > .../devicetree/bindings/powerpc/fsl/guts.txt       |   14 ++-
> > .../devicetree/bindings/powerpc/fsl/pamu.txt       |  142 =20
> ++++++++++++++++++++
> > arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   87 =20
> +++++++++++--
> > arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   87 =20
> +++++++++++--
> > arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   68 +++++++++-
> > arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   92 =20
> +++++++++++--
> > arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   92 =20
> +++++++++++--
> > 7 files changed, 533 insertions(+), 49 deletions(-)
> > create mode 100644 =20
> Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
>=20
> Scott, Stuart, does this have your guys Ack?

ACK

-Scott=
