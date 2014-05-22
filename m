Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2AEC1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 06:49:19 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 23 May 2014 06:49:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A59CD3578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 06:49:14 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4MKRasf7275002
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 06:27:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4MKnDf7015942
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 06:49:13 +1000
Message-ID: <537E6285.3050000@linux.vnet.ibm.com>
Date: Fri, 23 May 2014 02:18:05 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: NUMA topology question wrt. d4edc5b6
References: <20140521200451.GB5755@linux.vnet.ibm.com>
In-Reply-To: <20140521200451.GB5755@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dave Hansen <dave@sr71.net>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Linux MM <linux-mm@kvack.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com,
 Cody P Schafer <cody@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[ Adding a few more CC's ]

On 05/22/2014 01:34 AM, Nishanth Aravamudan wrote:
> Hi Srivatsa,
> 
> After d4edc5b6 ("powerpc: Fix the setup of CPU-to-Node mappings during
> CPU online"), cpu_to_node() looks like:
> 
> static inline int cpu_to_node(int cpu)
> {
>         int nid;
> 
>         nid = numa_cpu_lookup_table[cpu];
> 
>         /*
>          * During early boot, the numa-cpu lookup table might not have been
>          * setup for all CPUs yet. In such cases, default to node 0.
>          */
>         return (nid < 0) ? 0 : nid;
> }
> 
> However, I'm curious if this is correct in all cases. I have seen
> several LPARs that do not have any CPUs on node 0. In fact, because node
> 0 is statically set online in the initialization of the N_ONLINE
> nodemask, 0 is always present to Linux, whether it is present on the
> system. I'm not sure what the best thing to do here is, but I'm curious
> if you have any ideas? I would like to remove the static initialization
> of node 0, as it's confusing to users to see an empty node (particularly
> when it's completely separate in the numbering from other nodes), but
> we trip a panic (refer to:
> http://www.spinics.net/lists/linux-mm/msg73321.html).
> 

Ah, I see. I didn't have any particular reason to default it to zero.
I just did that because the existing code before this patch did the same
thing. (numa_cpu_lookup_table[] is a global array, so it will be initialized
with zeros. So if we access it before populating it via numa_setup_cpu(),
it would return 0. So I retained that behaviour with the above conditional).

Will something like the below [totally untested] patch solve the boot-panic?
I understand that as of today first_online_node will still pick 0 since
N_ONLINE is initialized statically, but with your proposed change to that
init code, I guess the following patch should avoid the boot panic.

[ But note that first_online_node is hard-coded to 0, if MAX_NUMNODES is = 1.
So we'll have to fix that if powerpc can have a single node system whose node
is numbered something other than 0. Can that happen as well? ]


And regarding your question about what is the best way to fix this whole Linux
MM's assumption about node0, I'm not really sure.. since I am not really aware
of the extent to which the MM subsystem is intertwined with this assumption
and what it would take to cure that :-(

Regards,
Srivatsa S. Bhat


diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index c920215..58e6469 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -18,6 +18,7 @@ struct device_node;
  */
 #define RECLAIM_DISTANCE 10
 
+#include <linux/nodemask.h>
 #include <asm/mmzone.h>
 
 static inline int cpu_to_node(int cpu)
@@ -30,7 +31,7 @@ static inline int cpu_to_node(int cpu)
 	 * During early boot, the numa-cpu lookup table might not have been
 	 * setup for all CPUs yet. In such cases, default to node 0.
 	 */
-	return (nid < 0) ? 0 : nid;
+	return (nid < 0) ? first_online_node : nid;
 }
 
 #define parent_node(node)	(node)
