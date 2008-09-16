Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 422C9DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 04:44:49 +1000 (EST)
Subject: [PATCH] powerpc: Remove obsolete junk in Documentation/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 16 Sep 2008 11:44:42 -0700
Message-Id: <1221590682.12463.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have all sort of totally rotten pieces of documentation
in there, let's get rid of them

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 ppc_htab.txt      |  118 ------------------------------------------------------
 smp.txt           |   34 ---------------
 sound.txt         |   81 -------------------------------------
 zImage_layout.txt |   47 ---------------------
 4 files changed, 280 deletions(-)

Index: linux-work/Documentation/powerpc/ppc_htab.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/ppc_htab.txt	2008-09-16 11:38:42.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
Index: linux-work/Documentation/powerpc/smp.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/smp.txt	2008-09-16 11:38:42.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,34 +0,0 @@
-                 Information about Linux/PPC SMP mode
-=====================================================================
-
-This document and the related code was written by me
-(Cort Dougan, cort@fsmlabs.com) please email me if you have questions,
-comments or corrections.
-
-Last Change: 3.31.99
-
-If you want to help by writing code or testing different hardware please
-email me!
-
-1. State of Supported Hardware
-
-  PowerSurge Architecture - tested on UMAX s900, Apple 9600
-    The second processor on this machine boots up just fine and
-    enters its idle loop.  Hopefully a completely working SMP kernel
-    on this machine will be done shortly.
-
-    The code makes the assumption of only two processors.  The changes
-    necessary to work with any number would not be overly difficult but
-    I don't have any machines with >2 processors so it's not high on my
-    list of priorities.  If anyone else would like do to the work email
-    me and I can point out the places that need changed.  If you have >2
-    processors and don't want to add support yourself let me know and I
-    can take a look into it.
-
-  BeBox
-    BeBox support hasn't been added to the 2.1.X kernels from 2.0.X
-    but work is being done and SMP support for BeBox is in the works.
-
-  CHRP
-    CHRP SMP works and is fairly solid.  It's been tested on the IBM F50
-    with 4 processors for quite some time now.
Index: linux-work/Documentation/powerpc/sound.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/sound.txt	2008-09-16 11:38:42.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,81 +0,0 @@
-            Information about PowerPC Sound support
-=====================================================================
-
-Please mail me (Cort Dougan, cort@fsmlabs.com) if you have questions,
-comments or corrections.
-
-Last Change: 6.16.99
-
-This just covers sound on the PReP and CHRP systems for now and later
-will contain information on the PowerMac's.
-
-Sound on PReP has been tested and is working with the PowerStack and IBM
-Power Series onboard sound systems which are based on the cs4231(2) chip.
-The sound options when doing the make config are a bit different from
-the default, though.
-
-The I/O base, irq and dma lines that you enter during the make config
-are ignored and are set when booting according to the machine type.
-This is so that one binary can be used for Motorola and IBM machines
-which use different values and isn't allowed by the driver, so things
-are hacked together in such a way as to allow this information to be
-set automatically on boot.
-
-1. Motorola PowerStack PReP machines
-
-  Enable support for "Crystal CS4232 based (PnP) cards" and for the
-  Microsoft Sound System.  The MSS isn't used, but some of the routines
-  that the CS4232 driver uses are in it.
-
-  Although the options you set are ignored and determined automatically
-  on boot these are included for information only:
-
-  (830) CS4232 audio I/O base 530, 604, E80 or F40
-  (10) CS4232 audio IRQ 5, 7, 9, 11, 12 or 15
-  (6) CS4232 audio DMA 0, 1 or 3
-  (7) CS4232 second (duplex) DMA 0, 1 or 3
-
-  This will allow simultaneous record and playback, as 2 different dma
-  channels are used.
-
-  The sound will be all left channel and very low volume since the
-  auxiliary input isn't muted by default.  I had the changes necessary
-  for this in the kernel but the sound driver maintainer didn't want
-  to include them since it wasn't common in other machines.  To fix this
-  you need to mute it using a mixer utility of some sort (if you find one
-  please let me know) or by patching the driver yourself and recompiling.
-
-  There is a problem on the PowerStack 2's (PowerStack Pro's) using a
-  different irq/drq than the kernel expects.  Unfortunately, I don't know
-  which irq/drq it is so if anyone knows please email me.
-
-  Midi is not supported since the cs4232 driver doesn't support midi yet.
-
-2. IBM PowerPersonal PReP machines
-
-  I've only tested sound on the Power Personal Series of IBM workstations
-  so if you try it on others please let me know the result.  I'm especially
-  interested in the 43p's sound system, which I know nothing about.
-
-  Enable support for "Crystal CS4232 based (PnP) cards" and for the
-  Microsoft Sound System.  The MSS isn't used, but some of the routines
-  that the CS4232 driver uses are in it.
-
-  Although the options you set are ignored and determined automatically
-  on boot these are included for information only:
-
-  (530) CS4232 audio I/O base 530, 604, E80 or F40
-  (5) CS4232 audio IRQ 5, 7, 9, 11, 12 or 15
-  (1) CS4232 audio DMA 0, 1 or 3
-  (7) CS4232 second (duplex) DMA 0, 1 or 3
-  (330) CS4232 MIDI I/O base 330, 370, 3B0 or 3F0
-  (9) CS4232 MIDI IRQ 5, 7, 9, 11, 12 or 15
-
-  This setup does _NOT_ allow for recording yet.
-
-  Midi is not supported since the cs4232 driver doesn't support midi yet.
-
-2. IBM CHRP
-
-  I have only tested this on the 43P-150.  Build the kernel with the cs4232
-  set as a module and load the module with irq=9 dma=1 dma2=2 io=0x550
Index: linux-work/Documentation/powerpc/zImage_layout.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/zImage_layout.txt	2008-09-16 11:38:42.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,47 +0,0 @@
-          Information about the Linux/PPC kernel images
-=====================================================================
-
-Please mail me (Cort Dougan, cort@fsmlabs.com) if you have questions,
-comments or corrections.
-
-This document is meant to answer several questions I've had about how
-the PReP system boots and how Linux/PPC interacts with that mechanism.
-It would be nice if we could have information on how other architectures
-boot here as well.  If you have anything to contribute, please
-let me know.
-
-
-1. PReP boot file
-
-  This is the file necessary to boot PReP systems from floppy or
-  hard drive.  The firmware reads the PReP partition table entry
-  and will load the image accordingly.
-
-  To boot the zImage, copy it onto a floppy with dd if=zImage of=/dev/fd0h1440
-  or onto a PReP hard drive partition with dd if=zImage of=/dev/sda4
-  assuming you've created a PReP partition (type 0x41) with fdisk on
-  /dev/sda4.
-
-  The layout of the image format is:
-
-  0x0     +------------+
-          |            | PReP partition table entry
-          |            |
-  0x400   +------------+
-          |            | Bootstrap program code + data
-          |            |
-          |            |
-          +------------+
-          |            | compressed kernel, elf header removed
-          +------------+
-          |            | initrd (if loaded)
-          +------------+
-          |            | Elf section table for bootstrap program
-          +------------+
-
-
-2. MBX boot file
-
-  The MBX boards can load an elf image, and relocate it to the
-  proper location in memory - it copies the image to the location it was
-  linked at.
