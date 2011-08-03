Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D364B71E4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2011 16:49:53 +1000 (EST)
From: <b35362@freescale.com>
To: <dwmw2@infradead.org>, <linuxppc-dev@linux.freescale.net>
Subject: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j command
Date: Wed, 3 Aug 2011 13:50:38 +0800
Message-ID: <1312350638-25566-1-git-send-email-b35362@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Shuo <b35362@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <b35362@freescale.com>

Flash_erase -j should fill discrete freeoob areas with required bytes
of JFFS2 cleanmarker in jffs2_check_nand_cleanmarker(). Not just fill
the first freeoob area.

Signed-off-by: Liu Shuo <b35362@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 flash_erase.c |   41 +++++++++++++++++++++++++++++++++++------
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/flash_erase.c b/flash_erase.c
index fe2eaca..e6747fc 100644
--- a/flash_erase.c
+++ b/flash_erase.c
@@ -98,6 +98,7 @@ int main(int argc, char *argv[])
 	int isNAND;
 	int error = 0;
 	uint64_t offset = 0;
+	void *oob_data = NULL;
 
 	/*
 	 * Process user arguments
@@ -197,15 +198,40 @@ int main(int argc, char *argv[])
 			if (ioctl(fd, MEMGETOOBSEL, &oobinfo) != 0)
 				return sys_errmsg("%s: unable to get NAND oobinfo", mtd_device);
 
+			cleanmarker.totlen = cpu_to_je32(8);
 			/* Check for autoplacement */
 			if (oobinfo.useecc == MTD_NANDECC_AUTOPLACE) {
+				struct nand_ecclayout_user ecclayout;
 				/* Get the position of the free bytes */
-				if (!oobinfo.oobfree[0][1])
+				if (ioctl(fd, ECCGETLAYOUT, &ecclayout) != 0)
+					return sys_errmsg("%s: unable to get NAND ecclayout", mtd_device);
+
+				if (!ecclayout.oobavail)
 					return errmsg(" Eeep. Autoplacement selected and no empty space in oob");
 				clmpos = oobinfo.oobfree[0][0];
-				clmlen = oobinfo.oobfree[0][1];
-				if (clmlen > 8)
-					clmlen = 8;
+				clmlen = MIN(ecclayout.oobavail, 8);
+
+				if (oobinfo.oobfree[0][1] < 8 && ecclayout.oobavail >= 8) {
+					int i, left, n, last = 0;
+					void *cm;
+
+					oob_data = malloc(mtd.oob_size);
+					if (!oob_data)
+						return -ENOMEM;
+
+					memset(oob_data, 0xff, mtd.oob_size);
+					cm = &cleanmarker;
+					for (i = 0, left = clmlen; left ; i++) {
+						n = MIN(left, oobinfo.oobfree[i][1]);
+						memcpy(oob_data + oobinfo.oobfree[i][0],
+								cm, n);
+						left -= n;
+						cm   += n;
+						last = oobinfo.oobfree[i][0] + n;
+					}
+
+					clmlen = last - clmpos;
+				}
 			} else {
 				/* Legacy mode */
 				switch (mtd.oob_size) {
@@ -223,7 +249,6 @@ int main(int argc, char *argv[])
 						break;
 				}
 			}
-			cleanmarker.totlen = cpu_to_je32(8);
 		}
 		cleanmarker.hdr_crc = cpu_to_je32(mtd_crc32(0, &cleanmarker, sizeof(cleanmarker) - 4));
 	}
@@ -272,7 +297,8 @@ int main(int argc, char *argv[])
 
 		/* write cleanmarker */
 		if (isNAND) {
-			if (mtd_write_oob(mtd_desc, &mtd, fd, offset + clmpos, clmlen, &cleanmarker) != 0) {
+			void *data = oob_data ? oob_data + clmpos : &cleanmarker;
+			if (mtd_write_oob(mtd_desc, &mtd, fd, offset + clmpos, clmlen, data) != 0) {
 				sys_errmsg("%s: MTD writeoob failure", mtd_device);
 				continue;
 			}
@@ -291,5 +317,8 @@ int main(int argc, char *argv[])
 	show_progress(&mtd, offset, eb, eb_start, eb_cnt);
 	bareverbose(!quiet, "\n");
 
+	if (oob_data)
+		free(oob_data);
+
 	return 0;
 }
-- 
1.7.1
