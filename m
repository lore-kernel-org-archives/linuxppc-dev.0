Message-ID: <1610.80.7.99.14.1087235010.squirrel@www.solinno.co.uk>
Date: Mon, 14 Jun 2004 18:43:30 +0100 (BST)
Subject: [PATCH][RFC] Are unnecessary ioremap invocations bad?
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In prep_find_bridges() we call setup_indirect_pci twice, which
ends up in two unnecessary ioremap() calls.  Is this bad in any
way?  Regardles, I think it would be nice to avoid it:

--- prep_pci.c.orig	2004-06-12 10:37:21.000000000 +0100
+++ prep_pci.c	2004-06-14 18:28:32.000000000 +0100
@@ -1322,8 +1322,6 @@
 	prep_init_resource(&hose->io_resource, 0, 0x007fffff, IORESOURCE_IO);
 	prep_init_resource(&hose->mem_resources[0], 0xc0000000, 0xfeffffff,
 			   IORESOURCE_MEM);
-	setup_indirect_pci(hose, PREP_ISA_IO_BASE + 0xcf8,
-			   PREP_ISA_IO_BASE + 0xcfc);

 	printk("PReP architecture\n");

@@ -1346,9 +1344,14 @@
 					ld_le32((unsigned *) (p.PPCData+8)));
 #undef p
 			} else
-				setup_indirect_pci(hose, 0x80000cf8, 0x80000cfc);
+				setup_indirect_pci(hose,
+						   PREP_ISA_IO_BASE + 0xcf8,
+						   PREP_ISA_IO_BASE + 0xcfc);
 		}
 	}
+	else
+		setup_indirect_pci(hose, PREP_ISA_IO_BASE + 0xcf8,
+					 PREP_ISA_IO_BASE + 0xcfc);

 	ppc_md.pcibios_fixup = prep_pcibios_fixup;
 	ppc_md.pcibios_after_init = prep_pcibios_after_init;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
