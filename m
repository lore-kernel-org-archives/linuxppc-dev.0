Message-Id: <200011240729.IAA00640@piglet.grunz.lu>
Date: Fri, 24 Nov 2000 08:29:33 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: chaos PCI config access for 2.4 kernels
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-975050978=:638"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-975050978=:638
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

Below is a patch that fills in the missing parts for chaos host bridge
PCI config accesses.

The patch is against Paul's devel tree rsync'ed last night. It does
compile witout warnings, but I've been unable to verify its operation
since Paul's kernels continue to refuse booting on my machine.

The patch however was working on the same basis in benh's 2.5 kernel,
and detected both control and planb on my chaos, without blowing
everything up ;-)

Whoever has a machine with a chaos hostbridge (7300/7500/7600/8500/8600)
please test, and report back!

Cheers, and happy testing ;-)

Michel

PS If anyone's interested, I have the patch also for benh's 2.5 kernel..

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-975050978=:638
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.4-paulus-chaos.diff"

--- /mnt/r4/usr/src/linux-2.4.paul/arch/ppc/kernel/pmac_pci.c	Wed Nov 22 01:30:11 2000
+++ linux-2.4.0-test11/arch/ppc/kernel/pmac_pci.c	Fri Nov 24 00:46:16 2000
@@ -30,6 +30,7 @@
 #undef DEBUG

 static void add_bridges(struct device_node *dev);
+static int chaos_validate_dev(struct pci_dev *dev);

 /* XXX Could be per-controller, but I don't think we risk anything by
  * assuming we won't have both UniNorth and Bandit */
@@ -93,12 +94,17 @@
 }

 /*
- * Apple MacRISC (UniNorth, Bandit) PCI controllers.
+ * Apple MacRISC (UniNorth, Bandit, Chaos) PCI controllers.
  *
  * The "Bandit" version is present in all early PCI PowerMacs,
  * and up to the first ones using Grackle. Some machines may
  * have 2 bandit controllers (2 PCI busses).
  *
+ * "Chaos" is used in some "Bandit"-type machines as a bridge
+ * for the separate display bus. It is accessed the same
+ * way as bandit, but cannot be probed for devices. It therefore
+ * has its own config access functions.
+ *
  * The "UniNorth" version is present in all Core99 machines
  * (iBook, G4, new IMacs, and all the recent Apple machines).
  * It contains 3 controllers in one ASIC.
@@ -196,44 +202,30 @@
  * based on what we find in OF device tree
  */

-static int chaos_config_read_byte(struct pci_dev *dev, int offset, u8 *val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static int chaos_config_read_word(struct pci_dev *dev, int offset, u16 *val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static int chaos_config_read_dword(struct pci_dev *dev, int offset, u32 *val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static int chaos_config_write_byte(struct pci_dev *dev, int offset, u8 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static int chaos_config_write_word(struct pci_dev *dev, int offset, u16 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
+#define CHAOS_PCI_OP(rw, size, type, op, op2)				    \
+static int __pmac							    \
+chaos_##rw##_config_##size(struct pci_dev *dev, int off, type val)	    \
+{									    \
+	if (chaos_validate_dev(dev) != PCIBIOS_SUCCESSFUL)		    \
+		return PCIBIOS_DEVICE_NOT_FOUND;			    \
+	return macrisc_##rw##_config_##size(dev, off, val);		    \
 }

-static int chaos_config_write_dword(struct pci_dev *dev, int offset, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
+CHAOS_PCI_OP(read, byte, u8 *, in_8, x)
+CHAOS_PCI_OP(read, word, u16 *, in_le16, x)
+CHAOS_PCI_OP(read, dword, u32 *, in_le32, x)
+CHAOS_PCI_OP(write, byte, u8, out_8, in_8)
+CHAOS_PCI_OP(write, word, u16, out_le16, in_le16)
+CHAOS_PCI_OP(write, dword, u32, out_le32, in_le32)

 static struct pci_ops chaos_pci_ops =
 {
-	chaos_config_read_byte,
-	chaos_config_read_word,
-	chaos_config_read_dword,
-	chaos_config_write_byte,
-	chaos_config_write_word,
-	chaos_config_write_dword
+	chaos_read_config_byte,
+	chaos_read_config_word,
+	chaos_read_config_dword,
+	chaos_write_config_byte,
+	chaos_write_config_word,
+	chaos_write_config_dword
 };


@@ -284,6 +276,17 @@
 	out_le32((volatile unsigned int *)bp->cfg_data, magic);
 	printk(KERN_INFO "Cache coherency enabled for bandit/PSX at %08lx\n",
 	       bp->io_base_phys);
+}
+
+
+/*
+ * Verifiy that a specific (bus, dev_fn) exists on chaos
+ */
+static int chaos_validate_dev(struct pci_dev *dev)
+{
+	if(pci_device_to_OF_node(dev) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return PCIBIOS_SUCCESSFUL;
 }



--134458388-1804289383-975050978=:638--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
