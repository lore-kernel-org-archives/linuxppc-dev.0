Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E367D2C0390
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 00:47:54 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 30 Oct 2013 13:47:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE8A72190074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:46 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UDlYji55902284
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:34 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UDljrG001893
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 07:47:46 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc/nvram: fix endian issue when reading the NVRAM
 size
Date: Wed, 30 Oct 2013 14:47:07 +0100
Message-Id: <1383140828-7481-3-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1383140828-7481-1-git-send-email-clg@fr.ibm.com>
References: <1383140828-7481-1-git-send-email-clg@fr.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cedric Le Goater <clg@fr.ibm.com>

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/platforms/chrp/nvram.c    |    4 ++--
 arch/powerpc/platforms/pseries/nvram.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/nvram.c b/arch/powerpc/platforms/chrp/nvram.c
index d3ceff0..9ef8cc3 100644
--- a/arch/powerpc/platforms/chrp/nvram.c
+++ b/arch/powerpc/platforms/chrp/nvram.c
@@ -66,7 +66,7 @@ static void chrp_nvram_write(int addr, unsigned char val)
 void __init chrp_nvram_init(void)
 {
 	struct device_node *nvram;
-	const unsigned int *nbytes_p;
+	const __be32 *nbytes_p;
 	unsigned int proplen;
 
 	nvram = of_find_node_by_type(NULL, "nvram");
@@ -79,7 +79,7 @@ void __init chrp_nvram_init(void)
 		return;
 	}
 
-	nvram_size = *nbytes_p;
+	nvram_size = be32_to_cpup(nbytes_p);
 
 	printk(KERN_INFO "CHRP nvram contains %u bytes\n", nvram_size);
 	of_node_put(nvram);
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 2498d4d..057fc89 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -804,7 +804,7 @@ machine_arch_initcall(pseries, pseries_nvram_init_log_partitions);
 int __init pSeries_nvram_init(void)
 {
 	struct device_node *nvram;
-	const unsigned int *nbytes_p;
+	const __be32 *nbytes_p;
 	unsigned int proplen;
 
 	nvram = of_find_node_by_type(NULL, "nvram");
@@ -817,7 +817,7 @@ int __init pSeries_nvram_init(void)
 		return -EIO;
 	}
 
-	nvram_size = *nbytes_p;
+	nvram_size = be32_to_cpup(nbytes_p);
 
 	nvram_fetch = rtas_token("nvram-fetch");
 	nvram_store = rtas_token("nvram-store");
-- 
1.7.10.4
