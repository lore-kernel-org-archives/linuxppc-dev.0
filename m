Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 594181A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:44 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 21 May 2014 16:32:42 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0464A357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L6BDaX41156702
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:11:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L6WdZQ023641
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:39 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: benh@au1.ibm.com
Subject: [PATCH 3/3] powerpc: Document sysfs DSCR interface
Date: Wed, 21 May 2014 16:32:39 +1000
Message-Id: <77f5ac21b520a3c60fdd3a6eeb09421f6986c842.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
Cc: aik@ozlabs.ru, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some documentation about ...

/sys/devices/system/cpu/dscr_default
/sys/devices/system/cpu/cpuN/dscr

... to Documentation/ABI/stable.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 Documentation/ABI/stable/sysfs-devices-system-cpu |   25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-devices-system-cpu

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
new file mode 100644
index 0000000..33c133e
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -0,0 +1,25 @@
+What: 		/sys/devices/system/cpu/dscr_default
+Date:		13-May-2014
+KernelVersion:	v3.15.0
+Contact:
+Description:	Writes are equivalent to writing to
+		/sys/devices/system/cpu/cpuN/dscr on all CPUs.
+		Reads return the last written value or 0.
+		This value is not a global default: it is a way to set
+		all per-CPU defaults at the same time.
+Values:		64 bit unsigned integer (bit field)
+
+What: 		/sys/devices/system/cpu/cpu[0-9]+/dscr
+Date:		13-May-2014
+KernelVersion:	v3.15.0
+Contact:
+Description:	Default value for the Data Stream Control Register (DSCR) on
+		a CPU.
+		This default value is used when the kernel is executing and
+		for any process that has not set the DSCR itself.
+		If a process ever sets the DSCR (via direct access to the
+		SPR) that value will be persisted for that process and used
+		on any CPU where it executes (overriding the value described
+		here).
+		If set by a process it will be inherited by child processes.
+Values:		64 bit unsigned integer (bit field)
-- 
1.7.10.4
