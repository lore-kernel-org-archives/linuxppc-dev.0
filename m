Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2EA41A0245
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 17:39:24 +1000 (AEST)
Received: by pacwb2 with SMTP id wb2so713472pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2015 00:39:22 -0700 (PDT)
Date: Tue, 1 Sep 2015 15:39:01 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 Geoff Levand <geoff@infradead.org>, Olof Johansson <olof@lixom.net>,
 Paul Mackerras <paulus@samba.org>, Alistair Popple <alistair@popple.id.au>,
 Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Question] Is little endian supported on all the platforms?
Message-ID: <20150901073901.GA2060@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
 <1441019966.31779.1.camel@ellerman.id.au>
 <55E444C6.9070706@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55E444C6.9070706@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 31, 2015 at 02:12:54PM +0200, C=E9dric Le Goater wrote:
>=20
>=20
> or like this, to be consistent with the other *_CPU configs in Kconfig.cp=
utype :
>=20
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -1,6 +1,6 @@
>  config PPC_PS3
>         bool "Sony PS3"
> -       depends on PPC64 && PPC_BOOK3S
> +       depends on PPC64 && PPC_BOOK3S && !CPU_LITTLE_ENDIAN
>         select PPC_CELL
>         select USB_OHCI_LITTLE_ENDIAN
>         select USB_OHCI_BIG_ENDIAN_MMIO
>

Hmm.. this works, however I would prefer to CPU_BIG_ENDIAN rather than
!CPU_LITTLE_ENDIAN because CPU_BIG_ENDIAN is more straightforward.

Does this look good?

Regards,
Boqun

-------8<
Subject: [PATCH] powerpc: Kconfig: remove BE-only platforms in LE kernel bu=
ild

Currently, little endian is only supported on powernv and pseries,
however, Kconfig still allow us to include other platforms in a LE
kernel, this may result in space wasting or even build errors if some
BE-only platforms always assume they are built for a BE kernel. So just
modify the Kconfigs in BE-only platforms to remove them from being built
for a LE kernel.

For 32bit only platforms, nothing needs to be done, because LE depends on
PPC64. For 64bit supported platforms, add CPU_BIG_ENDIAN to dependencies
explicitly [Suggested-by: C=E9dric Le Goater <clg@fr.ibm.com>].

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/powerpc/platforms/cell/Kconfig     | 4 ++--
 arch/powerpc/platforms/maple/Kconfig    | 2 +-
 arch/powerpc/platforms/pasemi/Kconfig   | 2 +-
 arch/powerpc/platforms/powermac/Kconfig | 2 +-
 arch/powerpc/platforms/ps3/Kconfig      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/c=
ell/Kconfig
index b0ac177..429fc59 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -25,7 +25,7 @@ config PPC_CELL_NATIVE
=20
 config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL_NATIVE
 	select PPC_OF_PLATFORM_PCI
 	select PCI
@@ -35,7 +35,7 @@ config PPC_IBM_CELL_BLADE
=20
 config PPC_CELL_QPACE
 	bool "IBM Cell - QPACE"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL_COMMON
=20
 config AXON_MSI
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/=
maple/Kconfig
index 1ea621a..e359d0d 100644
--- a/arch/powerpc/platforms/maple/Kconfig
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -1,5 +1,5 @@
 config PPC_MAPLE
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "Maple 970FX Evaluation Board"
 	select PCI
 	select MPIC
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms=
/pasemi/Kconfig
index a2aeb32..00d4b28 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -1,5 +1,5 @@
 config PPC_PASEMI
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "PA Semi SoC-based platforms"
 	default n
 	select MPIC
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platfor=
ms/powermac/Kconfig
index 607124b..43c6062 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -1,6 +1,6 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
-	depends on PPC_BOOK3S
+	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
 	select MPIC
 	select PCI
 	select PPC_INDIRECT_PCI if PPC32
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps=
3/Kconfig
index 56f2740..b27f40f 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -1,6 +1,6 @@
 config PPC_PS3
 	bool "Sony PS3"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	select PPC_CELL
 	select USB_OHCI_LITTLE_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO
