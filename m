Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 059172C0297
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:33:27 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:33:22 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4F83B38C804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:33:03 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIX3A9316522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:33:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIX3LE030020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:33:03 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIX2hV029940
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:33:02 -0300
Message-ID: <5175825E.4030807@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:33:02 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/12] Add PRRN event handler
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
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
four-byte Extended Event Log Length field is repurposed (since no
Extended Event Log message is included) to pass the "scope" parameter
that causes the ibm,update-nodes to return the nodes affected by the
specific resource reassignment.

This patch adds a handler for PRRN RTAS events. The function
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
 arch/powerpc/include/asm/rtas.h |    2 ++
 arch/powerpc/kernel/rtasd.c     |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-04-17 12:58:33.000000000 -0500
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-04-17 13:24:06.000000000 -0500
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
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-04-17 12:55:11.000000000 -0500
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-04-17 13:27:00.000000000 -0500
@@ -87,6 +87,8 @@
 			return "Resource Deallocation Event";
 		case RTAS_TYPE_DUMP:
 			return "Dump Notification Event";
+		case RTAS_TYPE_PRRN:
+			return "Platform Resource Reassignment Event";
 	}
 
 	return rtas_type[0];
@@ -265,7 +267,40 @@
 		spin_unlock_irqrestore(&rtasd_log_lock, s);
 		return;
 	}
+}
+
+static s32 update_scope;
+
+static void prrn_work_fn(struct work_struct *work)
+{
+	/*
+	 * For PRRN, we must pass the negative of the scope value in
+	 * the RTAS event.
+	 */
+	if (ppc_md.update_devicetree)
+		ppc_md.update_devicetree(-update_scope);
+}
+
+static DECLARE_WORK(prrn_work, prrn_work_fn);
+
+void prrn_schedule_update(u32 scope)
+{
+	flush_work(&prrn_work);
+	update_scope = scope;
+	schedule_work(&prrn_work);
+}
+
+static void pseries_handle_event(const struct rtas_error_log *log)
+{
+	pSeries_log_error((char *)log, ERR_TYPE_RTAS_LOG, 0);
+
+	if (log->type == RTAS_TYPE_PRRN)
+		/* For PRRN Events the extended log length is used to denote
+		 * the scope for calling rtas update-nodes.
+		 */
+		prrn_schedule_update(log->extended_log_length);
 
+	return;
 }
 
 static int rtas_log_open(struct inode * inode, struct file * file)
@@ -389,7 +424,7 @@
 		}
 
 		if (error == 0)
-			pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG, 0);
+			pseries_handle_event((struct rtas_error_log *)logdata);
 
 	} while(error == 0);
 }
