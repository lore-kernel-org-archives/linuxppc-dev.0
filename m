Return-Path: <joel@jms.id.au>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0086140123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 10:51:05 +1100 (EST)
Received: by mail-pd0-f180.google.com with SMTP id v10so4041633pde.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 16:51:02 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com,
 michael@ellerman.id.au, stewart@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc/powernv: Add invalid OPAL call
Date: Fri, 28 Mar 2014 10:20:40 +1030
Message-Id: <1395964240-8305-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1395964240-8305-1-git-send-email-joel@jms.id.au>
References: <1395964240-8305-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This call will not be understood by OPAL, and cause it to add an error
to it's log. Among other things, this is useful for testing the
behaviour of the log as it fills up.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/opal.h                | 2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 arch/powerpc/platforms/powernv/opal.c          | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6aa757e..7f480a4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -87,6 +87,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_ASYNC_COMPLETION	-15
 
 /* API Tokens (in r0) */
+#define OPAL_INVALID				-1
 #define OPAL_CONSOLE_WRITE			1
 #define OPAL_CONSOLE_READ			2
 #define OPAL_RTC_READ				3
@@ -853,6 +854,7 @@ int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		      uint32_t addr, __be32 *data, uint32_t sz);
 
+int64_t opal_invalid(void);
 int64_t opal_read_elog(uint64_t buffer, size_t size, uint64_t log_id);
 int64_t opal_get_elog_size(uint64_t *log_id, size_t *size, uint64_t *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 75c89df..69657dc 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -143,3 +143,4 @@ OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
 OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
+OPAL_CALL(opal_invalid,				OPAL_INVALID);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2bc032a..f58a3c7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -43,6 +43,8 @@ struct mcheck_recoverable_range {
 	u64 recover_addr;
 };
 
+EXPORT_SYMBOL_GPL(opal_invalid);
+
 static struct mcheck_recoverable_range *mc_recoverable_range;
 static int mc_recoverable_range_len;
 
-- 
1.9.1
