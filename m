Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 204C51A17E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:28:47 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 12:28:45 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E60DA19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:16:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIRJah61735130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 11:27:19 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RISfhu020748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:28:41 -0600
Received: from [9.41.105.89] ([9.41.105.89])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9RISfhl020701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 12:28:41 -0600
Subject: [PATCH v2 6/6] powerpc/pseries: Enable kernel CPU dlpar from sysfs
To: linuxppc-dev@lists.ozlabs.org
References: <562FC0C3.7000303@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562FC259.40101@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 13:28:41 -0500
MIME-Version: 1.0
In-Reply-To: <562FC0C3.7000303@linux.vnet.ibm.com>
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
index 438fdbd..2b93ae8 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -356,6 +356,9 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_RESOURCE_MEM:
 		rc = dlpar_memory(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_RESOURCE_CPU:
+		rc = dlpar_cpu(hp_elog);
+		break;
 	default:
 		pr_warn_ratelimited("Invalid resource (%d) specified\n",
 				    hp_elog->resource);
@@ -385,6 +388,9 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 	if (!strncmp(arg, "memory", 6)) {
 		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
 		arg += strlen("memory ");
+	} else if (!strncmp(arg, "cpu", 3)) {
+		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_CPU;
+		arg += strlen("cpu ");
 	} else {
 		pr_err("Invalid resource specified: \"%s\"\n", buf);
 		rc = -EINVAL;
