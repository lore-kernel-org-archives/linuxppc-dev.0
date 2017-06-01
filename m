Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdbdd6xRpzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 15:35:01 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id n23so6515997pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 22:35:01 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, anton@samba.org,
 npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com,
 khandual@linux.vnet.ibm.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH v3 3/3] Add documentation for the powerpc memtrace debugfs
 files
Date: Thu,  1 Jun 2017 15:34:40 +1000
Message-Id: <20170601053440.28976-3-rashmica.g@gmail.com>
In-Reply-To: <20170601053440.28976-1-rashmica.g@gmail.com>
References: <20170601053440.28976-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_PPC64_HARDWARE_TRACING must be set to use this feature. This can only
be used on powernv platforms.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 Documentation/ABI/testing/ppc-memtrace | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/ppc-memtrace

diff --git a/Documentation/ABI/testing/ppc-memtrace b/Documentation/ABI/testing/ppc-memtrace
new file mode 100644
index 0000000..f7eff02
--- /dev/null
+++ b/Documentation/ABI/testing/ppc-memtrace
@@ -0,0 +1,45 @@
+What:		/sys/kernel/debug/powerpc/memtrace
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	This folder contains the relevant debugfs files for the
+		hardware trace macro to use. CONFIG_PPC64_HARDWARE_TRACING
+		must be set.
+
+What:		/sys/kernel/debug/powerpc/memtrace/enable
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	Write an integer containing the size of the memory you want
+		removed from each NUMA node to this file - it must be
+		aligned to the memblock size. This amount of RAM will be
+		removed from the kernel mappings and the following debugfs
+		files will be created. This can only be successfully done
+		once per boot. Once memory is successfully removed from
+		each node, the following files are created.
+
+What:		/sys/kernel/debug/powerpc/memtrace/<node-id>
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	This directory contains information about the removed memory
+		from the specific NUMA node.
+
+What:		/sys/kernel/debug/powerpc/memtrace/<node-id>/size
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	This contains the size of the memory removed from the node.
+
+What:		/sys/kernel/debug/powerpc/memtrace/<node-id>/start
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	This contains the start address of the removed memory.
+
+What:		/sys/kernel/debug/powerpc/memtrace/<node-id>/trace
+Date:		May 2017
+KernelVersion:	4.13?
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	This is where the hardware trace macro will output the trace
+		it generates.
-- 
2.9.3
