Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11EE41A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 11:49:54 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 17 Oct 2014 18:49:52 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A805A19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 18:38:33 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9I0no0m50266178
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 02:49:50 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9I0nnx8030768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 18:49:50 -0600
Date: Fri, 17 Oct 2014 17:49:44 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/2] powerpc/numa: use cached value of update->cpu in
 update_cpu_topology
Message-ID: <20141018004944.GA3969@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Wang <wangyun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There isn't any need to keep referring to update->cpu, as we've already
checked cpu == update->cpu at this point.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 649666d5d1c2..86fdb004ad2f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1491,8 +1491,8 @@ static int update_cpu_topology(void *data)
 		if (cpu != update->cpu)
 			continue;
 
-		unmap_cpu_from_node(update->cpu);
-		map_cpu_to_node(update->cpu, update->new_nid);
+		unmap_cpu_from_node(cpu);
+		map_cpu_to_node(cpu, update->new_nid);
 		vdso_getcpu_init();
 	}
 
