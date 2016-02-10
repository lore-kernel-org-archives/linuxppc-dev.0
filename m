Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89E651A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:09:00 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 12:08:57 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6C393C90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:08:52 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1AH8sEX31260830
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:08:54 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1AH5cwG021091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:05:38 -0500
Received: from [9.41.105.104] ([9.41.105.104])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1AH5bcD021061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:05:37 -0500
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc/pseries: Update affinity index during memory dlpar
Message-ID: <56BB6EA5.9090405@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 11:08:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When adding or removing a LMB the associativity index for the LMB
needs to be updated in the device tree property ibm,dynamic-memory.

Without updating the associativity index for a LMB before adding the
LMB it could be added with the incorrect affinity. For LMBs that are
not present at boot the associativity index in the device tree property
is set to 0xffffffff, the result being that the LMB is added to the
first online node. For an LMB that was present at boot but was later
DLPAR removed, the LMB associativity may be stale causing the LMB
to be added to the incorrect node.

This set of patches updates the memory DLPAR add path to discover the
associativity index for a LMB and update the device tree property prior
to adding the memory for that LMB. This also updates the DLPAR remove
path to set the associativity back to 0xffffffff when a LMB is removed.

Patch 1/3 refactors the dlpar LMB add code to make further updates easier,
there are no functional changes.

Patch 2/3 updates the add and remove paths to modify the associativity
index for the LMB being added or removed.

Patch 3/3 removes some no longer needed conversions of the device tree
property from BE to cpu format.

-Nathan

 hotplug-memory.c |  306 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 214 insertions(+), 92 deletions(-)
