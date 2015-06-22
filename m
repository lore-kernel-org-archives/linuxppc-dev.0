Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 618A91A1DE4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 07:02:56 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 15:02:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1CCBB19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:53:53 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ML2nVD38600864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:02:49 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5ML2n3e023653
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:02:49 -0600
Received: from [9.41.105.93] (dhcp-9-41-105-93.austin.ibm.com [9.41.105.93])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t5ML2mCw023565
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 15:02:48 -0600
Message-ID: <558877F7.6060202@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 16:02:47 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] pseries: Enable kernel CPU dlpar from sysfs
References: <558875FF.2040000@linux.vnet.ibm.com>
In-Reply-To: <558875FF.2040000@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable new kernel cpu hotplug functionality by allowing cpu dlpar requests
to be initiated from sysfs.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4463e9a..85b8d9e 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -377,6 +377,9 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_RESOURCE_MEM:
 		rc = dlpar_memory(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_RESOURCE_CPU:
+		rc = dlpar_cpu(hp_elog);
+		break;
 	default:
 		pr_warn_ratelimited("Invalid resource (%d) specified\n",
 				    hp_elog->resource);
@@ -406,6 +409,9 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 	if (!strncmp(arg, "memory", 6)) {
 		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
 		arg += strlen("memory ");
+	} else if (!strncmp(arg, "cpu", 3)) {
+		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_CPU;
+		arg += strlen("cpu ");
 	} else {
 		pr_err("Invalid resource specified: \"%s\"\n", buf);
 		rc = -EINVAL;
