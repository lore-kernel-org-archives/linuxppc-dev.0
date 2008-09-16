Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 95CF1DDFF1
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 19:09:10 +1000 (EST)
Date: Tue, 16 Sep 2008 11:09:08 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Kill /proc/ppc_htab remainings
Message-ID: <Pine.LNX.4.64.0809161108350.1621@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1505100942-1221556148=:1621"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1505100942-1221556148=:1621
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

commit 14cf11af6cf608eb8c23e989ddb17a715ddce109 ("powerpc: Merge enough to
start building in arch/powerpc.") unwired /proc/ppc_htab, and commit
917f0af9e5a9ceecf9e72537fabb501254ba321d ("powerpc: Remove arch/ppc and
include/asm-ppc") removed the rest of the /proc/ppc_htab support, but there are
still a few references left. Kill them for good.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 Documentation/powerpc/00-INDEX     |    2 
 Documentation/powerpc/ppc_htab.txt |  118 -------------------------------------
 include/linux/proc_fs.h            |    1 
 3 files changed, 121 deletions(-)

--- a/Documentation/powerpc/00-INDEX
+++ b/Documentation/powerpc/00-INDEX
@@ -18,8 +18,6 @@ mpc52xx.txt
 	- Linux 2.6.x on MPC52xx family
 mpc52xx-device-tree-bindings.txt
 	- MPC5200 Device Tree Bindings
-ppc_htab.txt
-	- info about the Linux/PPC /proc/ppc_htab entry
 smp.txt
 	- use and state info about Linux/PPC on MP machines
 sound.txt
--- a/Documentation/powerpc/ppc_htab.txt
+++ /dev/null
@@ -1,118 +0,0 @@
-                 Information about /proc/ppc_htab
-=====================================================================
-
-This document and the related code was written by me (Cort Dougan), please
-email me (cort@fsmlabs.com) if you have questions, comments or corrections.
-
-Last Change: 2.16.98
-
-This entry in the proc directory is readable by all users but only
-writable by root.
-
-The ppc_htab interface is a user level way of accessing the
-performance monitoring registers as well as providing information
-about the PTE hash table.
-
-1. Reading
-
-  Reading this file will give you information about the memory management
-  hash table that serves as an extended tlb for page translation on the
-  powerpc.  It will also give you information about performance measurement
-  specific to the cpu that you are using.
-
-  Explanation of the 604 Performance Monitoring Fields:
-    MMCR0 - the current value of the MMCR0 register
-    PMC1
-    PMC2 - the value of the performance counters and a
-           description of what events they are counting
-           which are based on MMCR0 bit settings.
-  Explanation of the PTE Hash Table fields:
-
-    Size - hash table size in Kb.
-    Buckets -  number of buckets in the table.
-    Address - the virtual kernel address of the hash table base.
-    Entries - the number of ptes that can be stored in the hash table.
-    User/Kernel - how many pte's are in use by the kernel or user at that time.
-    Overflows - How many of the entries are in their secondary hash location.
-    Percent full - ratio of free pte entries to in use entries.
-    Reloads - Count of how many hash table misses have occurred
-              that were fixed with a reload from the linux tables.
-              Should always be 0 on 603 based machines.
-    Non-error Misses - Count of how many hash table misses have occurred
-              that were completed with the creation of a pte in the linux
-              tables with a call to do_page_fault().
-    Error Misses - Number of misses due to errors such as bad address
-              and permission violations.  This includes kernel access of
-              bad user addresses that are fixed up by the trap handler.
-
-  Note that calculation of the data displayed from /proc/ppc_htab takes
-  a long time and spends a great deal of time in the kernel.  It would
-  be quite hard on performance to read this file constantly.  In time
-  there may be a counter in the kernel that allows successive reads from
-  this file only after a given amount of time has passed to reduce the
-  possibility of a user slowing the system by reading this file.
-
-2. Writing
-
-  Writing to the ppc_htab allows you to change the characteristics of
-  the powerpc PTE hash table and setup performance monitoring.
-
-  Resizing the PTE hash table is not enabled right now due to many
-  complications with moving the hash table, rehashing the entries
-  and many many SMP issues that would have to be dealt with.
-
-  Write options to ppc_htab:
-  
-   - To set the size of the hash table to 64Kb:
-
-      echo 'size 64' > /proc/ppc_htab
-
-     The size must be a multiple of 64 and must be greater than or equal to
-     64.
-
-   - To turn off performance monitoring:
-
-      echo 'off' > /proc/ppc_htab
-
-   - To reset the counters without changing what they're counting:
-
-      echo 'reset' > /proc/ppc_htab
-
-     Note that counting will continue after the reset if it is enabled.
-
-   - To count only events in user mode or only in kernel mode:
-
-      echo 'user' > /proc/ppc_htab
-       ...or...
-      echo 'kernel' > /proc/ppc_htab
-
-     Note that these two options are exclusive of one another and the
-     lack of either of these options counts user and kernel.
-     Using 'reset' and 'off' reset these flags.
-
-   - The 604 has 2 performance counters which can each count events from
-     a specific set of events.  These sets are disjoint so it is not
-     possible to count _any_ combination of 2 events.  One event can
-     be counted by PMC1 and one by PMC2.
-
-     To start counting a particular event use:
-
-      echo 'event' > /proc/ppc_htab
-
-     and choose from these events:
-
-     PMC1
-     ----
-      'ic miss' - instruction cache misses
-      'dtlb' - data tlb misses (not hash table misses)
-
-     PMC2
-     ----
-      'dc miss' - data cache misses
-      'itlb' - instruction tlb misses (not hash table misses)
-      'load miss time' - cycles to complete a load miss
-
-3. Bugs
-
-  The PMC1 and PMC2 counters can overflow and give no indication of that
-  in /proc/ppc_htab.
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -139,7 +139,6 @@ extern int proc_readdir(struct file *, v
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, struct nameidata *);
 
 extern const struct file_operations proc_kcore_operations;
-extern const struct file_operations ppc_htab_operations;
 
 extern int pid_ns_prepare_proc(struct pid_namespace *ns);
 extern void pid_ns_release_proc(struct pid_namespace *ns);

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1505100942-1221556148=:1621--
