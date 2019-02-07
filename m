Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A2C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:41:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B902147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/HT/Ddl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B902147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w7yW4cxqzDq5Y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 17:41:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=tobin@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="g/HT/Ddl"; dkim-atps=neutral
X-Greylist: delayed 495 seconds by postgrey-1.36 at bilbo;
 Thu, 07 Feb 2019 17:11:58 AEDT
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w7Hy2rsCzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:11:58 +1100 (AEDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 8AE6C21F4F;
 Thu,  7 Feb 2019 01:03:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 07 Feb 2019 01:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=2YuzsNjNoDScehvMLjZ+6P9tpbAJo33BQ95qT9cozI4=; b=g/HT/Ddl
 aPez/Dvf+cfLsRmgBrJnrSe974+UpmlJuMrjWFLhLGoJHpGUFkufYa9AeRoMeMBJ
 h5IkD9ZwCsY3JKxb3vv0IsiuJVlB7k3BMGTvUREND9vB/2Jc5tcjLaCUBce7WMdv
 VjdCsRxE3Efd9V9ugTYBZhgJ+ZdNNj6XFB9nRBqiwo3mVoqZ0kEKdLSS5/gyX5QO
 mIQfVq5z1dwielDUSnqGuTuOrm9MplGsZtT5ahppV9/zYhZYJqb6qGXXF9t1j0GR
 DI0M6oA8Vs9pq1J9CfPvRkY1txw/lv/nB+JdmTFraZcQGTOZxLG2S9GAl0opgufP
 w5OmrQYJ2n2o3g==
X-ME-Sender: <xms:QMpbXLMbtl0wjueoM9rv8r6-6VdVPV2DgqZJR8QRVa7VIJ39Of-_WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeelgdekkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
 hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
 fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecuffhomhgrihhnpehpohifvghrrd
 horhhgpddvgeeithhnthdrtghomhenucfkphepuddvuddrgeegrddvvdeirddujeelnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlh
 hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QMpbXPzk27kdNIBfDi19Kdc4-MBrzJ4IwySTtH3msSSB2JevYxPWrQ>
 <xmx:QMpbXJHSU1gJOi5EPIj7IdUOUfxMDTE0JJPQa8BLkSm3xNpxk45gug>
 <xmx:QMpbXLEX8GT24tOkBZdUUnN5w9pX8D9hTN8tK5lsAdlD7t_5bIKhKw>
 <xmx:QMpbXJ87U2qhsZDCPVsWl8cSCkMi3zie4LQOf5knvaIbbkyeUAx_HQ>
Received: from eros.localdomain (ppp121-44-226-179.bras2.syd2.internode.on.net
 [121.44.226.179])
 by mail.messagingengine.com (Postfix) with ESMTPA id BCE2CE436D;
 Thu,  7 Feb 2019 01:03:40 -0500 (EST)
From: "Tobin C. Harding" <tobin@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/1] docs: powerpc: Convert to RST format
Date: Thu,  7 Feb 2019 17:03:16 +1100
Message-Id: <20190207060316.3221-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207060316.3221-1-tobin@kernel.org>
References: <20190207060316.3221-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Feb 2019 17:40:26 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <tobin@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The PowerPC docs have yet to be converted to RST format.  Let's kick it
off by doing all the files that _don't_ contain ASCII art.

- Add SPDX license identifier to each new RST file.

    .. SPDX-License-Identifier: GPL-2.0

- User correct heading adornments.

- Make all lines < 72 characters in width.

- Use correct indentation for code blocks, add syntax highlighting

- Sparingly use double ticks if it makes the files easier to parse
  both in text and on the web.

- Fix any super obvious typos (lean towards not making changes so that
  we don't introduce errors).

Edited as text files (obviously) and formatted as HTML to verify
rendering, no other formats verified.

Convert docs to RST format, adding license.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/index.rst                       |   1 +
 Documentation/powerpc/DAWR-POWER9.rst         |  60 ++++
 Documentation/powerpc/DAWR-POWER9.txt         |  58 ---
 Documentation/powerpc/bootwrapper.rst         | 140 ++++++++
 Documentation/powerpc/bootwrapper.txt         | 141 --------
 Documentation/powerpc/conf.py                 |  10 +
 Documentation/powerpc/cpu_features.rst        |  62 ++++
 Documentation/powerpc/cpu_features.txt        |  56 ---
 .../powerpc/eeh-pci-error-recovery.rst        | 319 +++++++++++++++++
 .../powerpc/eeh-pci-error-recovery.txt        | 334 ------------------
 Documentation/powerpc/index.rst               |  21 ++
 Documentation/powerpc/isa-versions.rst        | 234 ++++++++----
 Documentation/powerpc/mpc52xx.rst             |  52 +++
 Documentation/powerpc/mpc52xx.txt             |  39 --
 Documentation/powerpc/pmu-ebb.rst             | 148 ++++++++
 Documentation/powerpc/pmu-ebb.txt             | 137 -------
 Documentation/powerpc/ptrace.rst              | 177 ++++++++++
 Documentation/powerpc/ptrace.txt              | 151 --------
 .../{syscall64-abi.txt => syscall64-abi.rst}  |  80 +++--
 .../powerpc/transactional_memory.rst          | 259 ++++++++++++++
 .../powerpc/transactional_memory.txt          | 244 -------------
 21 files changed, 1460 insertions(+), 1263 deletions(-)
 create mode 100644 Documentation/powerpc/DAWR-POWER9.rst
 delete mode 100644 Documentation/powerpc/DAWR-POWER9.txt
 create mode 100644 Documentation/powerpc/bootwrapper.rst
 delete mode 100644 Documentation/powerpc/bootwrapper.txt
 create mode 100644 Documentation/powerpc/conf.py
 create mode 100644 Documentation/powerpc/cpu_features.rst
 delete mode 100644 Documentation/powerpc/cpu_features.txt
 create mode 100644 Documentation/powerpc/eeh-pci-error-recovery.rst
 delete mode 100644 Documentation/powerpc/eeh-pci-error-recovery.txt
 create mode 100644 Documentation/powerpc/index.rst
 create mode 100644 Documentation/powerpc/mpc52xx.rst
 delete mode 100644 Documentation/powerpc/mpc52xx.txt
 create mode 100644 Documentation/powerpc/pmu-ebb.rst
 delete mode 100644 Documentation/powerpc/pmu-ebb.txt
 create mode 100644 Documentation/powerpc/ptrace.rst
 delete mode 100644 Documentation/powerpc/ptrace.txt
 rename Documentation/powerpc/{syscall64-abi.txt => syscall64-abi.rst} (58%)
 create mode 100644 Documentation/powerpc/transactional_memory.rst
 delete mode 100644 Documentation/powerpc/transactional_memory.txt

diff --git a/Documentation/index.rst b/Documentation/index.rst
index c858c2e66e36..e0cf2e4a78cf 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,7 @@ implementation.
    :maxdepth: 2
 
    sh/index
+   powerpc/index
 
 Filesystem Documentation
 ------------------------
diff --git a/Documentation/powerpc/DAWR-POWER9.rst b/Documentation/powerpc/DAWR-POWER9.rst
new file mode 100644
index 000000000000..0af7c9567931
--- /dev/null
+++ b/Documentation/powerpc/DAWR-POWER9.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+DAWR issues on POWER9
+=====================
+
+On POWER9 the DAWR can cause a checkstop if it points to cache inhibited
+(CI) memory. Currently Linux has no way to disinguish CI memory when
+configuring the DAWR, so (for now) the DAWR is disabled by this commit::
+
+    commit 9654153158d3e0684a1bdb76dbababdb7111d5a0
+    Author: Michael Neuling <mikey@neuling.org>
+    Date:   Tue Mar 27 15:37:24 2018 +1100
+    powerpc: Disable DAWR in the base POWER9 CPU features
+
+Technical details
+=================
+
+DAWR has 6 different ways of being set.
+
+1. ptrace
+2. h_set_mode(DAWR)
+3. h_set_dabr()
+4. kvmppc_set_one_reg()
+5. xmon
+
+For ptrace, we now advertise zero breakpoints on POWER9 via the
+PPC_PTRACE_GETHWDBGINFO call. This results in GDB falling back to
+software emulation of the watchpoint (which is slow).
+
+h_set_mode(DAWR) and h_set_dabr() will now return an error to the guest
+on a POWER9 host. Current Linux guests ignore this error, so they will
+silently not get the DAWR.
+
+kvmppc_set_one_reg() will store the value in the vcpu but won't actually
+set it on POWER9 hardware. This is done so we don't break migration from
+POWER8 to POWER9, at the cost of silently losing the DAWR on the
+migration.
+
+For xmon, the 'bd' command will return an error on P9.
+
+Consequences for users
+======================
+
+For GDB watchpoints (ie 'watch' command) on POWER9 bare metal , GDB will
+accept the command. Unfortunately since there is no hardware support for
+the watchpoint, GDB will software emulate the watchpoint making it run
+very slowly.
+
+The same will also be true for any guests started on a POWER9 host. The
+watchpoint will fail and GDB will fall back to software emulation.
+
+If a guest is started on a POWER8 host, GDB will accept the watchpoint
+and configure the hardware to use the DAWR. This will run at full speed
+since it can use the hardware emulation. Unfortunately if this guest is
+migrated to a POWER9 host, the watchpoint will be lost on the
+POWER9. Loads and stores to the watchpoint locations will not be trapped
+in GDB. The watchpoint is remembered, so if the guest is migrated back
+to the POWER8 host, it will start working again.
+
diff --git a/Documentation/powerpc/DAWR-POWER9.txt b/Documentation/powerpc/DAWR-POWER9.txt
deleted file mode 100644
index 2feaa6619658..000000000000
--- a/Documentation/powerpc/DAWR-POWER9.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-DAWR issues on POWER9
-============================
-
-On POWER9 the DAWR can cause a checkstop if it points to cache
-inhibited (CI) memory. Currently Linux has no way to disinguish CI
-memory when configuring the DAWR, so (for now) the DAWR is disabled by
-this commit:
-
-    commit 9654153158d3e0684a1bdb76dbababdb7111d5a0
-    Author: Michael Neuling <mikey@neuling.org>
-    Date:   Tue Mar 27 15:37:24 2018 +1100
-    powerpc: Disable DAWR in the base POWER9 CPU features
-
-Technical Details:
-============================
-
-DAWR has 6 different ways of being set.
-1) ptrace
-2) h_set_mode(DAWR)
-3) h_set_dabr()
-4) kvmppc_set_one_reg()
-5) xmon
-
-For ptrace, we now advertise zero breakpoints on POWER9 via the
-PPC_PTRACE_GETHWDBGINFO call. This results in GDB falling back to
-software emulation of the watchpoint (which is slow).
-
-h_set_mode(DAWR) and h_set_dabr() will now return an error to the
-guest on a POWER9 host. Current Linux guests ignore this error, so
-they will silently not get the DAWR.
-
-kvmppc_set_one_reg() will store the value in the vcpu but won't
-actually set it on POWER9 hardware. This is done so we don't break
-migration from POWER8 to POWER9, at the cost of silently losing the
-DAWR on the migration.
-
-For xmon, the 'bd' command will return an error on P9.
-
-Consequences for users
-============================
-
-For GDB watchpoints (ie 'watch' command) on POWER9 bare metal , GDB
-will accept the command. Unfortunately since there is no hardware
-support for the watchpoint, GDB will software emulate the watchpoint
-making it run very slowly.
-
-The same will also be true for any guests started on a POWER9
-host. The watchpoint will fail and GDB will fall back to software
-emulation.
-
-If a guest is started on a POWER8 host, GDB will accept the watchpoint
-and configure the hardware to use the DAWR. This will run at full
-speed since it can use the hardware emulation. Unfortunately if this
-guest is migrated to a POWER9 host, the watchpoint will be lost on the
-POWER9. Loads and stores to the watchpoint locations will not be
-trapped in GDB. The watchpoint is remembered, so if the guest is
-migrated back to the POWER8 host, it will start working again.
-
diff --git a/Documentation/powerpc/bootwrapper.rst b/Documentation/powerpc/bootwrapper.rst
new file mode 100644
index 000000000000..fd12c4fcd300
--- /dev/null
+++ b/Documentation/powerpc/bootwrapper.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+The PowerPC boot wrapper
+========================
+
+Copyright (C) Secret Lab Technologies Ltd.
+
+PowerPC image targets compresses and wraps the kernel image (vmlinux)
+with a boot wrapper to make it usable by the system firmware.  There is
+no standard PowerPC firmware interface, so the boot wrapper is designed
+to be adaptable for each kind of image that needs to be built.
+
+The boot wrapper can be found in the arch/powerpc/boot/ directory.  The
+Makefile in that directory has targets for all the available image
+types.  The different image types are used to support all of the various
+firmware interfaces found on PowerPC platforms.  OpenFirmware is the
+most commonly used firmware type on general purpose PowerPC systems from
+Apple, IBM and others.  U-Boot is typically found on embedded PowerPC
+hardware, but there are a handful of other firmware implementations
+which are also popular.  Each firmware interface requires a different
+image format.
+
+The boot wrapper is built from the makefile in
+arch/powerpc/boot/Makefile and it uses the wrapper script
+(arch/powerpc/boot/wrapper) to generate target image.  The details of
+the build system is discussed in the next section.  Currently, the
+following image format targets exist:
+
+- ``cuImage.%``: Backwards compatible uImage for older version of U-Boot
+  (for versions that don't understand the device tree).  This image
+  embeds a device tree blob inside the image.  The boot wrapper, kernel
+  and device tree are all embedded inside the U-Boot uImage file format
+  with boot wrapper code that extracts data from the old bd_info
+  structure and loads the data into the device tree before jumping into
+  the kernel.  Because of the series of #ifdefs found in the bd_info
+  structure used in the old U-Boot interfaces, cuImages are platform
+  specific.  Each specific U-Boot platform has a different platform init
+  file which populates the embedded device tree with data from the
+  platform specific bd_info file.  The platform specific cuImage
+  platform init code can be found in arch/powerpc/boot/cuboot.*.c.
+  Selection of the correct cuImage init code for a specific board can be
+  found in the wrapper structure.
+
+- ``dtbImage.%``: Similar to zImage, except device tree blob is embedded
+  inside the image instead of provided by firmware.  The output image
+  file can be either an elf file or a flat binary depending on the
+  platform.  dtbImages are used on systems which do not have an
+  interface for passing a device tree directly.  dtbImages are similar
+  to simpleImages except that dtbImages have platform specific code for
+  extracting data from the board firmware, but simpleImages do not talk
+  to the firmware at all.  PlayStation 3 support uses dtbImage.  So do
+  Embedded Planet boards using the PlanetCore firmware.  Board specific
+  initialization code is typically found in a file named
+  arch/powerpc/boot/<platform>.c; but this can be overridden by the
+  wrapper script.
+
+- ``simpleImage.%``: Firmware independent compressed image that does not
+  depend on any particular firmware interface and embeds a device tree
+  blob.  This image is a flat binary that can be loaded to any location
+  in RAM and jumped to.  Firmware cannot pass any configuration data to
+  the kernel with this image type and it depends entirely on the
+  embedded device tree for all information.  The simpleImage is useful
+  for booting systems with an unknown firmware interface or for booting
+  from a debugger when no firmware is present (such as on the Xilinx
+  Virtex platform).  The only assumption that simpleImage makes is that
+  RAM is correctly initialized and that the MMU is either off or has RAM
+  mapped to base address 0.  simpleImage also supports inserting special
+  platform specific initialization code to the start of the bootup
+  sequence.  The virtex405 platform uses this feature to ensure that the
+  cache is invalidated before caching is enabled.  Platform specific
+  initialization code is added as part of the wrapper script and is
+  keyed on the image target name.  For example, all
+  simpleImage.virtex405-* targets will add the virtex405-head.S
+  initialization code (This also means that the dts file for virtex405
+  targets should be named (virtex405-<board>.dts).  Search the wrapper
+  script for 'virtex405' and see the file
+  arch/powerpc/boot/virtex405-head.S for details.
+
+- ``treeImage.%``: Image format for used with OpenBIOS firmware found on some
+  ppc4xx hardware.  This image embeds a device tree blob inside the
+  image.
+
+- ``uImage``: Native image format used by U-Boot.  The uImage target does
+  not add any boot code.  It just wraps a compressed vmlinux in the
+  uImage data structure.  This image requires a version of U-Boot that
+  is able to pass a device tree to the kernel at boot.  If using an
+  older version of U-Boot, then you need to use a cuImage instead.
+- ``zImage.%``: Image format which does not embed a device tree.  Used by
+  OpenFirmware and other firmware interfaces which are able to supply a
+  device tree.  This image expects firmware to provide the device tree
+  at boot.  Typically, if you have general purpose PowerPC hardware then
+  you want this image format.
+
+Image types which embed a device tree blob (simpleImage, dtbImage,
+treeImage, and cuImage) all generate the device tree blob from a file in
+the arch/powerpc/boot/dts/ directory.  The Makefile selects the correct
+device tree source based on the name of the target.  Therefore, if the
+kernel is built with 'make treeImage.walnut
+simpleImage.virtex405-ml403', then the build system will use
+arch/powerpc/boot/dts/walnut.dts to build treeImage.walnut and
+arch/powerpc/boot/dts/virtex405-ml403.dts to build the
+simpleImage.virtex405-ml403.
+
+Two special targets called 'zImage' and 'zImage.initrd' also exist.
+These targets build all the default images as selected by the kernel
+configuration.  Default images are selected by the boot wrapper Makefile
+(arch/powerpc/boot/Makefile) by adding targets to the $image-y variable.
+Look at the Makefile to see which default image targets are available.
+
+How it is built
+===============
+
+arch/powerpc is designed to support multiplatform kernels, which means
+that a single vmlinux image can be booted on many different target
+boards.  It also means that the boot wrapper must be able to wrap for
+many kinds of images on a single build.  The design decision was made to
+not use any conditional compilation code (#ifdef, etc) in the boot
+wrapper source code.  All of the boot wrapper pieces are buildable at
+any time regardless of the kernel configuration.  Building all the
+wrapper bits on every kernel build also ensures that obscure parts of
+the wrapper are at the very least compile tested in a large variety of
+environments.
+
+The wrapper is adapted for different image types at link time by linking
+in just the wrapper bits that are appropriate for the image type.  The
+'wrapper script' (found in arch/powerpc/boot/wrapper) is called by the
+Makefile and is responsible for selecting the correct wrapper bits for
+the image type.  The arguments are well documented in the script's
+comment block, so they are not repeated here.  However, it is worth
+mentioning that the script uses the -p (platform) argument as the main
+method of deciding which wrapper bits to compile in.  Look for the large
+'case "$platform" in' block in the middle of the script.  This is also
+the place where platform specific fixups can be selected by changing the
+link order.
+
+In particular, care should be taken when working with cuImages.  cuImage
+wrapper bits are very board specific and care should be taken to make
+sure the target you are trying to build is supported by the wrapper
+bits.
diff --git a/Documentation/powerpc/bootwrapper.txt b/Documentation/powerpc/bootwrapper.txt
deleted file mode 100644
index d60fced5e1cc..000000000000
--- a/Documentation/powerpc/bootwrapper.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-The PowerPC boot wrapper
-------------------------
-Copyright (C) Secret Lab Technologies Ltd.
-
-PowerPC image targets compresses and wraps the kernel image (vmlinux) with
-a boot wrapper to make it usable by the system firmware.  There is no
-standard PowerPC firmware interface, so the boot wrapper is designed to
-be adaptable for each kind of image that needs to be built.
-
-The boot wrapper can be found in the arch/powerpc/boot/ directory.  The
-Makefile in that directory has targets for all the available image types.
-The different image types are used to support all of the various firmware
-interfaces found on PowerPC platforms.  OpenFirmware is the most commonly
-used firmware type on general purpose PowerPC systems from Apple, IBM and
-others.  U-Boot is typically found on embedded PowerPC hardware, but there
-are a handful of other firmware implementations which are also popular.  Each
-firmware interface requires a different image format.
-
-The boot wrapper is built from the makefile in arch/powerpc/boot/Makefile and
-it uses the wrapper script (arch/powerpc/boot/wrapper) to generate target
-image.  The details of the build system is discussed in the next section.
-Currently, the following image format targets exist:
-
-   cuImage.%:		Backwards compatible uImage for older version of
-			U-Boot (for versions that don't understand the device
-			tree).  This image embeds a device tree blob inside
-			the image.  The boot wrapper, kernel and device tree
-			are all embedded inside the U-Boot uImage file format
-			with boot wrapper code that extracts data from the old
-			bd_info structure and loads the data into the device
-			tree before jumping into the kernel.
-			  Because of the series of #ifdefs found in the
-			bd_info structure used in the old U-Boot interfaces,
-			cuImages are platform specific.  Each specific
-			U-Boot platform has a different platform init file
-			which populates the embedded device tree with data
-			from the platform specific bd_info file.  The platform
-			specific cuImage platform init code can be found in
-			arch/powerpc/boot/cuboot.*.c.  Selection of the correct
-			cuImage init code for a specific board can be found in
-			the wrapper structure.
-   dtbImage.%:		Similar to zImage, except device tree blob is embedded
-			inside the image instead of provided by firmware.  The
-			output image file can be either an elf file or a flat
-			binary depending on the platform.
-			  dtbImages are used on systems which do not have an
-			interface for passing a device tree directly.
-			dtbImages are similar to simpleImages except that
-			dtbImages have platform specific code for extracting
-			data from the board firmware, but simpleImages do not
-			talk to the firmware at all.
-			  PlayStation 3 support uses dtbImage.  So do Embedded
-			Planet boards using the PlanetCore firmware.  Board
-			specific initialization code is typically found in a
-			file named arch/powerpc/boot/<platform>.c; but this
-			can be overridden by the wrapper script.
-   simpleImage.%:	Firmware independent compressed image that does not
-			depend on any particular firmware interface and embeds
-			a device tree blob.  This image is a flat binary that
-			can be loaded to any location in RAM and jumped to.
-			Firmware cannot pass any configuration data to the
-			kernel with this image type and it depends entirely on
-			the embedded device tree for all information.
-			  The simpleImage is useful for booting systems with
-			an unknown firmware interface or for booting from
-			a debugger when no firmware is present (such as on
-			the Xilinx Virtex platform).  The only assumption that
-			simpleImage makes is that RAM is correctly initialized
-			and that the MMU is either off or has RAM mapped to
-			base address 0.
-			  simpleImage also supports inserting special platform
-			specific initialization code to the start of the bootup
-			sequence.  The virtex405 platform uses this feature to
-			ensure that the cache is invalidated before caching
-			is enabled.  Platform specific initialization code is
-			added as part of the wrapper script and is keyed on
-			the image target name.  For example, all
-			simpleImage.virtex405-* targets will add the
-			virtex405-head.S initialization code (This also means
-			that the dts file for virtex405 targets should be
-			named (virtex405-<board>.dts).  Search the wrapper
-			script for 'virtex405' and see the file
-			arch/powerpc/boot/virtex405-head.S for details.
-   treeImage.%;		Image format for used with OpenBIOS firmware found
-			on some ppc4xx hardware.  This image embeds a device
-			tree blob inside the image.
-   uImage:		Native image format used by U-Boot.  The uImage target
-			does not add any boot code.  It just wraps a compressed
-			vmlinux in the uImage data structure.  This image
-			requires a version of U-Boot that is able to pass
-			a device tree to the kernel at boot.  If using an older
-			version of U-Boot, then you need to use a cuImage
-			instead.
-   zImage.%:		Image format which does not embed a device tree.
-			Used by OpenFirmware and other firmware interfaces
-			which are able to supply a device tree.  This image
-			expects firmware to provide the device tree at boot.
-			Typically, if you have general purpose PowerPC
-			hardware then you want this image format.
-
-Image types which embed a device tree blob (simpleImage, dtbImage, treeImage,
-and cuImage) all generate the device tree blob from a file in the
-arch/powerpc/boot/dts/ directory.  The Makefile selects the correct device
-tree source based on the name of the target.  Therefore, if the kernel is
-built with 'make treeImage.walnut simpleImage.virtex405-ml403', then the
-build system will use arch/powerpc/boot/dts/walnut.dts to build
-treeImage.walnut and arch/powerpc/boot/dts/virtex405-ml403.dts to build
-the simpleImage.virtex405-ml403.
-
-Two special targets called 'zImage' and 'zImage.initrd' also exist.  These
-targets build all the default images as selected by the kernel configuration.
-Default images are selected by the boot wrapper Makefile
-(arch/powerpc/boot/Makefile) by adding targets to the $image-y variable.  Look
-at the Makefile to see which default image targets are available.
-
-How it is built
----------------
-arch/powerpc is designed to support multiplatform kernels, which means
-that a single vmlinux image can be booted on many different target boards.
-It also means that the boot wrapper must be able to wrap for many kinds of
-images on a single build.  The design decision was made to not use any
-conditional compilation code (#ifdef, etc) in the boot wrapper source code.
-All of the boot wrapper pieces are buildable at any time regardless of the
-kernel configuration.  Building all the wrapper bits on every kernel build
-also ensures that obscure parts of the wrapper are at the very least compile
-tested in a large variety of environments.
-
-The wrapper is adapted for different image types at link time by linking in
-just the wrapper bits that are appropriate for the image type.  The 'wrapper
-script' (found in arch/powerpc/boot/wrapper) is called by the Makefile and
-is responsible for selecting the correct wrapper bits for the image type.
-The arguments are well documented in the script's comment block, so they
-are not repeated here.  However, it is worth mentioning that the script
-uses the -p (platform) argument as the main method of deciding which wrapper
-bits to compile in.  Look for the large 'case "$platform" in' block in the
-middle of the script.  This is also the place where platform specific fixups
-can be selected by changing the link order.
-
-In particular, care should be taken when working with cuImages.  cuImage
-wrapper bits are very board specific and care should be taken to make sure
-the target you are trying to build is supported by the wrapper bits.
diff --git a/Documentation/powerpc/conf.py b/Documentation/powerpc/conf.py
new file mode 100644
index 000000000000..aba67e9e8235
--- /dev/null
+++ b/Documentation/powerpc/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = 'PowerPC Documentation'
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'powerpc.tex', 'Linux Kernel Development Documentation',
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/powerpc/cpu_features.rst b/Documentation/powerpc/cpu_features.rst
new file mode 100644
index 000000000000..fe0b71c23559
--- /dev/null
+++ b/Documentation/powerpc/cpu_features.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+CPU Features
+============
+
+Hollis Blanchard <hollis@austin.ibm.com>
+5 Jun 2002
+
+This document describes the system (including self-modifying code) used
+in the PPC Linux kernel to support a variety of PowerPC CPUs without
+requiring compile-time selection.
+
+Early in the boot process the ppc32 kernel detects the current CPU type
+and chooses a set of features accordingly. Some examples include Altivec
+support, split instruction and data caches, and if the CPU supports the
+DOZE and NAP sleep modes.
+
+Detection of the feature set is simple. A list of processors can be
+found in arch/powerpc/kernel/cputable.c. The PVR register is masked and
+compared with each value in the list. If a match is found, the
+cpu_features of cur_cpu_spec is assigned to the feature bitmask for this
+processor and a __setup_cpu function is called.
+
+C code may test ``cur_cpu_spec[smp_processor_id()]->cpu_features`` for a
+particular feature bit. This is done in quite a few places, for example
+in ppc_setup_l2cr().
+
+Implementing cpufeatures in assembly is a little more involved. There
+are several paths that are performance-critical and would suffer if an
+array index, structure dereference, and conditional branch were
+added. To avoid the performance penalty but still allow for runtime
+(rather than compile-time) CPU selection, unused code is replaced by
+'nop' instructions. This nop'ing is based on CPU 0's capabilities, so a
+multi-processor system with non-identical processors will not work (but
+such a system would likely have other problems anyways).
+
+After detecting the processor type, the kernel patches out sections of
+code that shouldn't be used by writing nop's over it. Using cpufeatures
+requires just 2 macros (found in arch/powerpc/include/asm/cputable.h),
+as seen in head.S transfer_to_handler::
+
+	#ifdef CONFIG_ALTIVEC
+	BEGIN_FTR_SECTION
+		mfspr	r22,SPRN_VRSAVE		/* if G4, save vrsave register value */
+		stw	r22,THREAD_VRSAVE(r23)
+	END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	#endif /* CONFIG_ALTIVEC */
+
+If CPU 0 supports Altivec, the code is left untouched. If it doesn't,
+both instructions are replaced with nop's.
+
+The END_FTR_SECTION macro has two simpler variations:
+END_FTR_SECTION_IFSET and END_FTR_SECTION_IFCLR. These simply test if a
+flag is set (in ``cur_cpu_spec[0]->cpu_features``) or is cleared,
+respectively. These two macros should be used in the majority of cases.
+
+The END_FTR_SECTION macros are implemented by storing information about
+this code in the '__ftr_fixup' ELF section. When do_cpu_ftr_fixups
+(arch/powerpc/kernel/misc.S) is invoked, it will iterate over the
+records in __ftr_fixup, and if the required feature is not present it
+will loop writing nop's from each BEGIN_FTR_SECTION to END_FTR_SECTION.
diff --git a/Documentation/powerpc/cpu_features.txt b/Documentation/powerpc/cpu_features.txt
deleted file mode 100644
index ae09df8722c8..000000000000
--- a/Documentation/powerpc/cpu_features.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Hollis Blanchard <hollis@austin.ibm.com>
-5 Jun 2002
-
-This document describes the system (including self-modifying code) used in the
-PPC Linux kernel to support a variety of PowerPC CPUs without requiring
-compile-time selection.
-
-Early in the boot process the ppc32 kernel detects the current CPU type and
-chooses a set of features accordingly. Some examples include Altivec support,
-split instruction and data caches, and if the CPU supports the DOZE and NAP
-sleep modes.
-
-Detection of the feature set is simple. A list of processors can be found in
-arch/powerpc/kernel/cputable.c. The PVR register is masked and compared with
-each value in the list. If a match is found, the cpu_features of cur_cpu_spec
-is assigned to the feature bitmask for this processor and a __setup_cpu
-function is called.
-
-C code may test 'cur_cpu_spec[smp_processor_id()]->cpu_features' for a
-particular feature bit. This is done in quite a few places, for example
-in ppc_setup_l2cr().
-
-Implementing cpufeatures in assembly is a little more involved. There are
-several paths that are performance-critical and would suffer if an array
-index, structure dereference, and conditional branch were added. To avoid the
-performance penalty but still allow for runtime (rather than compile-time) CPU
-selection, unused code is replaced by 'nop' instructions. This nop'ing is
-based on CPU 0's capabilities, so a multi-processor system with non-identical
-processors will not work (but such a system would likely have other problems
-anyways).
-
-After detecting the processor type, the kernel patches out sections of code
-that shouldn't be used by writing nop's over it. Using cpufeatures requires
-just 2 macros (found in arch/powerpc/include/asm/cputable.h), as seen in head.S
-transfer_to_handler:
-
-	#ifdef CONFIG_ALTIVEC
-	BEGIN_FTR_SECTION
-		mfspr	r22,SPRN_VRSAVE		/* if G4, save vrsave register value */
-		stw	r22,THREAD_VRSAVE(r23)
-	END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	#endif /* CONFIG_ALTIVEC */
-
-If CPU 0 supports Altivec, the code is left untouched. If it doesn't, both
-instructions are replaced with nop's.
-
-The END_FTR_SECTION macro has two simpler variations: END_FTR_SECTION_IFSET
-and END_FTR_SECTION_IFCLR. These simply test if a flag is set (in
-cur_cpu_spec[0]->cpu_features) or is cleared, respectively. These two macros
-should be used in the majority of cases.
-
-The END_FTR_SECTION macros are implemented by storing information about this
-code in the '__ftr_fixup' ELF section. When do_cpu_ftr_fixups
-(arch/powerpc/kernel/misc.S) is invoked, it will iterate over the records in
-__ftr_fixup, and if the required feature is not present it will loop writing
-nop's from each BEGIN_FTR_SECTION to END_FTR_SECTION.
diff --git a/Documentation/powerpc/eeh-pci-error-recovery.rst b/Documentation/powerpc/eeh-pci-error-recovery.rst
new file mode 100644
index 000000000000..2abae1e0a428
--- /dev/null
+++ b/Documentation/powerpc/eeh-pci-error-recovery.rst
@@ -0,0 +1,319 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PCI Bus EEH Error Recovery
+==========================
+
+Linas Vepstas
+<linas@austin.ibm.com>
+12 January 2005
+
+
+Overview
+========
+
+The IBM POWER-based pSeries and iSeries computers include PCI bus
+controller chips that have extended capabilities for detecting and
+reporting a large variety of PCI bus error conditions.  These features
+go under the name of "EEH", for "Enhanced Error Handling".  The EEH
+hardware features allow PCI bus errors to be cleared and a PCI card to
+be "rebooted", without also having to reboot the operating system.
+
+This is in contrast to traditional PCI error handling, where the PCI
+chip is wired directly to the CPU, and an error would cause a CPU
+machine-check/check-stop condition, halting the CPU entirely.  Another
+"traditional" technique is to ignore such errors, which can lead to data
+corruption, both of user data or of kernel data, hung/unresponsive
+adapters, or system crashes/lockups.  Thus, the idea behind EEH is that
+the operating system can become more reliable and robust by protecting
+it from PCI errors, and giving the OS the ability to "reboot"/recover
+individual PCI devices.
+
+Future systems from other vendors, based on the PCI-E specification, may
+contain similar features.
+
+
+Causes of EEH Errors
+====================
+
+EEH was originally designed to guard against hardware failure, such as
+PCI cards dying from heat, humidity, dust, vibration and bad electrical
+connections. The vast majority of EEH errors seen in "real life" are due
+to either poorly seated PCI cards, or, unfortunately quite commonly, due
+to device driver bugs, device firmware bugs, and sometimes PCI card
+hardware bugs.
+
+The most common software bug, is one that causes the device to attempt
+to DMA to a location in system memory that has not been reserved for DMA
+access for that card.  This is a powerful feature, as it prevents what;
+otherwise, would have been silent memory corruption caused by the bad
+DMA.  A number of device driver bugs have been found and fixed in this
+way over the past few years.  Other possible causes of EEH errors
+include data or address line parity errors (for example, due to poor
+electrical connectivity due to a poorly seated card), and PCI-X
+split-completion errors (due to software, device firmware, or device PCI
+hardware bugs).  The vast majority of "true hardware failures" can be
+cured by physically removing and re-seating the PCI card.
+
+
+Detection and Recovery
+======================
+
+In the following discussion, a generic overview of how to detect and
+recover from EEH errors will be presented. This is followed by an
+overview of how the current implementation in the Linux kernel does it.
+The actual implementation is subject to change, and some of the finer
+points are still being debated.  These may in turn be swayed if or when
+other architectures implement similar functionality.
+
+When a PCI Host Bridge (PHB, the bus controller connecting the PCI bus
+to the system CPU electronics complex) detects a PCI error condition, it
+will "isolate" the affected PCI card.  Isolation will block all writes
+(either to the card from the system, or from the card to the system),
+and it will cause all reads to return all-ff's (0xff, 0xffff, 0xffffffff
+for 8/16/32-bit reads).  This value was chosen because it is the same
+value you would get if the device was physically unplugged from the
+slot.  This includes access to PCI memory, I/O space, and PCI config
+space.  Interrupts; however, will continued to be delivered.
+
+Detection and recovery are performed with the aid of ppc64 firmware.
+The programming interfaces in the Linux kernel into the firmware are
+referred to as RTAS (Run-Time Abstraction Services).  The Linux kernel
+does not (should not) access the EEH function in the PCI chipsets
+directly, primarily because there are a number of different chipsets out
+there, each with different interfaces and quirks. The firmware provides
+a uniform abstraction layer that will work with all pSeries and iSeries
+hardware (and be forwards-compatible).
+
+If the OS or device driver suspects that a PCI slot has been
+EEH-isolated, there is a firmware call it can make to determine if this
+is the case. If so, then the device driver should put itself into a
+consistent state (given that it won't be able to complete any pending
+work) and start recovery of the card.  Recovery normally would consist
+of resetting the PCI device (holding the PCI #RST line high for two
+seconds), followed by setting up the device config space (the base
+address registers (BAR's), latency timer, cache line size, interrupt
+line, and so on).  This is followed by a reinitialization of the device
+driver.  In a worst-case scenario, the power to the card can be toggled,
+at least on hot-plug-capable slots.  In principle, layers far above the
+device driver probably do not need to know that the PCI card has been
+"rebooted" in this way; ideally, there should be at most a pause in
+Ethernet/disk/USB I/O while the card is being reset.
+
+If the card cannot be recovered after three or four resets, the
+kernel/device driver should assume the worst-case scenario, that the
+card has died completely, and report this error to the sysadmin.  In
+addition, error messages are reported through RTAS and also through
+syslogd (/var/log/messages) to alert the sysadmin of PCI resets.  The
+correct way to deal with failed adapters is to use the standard PCI
+hotplug tools to remove and replace the dead card.
+
+
+Current PPC64 Linux EEH Implementation
+======================================
+
+At this time, a generic EEH recovery mechanism has been implemented, so
+that individual device drivers do not need to be modified to support EEH
+recovery.  This generic mechanism piggy-backs on the PCI hotplug
+infrastructure, and percolates events up through the userspace/udev
+infrastructure.  Following is a detailed description of how this is
+accomplished.
+
+EEH must be enabled in the PHB's very early during the boot process, and
+if a PCI slot is hot-plugged. The former is performed by eeh_init() in
+arch/powerpc/platforms/pseries/eeh.c, and the later by
+drivers/pci/hotplug/pSeries_pci.c calling in to the eeh.c code.  EEH
+must be enabled before a PCI scan of the device can proceed.  Current
+Power5 hardware will not work unless EEH is enabled; although older
+Power4 can run with it disabled.  Effectively, EEH can no longer be
+turned off.  PCI devices *must* be registered with the EEH code; the EEH
+code needs to know about the I/O address ranges of the PCI device in
+order to detect an error.  Given an arbitrary address, the routine
+pci_get_device_by_addr() will find the pci device associated with that
+address (if any).
+
+The default arch/powerpc/include/asm/io.h macros readb(), inb(), insb(),
+etc. include a check to see if the i/o read returned all-0xff's.  If so,
+these make a call to eeh_dn_check_failure(), which in turn asks the
+firmware if the all-ff's value is the sign of a true EEH error.  If it
+is not, processing continues as normal.  The grand total number of these
+false alarms or "false positives" can be seen in /proc/ppc64/eeh
+(subject to change).  Normally, almost all of these occur during boot,
+when the PCI bus is scanned, where a large number of 0xff reads are part
+of the bus scan procedure.
+
+If a frozen slot is detected, code in
+arch/powerpc/platforms/pseries/eeh.c will print a stack trace to syslog
+(/var/log/messages).  This stack trace has proven to be very useful to
+device-driver authors for finding out at what point the EEH error was
+detected, as the error itself usually occurs slightly beforehand.
+
+Next, it uses the Linux kernel notifier chain/work queue mechanism to
+allow any interested parties to find out about the failure.  Device
+drivers, or other parts of the kernel, can use
+``eeh_register_notifier(struct notifier_block *)`` to find out about EEH
+events.  The event will include a pointer to the pci device, the device
+node and some state info.  Receivers of the event can "do as they wish";
+the default handler will be described further in this section.
+
+To assist in the recovery of the device, eeh.c exports the following
+functions:
+
+- rtas_set_slot_reset() -- assert the  PCI #RST line for 1/8th of a
+  second.
+- rtas_configure_bridge() -- ask firmware to configure any PCI bridges
+  located topologically under the pci slot.
+- eeh_save_bars() and eeh_restore_bars(): save and restore the PCI
+  config-space info for a device and any devices under it.
+
+A handler for the EEH notifier_block events is implemented in
+drivers/pci/hotplug/pSeries_pci.c, called handle_eeh_events().  It saves
+the device BAR's and then calls rpaphp_unconfig_pci_adapter().  This
+last call causes the device driver for the card to be stopped, which
+causes uevents to go out to user space. This triggers user-space scripts
+that might issue commands such as "ifdown eth0" for ethernet cards, and
+so on.  This handler then sleeps for 5 seconds, hoping to give the
+user-space scripts enough time to complete.  It then resets the PCI
+card, reconfigures the device BAR's, and any bridges underneath. It then
+calls rpaphp_enable_pci_slot(), which restarts the device driver and
+triggers more user-space events (for example, calling "ifup eth0" for
+ethernet cards).
+
+
+Device Shutdown and User-Space Events
+=====================================
+
+This section documents what happens when a pci slot is unconfigured,
+focusing on how the device driver gets shut down, and on how the events
+get delivered to user-space scripts.
+
+Following is an example sequence of events that cause a device driver
+close function to be called during the first phase of an EEH reset.  The
+following sequence is an example of the pcnet32 device driver.::
+
+    rpa_php_unconfig_pci_adapter (struct slot *) { // in rpaphp_pci.c
+      calls
+      pci_remove_bus_device (struct pci_dev *) { // in /drivers/pci/remove.c
+        calls
+        pci_destroy_dev (struct pci_dev *) {
+          calls
+          device_unregister (&dev->dev) }        // in /drivers/base/core.c
+            calls
+            device_del (struct device *) {
+              calls
+              bus_remove_device() {              // in /drivers/base/bus.c
+                calls
+                device_release_driver() {
+                  calls
+                  struct device_driver->remove() // which is just
+                  pci_device_remove() {          // in /drivers/pci/pci_driver.c
+                    calls
+                    struct pci_driver->remove()  // which is just
+                    pcnet32_remove_one() {       // in /drivers/net/pcnet32.c
+                      calls
+                      unregister_netdev() {      // in /net/core/dev.c
+                        calls
+                        dev_close() {            // in /net/core/dev.c
+                           calls dev->stop();    // which is just
+                           pcnet32_close() {     // in pcnet32.c
+                             which does what you wanted to stop the device
+                           }
+                        }
+                     }
+                   which frees pcnet32 device driver memory
+                }
+     }}}}}}
+
+
+    in drivers/pci/pci_driver.c,
+    struct device_driver->remove() is just pci_device_remove()
+    which calls struct pci_driver->remove() which is pcnet32_remove_one()
+    which calls unregister_netdev()  (in net/core/dev.c)
+    which calls dev_close()  (in net/core/dev.c)
+    which calls dev->stop() which is pcnet32_close()
+    which then does the appropriate shutdown.
+
+
+Following is the analogous stack trace for events sent to user-space
+when the pci device is unconfigured.::
+
+    rpa_php_unconfig_pci_adapter() {             // in rpaphp_pci.c
+      calls
+      pci_remove_bus_device (struct pci_dev *) { // in /drivers/pci/remove.c
+        calls
+        pci_destroy_dev (struct pci_dev *) {
+          calls
+          device_unregister (&dev->dev) {        // in /drivers/base/core.c
+            calls
+            device_del(struct device * dev) {    // in /drivers/base/core.c
+              calls
+              kobject_del() {                    // in /libs/kobject.c
+                calls
+                kobject_uevent() {               // in /libs/kobject.c
+                  calls
+                  kset_uevent() {                // in /lib/kobject.c
+                    calls
+                    kset->uevent_ops->uevent()   // which is really just
+                    a call to
+                    dev_uevent() {               // in /drivers/base/core.c
+                      calls
+                      dev->bus->uevent()         // which is really just a call to
+                      pci_uevent () {            // in drivers/pci/hotplug.c
+                        which prints device name, etc....
+                     }
+                   }
+                   then kobject_uevent() sends a netlink uevent to userspace
+                   --> userspace uevent
+                   (during early boot, nobody listens to netlink events and
+                   kobject_uevent() executes uevent_helper[], which runs the
+                   event process /sbin/hotplug)
+               }
+             }
+             kobject_del() then calls sysfs_remove_dir(), which would
+             trigger any user-space daemon that was watching /sysfs,
+             and notice the delete event.
+
+
+Pro's and Con's of the Current Design
+=====================================
+
+There are several issues with the current EEH software recovery design,
+which may be addressed in future revisions.  But first, note that the
+big plus of the current design is that no changes need to be made to
+individual device drivers, so that the current design throws a wide net.
+The biggest negative of the design is that it potentially disturbs
+network daemons and file systems that didn't need to be disturbed.
+
+- A minor complaint is that resetting the network card causes user-space
+  back-to-back ifdown/ifup burps that potentially disturb network
+  daemons, that didn't need to even know that the pci card was being
+  rebooted.
+
+- A more serious concern is that the same reset, for SCSI devices,
+  causes havoc to mounted file systems.  Scripts cannot post-facto
+  unmount a file system without flushing pending buffers, but this is
+  impossible, because I/O has already been stopped.  Thus, ideally, the
+  reset should happen at or below the block layer, so that the file
+  systems are not disturbed.
+
+  Reiserfs does not tolerate errors returned from the block device.
+  Ext3fs seems to be tolerant, retrying reads/writes until it does
+  succeed. Both have been only lightly tested in this scenario.
+
+  The SCSI-generic subsystem already has built-in code for performing
+  SCSI device resets, SCSI bus resets, and SCSI host-bus-adapter (HBA)
+  resets.  These are cascaded into a chain of attempted resets if a SCSI
+  command fails. These are completely hidden from the block layer.  It
+  would be very natural to add an EEH reset into this chain of events.
+
+- If a SCSI error occurs for the root device, all is lost unless the
+  sysadmin had the foresight to run /bin, /sbin, /etc, /var and so on,
+  out of ramdisk/tmpfs.
+
+
+Conclusions
+===========
+
+There's forward progress ...
+
+
diff --git a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
deleted file mode 100644
index 678189280bb4..000000000000
--- a/Documentation/powerpc/eeh-pci-error-recovery.txt
+++ /dev/null
@@ -1,334 +0,0 @@
-
-
-                      PCI Bus EEH Error Recovery
-                      --------------------------
-                           Linas Vepstas
-                       <linas@austin.ibm.com>
-                          12 January 2005
-
-
-Overview:
----------
-The IBM POWER-based pSeries and iSeries computers include PCI bus
-controller chips that have extended capabilities for detecting and
-reporting a large variety of PCI bus error conditions.  These features
-go under the name of "EEH", for "Enhanced Error Handling".  The EEH
-hardware features allow PCI bus errors to be cleared and a PCI
-card to be "rebooted", without also having to reboot the operating
-system.
-
-This is in contrast to traditional PCI error handling, where the
-PCI chip is wired directly to the CPU, and an error would cause
-a CPU machine-check/check-stop condition, halting the CPU entirely.
-Another "traditional" technique is to ignore such errors, which
-can lead to data corruption, both of user data or of kernel data,
-hung/unresponsive adapters, or system crashes/lockups.  Thus,
-the idea behind EEH is that the operating system can become more
-reliable and robust by protecting it from PCI errors, and giving
-the OS the ability to "reboot"/recover individual PCI devices.
-
-Future systems from other vendors, based on the PCI-E specification,
-may contain similar features.
-
-
-Causes of EEH Errors
---------------------
-EEH was originally designed to guard against hardware failure, such
-as PCI cards dying from heat, humidity, dust, vibration and bad
-electrical connections. The vast majority of EEH errors seen in
-"real life" are due to either poorly seated PCI cards, or,
-unfortunately quite commonly, due to device driver bugs, device firmware
-bugs, and sometimes PCI card hardware bugs.
-
-The most common software bug, is one that causes the device to
-attempt to DMA to a location in system memory that has not been
-reserved for DMA access for that card.  This is a powerful feature,
-as it prevents what; otherwise, would have been silent memory
-corruption caused by the bad DMA.  A number of device driver
-bugs have been found and fixed in this way over the past few
-years.  Other possible causes of EEH errors include data or
-address line parity errors (for example, due to poor electrical
-connectivity due to a poorly seated card), and PCI-X split-completion
-errors (due to software, device firmware, or device PCI hardware bugs).
-The vast majority of "true hardware failures" can be cured by
-physically removing and re-seating the PCI card.
-
-
-Detection and Recovery
-----------------------
-In the following discussion, a generic overview of how to detect
-and recover from EEH errors will be presented. This is followed
-by an overview of how the current implementation in the Linux
-kernel does it.  The actual implementation is subject to change,
-and some of the finer points are still being debated.  These
-may in turn be swayed if or when other architectures implement
-similar functionality.
-
-When a PCI Host Bridge (PHB, the bus controller connecting the
-PCI bus to the system CPU electronics complex) detects a PCI error
-condition, it will "isolate" the affected PCI card.  Isolation
-will block all writes (either to the card from the system, or
-from the card to the system), and it will cause all reads to
-return all-ff's (0xff, 0xffff, 0xffffffff for 8/16/32-bit reads).
-This value was chosen because it is the same value you would
-get if the device was physically unplugged from the slot.
-This includes access to PCI memory, I/O space, and PCI config
-space.  Interrupts; however, will continued to be delivered.
-
-Detection and recovery are performed with the aid of ppc64
-firmware.  The programming interfaces in the Linux kernel
-into the firmware are referred to as RTAS (Run-Time Abstraction
-Services).  The Linux kernel does not (should not) access
-the EEH function in the PCI chipsets directly, primarily because
-there are a number of different chipsets out there, each with
-different interfaces and quirks. The firmware provides a
-uniform abstraction layer that will work with all pSeries
-and iSeries hardware (and be forwards-compatible).
-
-If the OS or device driver suspects that a PCI slot has been
-EEH-isolated, there is a firmware call it can make to determine if
-this is the case. If so, then the device driver should put itself
-into a consistent state (given that it won't be able to complete any
-pending work) and start recovery of the card.  Recovery normally
-would consist of resetting the PCI device (holding the PCI #RST
-line high for two seconds), followed by setting up the device
-config space (the base address registers (BAR's), latency timer,
-cache line size, interrupt line, and so on).  This is followed by a
-reinitialization of the device driver.  In a worst-case scenario,
-the power to the card can be toggled, at least on hot-plug-capable
-slots.  In principle, layers far above the device driver probably
-do not need to know that the PCI card has been "rebooted" in this
-way; ideally, there should be at most a pause in Ethernet/disk/USB
-I/O while the card is being reset.
-
-If the card cannot be recovered after three or four resets, the
-kernel/device driver should assume the worst-case scenario, that the
-card has died completely, and report this error to the sysadmin.
-In addition, error messages are reported through RTAS and also through
-syslogd (/var/log/messages) to alert the sysadmin of PCI resets.
-The correct way to deal with failed adapters is to use the standard
-PCI hotplug tools to remove and replace the dead card.
-
-
-Current PPC64 Linux EEH Implementation
---------------------------------------
-At this time, a generic EEH recovery mechanism has been implemented,
-so that individual device drivers do not need to be modified to support
-EEH recovery.  This generic mechanism piggy-backs on the PCI hotplug
-infrastructure,  and percolates events up through the userspace/udev
-infrastructure.  Following is a detailed description of how this is
-accomplished.
-
-EEH must be enabled in the PHB's very early during the boot process,
-and if a PCI slot is hot-plugged. The former is performed by
-eeh_init() in arch/powerpc/platforms/pseries/eeh.c, and the later by
-drivers/pci/hotplug/pSeries_pci.c calling in to the eeh.c code.
-EEH must be enabled before a PCI scan of the device can proceed.
-Current Power5 hardware will not work unless EEH is enabled;
-although older Power4 can run with it disabled.  Effectively,
-EEH can no longer be turned off.  PCI devices *must* be
-registered with the EEH code; the EEH code needs to know about
-the I/O address ranges of the PCI device in order to detect an
-error.  Given an arbitrary address, the routine
-pci_get_device_by_addr() will find the pci device associated
-with that address (if any).
-
-The default arch/powerpc/include/asm/io.h macros readb(), inb(), insb(),
-etc. include a check to see if the i/o read returned all-0xff's.
-If so, these make a call to eeh_dn_check_failure(), which in turn
-asks the firmware if the all-ff's value is the sign of a true EEH
-error.  If it is not, processing continues as normal.  The grand
-total number of these false alarms or "false positives" can be
-seen in /proc/ppc64/eeh (subject to change).  Normally, almost
-all of these occur during boot, when the PCI bus is scanned, where
-a large number of 0xff reads are part of the bus scan procedure.
-
-If a frozen slot is detected, code in 
-arch/powerpc/platforms/pseries/eeh.c will print a stack trace to 
-syslog (/var/log/messages).  This stack trace has proven to be very 
-useful to device-driver authors for finding out at what point the EEH 
-error was detected, as the error itself usually occurs slightly 
-beforehand.
-
-Next, it uses the Linux kernel notifier chain/work queue mechanism to
-allow any interested parties to find out about the failure.  Device
-drivers, or other parts of the kernel, can use
-eeh_register_notifier(struct notifier_block *) to find out about EEH
-events.  The event will include a pointer to the pci device, the
-device node and some state info.  Receivers of the event can "do as
-they wish"; the default handler will be described further in this
-section.
-
-To assist in the recovery of the device, eeh.c exports the
-following functions:
-
-rtas_set_slot_reset() -- assert the  PCI #RST line for 1/8th of a second
-rtas_configure_bridge() -- ask firmware to configure any PCI bridges
-   located topologically under the pci slot.
-eeh_save_bars() and eeh_restore_bars(): save and restore the PCI
-   config-space info for a device and any devices under it.
-
-
-A handler for the EEH notifier_block events is implemented in
-drivers/pci/hotplug/pSeries_pci.c, called handle_eeh_events().
-It saves the device BAR's and then calls rpaphp_unconfig_pci_adapter().
-This last call causes the device driver for the card to be stopped,
-which causes uevents to go out to user space. This triggers
-user-space scripts that might issue commands such as "ifdown eth0"
-for ethernet cards, and so on.  This handler then sleeps for 5 seconds,
-hoping to give the user-space scripts enough time to complete.
-It then resets the PCI card, reconfigures the device BAR's, and
-any bridges underneath. It then calls rpaphp_enable_pci_slot(),
-which restarts the device driver and triggers more user-space
-events (for example, calling "ifup eth0" for ethernet cards).
-
-
-Device Shutdown and User-Space Events
--------------------------------------
-This section documents what happens when a pci slot is unconfigured,
-focusing on how the device driver gets shut down, and on how the
-events get delivered to user-space scripts.
-
-Following is an example sequence of events that cause a device driver
-close function to be called during the first phase of an EEH reset.
-The following sequence is an example of the pcnet32 device driver.
-
-    rpa_php_unconfig_pci_adapter (struct slot *)  // in rpaphp_pci.c
-    {
-      calls
-      pci_remove_bus_device (struct pci_dev *) // in /drivers/pci/remove.c
-      {
-        calls
-        pci_destroy_dev (struct pci_dev *)
-        {
-          calls
-          device_unregister (&dev->dev) // in /drivers/base/core.c
-          {
-            calls
-            device_del (struct device *)
-            {
-              calls
-              bus_remove_device() // in /drivers/base/bus.c
-              {
-                calls
-                device_release_driver()
-                {
-                  calls
-                  struct device_driver->remove() which is just
-                  pci_device_remove()  // in /drivers/pci/pci_driver.c
-                  {
-                    calls
-                    struct pci_driver->remove() which is just
-                    pcnet32_remove_one() // in /drivers/net/pcnet32.c
-                    {
-                      calls
-                      unregister_netdev() // in /net/core/dev.c
-                      {
-                        calls
-                        dev_close()  // in /net/core/dev.c
-                        {
-                           calls dev->stop();
-                           which is just pcnet32_close() // in pcnet32.c
-                           {
-                             which does what you wanted
-                             to stop the device
-                           }
-                        }
-                     }
-                   which
-                   frees pcnet32 device driver memory
-                }
-     }}}}}}
-
-
-    in drivers/pci/pci_driver.c,
-    struct device_driver->remove() is just pci_device_remove()
-    which calls struct pci_driver->remove() which is pcnet32_remove_one()
-    which calls unregister_netdev()  (in net/core/dev.c)
-    which calls dev_close()  (in net/core/dev.c)
-    which calls dev->stop() which is pcnet32_close()
-    which then does the appropriate shutdown.
-
----
-Following is the analogous stack trace for events sent to user-space
-when the pci device is unconfigured.
-
-rpa_php_unconfig_pci_adapter() {             // in rpaphp_pci.c
-  calls
-  pci_remove_bus_device (struct pci_dev *) { // in /drivers/pci/remove.c
-    calls
-    pci_destroy_dev (struct pci_dev *) {
-      calls
-      device_unregister (&dev->dev) {        // in /drivers/base/core.c
-        calls
-        device_del(struct device * dev) {    // in /drivers/base/core.c
-          calls
-          kobject_del() {                    //in /libs/kobject.c
-            calls
-            kobject_uevent() {               // in /libs/kobject.c
-              calls
-              kset_uevent() {                // in /lib/kobject.c
-                calls
-                kset->uevent_ops->uevent()   // which is really just
-                a call to
-                dev_uevent() {               // in /drivers/base/core.c
-                  calls
-                  dev->bus->uevent() which is really just a call to
-                  pci_uevent () {            // in drivers/pci/hotplug.c
-                    which prints device name, etc....
-                 }
-               }
-               then kobject_uevent() sends a netlink uevent to userspace
-               --> userspace uevent
-               (during early boot, nobody listens to netlink events and
-               kobject_uevent() executes uevent_helper[], which runs the
-               event process /sbin/hotplug)
-           }
-         }
-         kobject_del() then calls sysfs_remove_dir(), which would
-         trigger any user-space daemon that was watching /sysfs,
-         and notice the delete event.
-
-
-Pro's and Con's of the Current Design
--------------------------------------
-There are several issues with the current EEH software recovery design,
-which may be addressed in future revisions.  But first, note that the
-big plus of the current design is that no changes need to be made to
-individual device drivers, so that the current design throws a wide net.
-The biggest negative of the design is that it potentially disturbs
-network daemons and file systems that didn't need to be disturbed.
-
--- A minor complaint is that resetting the network card causes
-   user-space back-to-back ifdown/ifup burps that potentially disturb
-   network daemons, that didn't need to even know that the pci
-   card was being rebooted.
-
--- A more serious concern is that the same reset, for SCSI devices,
-   causes havoc to mounted file systems.  Scripts cannot post-facto
-   unmount a file system without flushing pending buffers, but this
-   is impossible, because I/O has already been stopped.  Thus,
-   ideally, the reset should happen at or below the block layer,
-   so that the file systems are not disturbed.
-
-   Reiserfs does not tolerate errors returned from the block device.
-   Ext3fs seems to be tolerant, retrying reads/writes until it does
-   succeed. Both have been only lightly tested in this scenario.
-
-   The SCSI-generic subsystem already has built-in code for performing
-   SCSI device resets, SCSI bus resets, and SCSI host-bus-adapter
-   (HBA) resets.  These are cascaded into a chain of attempted
-   resets if a SCSI command fails. These are completely hidden
-   from the block layer.  It would be very natural to add an EEH
-   reset into this chain of events.
-
--- If a SCSI error occurs for the root device, all is lost unless
-   the sysadmin had the foresight to run /bin, /sbin, /etc, /var
-   and so on, out of ramdisk/tmpfs.
-
-
-Conclusions
------------
-There's forward progress ...
-
-
diff --git a/Documentation/powerpc/index.rst b/Documentation/powerpc/index.rst
new file mode 100644
index 000000000000..21e05d09bb42
--- /dev/null
+++ b/Documentation/powerpc/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+PowerPC Documentation
+=====================
+
+Documentation relating to the PowerPC architecture.
+
+.. toctree::
+   :maxdepth: 2
+
+   DAWR-POWER9
+   bootwrapper
+   cpu_features
+   eeh-pci-error-recovery
+   isa-versions
+   mpc52xx
+   pmu-ebb
+   ptrace
+   syscall64-abi
+   transactional_memory
diff --git a/Documentation/powerpc/isa-versions.rst b/Documentation/powerpc/isa-versions.rst
index 812e20cc898c..946ea9c264de 100644
--- a/Documentation/powerpc/isa-versions.rst
+++ b/Documentation/powerpc/isa-versions.rst
@@ -1,74 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
 CPU to ISA Version Mapping
 ==========================
 
 Mapping of some CPU versions to relevant ISA versions.
 
-========= ====================
-CPU       Architecture version
-========= ====================
-Power9    Power ISA v3.0B
-Power8    Power ISA v2.07
-Power7    Power ISA v2.06
-Power6    Power ISA v2.05
-PA6T      Power ISA v2.04
-Cell PPU  - Power ISA v2.02 with some minor exceptions
-          - Plus Altivec/VMX ~= 2.03
-Power5++  Power ISA v2.04 (no VMX)
-Power5+   Power ISA v2.03
-Power5    - PowerPC User Instruction Set Architecture Book I v2.02
-          - PowerPC Virtual Environment Architecture Book II v2.02
-          - PowerPC Operating Environment Architecture Book III v2.02
-PPC970    - PowerPC User Instruction Set Architecture Book I v2.01
-          - PowerPC Virtual Environment Architecture Book II v2.01
-          - PowerPC Operating Environment Architecture Book III v2.01
-          - Plus Altivec/VMX ~= 2.03
-========= ====================
+.. flat-table::
+   :widths: 2 6
+
+   * - CPU
+     - Architecture version
+
+   * - Power9
+     - Power ISA v3.0B
+
+   * - Power8
+     - Power ISA v2.07
+
+   * - Power7
+     - Power ISA v2.06
+
+   * - Power6
+     - Power ISA v2.05
+
+   * - PA6T
+     - Power ISA v2.04
+
+   * - Cell PPU
+     - Power ISA v2.02 with some minor exceptions
+
+   * - Cell PPU
+     - Plus Altivec/VMX ~= 2.03
+
+   * - Power5++
+     - Power ISA v2.04 (no VMX)
+
+   * - Power5+
+     - Power ISA v2.03
+
+   * - Power5
+     - PowerPC User Instruction Set Architecture Book I v2.02
+
+   * - Power5
+     - PowerPC Virtual Environment Architecture Book II v2.02
+
+   * - Power5
+     - PowerPC Operating Environment Architecture Book III v2.02
+
+   * - PPC970
+     - PowerPC User Instruction Set Architecture Book I v2.01
+
+   * - PPC970
+     - PowerPC Virtual Environment Architecture Book II v2.01
+
+   * - PPC970
+     - PowerPC Operating Environment Architecture Book III v2.01
+
+   * - PPC970
+     - Plus Altivec/VMX ~= 2.03
 
 
 Key Features
-------------
-
-========== ==================
-CPU        VMX (aka. Altivec)
-========== ==================
-Power9     Yes
-Power8     Yes
-Power7     Yes
-Power6     Yes
-PA6T       Yes
-Cell PPU   Yes
-Power5++   No
-Power5+    No
-Power5     No
-PPC970     Yes
-========== ==================
-
-========== ====
-CPU        VSX
-========== ====
-Power9     Yes
-Power8     Yes
-Power7     Yes
-Power6     No
-PA6T       No
-Cell PPU   No
-Power5++   No
-Power5+    No
-Power5     No
-PPC970     No
-========== ====
-
-========== ====================
-CPU        Transactional Memory
-========== ====================
-Power9     Yes (* see transactional_memory.txt)
-Power8     Yes
-Power7     No
-Power6     No
-PA6T       No
-Cell PPU   No
-Power5++   No
-Power5+    No
-Power5     No
-PPC970     No
-========== ====================
+============
+
+
+.. flat-table::
+   :widths: 2 6
+
+   * - CPU
+     - VMX (aka. Altivec)
+
+   * - Power9
+     - Yes
+
+   * - Power8
+     - Yes
+
+   * - Power7
+     - Yes
+
+   * - Power6
+     - Yes
+
+   * - PA6T
+     - Yes
+
+   * - Cell PPU
+     - Yes
+
+   * - Power5++
+     - No
+
+   * - Power5+
+     - No
+
+   * - Power5
+     - No
+
+   * - PPC970
+     - Yes
+
+
+
+.. flat-table::
+   :widths: 2 6
+
+   * - CPU
+     - VMX (aka. Altivec)
+
+   * - Power9
+     - Yes
+
+   * - Power8
+     - Yes
+
+   * - Power7
+     - Yes
+
+   * - Power6
+     - No
+
+   * - PA6T
+     - No
+
+   * - Cell PPU
+     - No
+
+   * - Power5++
+     - No
+
+   * - Power5+
+     - No
+
+   * - Power5
+     - No
+
+   * - PPC970
+     - No
+
+.. flat-table::
+   :widths: 2 6
+
+   * - CPU
+     - Transactional Memory
+
+   * - Power9
+     - Yes
+
+   * - Power8
+     - Yes
+
+   * - Power7
+     - No
+
+   * - Power6
+     - No
+
+   * - PA6T
+     - No
+
+   * - Cell PPU
+     - No
+
+   * - Power5++
+     - No
+
+   * - Power5+
+     - No
+
+   * - Power5
+     - No
+
+   * - PPC970
+     - No
diff --git a/Documentation/powerpc/mpc52xx.rst b/Documentation/powerpc/mpc52xx.rst
new file mode 100644
index 000000000000..d7f51a3f96ad
--- /dev/null
+++ b/Documentation/powerpc/mpc52xx.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Linux 2.6.x on MPC52xx family
+=============================
+
+For the latest info, go to http://www.246tNt.com/mpc52xx/
+
+To compile/use
+==============
+
+- U-Boot
+
+Edit Makefile to set ARCH=ppc & CROSS_COMPILE=... (also EXTRAVERSION if
+you wish to).  Then run::
+
+     # make lite5200_defconfig
+     # make uImage
+
+Then, on U-boot::
+
+     => tftpboot 200000 uImage
+     => tftpboot 400000 pRamdisk
+     => bootm 200000 400000
+
+- DBug
+
+Edit Makefile to set ARCH=ppc & CROSS_COMPILE=... (also EXTRAVERSION if
+you wish to).  Then run::
+
+     # make lite5200_defconfig
+     # cp your_initrd.gz arch/ppc/boot/images/ramdisk.image.gz
+     # make zImage.initrd
+     # make
+
+Then in DBug::
+
+     DBug> dn -i zImage.initrd.lite5200
+
+
+Some remarks
+============
+
+- The port is named mpc52xxx, and config options are PPC_MPC52xx. The
+  MGT5100 is not supported, and I'm not sure anyone is interesting in
+  working on it so. I didn't took 5xxx because there's apparently a lot
+  of 5xxx that have nothing to do with the MPC5200. I also included the
+  'MPC' for the same reason.
+
+- Of course, I inspired myself from the 2.4 port. If you think I forgot
+  to mention you/your company in the copyright of some code, I'll
+  correct it ASAP.
diff --git a/Documentation/powerpc/mpc52xx.txt b/Documentation/powerpc/mpc52xx.txt
deleted file mode 100644
index 0d540a31ea1a..000000000000
--- a/Documentation/powerpc/mpc52xx.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Linux 2.6.x on MPC52xx family
------------------------------
-
-For the latest info, go to http://www.246tNt.com/mpc52xx/
-
-To compile/use :
-
-  - U-Boot:
-     # <edit Makefile to set ARCH=ppc & CROSS_COMPILE=... ( also EXTRAVERSION
-        if you wish to ).
-     # make lite5200_defconfig
-     # make uImage
-
-     then, on U-boot:
-     => tftpboot 200000 uImage
-     => tftpboot 400000 pRamdisk
-     => bootm 200000 400000
-
-  - DBug:
-     # <edit Makefile to set ARCH=ppc & CROSS_COMPILE=... ( also EXTRAVERSION
-        if you wish to ).
-     # make lite5200_defconfig
-     # cp your_initrd.gz arch/ppc/boot/images/ramdisk.image.gz
-     # make zImage.initrd
-     # make
-
-     then in DBug:
-     DBug> dn -i zImage.initrd.lite5200
-
-
-Some remarks :
- - The port is named mpc52xxx, and config options are PPC_MPC52xx. The MGT5100
-   is not supported, and I'm not sure anyone is interesting in working on it
-   so. I didn't took 5xxx because there's apparently a lot of 5xxx that have
-   nothing to do with the MPC5200. I also included the 'MPC' for the same
-   reason.
- - Of course, I inspired myself from the 2.4 port. If you think I forgot to
-   mention you/your company in the copyright of some code, I'll correct it
-   ASAP.
diff --git a/Documentation/powerpc/pmu-ebb.rst b/Documentation/powerpc/pmu-ebb.rst
new file mode 100644
index 000000000000..85a606adc5a6
--- /dev/null
+++ b/Documentation/powerpc/pmu-ebb.rst
@@ -0,0 +1,148 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+PMU Event Based Branches
+========================
+
+Event Based Branches (EBBs) are a feature which allows the hardware to
+branch directly to a specified user space address when certain events
+occur.
+
+The full specification is available in Power ISA v2.07:
+
+  https://www.power.org/documentation/power-isa-version-2-07/
+
+One type of event for which EBBs can be configured is PMU exceptions.
+This document describes the API for configuring the Power PMU to
+generate EBBs, using the Linux perf_events API.
+
+
+Terminology
+===========
+
+Throughout this document we will refer to an "EBB event" or "EBB
+events". This just refers to a struct perf_event which has set the "EBB"
+flag in its attr.config. All events which can be configured on the
+hardware PMU are possible "EBB events".
+
+
+Background
+==========
+
+When a PMU EBB occurs it is delivered to the currently running process.
+As such EBBs can only sensibly be used by programs for self-monitoring.
+
+It is a feature of the perf_events API that events can be created on
+other processes, subject to standard permission checks.  This is also
+true of EBB events, however unless the target process enables EBBs (via
+mtspr(BESCR)) no EBBs will ever be delivered.
+
+This makes it possible for a process to enable EBBs for itself, but not
+actually configure any events.  At a later time another process can come
+along and attach an EBB event to the process, which will then cause EBBs
+to be delivered to the first process.  It's not clear if this is
+actually useful.
+
+When the PMU is configured for EBBs, all PMU interrupts are delivered to
+the user process.  This means once an EBB event is scheduled on the PMU,
+no non-EBB events can be configured.  This means that EBB events can not
+be run concurrently with regular 'perf' commands, or any other perf
+events.
+
+It is however safe to run 'perf' commands on a process which is using
+EBBs.  The kernel will in general schedule the EBB event, and perf will
+be notified that its events could not run.
+
+The exclusion between EBB events and regular events is implemented using
+the existing "pinned" and "exclusive" attributes of perf_events.  This
+means EBB events will be given priority over other events, unless they
+are also pinned.  If an EBB event and a regular event are both pinned,
+then whichever is enabled first will be scheduled and the other will be
+put in error state.  See the section below titled "Enabling an EBB
+event" for more information.
+
+
+Creating an EBB event
+=====================
+
+To request that an event is counted using EBB, the event code should
+have bit 63 set.
+
+EBB events must be created with a particular, and restrictive, set of
+attributes - this is so that they interoperate correctly with the rest
+of the perf_events subsystem.
+
+An EBB event must be created with the "pinned" and "exclusive"
+attributes set.  Note that if you are creating a group of EBB events,
+only the leader can have these attributes set.
+
+An EBB event must NOT set any of the "inherit", "sample_period", "freq"
+or "enable_on_exec" attributes.
+
+An EBB event must be attached to a task.  This is specified to
+perf_event_open() by passing a pid value, typically 0 indicating the
+current task.
+
+All events in a group must agree on whether they want EBB.  That is all
+events must request EBB, or none may request EBB.
+
+EBB events must specify the PMC they are to be counted on.  This ensures
+userspace is able to reliably determine which PMC the event is scheduled
+on.
+
+
+Enabling an EBB event
+=====================
+
+Once an EBB event has been successfully opened, it must be enabled with
+the perf_events API.  This can be achieved either via the ioctl()
+interface, or the prctl() interface.
+
+However, due to the design of the perf_events API, enabling an event
+does not guarantee that it has been scheduled on the PMU.  To ensure
+that the EBB event has been scheduled on the PMU, you must perform a
+read() on the event.  If the read() returns EOF, then the event has not
+been scheduled and EBBs are not enabled.
+
+This behaviour occurs because the EBB event is pinned and exclusive.
+When the EBB event is enabled it will force all other non-pinned events
+off the PMU.  In this case the enable will be successful.  However if
+there is already an event pinned on the PMU then the enable will not be
+successful.
+
+
+Reading an EBB event
+====================
+
+It is possible to read() from an EBB event.  However the results are
+meaningless.  Because interrupts are being delivered to the user process
+the kernel is not able to count the event, and so will return a junk
+value.
+
+
+Closing an EBB event
+====================
+
+When an EBB event is finished with, you can close it using close() as
+for any regular event.  If this is the last EBB event the PMU will be
+deconfigured and no further PMU EBBs will be delivered.
+
+
+EBB Handler
+===========
+
+The EBB handler is just regular userspace code, however it must be
+written in the style of an interrupt handler.  When the handler is
+entered all registers are live (possibly) and so must be saved somehow
+before the handler can invoke other code.
+
+It's up to the program how to handle this.  For C programs a relatively
+simple option is to create an interrupt frame on the stack and save
+registers there.
+
+Fork
+====
+
+EBB events are not inherited across fork.  If the child process wishes
+to use EBBs it should open a new event for itself.  Similarly the EBB
+state in BESCR/EBBHR/EBBRR is cleared across fork().
diff --git a/Documentation/powerpc/pmu-ebb.txt b/Documentation/powerpc/pmu-ebb.txt
deleted file mode 100644
index 73cd163dbfb8..000000000000
--- a/Documentation/powerpc/pmu-ebb.txt
+++ /dev/null
@@ -1,137 +0,0 @@
-PMU Event Based Branches
-========================
-
-Event Based Branches (EBBs) are a feature which allows the hardware to
-branch directly to a specified user space address when certain events occur.
-
-The full specification is available in Power ISA v2.07:
-
-  https://www.power.org/documentation/power-isa-version-2-07/
-
-One type of event for which EBBs can be configured is PMU exceptions. This
-document describes the API for configuring the Power PMU to generate EBBs,
-using the Linux perf_events API.
-
-
-Terminology
------------
-
-Throughout this document we will refer to an "EBB event" or "EBB events". This
-just refers to a struct perf_event which has set the "EBB" flag in its
-attr.config. All events which can be configured on the hardware PMU are
-possible "EBB events".
-
-
-Background
-----------
-
-When a PMU EBB occurs it is delivered to the currently running process. As such
-EBBs can only sensibly be used by programs for self-monitoring.
-
-It is a feature of the perf_events API that events can be created on other
-processes, subject to standard permission checks. This is also true of EBB
-events, however unless the target process enables EBBs (via mtspr(BESCR)) no
-EBBs will ever be delivered.
-
-This makes it possible for a process to enable EBBs for itself, but not
-actually configure any events. At a later time another process can come along
-and attach an EBB event to the process, which will then cause EBBs to be
-delivered to the first process. It's not clear if this is actually useful.
-
-
-When the PMU is configured for EBBs, all PMU interrupts are delivered to the
-user process. This means once an EBB event is scheduled on the PMU, no non-EBB
-events can be configured. This means that EBB events can not be run
-concurrently with regular 'perf' commands, or any other perf events.
-
-It is however safe to run 'perf' commands on a process which is using EBBs. The
-kernel will in general schedule the EBB event, and perf will be notified that
-its events could not run.
-
-The exclusion between EBB events and regular events is implemented using the
-existing "pinned" and "exclusive" attributes of perf_events. This means EBB
-events will be given priority over other events, unless they are also pinned.
-If an EBB event and a regular event are both pinned, then whichever is enabled
-first will be scheduled and the other will be put in error state. See the
-section below titled "Enabling an EBB event" for more information.
-
-
-Creating an EBB event
----------------------
-
-To request that an event is counted using EBB, the event code should have bit
-63 set.
-
-EBB events must be created with a particular, and restrictive, set of
-attributes - this is so that they interoperate correctly with the rest of the
-perf_events subsystem.
-
-An EBB event must be created with the "pinned" and "exclusive" attributes set.
-Note that if you are creating a group of EBB events, only the leader can have
-these attributes set.
-
-An EBB event must NOT set any of the "inherit", "sample_period", "freq" or
-"enable_on_exec" attributes.
-
-An EBB event must be attached to a task. This is specified to perf_event_open()
-by passing a pid value, typically 0 indicating the current task.
-
-All events in a group must agree on whether they want EBB. That is all events
-must request EBB, or none may request EBB.
-
-EBB events must specify the PMC they are to be counted on. This ensures
-userspace is able to reliably determine which PMC the event is scheduled on.
-
-
-Enabling an EBB event
----------------------
-
-Once an EBB event has been successfully opened, it must be enabled with the
-perf_events API. This can be achieved either via the ioctl() interface, or the
-prctl() interface.
-
-However, due to the design of the perf_events API, enabling an event does not
-guarantee that it has been scheduled on the PMU. To ensure that the EBB event
-has been scheduled on the PMU, you must perform a read() on the event. If the
-read() returns EOF, then the event has not been scheduled and EBBs are not
-enabled.
-
-This behaviour occurs because the EBB event is pinned and exclusive. When the
-EBB event is enabled it will force all other non-pinned events off the PMU. In
-this case the enable will be successful. However if there is already an event
-pinned on the PMU then the enable will not be successful.
-
-
-Reading an EBB event
---------------------
-
-It is possible to read() from an EBB event. However the results are
-meaningless. Because interrupts are being delivered to the user process the
-kernel is not able to count the event, and so will return a junk value.
-
-
-Closing an EBB event
---------------------
-
-When an EBB event is finished with, you can close it using close() as for any
-regular event. If this is the last EBB event the PMU will be deconfigured and
-no further PMU EBBs will be delivered.
-
-
-EBB Handler
------------
-
-The EBB handler is just regular userspace code, however it must be written in
-the style of an interrupt handler. When the handler is entered all registers
-are live (possibly) and so must be saved somehow before the handler can invoke
-other code.
-
-It's up to the program how to handle this. For C programs a relatively simple
-option is to create an interrupt frame on the stack and save registers there.
-
-Fork
-----
-
-EBB events are not inherited across fork. If the child process wishes to use
-EBBs it should open a new event for itself. Similarly the EBB state in
-BESCR/EBBHR/EBBRR is cleared across fork().
diff --git a/Documentation/powerpc/ptrace.rst b/Documentation/powerpc/ptrace.rst
new file mode 100644
index 000000000000..34372054740e
--- /dev/null
+++ b/Documentation/powerpc/ptrace.rst
@@ -0,0 +1,177 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+PTRACE
+======
+
+GDB intends to support the following hardware debug features of BookE
+processors:
+
+- 4 hardware breakpoints (IAC)
+- 2 hardware watchpoints (read, write and read-write) (DAC)
+- 2 value conditions for the hardware watchpoints (DVC)
+
+For that, we need to extend ptrace so that GDB can query and set these
+resources. Since we're extending, we're trying to create an interface
+that's extendable and that covers both BookE and server processors, so
+that GDB doesn't need to special-case each of them. We added the
+following 3 new ptrace requests.
+
+
+PTRACE_PPC_GETHWDEBUGINFO
+=========================
+
+Query for GDB to discover the hardware debug features. The main info to
+be returned here is the minimum alignment for the hardware watchpoints.
+BookE processors don't have restrictions here, but server processors
+have an 8-byte alignment restriction for hardware watchpoints. We'd like
+to avoid adding special cases to GDB based on what it sees in AUXV.
+
+Since we're at it, we added other useful info that the kernel can return
+to GDB: this query will return the number of hardware breakpoints,
+hardware watchpoints and whether it supports a range of addresses and a
+condition.  The query will fill the following structure provided by the
+requesting process.
+
+    .. code-block:: c
+
+       struct ppc_debug_info {
+               unit32_t version;
+	       unit32_t num_instruction_bps;
+	       unit32_t num_data_bps;
+    	       unit32_t num_condition_regs;
+	       unit32_t data_bp_alignment;
+	       unit32_t sizeof_condition; /* size of the DVC register */
+	       uint64_t features; /* bitmask of the individual flags */
+       };
+
+features will have bits indicating whether there is support for:
+
+    .. code-block:: c
+
+       #define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
+       #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
+       #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
+       #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
+       #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x10
+
+PTRACE_SETHWDEBUG
+=================
+
+Sets a hardware breakpoint or watchpoint, according to the provided
+structure:
+
+    .. code-block:: c
+
+       struct ppc_hw_breakpoint {
+               uint32_t version;
+       #define PPC_BREAKPOINT_TRIGGER_EXECUTE  0x1
+       #define PPC_BREAKPOINT_TRIGGER_READ     0x2
+       #define PPC_BREAKPOINT_TRIGGER_WRITE    0x4
+               uint32_t trigger_type;       /* only some combinations allowed */
+       #define PPC_BREAKPOINT_MODE_EXACT               0x0
+       #define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE     0x1
+       #define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE     0x2
+       #define PPC_BREAKPOINT_MODE_MASK                0x3
+               uint32_t addr_mode;          /* address match mode */
+
+       #define PPC_BREAKPOINT_CONDITION_MODE   0x3
+       #define PPC_BREAKPOINT_CONDITION_NONE   0x0
+       #define PPC_BREAKPOINT_CONDITION_AND    0x1
+       #define PPC_BREAKPOINT_CONDITION_EXACT  0x1	/* different name for the same thing as above */
+       #define PPC_BREAKPOINT_CONDITION_OR     0x2
+       #define PPC_BREAKPOINT_CONDITION_AND_OR 0x3
+       #define PPC_BREAKPOINT_CONDITION_BE_ALL 0x00ff0000	/* byte enable bits */
+       #define PPC_BREAKPOINT_CONDITION_BE(n)  (1<<((n)+16))
+               uint32_t condition_mode;     /* break/watchpoint condition flags */
+
+               uint64_t addr;
+               uint64_t addr2;
+               uint64_t condition_value;
+       };
+
+A request specifies one event, not necessarily just one register to be
+set.  For instance, if the request is for a watchpoint with a condition,
+both the DAC and DVC registers will be set in the same request.
+
+With this GDB can ask for all kinds of hardware breakpoints and
+watchpoints that the BookE supports. COMEFROM breakpoints available in
+server processors are not contemplated, but that is out of the scope of
+this work.
+
+ptrace will return an integer (handle) uniquely identifying the
+breakpoint or watchpoint just created. This integer will be used in the
+PTRACE_DELHWDEBUG request to ask for its removal. Return -ENOSPC if the
+requested breakpoint can't be allocated on the registers.
+
+**Some examples of using the structure to:**
+
+Set a breakpoint in the first breakpoint register:
+::
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = 0;
+
+Set a watchpoint which triggers on reads in the second watchpoint
+register:
+
+::
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = 0;
+
+Set a watchpoint which triggers only with a specific value:
+::
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_AND | PPC_BREAKPOINT_CONDITION_BE_ALL;
+  p.addr            = (uint64_t) address;
+  p.addr2           = 0;
+  p.condition_value = (uint64_t) condition;
+
+Set a ranged hardware breakpoint:
+::
+
+  p.version         = PPC_DEBUG_CURRENT_VERSION;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) begin_range;
+  p.addr2           = (uint64_t) end_range;
+  p.condition_value = 0;
+
+Set a watchpoint in server processors (BookS):
+::
+
+  p.version         = 1;
+  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
+  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+  or
+  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
+
+  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
+  p.addr            = (uint64_t) begin_range;
+  /* For PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE addr2 needs to be specified, where
+   * addr2 - addr <= 8 Bytes.
+   */
+  p.addr2           = (uint64_t) end_range;
+  p.condition_value = 0;
+
+PTRACE_DELHWDEBUG
+=================
+
+Takes an integer which identifies an existing breakpoint or watchpoint
+(i.e., the value returned from PTRACE_SETHWDEBUG), and deletes the
+corresponding breakpoint or watchpoint..
diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
deleted file mode 100644
index 99c5ce88d0fe..000000000000
--- a/Documentation/powerpc/ptrace.txt
+++ /dev/null
@@ -1,151 +0,0 @@
-GDB intends to support the following hardware debug features of BookE
-processors:
-
-4 hardware breakpoints (IAC)
-2 hardware watchpoints (read, write and read-write) (DAC)
-2 value conditions for the hardware watchpoints (DVC)
-
-For that, we need to extend ptrace so that GDB can query and set these
-resources. Since we're extending, we're trying to create an interface
-that's extendable and that covers both BookE and server processors, so
-that GDB doesn't need to special-case each of them. We added the
-following 3 new ptrace requests.
-
-1. PTRACE_PPC_GETHWDEBUGINFO
-
-Query for GDB to discover the hardware debug features. The main info to
-be returned here is the minimum alignment for the hardware watchpoints.
-BookE processors don't have restrictions here, but server processors have
-an 8-byte alignment restriction for hardware watchpoints. We'd like to avoid
-adding special cases to GDB based on what it sees in AUXV.
-
-Since we're at it, we added other useful info that the kernel can return to
-GDB: this query will return the number of hardware breakpoints, hardware
-watchpoints and whether it supports a range of addresses and a condition.
-The query will fill the following structure provided by the requesting process:
-
-struct ppc_debug_info {
-       unit32_t version;
-       unit32_t num_instruction_bps;
-       unit32_t num_data_bps;
-       unit32_t num_condition_regs;
-       unit32_t data_bp_alignment;
-       unit32_t sizeof_condition; /* size of the DVC register */
-       uint64_t features; /* bitmask of the individual flags */
-};
-
-features will have bits indicating whether there is support for:
-
-#define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
-#define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
-#define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
-#define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
-#define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x10
-
-2. PTRACE_SETHWDEBUG
-
-Sets a hardware breakpoint or watchpoint, according to the provided structure:
-
-struct ppc_hw_breakpoint {
-        uint32_t version;
-#define PPC_BREAKPOINT_TRIGGER_EXECUTE  0x1
-#define PPC_BREAKPOINT_TRIGGER_READ     0x2
-#define PPC_BREAKPOINT_TRIGGER_WRITE    0x4
-        uint32_t trigger_type;       /* only some combinations allowed */
-#define PPC_BREAKPOINT_MODE_EXACT               0x0
-#define PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE     0x1
-#define PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE     0x2
-#define PPC_BREAKPOINT_MODE_MASK                0x3
-        uint32_t addr_mode;          /* address match mode */
-
-#define PPC_BREAKPOINT_CONDITION_MODE   0x3
-#define PPC_BREAKPOINT_CONDITION_NONE   0x0
-#define PPC_BREAKPOINT_CONDITION_AND    0x1
-#define PPC_BREAKPOINT_CONDITION_EXACT  0x1	/* different name for the same thing as above */
-#define PPC_BREAKPOINT_CONDITION_OR     0x2
-#define PPC_BREAKPOINT_CONDITION_AND_OR 0x3
-#define PPC_BREAKPOINT_CONDITION_BE_ALL 0x00ff0000	/* byte enable bits */
-#define PPC_BREAKPOINT_CONDITION_BE(n)  (1<<((n)+16))
-        uint32_t condition_mode;     /* break/watchpoint condition flags */
-
-        uint64_t addr;
-        uint64_t addr2;
-        uint64_t condition_value;
-};
-
-A request specifies one event, not necessarily just one register to be set.
-For instance, if the request is for a watchpoint with a condition, both the
-DAC and DVC registers will be set in the same request.
-
-With this GDB can ask for all kinds of hardware breakpoints and watchpoints
-that the BookE supports. COMEFROM breakpoints available in server processors
-are not contemplated, but that is out of the scope of this work.
-
-ptrace will return an integer (handle) uniquely identifying the breakpoint or
-watchpoint just created. This integer will be used in the PTRACE_DELHWDEBUG
-request to ask for its removal. Return -ENOSPC if the requested breakpoint
-can't be allocated on the registers.
-
-Some examples of using the structure to:
-
-- set a breakpoint in the first breakpoint register
-
-  p.version         = PPC_DEBUG_CURRENT_VERSION;
-  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
-  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
-  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
-  p.addr            = (uint64_t) address;
-  p.addr2           = 0;
-  p.condition_value = 0;
-
-- set a watchpoint which triggers on reads in the second watchpoint register
-
-  p.version         = PPC_DEBUG_CURRENT_VERSION;
-  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
-  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
-  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
-  p.addr            = (uint64_t) address;
-  p.addr2           = 0;
-  p.condition_value = 0;
-
-- set a watchpoint which triggers only with a specific value
-
-  p.version         = PPC_DEBUG_CURRENT_VERSION;
-  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_READ;
-  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
-  p.condition_mode  = PPC_BREAKPOINT_CONDITION_AND | PPC_BREAKPOINT_CONDITION_BE_ALL;
-  p.addr            = (uint64_t) address;
-  p.addr2           = 0;
-  p.condition_value = (uint64_t) condition;
-
-- set a ranged hardware breakpoint
-
-  p.version         = PPC_DEBUG_CURRENT_VERSION;
-  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_EXECUTE;
-  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
-  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
-  p.addr            = (uint64_t) begin_range;
-  p.addr2           = (uint64_t) end_range;
-  p.condition_value = 0;
-
-- set a watchpoint in server processors (BookS)
-
-  p.version         = 1;
-  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
-  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
-  or
-  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
-
-  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
-  p.addr            = (uint64_t) begin_range;
-  /* For PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE addr2 needs to be specified, where
-   * addr2 - addr <= 8 Bytes.
-   */
-  p.addr2           = (uint64_t) end_range;
-  p.condition_value = 0;
-
-3. PTRACE_DELHWDEBUG
-
-Takes an integer which identifies an existing breakpoint or watchpoint
-(i.e., the value returned from PTRACE_SETHWDEBUG), and deletes the
-corresponding breakpoint or watchpoint..
diff --git a/Documentation/powerpc/syscall64-abi.txt b/Documentation/powerpc/syscall64-abi.rst
similarity index 58%
rename from Documentation/powerpc/syscall64-abi.txt
rename to Documentation/powerpc/syscall64-abi.rst
index fa716a0d88bd..396832f6c34f 100644
--- a/Documentation/powerpc/syscall64-abi.txt
+++ b/Documentation/powerpc/syscall64-abi.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================================
 Power Architecture 64-bit Linux system call ABI
 ===============================================
@@ -5,73 +7,77 @@ Power Architecture 64-bit Linux system call ABI
 syscall
 =======
 
-syscall calling sequence[*] matches the Power Architecture 64-bit ELF ABI
-specification C function calling sequence, including register preservation
-rules, with the following differences.
+syscall calling sequence :sub:`[*]` matches the Power Architecture 64-bit ELF
+ABI specification C function calling sequence, including register
+preservation rules, with the following differences.
 
-[*] Some syscalls (typically low-level management functions) may have
-    different calling sequences (e.g., rt_sigreturn).
+:sub:`[*]` Some syscalls (typically low-level management functions) may
+have different calling sequences (e.g., rt_sigreturn).
 
 Parameters and return value
 ---------------------------
 The system call number is specified in r0.
 
-There is a maximum of 6 integer parameters to a syscall, passed in r3-r8.
+There is a maximum of 6 integer parameters to a syscall, passed in
+r3-r8.
 
-Both a return value and a return error code are returned. cr0.SO is the return
-error code, and r3 is the return value or error code. When cr0.SO is clear,
-the syscall succeeded and r3 is the return value. When cr0.SO is set, the
-syscall failed and r3 is the error code that generally corresponds to errno.
+Both a return value and a return error code are returned. cr0.SO is the
+return error code, and r3 is the return value or error code. When cr0.SO
+is clear, the syscall succeeded and r3 is the return value. When cr0.SO
+is set, the syscall failed and r3 is the error code that generally
+corresponds to errno.
 
 Stack
 -----
-System calls do not modify the caller's stack frame. For example, the caller's
-stack frame LR and CR save fields are not used.
+System calls do not modify the caller's stack frame. For example, the
+caller's stack frame LR and CR save fields are not used.
 
 Register preservation rules
 ---------------------------
 Register preservation rules match the ELF ABI calling sequence with the
-following differences:
+following differences::
 
-r0:         Volatile.   (System call number.)
-r3:         Volatile.   (Parameter 1, and return value.)
-r4-r8:      Volatile.   (Parameters 2-6.)
-cr0:        Volatile    (cr0.SO is the return error condition)
-cr1, cr5-7: Nonvolatile.
-lr:         Nonvolatile.
+  r0:         Volatile.   (System call number.)
+  r3:         Volatile.   (Parameter 1, and return value.)
+  r4-r8:      Volatile.   (Parameters 2-6.)
+  cr0:        Volatile    (cr0.SO is the return error condition)
+  cr1, cr5-7: Nonvolatile.
+  lr:         Nonvolatile.
 
 All floating point and vector data registers as well as control and status
 registers are nonvolatile.
 
 Invocation
 ----------
-The syscall is performed with the sc instruction, and returns with execution
-continuing at the instruction following the sc instruction.
+The syscall is performed with the sc instruction, and returns with
+execution continuing at the instruction following the sc instruction.
 
 Transactional Memory
 --------------------
-Syscall behavior can change if the processor is in transactional or suspended
-transaction state, and the syscall can affect the behavior of the transaction.
+Syscall behavior can change if the processor is in transactional or
+suspended transaction state, and the syscall can affect the behavior of the
+transaction.
 
 If the processor is in suspended state when a syscall is made, the syscall
 will be performed as normal, and will return as normal. The syscall will be
-performed in suspended state, so its side effects will be persistent according
-to the usual transactional memory semantics. A syscall may or may not result
-in the transaction being doomed by hardware.
+performed in suspended state, so its side effects will be persistent
+according to the usual transactional memory semantics. A syscall may or may
+not result in the transaction being doomed by hardware.
 
 If the processor is in transactional state when a syscall is made, then the
-behavior depends on the presence of PPC_FEATURE2_HTM_NOSC in the AT_HWCAP2 ELF
-auxiliary vector.
+behavior depends on the presence of PPC_FEATURE2_HTM_NOSC in the AT_HWCAP2
+ELF auxiliary vector.
 
-- If present, which is the case for newer kernels, then the syscall will not
-  be performed and the transaction will be doomed by the kernel with the
-  failure code TM_CAUSE_SYSCALL | TM_CAUSE_PERSISTENT in the TEXASR SPR.
+- If present, which is the case for newer kernels, then the syscall will
+  not be performed and the transaction will be doomed by the kernel with
+  the failure code TM_CAUSE_SYSCALL | TM_CAUSE_PERSISTENT in the TEXASR
+  SPR.
 
 - If not present (older kernels), then the kernel will suspend the
   transactional state and the syscall will proceed as in the case of a
   suspended state syscall, and will resume the transactional state before
-  returning to the caller. This case is not well defined or supported, so this
-  behavior should not be relied upon.
+  returning to the caller. This case is not well defined or supported, so
+  this behavior should not be relied upon.
 
 
 vsyscall
@@ -96,10 +102,10 @@ lr: Volatile.
 
 Invocation
 ----------
-The vsyscall is performed with a branch-with-link instruction to the vsyscall
-function address.
+The vsyscall is performed with a branch-with-link instruction to the
+vsyscall function address.
 
 Transactional Memory
 --------------------
-vsyscalls will run in the same transactional state as the caller. A vsyscall
-may or may not result in the transaction being doomed by hardware.
+vsyscalls will run in the same transactional state as the caller. A
+vsyscall may or may not result in the transaction being doomed by hardware.
diff --git a/Documentation/powerpc/transactional_memory.rst b/Documentation/powerpc/transactional_memory.rst
new file mode 100644
index 000000000000..5fcfd6bd16f0
--- /dev/null
+++ b/Documentation/powerpc/transactional_memory.rst
@@ -0,0 +1,259 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Transactional Memory support
+============================
+
+POWER kernel support for this feature is currently limited to supporting
+its use by user programs.  It is not currently used by the kernel
+itself.
+
+This file aims to sum up how it is supported by Linux and what behaviour
+you can expect from your user programs.
+
+
+Basic overview
+==============
+
+Hardware Transactional Memory is supported on POWER8 processors, and is
+a feature that enables a different form of atomic memory access.
+Several new instructions are presented to delimit transactions;
+transactions are guaranteed to either complete atomically or roll back
+and undo any partial changes.
+
+A simple transaction looks like this::
+
+  begin_move_money:
+    tbegin
+    beq   abort_handler
+
+    ld    r4, SAVINGS_ACCT(r3)
+    ld    r5, CURRENT_ACCT(r3)
+    subi  r5, r5, 1
+    addi  r4, r4, 1
+    std   r4, SAVINGS_ACCT(r3)
+    std   r5, CURRENT_ACCT(r3)
+
+    tend
+
+    b     continue
+
+  abort_handler:
+    ... test for odd failures ...
+
+    /* Retry the transaction if it failed because it conflicted with
+     * someone else: */
+    b     begin_move_money
+
+
+The 'tbegin' instruction denotes the start point, and 'tend' the end
+point.  Between these points the processor is in 'Transactional' state;
+any memory references will complete in one go if there are no conflicts
+with other transactional or non-transactional accesses within the
+system.  In this example, the transaction completes as though it were
+normal straight-line code IF no other processor has touched
+SAVINGS_ACCT(r3) or CURRENT_ACCT(r3); an atomic move of money from the
+current account to the savings account has been performed.  Even though
+the normal ld/std instructions are used (note no lwarx/stwcx), either
+*both* SAVINGS_ACCT(r3) and CURRENT_ACCT(r3) will be updated, or neither
+will be updated.
+
+If, in the meantime, there is a conflict with the locations accessed by
+the transaction, the transaction will be aborted by the CPU.  Register
+and memory state will roll back to that at the 'tbegin', and control
+will continue from 'tbegin+4'.  The branch to abort_handler will be
+taken this second time; the abort handler can check the cause of the
+failure, and retry.
+
+Checkpointed registers include all GPRs, FPRs, VRs/VSRs, LR, CCR/CR,
+CTR, FPCSR and a few other status/flag regs; see the ISA for details.
+
+Causes of transaction aborts
+============================
+
+- Conflicts with cache lines used by other processors.
+- Signals.
+- Context switches.
+- See the ISA for full documentation of everything that will abort
+  transactions.
+
+
+
+Syscalls
+========
+
+Syscalls made from within an active transaction will not be performed
+and the transaction will be doomed by the kernel with the failure code
+TM_CAUSE_SYSCALL | TM_CAUSE_PERSISTENT.
+
+Syscalls made from within a suspended transaction are performed as
+normal and the transaction is not explicitly doomed by the kernel.
+However, what the kernel does to perform the syscall may result in the
+transaction being doomed by the hardware.  The syscall is performed in
+suspended mode so any side effects will be persistent, independent of
+transaction success or failure.  No guarantees are provided by the
+kernel about which syscalls will affect transaction success.
+
+Care must be taken when relying on syscalls to abort during active
+transactions if the calls are made via a library.  Libraries may cache
+values (which may give the appearance of success) or perform operations
+that cause transaction failure before entering the kernel (which may
+produce different failure codes).  Examples are glibc's getpid() and
+lazy symbol resolution.
+
+
+Signals
+=======
+
+Delivery of signals (both sync and async) during transactions provides a
+second thread state (ucontext/mcontext) to represent the second
+transactional register state.  Signal delivery 'treclaim's to capture
+both register states, so signals abort transactions.  The usual
+ucontext_t passed to the signal handler represents the
+checkpointed/original register state; the signal appears to have arisen
+at 'tbegin+4'.
+
+If the sighandler ucontext has uc_link set, a second ucontext has been
+delivered.  For future compatibility the MSR.TS field should be checked
+to determine the transactional state -- if so, the second ucontext in
+uc->uc_link represents the active transactional registers at the point
+of the signal.
+
+For 64-bit processes, uc->uc_mcontext.regs->msr is a full 64-bit MSR and
+its TS field shows the transactional mode.
+
+For 32-bit processes, the mcontext's MSR register is only 32 bits; the
+top 32 bits are stored in the MSR of the second ucontext, i.e. in
+uc->uc_link->uc_mcontext.regs->msr.  The top word contains the
+transactional state TS.
+
+However, basic signal handlers don't need to be aware of transactions
+and simply returning from the handler will deal with things correctly:
+
+Transaction-aware signal handlers can read the transactional register
+state from the second ucontext.  This will be necessary for crash
+handlers to determine, for example, the address of the instruction
+causing the SIGSEGV.
+
+Example signal handler:
+
+  .. code-block:: c
+
+     void crash_handler(int sig, siginfo_t *si, void *uc)
+     {
+         ucontext_t *ucp = uc;
+         ucontext_t *transactional_ucp = ucp->uc_link;
+
+         if (ucp_link) {
+             u64 msr = ucp->uc_mcontext.regs->msr;
+             /* May have transactional ucontext! */
+     #ifndef __powerpc64__
+             msr |= ((u64)transactional_ucp->uc_mcontext.regs->msr) << 32;
+     #endif
+             if (MSR_TM_ACTIVE(msr)) {
+                 /* Yes, we crashed during a transaction.  Oops. */
+                 fprintf(stderr, "Transaction to be restarted at 0x%llx, but "
+                         "crashy instruction was at 0x%llx\n",
+                         ucp->uc_mcontext.regs->nip,
+                         transactional_ucp->uc_mcontext.regs->nip);
+             }
+         }
+
+         fix_the_problem(ucp->dar);
+     }
+
+When in an active transaction that takes a signal, we need to be careful
+with the stack.  It's possible that the stack has moved back up after
+the tbegin.  The obvious case here is when the tbegin is called inside a
+function that returns before a tend.  In this case, the stack is part of
+the checkpointed transactional memory state.  If we write over this non
+transactionally or in suspend, we are in trouble because if we get a tm
+abort, the program counter and stack pointer will be back at the tbegin
+but our in memory stack won't be valid anymore.
+
+To avoid this, when taking a signal in an active transaction, we need to
+use the stack pointer from the checkpointed state, rather than the
+speculated state.  This ensures that the signal context (written tm
+suspended) will be written below the stack required for the rollback.
+The transaction is aborted because of the treclaim, so any memory
+written between the tbegin and the signal will be rolled back anyway.
+
+For signals taken in non-TM or suspended mode, we use the
+normal/non-checkpointed stack pointer.
+
+Any transaction initiated inside a sighandler and suspended on return
+from the sighandler to the kernel will get reclaimed and discarded.
+
+Failure cause codes used by kernel
+==================================
+
+These are defined in <asm/reg.h>, and distinguish different reasons why
+the kernel aborted a transaction::
+
+ TM_CAUSE_RESCHED       Thread was rescheduled.
+ TM_CAUSE_TLBI          Software TLB invalid.
+ TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
+ TM_CAUSE_SYSCALL       Syscall from active transaction.
+ TM_CAUSE_SIGNAL        Signal delivered.
+ TM_CAUSE_MISC          Currently unused.
+ TM_CAUSE_ALIGNMENT     Alignment fault.
+ TM_CAUSE_EMULATE       Emulation that touched memory.
+
+These can be checked by the user program's abort handler as TEXASR[0:7].
+If bit 7 is set, it indicates that the error is consider persistent.
+For example a TM_CAUSE_ALIGNMENT will be persistent while a
+TM_CAUSE_RESCHED will not.
+
+GDB
+===
+
+GDB and ptrace are not currently TM-aware.  If one stops during a
+transaction, it looks like the transaction has just started (the
+checkpointed state is presented).  The transaction cannot then be
+continued and will take the failure handler route.  Furthermore, the
+transactional 2nd register state will be inaccessible.  GDB can
+currently be used on programs using TM, but not sensibly in parts within
+transactions.
+
+POWER9
+======
+
+TM on POWER9 has issues with storing the complete register state. This
+is described in this commit::
+
+    commit 4bb3c7a0208fc13ca70598efd109901a7cd45ae7
+    Author: Paul Mackerras <paulus@ozlabs.org>
+    Date:   Wed Mar 21 21:32:01 2018 +1100
+    KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9
+
+To account for this different POWER9 chips have TM enabled in different
+ways.
+
+On POWER9N DD2.01 and below, TM is disabled. ie HWCAP2[PPC_FEATURE2_HTM]
+is not set.
+
+On POWER9N DD2.1 TM is configured by firmware to always abort a
+transaction when tm suspend occurs. So tsuspend will cause a transaction
+to be aborted and rolled back. Kernel exceptions will also cause the
+transaction to be aborted and rolled back and the exception will not
+occur. If userspace constructs a sigcontext that enables TM suspend, the
+sigcontext will be rejected by the kernel. This mode is advertised to
+users with HWCAP2[PPC_FEATURE2_HTM_NO_SUSPEND] set.
+HWCAP2[PPC_FEATURE2_HTM] is not set in this mode.
+
+On POWER9N DD2.2 and above, KVM and POWERVM emulate TM for guests (as
+described in commit 4bb3c7a0208f), hence TM is enabled for guests
+ie. HWCAP2[PPC_FEATURE2_HTM] is set for guest userspace. Guests that
+makes heavy use of TM suspend (tsuspend or kernel suspend) will result
+in traps into the hypervisor and hence will suffer a performance
+degradation. Host userspace has TM disabled ie. HWCAP2[PPC_FEATURE2_HTM]
+is not set. (although we make enable it at some point in the future if
+we bring the emulation into host userspace context switching).
+
+POWER9C DD1.2 and above are only available with POWERVM and hence Linux
+only runs as a guest. On these systems TM is emulated like on POWER9N
+DD2.2.
+
+Guest migration from POWER8 to POWER9 will work with POWER9N DD2.2 and
+POWER9C DD1.2. Since earlier POWER9 processors don't support TM
+emulation, migration from POWER8 to POWER9 is not supported there.
diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
deleted file mode 100644
index 52c023e14f26..000000000000
--- a/Documentation/powerpc/transactional_memory.txt
+++ /dev/null
@@ -1,244 +0,0 @@
-Transactional Memory support
-============================
-
-POWER kernel support for this feature is currently limited to supporting
-its use by user programs.  It is not currently used by the kernel itself.
-
-This file aims to sum up how it is supported by Linux and what behaviour you
-can expect from your user programs.
-
-
-Basic overview
-==============
-
-Hardware Transactional Memory is supported on POWER8 processors, and is a
-feature that enables a different form of atomic memory access.  Several new
-instructions are presented to delimit transactions; transactions are
-guaranteed to either complete atomically or roll back and undo any partial
-changes.
-
-A simple transaction looks like this:
-
-begin_move_money:
-  tbegin
-  beq   abort_handler
-
-  ld    r4, SAVINGS_ACCT(r3)
-  ld    r5, CURRENT_ACCT(r3)
-  subi  r5, r5, 1
-  addi  r4, r4, 1
-  std   r4, SAVINGS_ACCT(r3)
-  std   r5, CURRENT_ACCT(r3)
-
-  tend
-
-  b     continue
-
-abort_handler:
-  ... test for odd failures ...
-
-  /* Retry the transaction if it failed because it conflicted with
-   * someone else: */
-  b     begin_move_money
-
-
-The 'tbegin' instruction denotes the start point, and 'tend' the end point.
-Between these points the processor is in 'Transactional' state; any memory
-references will complete in one go if there are no conflicts with other
-transactional or non-transactional accesses within the system.  In this
-example, the transaction completes as though it were normal straight-line code
-IF no other processor has touched SAVINGS_ACCT(r3) or CURRENT_ACCT(r3); an
-atomic move of money from the current account to the savings account has been
-performed.  Even though the normal ld/std instructions are used (note no
-lwarx/stwcx), either *both* SAVINGS_ACCT(r3) and CURRENT_ACCT(r3) will be
-updated, or neither will be updated.
-
-If, in the meantime, there is a conflict with the locations accessed by the
-transaction, the transaction will be aborted by the CPU.  Register and memory
-state will roll back to that at the 'tbegin', and control will continue from
-'tbegin+4'.  The branch to abort_handler will be taken this second time; the
-abort handler can check the cause of the failure, and retry.
-
-Checkpointed registers include all GPRs, FPRs, VRs/VSRs, LR, CCR/CR, CTR, FPCSR
-and a few other status/flag regs; see the ISA for details.
-
-Causes of transaction aborts
-============================
-
-- Conflicts with cache lines used by other processors
-- Signals
-- Context switches
-- See the ISA for full documentation of everything that will abort transactions.
-
-
-Syscalls
-========
-
-Syscalls made from within an active transaction will not be performed and the
-transaction will be doomed by the kernel with the failure code TM_CAUSE_SYSCALL
-| TM_CAUSE_PERSISTENT.
-
-Syscalls made from within a suspended transaction are performed as normal and
-the transaction is not explicitly doomed by the kernel.  However, what the
-kernel does to perform the syscall may result in the transaction being doomed
-by the hardware.  The syscall is performed in suspended mode so any side
-effects will be persistent, independent of transaction success or failure.  No
-guarantees are provided by the kernel about which syscalls will affect
-transaction success.
-
-Care must be taken when relying on syscalls to abort during active transactions
-if the calls are made via a library.  Libraries may cache values (which may
-give the appearance of success) or perform operations that cause transaction
-failure before entering the kernel (which may produce different failure codes).
-Examples are glibc's getpid() and lazy symbol resolution.
-
-
-Signals
-=======
-
-Delivery of signals (both sync and async) during transactions provides a second
-thread state (ucontext/mcontext) to represent the second transactional register
-state.  Signal delivery 'treclaim's to capture both register states, so signals
-abort transactions.  The usual ucontext_t passed to the signal handler
-represents the checkpointed/original register state; the signal appears to have
-arisen at 'tbegin+4'.
-
-If the sighandler ucontext has uc_link set, a second ucontext has been
-delivered.  For future compatibility the MSR.TS field should be checked to
-determine the transactional state -- if so, the second ucontext in uc->uc_link
-represents the active transactional registers at the point of the signal.
-
-For 64-bit processes, uc->uc_mcontext.regs->msr is a full 64-bit MSR and its TS
-field shows the transactional mode.
-
-For 32-bit processes, the mcontext's MSR register is only 32 bits; the top 32
-bits are stored in the MSR of the second ucontext, i.e. in
-uc->uc_link->uc_mcontext.regs->msr.  The top word contains the transactional
-state TS.
-
-However, basic signal handlers don't need to be aware of transactions
-and simply returning from the handler will deal with things correctly:
-
-Transaction-aware signal handlers can read the transactional register state
-from the second ucontext.  This will be necessary for crash handlers to
-determine, for example, the address of the instruction causing the SIGSEGV.
-
-Example signal handler:
-
-    void crash_handler(int sig, siginfo_t *si, void *uc)
-    {
-      ucontext_t *ucp = uc;
-      ucontext_t *transactional_ucp = ucp->uc_link;
-
-      if (ucp_link) {
-        u64 msr = ucp->uc_mcontext.regs->msr;
-        /* May have transactional ucontext! */
-#ifndef __powerpc64__
-        msr |= ((u64)transactional_ucp->uc_mcontext.regs->msr) << 32;
-#endif
-        if (MSR_TM_ACTIVE(msr)) {
-           /* Yes, we crashed during a transaction.  Oops. */
-   fprintf(stderr, "Transaction to be restarted at 0x%llx, but "
-                           "crashy instruction was at 0x%llx\n",
-                           ucp->uc_mcontext.regs->nip,
-                           transactional_ucp->uc_mcontext.regs->nip);
-        }
-      }
-
-      fix_the_problem(ucp->dar);
-    }
-
-When in an active transaction that takes a signal, we need to be careful with
-the stack.  It's possible that the stack has moved back up after the tbegin.
-The obvious case here is when the tbegin is called inside a function that
-returns before a tend.  In this case, the stack is part of the checkpointed
-transactional memory state.  If we write over this non transactionally or in
-suspend, we are in trouble because if we get a tm abort, the program counter and
-stack pointer will be back at the tbegin but our in memory stack won't be valid
-anymore.
-
-To avoid this, when taking a signal in an active transaction, we need to use
-the stack pointer from the checkpointed state, rather than the speculated
-state.  This ensures that the signal context (written tm suspended) will be
-written below the stack required for the rollback.  The transaction is aborted
-because of the treclaim, so any memory written between the tbegin and the
-signal will be rolled back anyway.
-
-For signals taken in non-TM or suspended mode, we use the
-normal/non-checkpointed stack pointer.
-
-Any transaction initiated inside a sighandler and suspended on return
-from the sighandler to the kernel will get reclaimed and discarded.
-
-Failure cause codes used by kernel
-==================================
-
-These are defined in <asm/reg.h>, and distinguish different reasons why the
-kernel aborted a transaction:
-
- TM_CAUSE_RESCHED       Thread was rescheduled.
- TM_CAUSE_TLBI          Software TLB invalid.
- TM_CAUSE_FAC_UNAV      FP/VEC/VSX unavailable trap.
- TM_CAUSE_SYSCALL       Syscall from active transaction.
- TM_CAUSE_SIGNAL        Signal delivered.
- TM_CAUSE_MISC          Currently unused.
- TM_CAUSE_ALIGNMENT     Alignment fault.
- TM_CAUSE_EMULATE       Emulation that touched memory.
-
-These can be checked by the user program's abort handler as TEXASR[0:7].  If
-bit 7 is set, it indicates that the error is consider persistent.  For example
-a TM_CAUSE_ALIGNMENT will be persistent while a TM_CAUSE_RESCHED will not.
-
-GDB
-===
-
-GDB and ptrace are not currently TM-aware.  If one stops during a transaction,
-it looks like the transaction has just started (the checkpointed state is
-presented).  The transaction cannot then be continued and will take the failure
-handler route.  Furthermore, the transactional 2nd register state will be
-inaccessible.  GDB can currently be used on programs using TM, but not sensibly
-in parts within transactions.
-
-POWER9
-======
-
-TM on POWER9 has issues with storing the complete register state. This
-is described in this commit:
-
-    commit 4bb3c7a0208fc13ca70598efd109901a7cd45ae7
-    Author: Paul Mackerras <paulus@ozlabs.org>
-    Date:   Wed Mar 21 21:32:01 2018 +1100
-    KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9
-
-To account for this different POWER9 chips have TM enabled in
-different ways.
-
-On POWER9N DD2.01 and below, TM is disabled. ie
-HWCAP2[PPC_FEATURE2_HTM] is not set.
-
-On POWER9N DD2.1 TM is configured by firmware to always abort a
-transaction when tm suspend occurs. So tsuspend will cause a
-transaction to be aborted and rolled back. Kernel exceptions will also
-cause the transaction to be aborted and rolled back and the exception
-will not occur. If userspace constructs a sigcontext that enables TM
-suspend, the sigcontext will be rejected by the kernel. This mode is
-advertised to users with HWCAP2[PPC_FEATURE2_HTM_NO_SUSPEND] set.
-HWCAP2[PPC_FEATURE2_HTM] is not set in this mode.
-
-On POWER9N DD2.2 and above, KVM and POWERVM emulate TM for guests (as
-described in commit 4bb3c7a0208f), hence TM is enabled for guests
-ie. HWCAP2[PPC_FEATURE2_HTM] is set for guest userspace. Guests that
-makes heavy use of TM suspend (tsuspend or kernel suspend) will result
-in traps into the hypervisor and hence will suffer a performance
-degradation. Host userspace has TM disabled
-ie. HWCAP2[PPC_FEATURE2_HTM] is not set. (although we make enable it
-at some point in the future if we bring the emulation into host
-userspace context switching).
-
-POWER9C DD1.2 and above are only available with POWERVM and hence
-Linux only runs as a guest. On these systems TM is emulated like on
-POWER9N DD2.2.
-
-Guest migration from POWER8 to POWER9 will work with POWER9N DD2.2 and
-POWER9C DD1.2. Since earlier POWER9 processors don't support TM
-emulation, migration from POWER8 to POWER9 is not supported there.
-- 
2.20.1

