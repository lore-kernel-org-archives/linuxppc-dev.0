Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.35410.880000.878984@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 16:57:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: [PATCH] ppc32: don't call progress functions after boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On ppc32, the platform code can supply a "progress" function that is
used to show progress through the boot.  These functions are usually
in an init section and so can't be called after the init pages are
freed.  Now that the cpu bringup code can be called after the system
is booted (for hotplug cpu) we can get the situation where the
progress function can be called after boot.  The simple fix is to set
the progress function pointer to NULL when the init pages are freed,
and that is what this patch does (note that all callers already check
whether the function pointer is NULL before trying to call it).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc/mm/init.c pmac-2.5/arch/ppc/mm/init.c
--- linux-2.6/arch/ppc/mm/init.c	2005-04-26 15:37:55.000000000 +1000
+++ pmac-2.5/arch/ppc/mm/init.c	2005-04-26 20:34:00.000000000 +1000
@@ -179,6 +179,7 @@
 	if (!have_of)
 		FREESEC(openfirmware);
  	printk("\n");
+	ppc_md.progress = NULL;
 #undef FREESEC
 }
 
