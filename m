Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D2951A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 20:23:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9F3902BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:59 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0DAMxr527721976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:59 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0DAMx8i021586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:22:59 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/12] documentation,
 powerpc: Add documentation for DSCR support
Date: Tue, 13 Jan 2015 15:52:33 +0530
Message-Id: <1421144560-15901-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new documentation file explaining the DSCR
support on powerpc platforms. This explains DSCR related data
structure, code paths and also available user interfaces. Any
further functional changes to the DSCR support in the kernel
should definitely update the documentation here.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 Documentation/powerpc/00-INDEX |  2 +
 Documentation/powerpc/dscr.txt | 83 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/powerpc/dscr.txt

diff --git a/Documentation/powerpc/00-INDEX b/Documentation/powerpc/00-INDEX
index 6fd0e8b..9dc845c 100644
--- a/Documentation/powerpc/00-INDEX
+++ b/Documentation/powerpc/00-INDEX
@@ -30,3 +30,5 @@ ptrace.txt
 	- Information on the ptrace interfaces for hardware debug registers.
 transactional_memory.txt
 	- Overview of the Power8 transactional memory support.
+dscr.txt
+	- Overview DSCR (Data Stream Control Register) support.
diff --git a/Documentation/powerpc/dscr.txt b/Documentation/powerpc/dscr.txt
new file mode 100644
index 0000000..1ff4400
--- /dev/null
+++ b/Documentation/powerpc/dscr.txt
@@ -0,0 +1,83 @@
+			DSCR (Data Stream Control Register)
+		================================================
+
+DSCR register in powerpc allows user to have some control of prefetch of data
+stream in the processor. Please refer to the ISA documents or related manual
+for more detailed information regarding how to use this DSCR to attain this
+control of the pefetches . This document here provides an overview of kernel
+support for DSCR, related kernel objects, it's functionalities and exported
+user interface.
+
+(A) Data Structures:
+
+	(1) thread_struct:
+		dscr		/* Thread DSCR value */
+		dscr_inherit	/* Thread has changed default DSCR */
+
+	(2) PACA:
+		dscr_default	/* per-CPU DSCR default value */
+
+	(3) sysfs.c:
+		dscr_default	/* System DSCR default value */
+
+(B) Scheduler Changes:
+
+	Scheduler will write the per-CPU DSCR default which is stored in the
+	CPU's PACA value into the register if the thread has dscr_inherit value
+	cleared which means that it has not changed the default DSCR till now.
+	If the dscr_inherit value is set which means that it has changed the
+	default DSCR value, scheduler will write the changed value which will
+	now be contained in thread struct's dscr into the register instead of
+	the per-CPU default PACA based DSCR value.
+
+	NOTE: Please note here that the system wide global DSCR value never
+	gets used directly in the scheduler process context switch at all.
+
+(C) SYSFS Interface:
+
+	Global DSCR default:		/sys/devices/system/cpu/dscr_default
+	CPU specific DSCR default:	/sys/devices/system/cpu/cpuN/dscr
+
+	Changing the global DSCR default in the sysfs will change all the CPU
+	specific DSCR defaults immediately in their PACA structures. Again if
+	the current process has the dscr_inherit clear, it also writes the new
+	value into every CPU's DSCR register right away and updates the current
+	thread's DSCR value as well.
+
+	Changing the CPU specif DSCR default value in the sysfs does exactly
+	the same thing as above but unlike the global one above, it just changes
+	stuff for that particular CPU instead for all the CPUs on the system.
+
+(D) User Space Instructions:
+
+	The DSCR register can be accessed in the user space using any of these
+	two SPR numbers available for that purpose.
+
+	(1) Problem state SPR:		0x03	(Un-privileged, POWER8 only)
+	(2) Privileged state SPR:	0x11	(Privileged)
+
+	Accessing DSCR through privileged SPR number (0x11) from user space
+	works, as it is emulated following an illegal instruction exception
+	inside the kernel. Both mfspr and mtspr instructions are emulated.
+
+	Accessing DSCR through user level SPR (0x03) from user space will first
+	create a facility unavailable exception. Inside this exception handler
+	all mfspr isntruction based read attempts will get emulated and returned
+	where as the first mtspr instruction based write attempts will enable
+	the DSCR facility for the next time around (both for read and write) by
+	setting DSCR facility in the FSCR register.
+
+(E) Specifics about 'dscr_inherit':
+
+	The thread struct element 'dscr_inherit' represents whether the thread
+	in question has attempted and changed the DSCR itself using any of the
+	following methods. This element signifies whether the thread wants to
+	use the CPU default DSCR value or its own changed DSCR value in the
+	kernel.
+
+		(1) mtspr instruction	(SPR number 0x03)
+		(2) mtspr instruction	(SPR number 0x11)
+		(3) ptrace interface	(Explicitly set user DSCR value)
+
+	Any child of the process created after this event in the process inherits
+	this same behaviour as well.
-- 
1.9.3
