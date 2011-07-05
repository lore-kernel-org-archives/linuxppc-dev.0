Return-Path: <ohad@wizery.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5F06B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 00:07:06 +1000 (EST)
Received: by wwj40 with SMTP id 40so4757098wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 07:07:02 -0700 (PDT)
From: Ohad Ben-Cohen <ohad@wizery.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux-foundation.org
Subject: [RFC] virtio: expose for non-virtualization users too
Date: Tue,  5 Jul 2011 17:06:14 +0300
Message-Id: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, linux-ia64@vger.kernel.org,
	kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org, Alexander Graf <agraf@suse.de>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Xiantao Zhang <xiantao.zhang@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Chris Metcalf <cmetcalf@tilera.com>,
	John Stultz <john.stultz@linaro.org>, kvm-ppc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Luck <tony.luck@intel.com>, kvm-ia64@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

virtio has been so far used only in the context of virtualization,
and the virtio Kconfig was sourced directly by the relevant arch
Kconfigs when VIRTUALIZATION was selected.

Now that we start using virtio for inter-processor communications,
we need to source the virtio Kconfig outside of the virtualization
scope too.

Moreover, some architectures might use virtio for both virtualization
and inter-processor communications, so directly sourcing virtio
might yield unexpected results due to conflicting selections.

The simple solution offered by this patch is to always source virtio's
Kconfig in drivers/Kconfig, and remove it from the appropriate arch
Kconfigs. Additionally, a virtio menu entry has been added so virtio
drivers don't show up in the general drivers menu.

This way anyone can use virtio, though it's arguably less accessible
(and neat!) for virtualization users now.

Note: some architectures (mips and sh) seem to have a VIRTUALIZATION
menu merely for sourcing virtio's Kconfig, so that menu is removed too.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
The motivation behind this patch is: https://lkml.org/lkml/2011/6/21/47

If the general approach is agreed upon, we can either merge the patch
independently, or add it to the AMP patch set.

 arch/ia64/kvm/Kconfig    |    1 -
 arch/mips/Kconfig        |   16 ----------------
 arch/powerpc/kvm/Kconfig |    1 -
 arch/s390/kvm/Kconfig    |    1 -
 arch/sh/Kconfig          |   16 ----------------
 arch/tile/kvm/Kconfig    |    1 -
 arch/x86/kvm/Kconfig     |    1 -
 drivers/Kconfig          |    2 ++
 drivers/virtio/Kconfig   |    3 +++
 9 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/arch/ia64/kvm/Kconfig b/arch/ia64/kvm/Kconfig
index fa4d1e5..9806e55 100644
--- a/arch/ia64/kvm/Kconfig
+++ b/arch/ia64/kvm/Kconfig
@@ -49,6 +49,5 @@ config KVM_INTEL
 	  extensions.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653da62..a627a2c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2489,20 +2489,4 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
-menuconfig VIRTUALIZATION
-	bool "Virtualization"
-	default n
-	---help---
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-source drivers/virtio/Kconfig
-
-endif # VIRTUALIZATION
-
 source "lib/Kconfig"
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index b7baff7..105b691 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -99,6 +99,5 @@ config KVM_E500
 	  If unsure, say N.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index f66a1bd..a216341 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -37,6 +37,5 @@ config KVM
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index bbdeb48..748ff19 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -897,20 +897,4 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
-menuconfig VIRTUALIZATION
-	bool "Virtualization"
-	default n
-	---help---
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-source drivers/virtio/Kconfig
-
-endif # VIRTUALIZATION
-
 source "lib/Kconfig"
diff --git a/arch/tile/kvm/Kconfig b/arch/tile/kvm/Kconfig
index b88f9c0..669fcdb 100644
--- a/arch/tile/kvm/Kconfig
+++ b/arch/tile/kvm/Kconfig
@@ -33,6 +33,5 @@ config KVM
 	  If unsure, say N.
 
 source drivers/vhost/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 50f6364..65cf823 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -76,6 +76,5 @@ config KVM_MMU_AUDIT
 # the virtualization menu.
 source drivers/vhost/Kconfig
 source drivers/lguest/Kconfig
-source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 3bb154d..795218e 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -114,6 +114,8 @@ source "drivers/uio/Kconfig"
 
 source "drivers/vlynq/Kconfig"
 
+source "drivers/virtio/Kconfig"
+
 source "drivers/xen/Kconfig"
 
 source "drivers/staging/Kconfig"
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 3dd6294..57e493b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -7,6 +7,8 @@ config VIRTIO_RING
 	tristate
 	depends on VIRTIO
 
+menu "Virtio drivers"
+
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL
@@ -33,3 +35,4 @@ config VIRTIO_BALLOON
 
 	 If unsure, say M.
 
+endmenu
-- 
1.7.1
