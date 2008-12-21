Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id D059BDDED8
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 19:06:29 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2289593rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 00:06:29 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/4] powerpc/mpc5200: Bestcomm fixes to ATA support
To: linuxppc-dev@ozlabs.org, hans.lehmann@ritter-elektronik.de,
	matt@genesi-usa.com, olaf@aepfle.de
Date: Sun, 21 Dec 2008 01:06:25 -0700
Message-ID: <20081221080624.29029.9108.stgit@localhost.localdomain>
In-Reply-To: <20081221080213.29029.7646.stgit@localhost.localdomain>
References: <20081221080213.29029.7646.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Tim Yamin <plasm@roo.me.uk>

1) ata.h has dst_pa in the wrong place (needs to match what the BestComm
   task microcode in bcom_ata_task.c expects); fix it.

2) The BestComm ATA task priority was changed to maximum in bestcomm_priv.h;
   this fixes a deadlock issue experienced with heavy DMA occurring on
   both the ATA and Ethernet BestComm tasks, e.g. when downloading a large
   file over a LAN to disk.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/ata.h           |    2 +-
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/ata.h b/arch/powerpc/sysdev/bestcomm/ata.h
index 1098276..0374322 100644
--- a/arch/powerpc/sysdev/bestcomm/ata.h
+++ b/arch/powerpc/sysdev/bestcomm/ata.h
@@ -16,8 +16,8 @@
 
 struct bcom_ata_bd {
 	u32	status;
-	u32	dst_pa;
 	u32	src_pa;
+	u32	dst_pa;
 };
 
 extern struct bcom_task *
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
index 866a291..746f155 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
@@ -198,8 +198,8 @@ struct bcom_task_header {
 #define BCOM_IPR_SCTMR_1	2
 #define BCOM_IPR_FEC_RX		6
 #define BCOM_IPR_FEC_TX		5
-#define BCOM_IPR_ATA_RX		4
-#define BCOM_IPR_ATA_TX		3
+#define BCOM_IPR_ATA_RX		7
+#define BCOM_IPR_ATA_TX		7
 #define BCOM_IPR_SCPCI_RX	2
 #define BCOM_IPR_SCPCI_TX	2
 #define BCOM_IPR_PSC3_RX	2
