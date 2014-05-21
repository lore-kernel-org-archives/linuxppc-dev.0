Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91CF1A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 06:05:11 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 21 May 2014 14:05:08 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 742AF19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:05:00 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4LK4Dw66816094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 22:04:13 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4LK56BJ026267
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:05:07 -0600
Date: Wed, 21 May 2014 13:04:51 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: srivatsa.bhat@linux.vnet.ibm.com
Subject: NUMA topology question wrt. d4edc5b6
Message-ID: <20140521200451.GB5755@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srivatsa,

After d4edc5b6 ("powerpc: Fix the setup of CPU-to-Node mappings during
CPU online"), cpu_to_node() looks like:

static inline int cpu_to_node(int cpu)
{
        int nid;

        nid = numa_cpu_lookup_table[cpu];

        /*
         * During early boot, the numa-cpu lookup table might not have been
         * setup for all CPUs yet. In such cases, default to node 0.
         */
        return (nid < 0) ? 0 : nid;
}

However, I'm curious if this is correct in all cases. I have seen
several LPARs that do not have any CPUs on node 0. In fact, because node
0 is statically set online in the initialization of the N_ONLINE
nodemask, 0 is always present to Linux, whether it is present on the
system. I'm not sure what the best thing to do here is, but I'm curious
if you have any ideas? I would like to remove the static initialization
of node 0, as it's confusing to users to see an empty node (particularly
when it's completely separate in the numbering from other nodes), but
we trip a panic (refer to:
http://www.spinics.net/lists/linux-mm/msg73321.html).

Thanks,
Nish
