Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <009a01c38bb6$ceb84f40$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Walnut boot problem solved
Date: Mon, 6 Oct 2003 11:06:14 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0097_01C38BF9.DBD9FDC0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0097_01C38BF9.DBD9FDC0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Dear all,

    I have figured out why my kernel hanged while booting on Walnut
platform. It is because the structure of board_info is different between
u-boot-0.4.8 and linuxppc-2.4-devel. After syncing the structure, I can boot
up to where the kernel tries to mount the filesystem. Attached is a patch
for the fix.

    Thanks for all help and suggestions.

Best regards,
Jacky Lam

------=_NextPart_000_0097_01C38BF9.DBD9FDC0
Content-Type: application/octet-stream;
	name="patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch"

--- walnut.h	Mon Oct  6 11:04:08 2003
+++ walnut.h.orig	Mon Oct  6 11:03:59 2003
@@ -37,26 +37,14 @@
  */
=20
 typedef struct board_info {
-        unsigned long bi_memstart;
-        unsigned long bi_memsize;
-        unsigned long bi_flashstart;
-        unsigned long bi_flashsize;
-        unsigned long bi_flashoffset;
-        unsigned long bi_sramstart;
-        unsigned long bi_sramsize;
-        unsigned long bi_bootflags;
-        unsigned long bi_ip_addr;
-        unsigned char bi_enetaddr[6];
-        unsigned short bi_ethspeed;
-        unsigned long bi_intfreq;
-        unsigned long bi_busfreq;
-        unsigned long bi_baudrate;
-        unsigned char bi_s_version[4];
-        unsigned char bi_r_version[32];
-        unsigned int bi_procfreq;
-        unsigned int bi_plb_busfreq;
-        unsigned int bi_pci_busfreq;
-        unsigned char bi_pci_enetaddr[6];
+	unsigned char	 bi_s_version[4];	/* Version of this structure */
+	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
+	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
+	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
+	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
+	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
+	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
 } bd_t;
=20
 /* Some 4xx parts use a different timebase frequency from the internal =
clock.

------=_NextPart_000_0097_01C38BF9.DBD9FDC0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
