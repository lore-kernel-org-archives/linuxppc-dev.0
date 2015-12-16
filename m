Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34B331A1A5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 07:56:07 +1100 (AEDT)
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 16 Dec 2015 15:56:05 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBGKu3sV18415838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 20:56:03 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBGKu3Xb005244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:56:03 -0500
Received: from [9.41.105.164] ([9.41.105.164])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBGKu2pp005197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 15:56:02 -0500
Subject: [PATCH v3 6/6] powerpc/pseries: Enable kernel CPU dlpar from sysfs
To: linuxppc-dev@lists.ozlabs.org
References: <5671CD8A.8000500@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <5671CFE2.1060204@linux.vnet.ibm.com>
Date: Wed, 16 Dec 2015 14:56:02 -0600
MIME-Version: 1.0
In-Reply-To: <5671CD8A.8000500@linux.vnet.ibm.com>
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
