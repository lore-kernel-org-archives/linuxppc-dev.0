Message-ID: <3ECD5B1E.4070805@mvista.com>
Date: Thu, 22 May 2003 16:19:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch to arch/ppc/kernel/setup.c
Content-Type: multipart/mixed;
 boundary="------------040309070803000006060501"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040309070803000006060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a minor patch to move the default setting of the default
loops_per_jiffy to before the call to platform_init().  This would be
necessary if someone required a reasonable value for loops_per_jiffy so
that their progress output would work (e.g., polled UART I/O that
required a udelay() call).  Ideally, this should never be necessary
since the board-specific platform_init() should set it up correctly.
This is just in case.

Mark

P.S., I would almost prefer just getting rid of the default
loops_per_jiffy setup.  Anyone else?
--

--------------040309070803000006060501
Content-Type: text/plain;
 name="setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup.patch"

===== arch/ppc/kernel/setup.c 1.119 vs edited =====
--- 1.119/arch/ppc/kernel/setup.c	Mon Apr 21 17:13:07 2003
+++ edited/arch/ppc/kernel/setup.c	Thu May  8 17:43:26 2003
@@ -513,6 +513,9 @@
 	strcpy(cmd_line, CONFIG_CMDLINE);
 #endif /* CONFIG_CMDLINE */

+	/* so udelay does something sensible, assume <= 1000 bogomips */
+	loops_per_jiffy = 500000000 / HZ;
+
 	platform_init(r3, r4, r5, r6, r7);

 	if (ppc_md.progress_init)
@@ -558,9 +561,6 @@
 	extern char _etext[], _edata[];
 	extern char *klimit;
 	extern void do_init_bootmem(void);
-
-	/* so udelay does something sensible, assume <= 1000 bogomips */
-	loops_per_jiffy = 500000000 / HZ;

 #ifdef CONFIG_ALL_PPC
 	/* This could be called "early setup arch", it must be done

--------------040309070803000006060501--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
