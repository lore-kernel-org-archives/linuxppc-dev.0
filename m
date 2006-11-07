Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 08 Nov 2006 10:22:59 +1100
Subject: [PATCH] Do a single one-line printk in bad_page_fault()
Message-Id: <20061107232300.0780D67CC6@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

bad_page_fault() prints a message telling the user what type of bad
fault we took. The first line of this message is currently implemented
as two separate printks. This has the unfortunate effect that if
several cpus simultaneously take a bad fault, the first and second parts
of the printk get jumbled up, which looks dodge and is hard to read.

So do a single one-line printk for each fault type.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/fault.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

Index: to-merge/arch/powerpc/mm/fault.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/fault.c
+++ to-merge/arch/powerpc/mm/fault.c
@@ -426,18 +426,21 @@ void bad_page_fault(struct pt_regs *regs
 
 	/* kernel has accessed a bad area */
 
-	printk(KERN_ALERT "Unable to handle kernel paging request for ");
 	switch (regs->trap) {
-		case 0x300:
-		case 0x380:
-			printk("data at address 0x%08lx\n", regs->dar);
-			break;
-		case 0x400:
-		case 0x480:
-			printk("instruction fetch\n");
-			break;
-		default:
-			printk("unknown fault\n");
+	case 0x300:
+	case 0x380:
+		printk(KERN_ALERT "Unable to handle kernel paging request for "
+			"data at address 0x%08lx\n", regs->dar);
+		break;
+	case 0x400:
+	case 0x480:
+		printk(KERN_ALERT "Unable to handle kernel paging request for "
+			"instruction fetch\n");
+		break;
+	default:
+		printk(KERN_ALERT "Unable to handle kernel paging request for "
+			"unknown fault\n");
+		break;
 	}
 	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
 		regs->nip);
