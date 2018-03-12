Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400YS6360wzF0m2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:03:18 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CMwmuu147440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:15 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gp0xpuuyg-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:15 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 17:03:14 -0600
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v2 4/4] rfi-flush: Call setup_rfi_flush() after LPM migration
Date: Mon, 12 Mar 2018 20:02:58 -0300
In-Reply-To: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1520895778-17586-5-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

We might have migrated to a machine that uses a different flush type,
or doesn't need flushing at all.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 3 +++
 arch/powerpc/platforms/pseries/pseries.h  | 2 ++
 arch/powerpc/platforms/pseries/setup.c    | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 0f7fb71..8a8033a 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -348,6 +348,9 @@ void post_mobility_fixup(void)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
 
+	/* Possibly switch to a new RFI flush type */
+	pseries_setup_rfi_flush();
+
 	return;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1ae1d9f..27cdcb6 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -100,4 +100,6 @@ static inline unsigned long cmo_get_page_size(void)
 
 int dlpar_workqueue_init(void);
 
+void pseries_setup_rfi_flush(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2f82bbb..360efe7 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -459,7 +459,7 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
-static void pseries_setup_rfi_flush(void)
+void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
 	enum l1d_flush_type types;
-- 
2.7.4
