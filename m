Return-Path: <B11780@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC0982C0347
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 07:01:23 +1100 (EST)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: describe the PAMU topology in the
 device tree
Date: Tue, 12 Feb 2013 20:01:14 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D7165CB@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1358462073-2558-1-git-send-email-timur@tabi.org>
 <1358462073-2558-2-git-send-email-timur@tabi.org>
In-Reply-To: <1358462073-2558-2-git-send-email-timur@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>,
 Yoder Stuart-B08248 <B08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2013, at 4:34 PM, Timur Tabi wrote:

> From: Timur Tabi <timur@freescale.com>
>=20
> The PAMU caches use the LIODNs to determine which cache lines hold the
> entries for the corresponding LIODs.  The LIODNs must therefore be
> carefully assigned to avoid cache thrashing -- two active LIODs with
> LIODNs that put them in the same cache line.
>=20
> Currently, LIODNs are statically assigned by U-Boot, but this has
> limitations.  LIODNs are assigned even for devices that may be disabled
> or unused by the kernel.  Static assignments also do not allow for device
> drivers which may know which LIODs can be used simultaneously.  In
> other words, we really should assign LIODNs dynamically in Linux.
>=20
> To do that, we need to describe the PAMU device and cache topologies in
> the device trees.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/guts.txt       |   14 ++-
> .../devicetree/bindings/powerpc/fsl/pamu.txt       |  142 +++++++++++++++=
+++++
> arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   87 +++++++++++--
> arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   87 +++++++++++--
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   68 +++++++++-
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   92 +++++++++++--
> arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   92 +++++++++++--
> 7 files changed, 533 insertions(+), 49 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/pamu.txt

applied to next

- k=
