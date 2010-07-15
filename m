Return-Path: <anton@ozlabs.org>
Date: Thu, 15 Jul 2010 15:31:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, dwg@au1.ibm.com
Subject: [PATCH] powerpc/mm: Handle hypervisor pte insert failure in
	__hash_page_huge
Message-ID: <20100715053148.GD10155@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


If the hypervisor gives us an error on a hugepage insert we panic. The
normal page code already handles this by returning an error instead and we end
calling low_hash_fault which will just kill the task if possible.

The patch below does a similar thing for the hugepage case.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/mm/hugetlbpage-hash64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/hugetlbpage-hash64.c	2010-07-15 15:24:19.520742137 +1000
+++ powerpc.git/arch/powerpc/mm/hugetlbpage-hash64.c	2010-07-15 15:24:30.343243050 +1000
@@ -121,8 +121,15 @@ repeat:
                         }
 		}
 
-		if (unlikely(slot == -2))
-			panic("hash_huge_page: pte_insert failed\n");
+		/*
+		 * Hypervisor failure. Restore old pte and return -1
+		 * similar to __hash_page_*
+		 */
+		if (unlikely(slot == -2)) {
+			*ptep = __pte(old_pte);
+			err = -1;
+			goto out;
+		}
 
 		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
 	}
