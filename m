Message-Id: <199903201938.UAA21983@student.physik.uni-mainz.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Patches to NE2000 PCI driver
Date: Sat, 20 Mar 1999 20:31:23 CET
From: "Christian Bauer" <cbauer@student.physik.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Reply-To: cbauer@student.physik.uni-mainz.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

After some tweaking, I've managed to make a $10 NE2000 PCI card (RealTek
8029 chipset) work in my Mac clone with the LinuxPPC kernel 2.2.1. It turned
out to be an endian problem (as always).

Here are the patches I've made to drivers/net/ne2k-pci.c:

--- ne2k-pci.c.old	Sun Mar 21 07:15:15 1999
+++ ne2k-pci.c	Sun Mar 21 07:13:04 1999
@@ -462,7 +462,8 @@
 	outb(E8390_RREAD+E8390_START, nic_base + NE_CMD);
 
 #if defined(USE_LONGIO)
-	*(u32*)hdr = inl(NE_BASE + NE_DATAPORT);
+	*(u32*)hdr = le32_to_cpu(inl(NE_BASE + NE_DATAPORT));
+	le16_to_cpus(&hdr->count);
 #else
 	insw(NE_BASE + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr)>>1);
 #endif
@@ -481,6 +482,7 @@
 {
 	int nic_base = dev->base_addr;
 	char *buf = skb->data;
+	int i;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
 	if (ei_status.dmaing) {
@@ -500,10 +502,12 @@
 
 #if defined(USE_LONGIO)
 	insl(NE_BASE + NE_DATAPORT, buf, count>>2);
+	for (i=0; i<(count>>2); i++)
+		le32_to_cpus((u32*)buf + i);
 	if (count & 3) {
 		buf += count & ~3;
 		if (count & 2)
-			*((u16*)buf)++ = inw(NE_BASE + NE_DATAPORT);
+			*((u16*)buf)++ = le16_to_cpu(inw(NE_BASE + NE_DATAPORT));
 		if (count & 1)
 			*buf = inb(NE_BASE + NE_DATAPORT);
 	}
@@ -524,6 +528,7 @@
 {
 	int nic_base = NE_BASE;
 	unsigned long dma_start;
+	int i;
 
 	/* On little-endian it's always safe to round the count up for
 	   word writes. */
@@ -562,11 +567,13 @@
 	outb(start_page, nic_base + EN0_RSARHI);
 	outb(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
 #if defined(USE_LONGIO)
+	for (i=0; i<(count>>2); i++)
+		cpu_to_le32s((u32*)buf + i);
 	outsl(NE_BASE + NE_DATAPORT, buf, count>>2);
 	if (count & 3) {
 		buf += count & ~3;
 		if (count & 2)
-			outw(*((u16*)buf)++, NE_BASE + NE_DATAPORT);
+			outw(cpu_to_le16(*((u16*)buf)++), NE_BASE + NE_DATAPORT);
 	}
 #else
 	outsw(NE_BASE + NE_DATAPORT, buf, count>>1);

Bye,
Christian

-- 
  / Coding on PowerPC and proud of it
\/ http://www.uni-mainz.de/~bauec002/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
