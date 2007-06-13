Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/13] Remove a couple of unused definitions from pgtable_32.c
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045256.B35E1DDECA@ozlabs.org>
Date: Wed, 13 Jun 2007 14:52:56 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In arch/powerpc/mm/pgtable_32.c, the varialbe io_bat_index and the
macro is_power_of_4() no longer have any users.  This patch removes
them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/mm/pgtable_32.c |    4 ----
 1 file changed, 4 deletions(-)

Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-05-10 14:13:36.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-05-10 14:13:44.000000000 +1000
@@ -36,7 +36,6 @@
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
-int io_bat_index;
 
 #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
 #define HAVE_BATS	1
@@ -299,9 +298,6 @@ void __init mapin_ram(void)
 	}
 }
 
-/* is x a power of 4? */
-#define is_power_of_4(x)	is_power_of_2(x) && (ffs(x) & 1)
-
 /* Scan the real Linux page tables and return a PTE pointer for
  * a virtual address in a context.
  * Returns true (1) if PTE was found, zero otherwise.  The pointer to
