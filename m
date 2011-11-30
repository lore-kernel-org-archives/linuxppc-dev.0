Return-Path: <anton@samba.org>
Message-Id: <20111130102415.232590978@samba.org>
Date: Wed, 30 Nov 2011 21:23:14 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 6/9] powerpc: Reduce pseries panic timeout from 180s to 10s
References: <20111130102308.348262468@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've had a 180 second panic timeout on ppc64 for as long as I
can remember. This patch reduces it to 10 seconds on pseries for a few
reasons:

- Almost all pseries machines have a hypervisor console so panic
  output will be available in a scrollback buffer.

- The 180 seconds impacts our availability, users (other than
  kernel hackers) just want the box to come back around so it
  can continue its work.

- I spend a lot of my life staring at the 180 second panic timeout.
  Many pseries machines take minutes to power cycle, so it's quicker
  to sit through the 180 seconds than it is to power cycle.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/setup.c	2011-11-08 11:41:51.842584444 +1100
+++ linux-build/arch/powerpc/platforms/pseries/setup.c	2011-11-14 08:32:24.581252444 +1100
@@ -354,6 +354,8 @@ early_initcall(alloc_dispatch_log_kmem_c
 
 static void __init pSeries_setup_arch(void)
 {
+	panic_timeout = 10;
+
 	/* Discover PIC type and setup ppc_md accordingly */
 	pseries_discover_pic();
 
