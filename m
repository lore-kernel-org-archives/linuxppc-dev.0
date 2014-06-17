Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 976AB1A034F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:47:54 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 11:47:52 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 336136E802D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:47:40 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HFlmIG3473912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:47:48 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HFlmku025790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:47:48 -0400
Received: from localhost.localdomain ([9.80.40.207])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5HFllms025703
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:47:47 -0400
Message-ID: <53A06323.3080707@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 10:47:47 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/4] Hook into ras epow interrupt handler for hotplug
References: <53A061EC.10403@linux.vnet.ibm.com>
In-Reply-To: <53A061EC.10403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch hooks into the ras EPOW interrupt handler so that we can
communicate hotplug rtas events to a PowerKVM guest from qemu.

The ras epow interrupt wil lnow check for hotplgu rtas events and
invoke the common handling routine accordingly.
---
 arch/powerpc/include/asm/rtas.h          |  1 +
 arch/powerpc/platforms/pseries/dlpar.c   |  2 +-
 arch/powerpc/platforms/pseries/pseries.h |  1 +
 arch/powerpc/platforms/pseries/ras.c     | 12 +++++++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 26491ae..7313e6f 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -124,6 +124,7 @@ struct rtas_suspend_me_data {
 #define RTAS_TYPE_INFO			0xE2
 #define RTAS_TYPE_DEALLOC		0xE3
 #define RTAS_TYPE_DUMP			0xE4
+#define RTAS_TYPE_HOTPLUG		0xE5
 /* I don't add PowerMGM events right now, this is a different topic */ 
 #define RTAS_TYPE_PMGM_POWER_SW_ON	0x60
 #define RTAS_TYPE_PMGM_POWER_SW_OFF	0x61
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 53f4fe6..6d3de6e 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -360,7 +360,7 @@ int dlpar_release_drc(u32 drc_index)
 	return 0;
 }
 
-static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
+int handle_dlpar_errorlog(struct rtas_error_log *error_log)
 {
 	struct pseries_errorlog *pseries_log;
 	struct pseries_hp_elog *hp_elog;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1706215..9b9bd82 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -64,6 +64,7 @@ extern int dlpar_acquire_drc(u32);
 extern int dlpar_release_drc(u32);
 extern int dlpar_memory(struct pseries_hp_elog *);
 extern int dlpar_cpus(struct pseries_hp_elog *);
+extern int handle_dlpar_errorlog(struct rtas_error_log *);
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 9c5778e..3cc6a49 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -183,6 +183,7 @@ void rtas_parse_epow_errlog(struct rtas_error_log *log)
 /* Handle environmental and power warning (EPOW) interrupts. */
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
 {
+	struct rtas_error_log *elog;
 	int status;
 	int state;
 	int critical;
@@ -205,7 +206,16 @@ static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
 
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
 
-	rtas_parse_epow_errlog((struct rtas_error_log *)ras_log_buf);
+	elog = (struct rtas_error_log *)ras_log_buf;
+
+	switch(rtas_error_type(elog)) {
+	case RTAS_TYPE_EPOW:
+		rtas_parse_epow_errlog(elog);
+		break;
+	case RTAS_TYPE_HOTPLUG:
+		handle_dlpar_errorlog(elog);
+		break;
+	}
 
 	spin_unlock(&ras_log_buf_lock);
 	return IRQ_HANDLED;
-- 
2.0.0.rc3.2.g998f840
