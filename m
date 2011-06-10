Return-Path: <ccano@interfaceconcept.com>
Received: from smtp-out06.msg.oleane.net (smtp-out06.msg.oleane.net
	[62.161.7.4]) by ozlabs.org (Postfix) with ESMTP id BBCF5B702D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jun 2011 03:51:49 +1000 (EST)
Received: from smtp06.msg.oleane.net (smtp06.mail.priv [172.17.20.115])
	by smtp-out06.msg.oleane.net with ESMTP id p5AEGlQv007279
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2011 16:16:48 +0200
Received: from ic.fr (iconcept-gw.rain.fr [194.2.96.216])
	by smtp06.msg.oleane.net (MTA) with ESMTP id p5ADuV3v020722
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2011 15:56:31 +0200
Received: from [192.168.1.33] (unknown [192.168.1.33])
	by ic.fr (Postfix) with ESMTPA id D363822DE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 15:56:35 +0200 (CEST)
Message-ID: <4DF2228E.7060806@ic.fr>
Date: Fri, 10 Jun 2011 15:56:30 +0200
From: =?ISO-8859-1?Q?C=E9dric_Cano?= <ccano@interfaceconcept.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] Big endian swap for Marvell 6440 SAS driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Marvell SAS driver doesn't work on powerpc architecture due to big 
endian swap. I've tested it with the MV6440 chip.
Here you can find the patch for Linux 2.6.39.1.

Cedric Cano

Signed-off-by: Cedric Cano <ccano@interfaceconcept.com>
---
--- drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:04.000000000 +0200
+++ drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:12.000000000 +0200
@@ -1143,6 +1143,14 @@
      MVS_CHIP_DISP->write_port_cfg_addr(mvi, i, PHYR_SATA_SIG0);
      s[0] = MVS_CHIP_DISP->read_port_cfg_data(mvi, i);

+    /* swap for big endian devices because of use of these data in bytes */
+#ifdef __BIG_ENDIAN
+    s[0] = swab32(s[0]);
+    s[1] = swab32(s[1]);
+    s[2] = swab32(s[2]);
+    s[3] = swab32(s[3]);
+#endif /* __BIG_ENDIAN */
+
      /* Workaround: take some ATAPI devices for ATA */
      if (((s[1] & 0x00FFFFFF) == 0x00EB1401) && (*(u8 *)&s[3] == 0x01))
          s[1] = 0x00EB1401 | (*((u8 *)&s[1] + 3) & 0x10);

---
