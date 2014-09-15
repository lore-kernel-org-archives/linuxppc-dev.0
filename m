Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF9041A0009
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 06:29:25 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 14:29:23 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A397DC9002E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:29:12 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FKTLkR44695730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 20:29:21 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FKTLdD011030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:29:21 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8FKTKMo011020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:29:21 -0400
Message-ID: <54174C20.1000009@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:29:20 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] pseries: Define rtas hotplug event sections
References: <54174B81.50504@linux.vnet.ibm.com>
In-Reply-To: <54174B81.50504@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to handle device hotplug in the kernel on pseries the hotplug
notification will be communicated to the kernel in the form of a
rtas hotplug event. This patch adds the definition of rtas hotplug event
sections.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b390f55..a01879e 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -273,6 +273,7 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
 #define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
 #define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
 #define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
+#define PSERIES_ELOG_SECT_ID_HOTPLUG		(('H' << 8) | 'P')
 
 /* Vendor specific Platform Event Log Format, Version 6, section header */
 struct pseries_errorlog {
@@ -296,6 +297,31 @@ inline uint16_t pseries_errorlog_length(struct pseries_errorlog *sect)
 	return be16_to_cpu(sect->length);
 }
 
+/* RTAS pseries hotplug errorlog section */
+struct pseries_hp_errorlog {
+	uint8_t	resource;
+	uint8_t	action;
+	uint8_t	id_type;
+	uint8_t	reserved;
+	union {
+		__be32	drc_index;
+		__be32	drc_count;
+		char	drc_name[1];
+	} _drc_u;
+};
+
+#define PSERIES_HP_ELOG_RESOURCE_CPU	1
+#define PSERIES_HP_ELOG_RESOURCE_MEM	2
+#define PSERIES_HP_ELOG_RESOURCE_SLOT	3
+#define PSERIES_HP_ELOG_RESOURCE_PHB	4
+
+#define PSERIES_HP_ELOG_ACTION_ADD	1
+#define PSERIES_HP_ELOG_ACTION_REMOVE	2
+
+#define PSERIES_HP_ELOG_ID_DRC_NAME	1
+#define PSERIES_HP_ELOG_ID_DRC_INDEX	2
+#define PSERIES_HP_ELOG_ID_DRC_COUNT	3
+
 struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 					      uint16_t section_id);
 
