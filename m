Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 716EB2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 06:56:57 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 11 Mar 2014 13:56:54 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 54B7019D804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 13:56:49 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BJuprK5374342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 20:56:51 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BJunCc011433
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 13:56:51 -0600
Date: Tue, 11 Mar 2014 12:56:33 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Subject: Node 0 not necessary for powerpc?
Message-ID: <20140311195632.GA946@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cl@linux.com, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a P7 system that has no node0, but a node0 shows up in numactl
--hardware, which has no cpus and no memory (and no PCI devices):

numactl --hardware
available: 4 nodes (0-3)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus:
node 2 size: 7935 MB
node 2 free: 7716 MB
node 3 cpus:
node 3 size: 8395 MB
node 3 free: 8015 MB
node distances:
node   0   1   2   3 
  0:  10  20  10  20 
  1:  20  10  20  20 
  2:  10  20  10  20 
  3:  20  20  20  10 

This is because we statically initialize N_ONLINE to be [0] in
mm/page_alloc.c:

        [N_ONLINE] = { { [0] = 1UL } },

I'm not sure what the architectural requirements are here, but at least
on this test system, removing this initialization, it boots fine and is
running. I've not yet tried stress tests, but it's survived the
beginnings of kernbench so far.

numactl --hardware
available: 3 nodes (1-3)
node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus:
node 2 size: 7935 MB
node 2 free: 7479 MB
node 3 cpus:
node 3 size: 8396 MB
node 3 free: 8375 MB
node distances:
node   1   2   3 
  1:  10  20  20 
  2:  20  10  20 
  3:  20  20  10

Perhaps we could put in a ARCH_DOES_NOT_NEED_NODE0 and only define it on
powerpc for now, conditionalizing the above initialization on that?

Thanks,
Nish
