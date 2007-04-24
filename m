Return-Path: <dgibson@ozlabs.org>
Date: Tue, 24 Apr 2007 15:05:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Abolish PHYS_FMT macro from arch/powerpc
Message-ID: <20070424050518.GC30007@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

32-bit powerpc systems define a macro, PHYS_FMT, giving a printf
format string fragment for displaying physical addresses, since most
32-bit powerpc platforms use 32-bit physical addresses but a few use
64-bit physical addresses.

This macro is used in exactly one place, a rare error message, where
we can solve the problem more simply by just unconditionally casting
the address up to 64-bit quantity before formatting it.

This patch does so, meaning that as we bring MMU definitions from
asm-ppc over to asm-powerpc, cleaning them up in the process, we don't
need to implement this ugly macro (which additionally has a very bad
name for something global).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-04-24 14:58:10.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-04-24 14:58:46.000000000 +1000
@@ -183,8 +183,8 @@ __ioremap(phys_addr_t addr, unsigned lon
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
 	if (mem_init_done && (p < virt_to_phys(high_memory))) {
-		printk("__ioremap(): phys addr "PHYS_FMT" is RAM lr %p\n", p,
-		       __builtin_return_address(0));
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
+		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
