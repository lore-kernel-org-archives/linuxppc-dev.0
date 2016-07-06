Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkqH71JT1zDqxX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:36:02 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u665XXcI032070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 01:36:00 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240ndnhjx2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 01:36:00 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 6 Jul 2016 15:35:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DD3552CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:35:54 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u665ZsLR15532182
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:54 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u665Zs6v024634
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:54 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: david@gibson.dropbear.id.au
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] Rework spapr: Better handling of ibm,
 pa-features TM bit
Date: Wed,  6 Jul 2016 15:35:20 +1000
In-Reply-To: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
Message-Id: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Here's version 2.


Changes v1 -> v2:
Patch 2/3: spapr: Set ibm, pa-features HTM from KVM_CAP_PPC_HTM

* Improve readability of HTM bit set code.
* Move the test for KVM into kvmppc_get_htm_support().


Sam Bobroff (3):
  spapr: Disable ibm, pa-features HTM bit
  Add KVM_CAP_PPC_HTM to linux/kvm.h
  spapr: Set ibm, pa-features HTM from KVM_CAP_PPC_HTM

 hw/ppc/spapr.c            |  5 ++++-
 linux-headers/linux/kvm.h |  1 +
 target-ppc/kvm.c          | 29 +++++++++++++++++++++++++++++
 target-ppc/kvm_ppc.h      |  6 ++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.1.0
