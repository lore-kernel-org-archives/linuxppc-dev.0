Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hJJG3st3zF21T
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 04:15:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w72IEOtc134464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2018 14:15:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2km6k019qv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 14:15:39 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 2 Aug 2018 14:15:38 -0400
To: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.co>,
 Michael Ellerman <mpe@ellerman.id.au>, engebret@us.ibm.com,
 santil@us.ibm.com, hollisb@us.ibm.com, rcjenn@us.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: vio.c:__vio_register_driver && LPAR Migration issue
Date: Thu, 2 Aug 2018 13:15:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e815e222-e468-4bd4-5f6f-8657fc980689@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello:
    I have been observing an anomaly during LPAR migrations between
a couple of P8 systems.

This is the problem.  After migrating an LPAR, the PPC mobility code
receives RTAS requests to delete nodes with platform-/hardware-specific
attributes when restarting the kernel after a migration.  My example is
for migration between a P8 Alpine and a P8 Brazos.  Among the nodes
that I see being deleted are 'ibm,random-v1', 'ibm,compression-v1',
'ibm,platform-facilities', and 'ibm,sym-encryption-v1'.  Of these
nodes, the following are created during initial boot by calls to
vio_register_driver:

drivers/char/hw_random/pseries-rng.c
        ibm,random-v1

drivers/crypto/nx/nx-842-pseries.c
        ibm,compression-v1

drivers/crypto/nx/nx.c
        ibm,sym-encryption-v1

After the migration, these nodes are deleted, but nothing recreates
them.  If I boot the LPAR on the target system, the nodes are added
again.

My question is how do we recreate these nodes after migration?

Thanks.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
