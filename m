From: praveen.nale@wipro.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: pci mbx860
Date: Mon, 1 Dec 2003 13:47:01 +0530
Message-ID: <19DC990402F5E9438197A8DFAEE8131F72F4D3@blr-ec-msg01.wipro.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I could get PCI working on MBX860 with few changes to
qspan_pci.c file (see the patch below) on linux-2.4.21. Do
note that there are many copies of this file in different
directories (arch/ppc/kernel, arch/ppc/syslib,
arch/ppc/boot/simple). The one in boot/simple seems to be the
older one (qspan_init not required as PPC-BUG bootloader
initializes QSPAN correctly). I had patched the file in
ppc/kernel for linux-2.4.2x. Seems it is now moved to
ppc/syslib in linux-2.5/6 versions.

Another tip if you are working on MBX860 board. Both of my
boards had -12V on PC104-Plus bus missing! Do check pin A30 on
PC104+ for -12V. I had to provide an external -12V supply for
the PCI cards to make them work!

HTH...

Regards,
Praveen.

------% start of qspan.c patch %-------
--- qspan_pci-orig.c	2003-11-18 17:04:45.000000000 +0530
+++ qspan_pci.c	2003-11-24 09:21:58.000000000 +0530
@@ -83,7 +83,7 @@
 		"	.align 2\n"                   \
 		"	.long 1b,3b\n"                \
 		".text"                             \
-		: "=r"(x) : "r"(addr) : " %0")
+                : "=r"(x) : "r"(addr) : "%0")

 #define QS_CONFIG_ADDR	((volatile uint *)(PCI_CSR_ADDR + 0x500))
 #define QS_CONFIG_DATA	((volatile uint *)(PCI_CSR_ADDR + 0x504))
@@ -363,17 +363,53 @@
     return PCIBIOS_DEVICE_NOT_FOUND;
 }

+#define pcibios_access(host,rw,size,type)                         \
+int host##_pci_bios_##rw##_config_##size (struct pci_dev *dev,    \
+		int pos, type value)                                   \
+{                                                                 \
+	return host##_pcibios_##rw##_config_##size (dev->bus->number,\
+			dev->devfn, pos, value);
\
+}
+
+pcibios_access(qspan, read, byte, u8 *)
+pcibios_access(qspan, read, word, u16 *)
+pcibios_access(qspan, read, dword, u32 *)
+pcibios_access(qspan, write, byte, u8)
+pcibios_access(qspan, write, word, u16)
+pcibios_access(qspan, write, dword, u32)
+
+#define set_config_access_method(host)   \
+static struct pci_ops pci_root_ops = {   \
+	host##_pci_bios_read_config_byte,   \
+	host##_pci_bios_read_config_word,   \
+	host##_pci_bios_read_config_dword,  \
+	host##_pci_bios_write_config_byte,  \
+	host##_pci_bios_write_config_word,  \
+	host##_pci_bios_write_config_dword  \
+}
+
+set_config_access_method(qspan);
+
 void __init
-m8xx_pcibios_fixup(void))
+m8xx_pcibios_fixup(void)
 {
-   /* Lots to do here, all board and configuration specific. */
 }

 void __init
-m8xx_setup_pci_ptrs(void))
+m8xx_setup_pci_ptrs(void)
 {
-	set_config_access_method(qspan);
+	struct pci_controller *hose = NULL;

-	ppc_md.pcibios_fixup = m8xx_pcibios_fixup;
-}
+/*        ppc_md.pcibios_fixup = m8xx_pcibios_fixup;*/
+
+	hose = pcibios_alloc_controller ();
+	if (!hose)
+	{
+		printk(KERN_ERR "PCI:Unable to allocate hose\n");
+		return;
+	}
+	hose->ops = &pci_root_ops;

+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+}

------% End of qspan.c patch %-------

 -----Original Message-----

 Subject: pci mbx860
 From: Amit.Lubovsky@infineon.com
 Date: Wed, 5 Nov 2003 09:07:38 +0100

 I have to implement pci on MBX860 since the current code is
 broken (I use 2.4.20 kernel from denx), Could anybody point me
 to a sample implementation of pci as a starting and reference
 point ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
