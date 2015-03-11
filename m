Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBAC21A09E1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ECEF72CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8MWP32178298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD7uqg011759
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:07:57 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 4/7]powerpc/powernv: Add OPAL support for Nest pmu
Date: Wed, 11 Mar 2015 18:37:10 +0530
Message-Id: <1426079233-16720-5-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nest Counters can be configured via PORE Engine and OPAL
provides an interface call to it. PORE Engine also does the 
work of moving the counter data to memory.  

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                | 3 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9ee0a30..8ac586b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -169,6 +169,7 @@ struct opal_sg_list {
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
+#define OPAL_UNCORE_CONTROL			114
 
 /* Device tree flags */
 
@@ -932,6 +933,8 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
 
+int64_t opal_uncore_control(uint32_t value);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca..df709c3 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -292,3 +292,4 @@ OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
 OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_uncore_control,			OPAL_UNCORE_CONTROL);
-- 
1.9.1
