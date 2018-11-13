Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E2C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:54:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1596522360
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1596522360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLyl57XDzDrJs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:54:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLQF631czF3Fk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:29:25 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id CBD54AE8030F;
 Tue, 13 Nov 2018 03:29:21 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 16/22] powerpc/powernv: Add purge cache OPAL call
Date: Tue, 13 Nov 2018 19:28:17 +1100
Message-Id: <20181113082823.2440-17-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113082823.2440-1-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Flushing caches using the dcbf instruction takes quite some time if we
need to flush gigabytes (16GB takes more than 15s); OPAL just added
a big hammer to flush all caches.

This adds opal_purge_cache() which will be used later to flush caches
for coherent GPU memory which might suddenly become unavailable if a GPU
is reset and NVLink is not (re)trained.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/opal-api.h            | 3 ++-
 arch/powerpc/include/asm/opal.h                | 1 +
 arch/powerpc/platforms/powernv/opal.c          | 1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b..55bc640 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -210,7 +210,8 @@
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define	OPAL_NX_COPROC_INIT			167
-#define OPAL_LAST				167
+#define OPAL_CLEAR_CACHE			170
+#define OPAL_LAST				170
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ff38664..7db576e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -294,6 +294,7 @@ int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
 int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 int opal_nx_coproc_init(uint32_t chip_id, uint32_t ct);
+int opal_purge_cache(void);
 
 s64 opal_signal_system_reset(s32 cpu);
 s64 opal_quiesce(u64 shutdown_type, s32 cpu);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index beed86f..44ce824 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -1113,3 +1113,4 @@ EXPORT_SYMBOL_GPL(opal_int_eoi);
 EXPORT_SYMBOL_GPL(opal_error_code);
 /* Export the below symbol for NX compression */
 EXPORT_SYMBOL(opal_nx_coproc_init);
+EXPORT_SYMBOL(opal_purge_cache);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 2515282..5b886a6 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -331,3 +331,4 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_purge_cache,			OPAL_CLEAR_CACHE);
-- 
2.17.1

