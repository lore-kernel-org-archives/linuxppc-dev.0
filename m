Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18ED42C0111
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 01:51:56 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 09:51:54 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D272DC90025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:51:51 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OFppET231594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:51:51 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OFph8K010896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:51:43 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OFphve010829
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:51:43 -0600
Message-ID: <5177FF85.5070105@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 10:51:33 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/13] Add PRRN RTAS event handler
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

A PRRN event is signaled via the RTAS event-scan mechanism, which
returns a Hot Plug Event message "fixed part" indicating "Platform
Resource Reassignment". In response to the Hot Plug Event message,
we must call ibm,update-nodes to determine which resources were
reassigned and then ibm,update-properties to obtain the new affinity
information about those resources.

The PRRN event-scan RTAS message contains only the "fixed part" with
the "Type" field set to the value 160 and no Extended Event Log. The
four-byte Extended Event Log Length field is re-purposed (since no
Extended Event Log message is included) to pass the "scope" parameter
that causes the ibm,update-nodes to return the nodes affected by the
specific resource reassignment.

This patch adds a handler for RTAS events. The function
pseries_devicetree_update() (from mobility.c) is used to make the
ibm,update-nodes/ibm,update-properties RTAS calls. Updating the NUMA maps
(handled by a subsequent patch) will require significant processing,
so pseries_devicetree_update() is called from an asynchronous workqueue
to allow event processing to continue. 

PRRN RTAS events on pseries systems are rare events that have to be
initiated from the HMC console for the system by an IBM tech. This allows
us to assume that these events are widely spaced. Additionally, all work
on the queue is flushed before handling any new work to ensure we only have
one event in flight being handled at a time.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |    2 +
 arch/powerpc/kernel/rtasd.c     |   46 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-04-23 13:22:37.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-04-23 13:40:36.000000000 -0500
@@ -143,6 +143,8 @@
 #define RTAS_TYPE_PMGM_TIME_ALARM	0x6f
 #define RTAS_TYPE_PMGM_CONFIG_CHANGE	0x70
 #define RTAS_TYPE_PMGM_SERVICE_PROC	0x71
+/* Platform Resource Reassignment Notification */
+#define RTAS_TYPE_PRRN			0xA0
 
 /* RTAS check-exception vector offset */
 #define RTAS_VECTOR_EXTERNAL_INTERRUPT	0x500
Index: powerpc/arch/powerpc/kernel/rtasd.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-04-23 12:54:23.000000000 -0500
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-04-23 13:52:08.000000000 -0500
@@ -87,6 +87,8 @@
 			return "Resource Deallocation Event";
 		case RTAS_TYPE_DUMP:
 			return "Dump Notification Event";
+		case RTAS_TYPE_PRRN:
+			return "Platform Resource Reassignment Event";
 	}
 
 	return rtas_type[0];
@@ -265,9 +267,49 @@
 		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
+}
+
+#ifdef CONFIG_PPC_PSERIES
+static s32 prrn_update_scope;
+
+static void prrn_work_fn(struct work_struct *work)
+{
+	/*
+	 * For PRRN, we must pass the negative of the scope value in
+	 * the RTAS event.
+	 */
+	pseries_devicetree_update(-prrn_update_scope);
+}
+
+static DECLARE_WORK(prrn_work, prrn_work_fn);
+
+void prrn_schedule_update(u32 scope)
+{
+	flush_work(&prrn_work);
+	prrn_update_scope = scope;
+	schedule_work(&prrn_work);
+}
+
+static void handle_rtas_event(const struct rtas_error_log *log)
+{
+	if (log->type == RTAS_TYPE_PRRN)
+		/* For PRRN Events the extended log length is used to denote
+		 * the scope for calling rtas update-nodes.
+		 */
+		prrn_schedule_update(log->extended_log_length);
+
+	return;
+}
+
+#else
 
+static void handle_rtas_event(const struct rtas_error_log *log)
+{
+	return;
 }
 
+#endif
+
 static int rtas_log_open(struct inode * inode, struct file * file)
 {
 	return 0;
@@ -388,8 +430,10 @@
 			break;
 		}
 
-		if (error == 0)
+		if (error == 0) {
 			pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG, 0);
+			handle_rtas_event((struct rtas_error_log *)logdata);
+		}
 
 	} while(error == 0);
 }
