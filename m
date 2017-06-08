Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkDHx37WvzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 04:20:45 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58IJYF5113894
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 14:20:42 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2axxrdvw05-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 14:20:42 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 8 Jun 2017 12:20:42 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>, John Allen
 <jallen@linux.vnet.ibm.com>, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Resend [PATCH] powerpc/hotplug-mem: Fix aa_index match bug for hotplug
Date: Thu, 8 Jun 2017 13:20:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <fa73f943-a8c7-f74b-fca8-20b7e53212ed@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When adding or removing memory, the aa_index (affinity value) for the
memblock must also be converted to match the endianness of the rest
of the 'ibm,dynamic-memory' property.  Otherwise, subsequent retrieval
of the attribute will likely lead to non-existent nodes, followed by
using the default node in the code inappropriately.

Note: This is a bug that we would likely want to see fixed in stable
      circa v4.1+.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e104c71..1fb162b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -124,6 +124,7 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 	for (i = 0; i < num_lmbs; i++) {
 		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
 		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
+		lmbs[i].aa_index = be32_to_cpu(lmbs[i].aa_index);
 		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
 	}
 
@@ -147,6 +148,7 @@ static void dlpar_update_drconf_property(struct device_node *dn,
 	for (i = 0; i < num_lmbs; i++) {
 		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
 		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
+		lmbs[i].aa_index = cpu_to_be32(lmbs[i].aa_index);
 		lmbs[i].flags = cpu_to_be32(lmbs[i].flags);
 	}
 
