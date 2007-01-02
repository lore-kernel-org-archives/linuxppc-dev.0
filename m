Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id D66D9DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:37:16 +1100 (EST)
Date: Tue, 2 Jan 2007 16:37:06 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix unbalanced uses of of_node_put
Message-ID: <20070102223706.GB6279@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The (maple|pasemi)_init_IRQ functions call of_node_put(root) once more
than they should, causing the refcount of the root node to underflow,
which triggers the WARN_ON in kref_get.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index f12d5c6..50855d4 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -254,7 +254,6 @@ static void __init maple_init_IRQ(void)
 		printk(KERN_DEBUG "OpenPIC addr: %lx, has ISUs: %d\n",
 		       openpic_addr, has_isus);
 	}
-	of_node_put(root);
 
 	BUG_ON(openpic_addr == 0);
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 89d6e29..bea7d1b 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -129,7 +129,6 @@ static __init void pas_init_IRQ(void)
 	}
 	openpic_addr = of_read_number(opprop, naddr);
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
-	of_node_put(root);
 
 	mpic = mpic_alloc(mpic_node, openpic_addr, MPIC_PRIMARY, 0, 0,
 			  " PAS-OPIC  ");
