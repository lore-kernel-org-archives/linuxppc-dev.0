Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 May 2008 16:16:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Fix  __set_fixmap() for STRICT_MM_TYPECHECKS
Message-ID: <20080519061559.GD25453@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

__set_fixmap() in pgtable_32.c currently fails to compile if
STRICT_MM_TYPECHECKS is defined.  This patch fixes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2008-05-19 16:13:02.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2008-05-19 16:13:09.000000000 +1000
@@ -402,7 +402,7 @@ void __set_fixmap (enum fixed_addresses 
 		return;
 	}
 
-	map_page(address, phys, flags);
+	map_page(address, phys, pgprot_val(flags));
 	fixmaps++;
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
