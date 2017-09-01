Return-Path: <dja@axtens.net>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk9pK3yWvzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 17:28:41 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id r187so1171212pfr.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 00:28:41 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgaas@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, lukas@wunner.de,
 ard.biesheuvel@linaro.org, lorenzo.pieralisi@arm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 3/3] drm: documentation for default display device
Date: Fri,  1 Sep 2017 17:27:44 +1000
Message-Id: <20170901072744.2409-4-dja@axtens.net>
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have refactored and extended this - document it.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/gpu/default_display.rst | 93 +++++++++++++++++++++++++++++++++++
 Documentation/gpu/index.rst           |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/gpu/default_display.rst

diff --git a/Documentation/gpu/default_display.rst b/Documentation/gpu/default_display.rst
new file mode 100644
index 000000000000..3c190611564e
--- /dev/null
+++ b/Documentation/gpu/default_display.rst
@@ -0,0 +1,93 @@
+=======================
+Default Display Devices
+=======================
+
+Overview
+========
+
+.. kernel-doc:: drivers/gpu/vga/default_display.c
+		:doc: overview
+
+
+Why do we need this?
+====================
+
+The default device is used to set the ``boot_vga`` per-device sysfs
+file, which is used by user-space. Most notably, Xorg reads this file
+via libpciaccess in order to facilitate auto-configuration.
+
+
+History
+=======
+
+When the VGA arbiter was introduced, it would pick a default device on
+boot. As the arbiter exists to arbitrate access to legacy resources,
+it would only pick a card that could be accessed through legacy areas.
+(See the :doc:`vgaarbiter` documentation for more.)
+
+The arbiter was later extended on x86 and IA64 to consider the EFI
+framebuffer.
+
+This is all well and good if you have legacy resources or
+EFI. However, some systems do not have either of those. For example,
+on POWER8: [0]_
+
+ - There is no IO space at all
+
+ - We configure the 32-bit MMIO window to be around 3..4G (to avoid
+   overlapping with DMA space below it).
+
+So effectively, there is no path to the legacy areas.
+
+This means the VGA arbiter will not pick a default device on these
+platforms. So, on powerpc, a class hook was added to mark a default
+device (``arch/powerpc/kernel/pci-common.c``), independent of the
+arbiter.
+
+When this issue arose on an arm64 system, it was decided that a generic
+approach would be better than more special cases. Therefore, the
+default device selection was factored out, and it now operates using
+the priority list described in the Overview.
+
+API
+===
+
+Public
+------
+
+.. kernel-doc:: drivers/gpu/vga/default_display.c
+		:export:
+
+Private
+-------
+
+.. kernel-doc:: drivers/gpu/vga/default_display.c
+		:internal:
+
+Future Work
+===========
+
+There is no support for non-PCI VGA devices being marked as default.
+The following comment, extracted from an earlier version of
+:c:func:`pci_default_display()` might help:
+
+  If your VGA default device is not PCI, you'll have to override this
+  and return NULL here. In this case, I assume it will not conflict
+  with any PCI card. If this is not true, I'll have to define two
+  archs hooks for enabling/disabling the VGA default device if that
+  is possible. 
+
+  This may be a problem with real _ISA_ VGA cards, in addition to a
+  PCI one. I don't know at this point how to deal with that card. Can
+  theirs IOs be disabled at all ? If not, then I suppose it's a matter
+  of having the proper arch hook telling us about it, so we basically
+  never allow anybody to succeed a ``vga_get()``...
+
+Currently there is also no way to support non-VGA-class PCI devices as
+default display devices.
+
+
+References
+==========
+	   
+.. [0] https://www.spinics.net/lists/linux-pci/msg64142.html
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index 35d673bf9b56..8083d84f2334 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -16,6 +16,7 @@ Linux GPU Driver Developer's Guide
    tegra
    tinydrm
    vc4
+   default_display
    vga-switcheroo
    vgaarbiter
    bridge/dw-hdmi
-- 
2.11.0
