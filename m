Date: Sat, 3 Nov 2001 15:25:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Fixups for Longtrail (2.4.14-pre7)
Message-ID: <20011103152503.H29932@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  I pulled out my Longtrail to play again, and I found some
wierd problems.  If I keep the 'default' type cards in it (What I
_think_ are the original video & ethernet, or at least known-OF-happy
ones), the box actually works.  But If I throw in a PC video card
(Matrox Millennium 1 in this case) I get oopses all over the place.  I
think the problem is that the firmware doesn't go and set all of the
properties, so lots of strcmp's blow up.  The followig gets me both
video cards (and I even logged into a mingetty on 'em) and seems to be
OK with some light testing.  Now the question is, is the following patch
worth pushing?  It does fix some technical problems, but I'm willing to
bet only Longtrail is bitten.  Comments?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/pci.c 1.36 vs edited =====
--- 1.36/arch/ppc/kernel/pci.c	Thu Nov  1 12:25:33 2001
+++ edited/arch/ppc/kernel/pci.c	Sat Nov  3 14:45:54 2001
@@ -523,7 +523,7 @@
 		class_code = (unsigned int *) get_property(node, "class-code", 0);
 		if ((!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS)) &&
-			strcmp(node->name, "multifunc-device"))
+			node->name && strcmp(node->name, "multifunc-device"))
 			continue;
 		sub_node = scan_OF_pci_childs(node->child, filter, data);
 		if (sub_node)
===== drivers/video/offb.c 1.10 vs edited =====
--- 1.10/drivers/video/offb.c	Thu Oct  4 10:14:53 2001
+++ edited/drivers/video/offb.c	Sat Nov  3 14:54:41 2001
@@ -371,7 +371,7 @@
 	address = (u_long)dp->addrs[i].address;

 	/* kludge for valkyrie */
-	if (strcmp(dp->name, "valkyrie") == 0)
+	if (dp->name && strcmp(dp->name, "valkyrie") == 0)
 	    address += 0x1000;
     }
     offb_init_fb(dp->name, dp->full_name, width, height, depth,
===== fs/proc/proc_devtree.c 1.1 vs edited =====
--- 1.1/fs/proc/proc_devtree.c	Sat Jan  6 00:25:55 2001
+++ edited/fs/proc/proc_devtree.c	Sat Nov  3 14:41:14 2001
@@ -96,9 +96,11 @@
 		 * add a symlink with the name property as its name.
 		 */
 		for (sib = np->child; sib != child; sib = sib->sibling)
-			if (sib->name && strcmp(sib->name, child->name) == 0)
+			if (sib->name && child->name &&
+					strcmp(sib->name, child->name) == 0)
 				break;
-		if (sib == child && strncmp(p, child->name, l) != 0) {
+		if (sib == child && p && child->name &&
+				strncmp(p, child->name, l) != 0) {
 			al = proc_symlink(child->name, de, ent->name);
 			if (al == 0)
 				break;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
