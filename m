Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E5182C0365
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:00:19 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:00:17 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9DE8819D8036
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:00:11 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2940DcW057616
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:00:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2940CgO007431
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:00:12 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2940ARg007263
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:00:11 -0700
Message-ID: <513AB3C9.6010302@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:00:09 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH2/11] Add PRRN Event Handler
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
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

This patch adds a handler in rtasd for PRRN RTAS events. The function
pseries_devicetree_update() (from mobility.c) is used to make the
ibm,update-nodes/ibm,update-properties RTAS calls. Updating the NUMA maps
(handled by a subsequent patch) will require significant processing,
so pseries_devicetree_update() is called from an asynchronous workqueue
to allow rtasd to continue processing events.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |    2 ++
 arch/powerpc/kernel/rtasd.c     |   35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/include/asm/rtas.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/rtas.h	2013-03-08 19:56:13.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/rtas.h	2013-03-08 19:56:48.000000000 -0600
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
--- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-03-08 19:23:06.000000000 -0600
+++ powerpc/arch/powerpc/kernel/rtasd.c	2013-03-08 19:56:48.000000000 -0600
@@ -87,6 +87,8 @@
 			return "Resource Deallocation Event";
 		case RTAS_TYPE_DUMP:
 			return "Dump Notification Event";
+		case RTAS_TYPE_PRRN:
+			return "Platform Resource Reassignment Event";
 	}
 
 	return rtas_type[0];
@@ -265,7 +267,38 @@
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
+	pseries_devicetree_update(-update_scope);
+}
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
@@ -389,7 +422,7 @@
 		}
 
 		if (error == 0)
-			pSeries_log_error(logdata, ERR_TYPE_RTAS_LOG, 0);
+			pseries_handle_event((struct rtas_error_log *)logdata);
 
 	} while(error == 0);
 }
