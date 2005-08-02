Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1123023575.2614.25.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 02 Aug 2005 17:59:35 -0500
Subject: Beginning Merger Patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

I have grabbed my asbestos suit.

Here is a patch to begin the process of merging
the PPC32 and PPC64 include directories into a
new common "powerpc" arch.

This patch introduces the include/asm-powerpc directory.
It then places into it, all of the files in asm-ppc and
asm-ppc64 that are essentially identical.  A stub is left
in asm-ppc and asm-ppc64 pointing to the unified files.
No real thought went into this set of files; these are
the dead-simple identical files for starters!

This patch can be rsync'ed from here:

    rsync www.jdl.com::pub/software/patches/linux-20050802-01.patch 20050802-01.patch

It may be cg-pull'ed from this tree:

    cg-clone http://www.jdl.com/pub/software/linux-2.6-jdl.git
or
    cg-clone rsync://www.jdl.com/pub/software/linux-2.6-jdl.git

Oh yeah.

jdl


Signed-off-by: Jon Loeliger <jdl@freescale.com>



---
commit 2c6a0ac49cb3ec2b73fc48b015aa3550e2df27c7
tree f12b4db25885fb67cacf1597daf2a789140c974d
parent 9a351e30d72d409ec62c83f380e330e0baa584b4
author Jon Loeliger <jdl@freescale.com> Tue, 02 Aug 2005 14:27:26 -0500
committer Jon Loeliger <jdl@freescale.com> Tue, 02 Aug 2005 14:27:26 -0500

 include/asm-powerpc/8253pit.h           |   10 +++++++++
 include/asm-powerpc/agp.h               |   23 +++++++++++++++++++++
 include/asm-powerpc/cputime.h           |    1 +
 include/asm-powerpc/emergency-restart.h |    1 +
 include/asm-powerpc/errno.h             |   18 ++++++++++++++++
 include/asm-powerpc/hdreg.h             |    1 +
 include/asm-powerpc/ipc.h               |    1 +
 include/asm-powerpc/linkage.h           |    6 +++++
 include/asm-powerpc/local.h             |    1 +
 include/asm-powerpc/parport.h           |   18 ++++++++++++++++
 include/asm-powerpc/percpu.h            |    1 +
 include/asm-powerpc/poll.h              |   32 +++++++++++++++++++++++++++++
 include/asm-powerpc/resource.h          |    1 +
 include/asm-powerpc/shmparam.h          |   13 ++++++++++++
 include/asm-powerpc/xor.h               |    1 +
 include/asm-ppc/8253pit.h               |   12 ++---------
 include/asm-ppc/agp.h                   |   25 ++---------------------
 include/asm-ppc/cputime.h               |    5 -----
 include/asm-ppc/emergency-restart.h     |    5 -----
 include/asm-ppc/errno.h                 |   13 ++----------
 include/asm-ppc/linkage.h               |    8 ++-----
 include/asm-ppc/local.h                 |    5 -----
 include/asm-ppc/parport.h               |   19 +----------------
 include/asm-ppc/percpu.h                |    5 -----
 include/asm-ppc/poll.h                  |   25 ++---------------------
 include/asm-ppc/resource.h              |    5 -----
 include/asm-ppc/shmparam.h              |    7 ++----
 include/asm-ppc64/8253pit.h             |   12 ++---------
 include/asm-ppc64/agp.h                 |   25 ++---------------------
 include/asm-ppc64/cputime.h             |    5 -----
 include/asm-ppc64/emergency-restart.h   |    5 -----
 include/asm-ppc64/errno.h               |   20 ++----------------
 include/asm-ppc64/linkage.h             |    8 ++-----
 include/asm-ppc64/parport.h             |   19 +----------------
 include/asm-ppc64/percpu.h              |    5 -----
 include/asm-ppc64/poll.h                |   34 ++-----------------------------
 include/asm-ppc64/resource.h            |    5 -----
 include/asm-ppc64/shmparam.h            |   15 ++------------
 38 files changed, 154 insertions(+), 261 deletions(-)

diff --git a/include/asm-powerpc/8253pit.h b/include/asm-powerpc/8253pit.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/8253pit.h
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _ASM_POWERPC_8253PIT_H
+#define _ASM_POWERPC_8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif	/* _ASM_POWERPC_8253PIT_H */
diff --git a/include/asm-powerpc/agp.h b/include/asm-powerpc/agp.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/agp.h
@@ -0,0 +1,23 @@
+#ifndef _ASM_POWERPC_AGP_H
+#define _ASM_POWERPC_AGP_H
+
+#include <asm/io.h>
+
+/* nothing much needed here */
+
+#define map_page_into_agp(page)
+#define unmap_page_from_agp(page)
+#define flush_agp_mappings()
+#define flush_agp_cache() mb()
+
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
+#endif	/* _ASM_POWERPC_AGP_H */
diff --git a/include/asm-powerpc/cputime.h b/include/asm-powerpc/cputime.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/cputime.h
@@ -0,0 +1 @@
+#include <asm-generic/cputime.h>
diff --git a/include/asm-powerpc/emergency-restart.h b/include/asm-powerpc/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/emergency-restart.h
@@ -0,0 +1 @@
+#include <asm-generic/emergency-restart.h>
diff --git a/include/asm-powerpc/errno.h b/include/asm-powerpc/errno.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/errno.h
@@ -0,0 +1,18 @@
+/* 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_ERRNO_H
+#define _ASM_POWERPC_ERRNO_H
+
+#include <asm-generic/errno.h>
+
+#undef	EDEADLOCK
+#define	EDEADLOCK	58	/* File locking deadlock error */
+
+#define _LAST_ERRNO	516
+
+#endif	/* _ASM_POWERPC_ERRNO_H */
diff --git a/include/asm-powerpc/hdreg.h b/include/asm-powerpc/hdreg.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/hdreg.h
@@ -0,0 +1 @@
+#include <asm-generic/hdreg.h>
diff --git a/include/asm-powerpc/ipc.h b/include/asm-powerpc/ipc.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/ipc.h
@@ -0,0 +1 @@
+#include <asm-generic/ipc.h>
diff --git a/include/asm-powerpc/linkage.h b/include/asm-powerpc/linkage.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/linkage.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_POWERPC_LINKAGE_H
+#define _ASM_POWERPC_LINKAGE_H
+
+/* Nothing to see here... */
+
+#endif	/* _ASM_POWERPC_LINKAGE_H */
diff --git a/include/asm-powerpc/local.h b/include/asm-powerpc/local.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/local.h
@@ -0,0 +1 @@
+#include <asm-generic/local.h>
diff --git a/include/asm-powerpc/parport.h b/include/asm-powerpc/parport.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/parport.h
@@ -0,0 +1,18 @@
+/*
+ * parport.h: platform-specific PC-style parport initialisation
+ *
+ * Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
+ *
+ * This file should only be included by drivers/parport/parport_pc.c.
+ */
+
+#ifndef _ASM_POWERPC_PARPORT_H
+#define _ASM_POWERPC_PARPORT_H
+
+static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
+static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
+{
+	return parport_pc_find_isa_ports (autoirq, autodma);
+}
+
+#endif	/* _ASM_POWERPC_PARPORT_H */
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/percpu.h
@@ -0,0 +1 @@
+#include <asm-generic/percpu.h>
diff --git a/include/asm-powerpc/poll.h b/include/asm-powerpc/poll.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/poll.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2001 PPC64 Team, IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_POLL_H
+#define _ASM_POWERPC_POLL_H
+
+#define POLLIN		0x0001
+#define POLLPRI		0x0002
+#define POLLOUT		0x0004
+#define POLLERR		0x0008
+#define POLLHUP		0x0010
+#define POLLNVAL	0x0020
+#define POLLRDNORM	0x0040
+#define POLLRDBAND	0x0080
+#define POLLWRNORM	0x0100
+#define POLLWRBAND	0x0200
+#define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
+
+struct pollfd {
+	int fd;
+	short events;
+	short revents;
+};
+
+#endif	/* _ASM_POWERPC_POLL_H */
diff --git a/include/asm-powerpc/resource.h b/include/asm-powerpc/resource.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/resource.h
@@ -0,0 +1 @@
+#include <asm-generic/resource.h>
diff --git a/include/asm-powerpc/shmparam.h b/include/asm-powerpc/shmparam.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/shmparam.h
@@ -0,0 +1,13 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_SHMPARAM_H
+#define _ASM_POWERPC_SHMPARAM_H
+
+#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
+
+#endif	/* _ASM_POWERPC_SHMPARAM_H */
diff --git a/include/asm-powerpc/xor.h b/include/asm-powerpc/xor.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/xor.h
@@ -0,0 +1 @@
+#include <asm-generic/xor.h>
diff --git a/include/asm-ppc/8253pit.h b/include/asm-ppc/8253pit.h
--- a/include/asm-ppc/8253pit.h
+++ b/include/asm-ppc/8253pit.h
@@ -1,10 +1,2 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
-
-#ifndef _8253PIT_H
-#define _8253PIT_H
-
-#define PIT_TICK_RATE 	1193182UL
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/8253pit.h>
diff --git a/include/asm-ppc/agp.h b/include/asm-ppc/agp.h
--- a/include/asm-ppc/agp.h
+++ b/include/asm-ppc/agp.h
@@ -1,23 +1,2 @@
-#ifndef AGP_H
-#define AGP_H 1
-
-#include <asm/io.h>
-
-/* nothing much needed here */
-
-#define map_page_into_agp(page)
-#define unmap_page_from_agp(page)
-#define flush_agp_mappings()
-#define flush_agp_cache() mb()
-
-/* Convert a physical address to an address suitable for the GART. */
-#define phys_to_gart(x) (x)
-#define gart_to_phys(x) (x)
-
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/agp.h>
diff --git a/include/asm-ppc/cputime.h b/include/asm-ppc/cputime.h
--- a/include/asm-ppc/cputime.h
+++ b/include/asm-ppc/cputime.h
@@ -1,6 +1 @@
-#ifndef __PPC_CPUTIME_H
-#define __PPC_CPUTIME_H
-
 #include <asm-generic/cputime.h>
-
-#endif /* __PPC_CPUTIME_H */
diff --git a/include/asm-ppc/emergency-restart.h b/include/asm-ppc/emergency-restart.h
--- a/include/asm-ppc/emergency-restart.h
+++ b/include/asm-ppc/emergency-restart.h
@@ -1,6 +1 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
 #include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc/errno.h b/include/asm-ppc/errno.h
--- a/include/asm-ppc/errno.h
+++ b/include/asm-ppc/errno.h
@@ -1,11 +1,2 @@
-#ifndef _PPC_ERRNO_H
-#define _PPC_ERRNO_H
-
-#include <asm-generic/errno.h>
-
-#undef	EDEADLOCK
-#define	EDEADLOCK	58	/* File locking deadlock error */
-
-#define _LAST_ERRNO	516
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/errno.h>
diff --git a/include/asm-ppc/linkage.h b/include/asm-ppc/linkage.h
--- a/include/asm-ppc/linkage.h
+++ b/include/asm-ppc/linkage.h
@@ -1,6 +1,2 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/linkage.h>
diff --git a/include/asm-ppc/local.h b/include/asm-ppc/local.h
--- a/include/asm-ppc/local.h
+++ b/include/asm-ppc/local.h
@@ -1,6 +1 @@
-#ifndef __PPC_LOCAL_H
-#define __PPC_LOCAL_H
-
 #include <asm-generic/local.h>
-
-#endif /* __PPC_LOCAL_H */
diff --git a/include/asm-ppc/parport.h b/include/asm-ppc/parport.h
--- a/include/asm-ppc/parport.h
+++ b/include/asm-ppc/parport.h
@@ -1,18 +1 @@
-/*
- * parport.h: platform-specific PC-style parport initialisation
- *
- * Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
- *
- * This file should only be included by drivers/parport/parport_pc.c.
- */
-
-#ifndef _ASM_PPC_PARPORT_H
-#define _ASM_PPC_PARPORT_H
-
-static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
-{
-	return parport_pc_find_isa_ports (autoirq, autodma);
-}
-
-#endif /* !(_ASM_PPC_PARPORT_H) */
+#include <asm-powerpc/parport.h>
diff --git a/include/asm-ppc/percpu.h b/include/asm-ppc/percpu.h
--- a/include/asm-ppc/percpu.h
+++ b/include/asm-ppc/percpu.h
@@ -1,6 +1 @@
-#ifndef __ARCH_PPC_PERCPU__
-#define __ARCH_PPC_PERCPU__
-
 #include <asm-generic/percpu.h>
-
-#endif /* __ARCH_PPC_PERCPU__ */
diff --git a/include/asm-ppc/poll.h b/include/asm-ppc/poll.h
--- a/include/asm-ppc/poll.h
+++ b/include/asm-ppc/poll.h
@@ -1,23 +1,2 @@
-#ifndef __PPC_POLL_H
-#define __PPC_POLL_H
-
-#define POLLIN		0x0001
-#define POLLPRI		0x0002
-#define POLLOUT		0x0004
-#define POLLERR		0x0008
-#define POLLHUP		0x0010
-#define POLLNVAL	0x0020
-#define POLLRDNORM	0x0040
-#define POLLRDBAND	0x0080
-#define POLLWRNORM	0x0100
-#define POLLWRBAND	0x0200
-#define POLLMSG		0x0400
-#define POLLREMOVE	0x1000
-
-struct pollfd {
-	int fd;
-	short events;
-	short revents;
-};
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/poll.h>
diff --git a/include/asm-ppc/resource.h b/include/asm-ppc/resource.h
--- a/include/asm-ppc/resource.h
+++ b/include/asm-ppc/resource.h
@@ -1,6 +1 @@
-#ifndef _PPC_RESOURCE_H
-#define _PPC_RESOURCE_H
-
 #include <asm-generic/resource.h>
-
-#endif
diff --git a/include/asm-ppc/shmparam.h b/include/asm-ppc/shmparam.h
--- a/include/asm-ppc/shmparam.h
+++ b/include/asm-ppc/shmparam.h
@@ -1,6 +1,3 @@
-#ifndef _PPC_SHMPARAM_H
-#define _PPC_SHMPARAM_H
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/shmparam.h>
 
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _PPC_SHMPARAM_H */
diff --git a/include/asm-ppc64/8253pit.h b/include/asm-ppc64/8253pit.h
--- a/include/asm-ppc64/8253pit.h
+++ b/include/asm-ppc64/8253pit.h
@@ -1,10 +1,2 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
-
-#ifndef _8253PIT_H
-#define _8253PIT_H
-
-#define PIT_TICK_RATE 	1193182UL
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/8253pit.h>
diff --git a/include/asm-ppc64/agp.h b/include/asm-ppc64/agp.h
--- a/include/asm-ppc64/agp.h
+++ b/include/asm-ppc64/agp.h
@@ -1,23 +1,2 @@
-#ifndef AGP_H
-#define AGP_H 1
-
-#include <asm/io.h>
-
-/* nothing much needed here */
-
-#define map_page_into_agp(page)
-#define unmap_page_from_agp(page)
-#define flush_agp_mappings()
-#define flush_agp_cache() mb()
-
-/* Convert a physical address to an address suitable for the GART. */
-#define phys_to_gart(x) (x)
-#define gart_to_phys(x) (x)
-
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/agp.h>
diff --git a/include/asm-ppc64/cputime.h b/include/asm-ppc64/cputime.h
--- a/include/asm-ppc64/cputime.h
+++ b/include/asm-ppc64/cputime.h
@@ -1,6 +1 @@
-#ifndef __PPC_CPUTIME_H
-#define __PPC_CPUTIME_H
-
 #include <asm-generic/cputime.h>
-
-#endif /* __PPC_CPUTIME_H */
diff --git a/include/asm-ppc64/emergency-restart.h b/include/asm-ppc64/emergency-restart.h
--- a/include/asm-ppc64/emergency-restart.h
+++ b/include/asm-ppc64/emergency-restart.h
@@ -1,6 +1 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
 #include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc64/errno.h b/include/asm-ppc64/errno.h
--- a/include/asm-ppc64/errno.h
+++ b/include/asm-ppc64/errno.h
@@ -1,18 +1,2 @@
-#ifndef _PPC64_ERRNO_H
-#define _PPC64_ERRNO_H
-
-/* 
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm-generic/errno.h>
-
-#undef	EDEADLOCK
-#define	EDEADLOCK	58	/* File locking deadlock error */
-
-#define _LAST_ERRNO	516
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/errno.h>
diff --git a/include/asm-ppc64/linkage.h b/include/asm-ppc64/linkage.h
--- a/include/asm-ppc64/linkage.h
+++ b/include/asm-ppc64/linkage.h
@@ -1,6 +1,2 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/linkage.h>
diff --git a/include/asm-ppc64/parport.h b/include/asm-ppc64/parport.h
--- a/include/asm-ppc64/parport.h
+++ b/include/asm-ppc64/parport.h
@@ -1,18 +1 @@
-/*
- * parport.h: platform-specific PC-style parport initialisation
- *
- * Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
- *
- * This file should only be included by drivers/parport/parport_pc.c.
- */
-
-#ifndef _ASM_PPC64_PARPORT_H
-#define _ASM_PPC64_PARPORT_H
-
-static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
-{
-	return parport_pc_find_isa_ports (autoirq, autodma);
-}
-
-#endif /* !(_ASM_PPC_PARPORT_H) */
+#include <asm-powerpc/parport.h>
diff --git a/include/asm-ppc64/percpu.h b/include/asm-ppc64/percpu.h
--- a/include/asm-ppc64/percpu.h
+++ b/include/asm-ppc64/percpu.h
@@ -1,6 +1 @@
-#ifndef __ARCH_PPC64_PERCPU__
-#define __ARCH_PPC64_PERCPU__
-
 #include <asm-generic/percpu.h>
-
-#endif /* __ARCH_PPC64_PERCPU__ */
diff --git a/include/asm-ppc64/poll.h b/include/asm-ppc64/poll.h
--- a/include/asm-ppc64/poll.h
+++ b/include/asm-ppc64/poll.h
@@ -1,32 +1,2 @@
-#ifndef __PPC64_POLL_H
-#define __PPC64_POLL_H
-
-/*
- * Copyright (C) 2001 PPC64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define POLLIN		0x0001
-#define POLLPRI		0x0002
-#define POLLOUT		0x0004
-#define POLLERR		0x0008
-#define POLLHUP		0x0010
-#define POLLNVAL	0x0020
-#define POLLRDNORM	0x0040
-#define POLLRDBAND	0x0080
-#define POLLWRNORM	0x0100
-#define POLLWRBAND	0x0200
-#define POLLMSG		0x0400
-#define POLLREMOVE	0x1000
-
-struct pollfd {
-	int fd;
-	short events;
-	short revents;
-};
-
-#endif /* __PPC64_POLL_H */
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/poll.h>
diff --git a/include/asm-ppc64/resource.h b/include/asm-ppc64/resource.h
--- a/include/asm-ppc64/resource.h
+++ b/include/asm-ppc64/resource.h
@@ -1,6 +1 @@
-#ifndef _PPC64_RESOURCE_H
-#define _PPC64_RESOURCE_H
-
 #include <asm-generic/resource.h>
-
-#endif /* _PPC64_RESOURCE_H */
diff --git a/include/asm-ppc64/shmparam.h b/include/asm-ppc64/shmparam.h
--- a/include/asm-ppc64/shmparam.h
+++ b/include/asm-ppc64/shmparam.h
@@ -1,13 +1,2 @@
-#ifndef _PPC64_SHMPARAM_H
-#define _PPC64_SHMPARAM_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _PPC64_SHMPARAM_H */
+/* ppc and ppc64 are being merged into powerpc */
+#include <asm-powerpc/shmparam.h>
