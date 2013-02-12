Return-Path: <B11780@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 067D52C038B
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 07:01:14 +1100 (EST)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix various PCI node compatible strings
Date: Tue, 12 Feb 2013 20:01:04 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D7165C0@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1358462073-2558-1-git-send-email-timur@tabi.org>
In-Reply-To: <1358462073-2558-1-git-send-email-timur@tabi.org>
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
> Fix and/or improve the compatible strings of the PCI device tree nodes fo=
r
> some Freescale SOCs.  This fixes some issues and improves consistency amo=
ng
> the SOCs.
>=20
> Specifically:
>=20
> 1) The P1022 has a v1 PCIe controller, so the compatible property should =
just
> say "fsl,mpc8548-pcie".  U-Boot does not look for "fsl,p1022-pcie", so it
> wasn't fixing up the node.
>=20
> 2) The P4080 has a v2.1 PCIe controller, so add that version-specific str=
ing
> to the device tree.  Update the kernel to also look for that string.
> Currently, the kernel looks for "fsl,p4080-pcie" specifically, but
> eventually that check should be deleted.
>=20
> 3) The P1010 device tree claims compatibility with v2.2 and v2.3, but tha=
t's
> redundant.  No other device tree does this.  Remove the v2.2 string.
>=20
> 4) The kernel looks for both "fsl,p1023-pcie" and "fsl,qoriq-pcie-v2.2",
> even though the P1023 device trees has always included both strings.  Rem=
ove
> the search for "fsl,p1023-pcie".
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p1010si-post.dtsi |    4 ++--
> arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    6 +++---
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    6 +++---
> arch/powerpc/sysdev/fsl_pci.c               |   15 ++++++++++-----
> 4 files changed, 18 insertions(+), 13 deletions(-)

applied to next

- k=
