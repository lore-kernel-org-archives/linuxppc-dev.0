Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkByb1mLfzDrGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:19:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u655JWQQ005909
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 01:19:32 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mdhvpd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 01:19:32 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 5 Jul 2016 15:19:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 32FCB2BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:19:26 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u655JQQu22544538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 15:19:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u655JPA4025011
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 15:19:26 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: david@gibson.dropbear.id.au
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Rework spapr: Better handling of ibm, pa-features TM bit
Date: Tue,  5 Jul 2016 15:19:21 +1000
In-Reply-To: <20160608022602.GU9226@voom.fritz.box>
References: <20160608022602.GU9226@voom.fritz.box>
Message-Id: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi David,

Anton asked me to have a look at this, so here is an attempt at a
re-implementation of his: "spapr: Better handling of ibm, pa-features TM bit"
addressing your comments and those from Paul Mackerras.  I've broken the
patch into one to unconditionally disable the HTM bit in pa-features and a
second one to set it conditionally based on a (new) KVM capability. It requires
a small patch to KVM to support the capability, presumably something like this:

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 02416fe..4a8ddab 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -588,6 +588,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
                r = 1;
                break;
 #endif
+       case KVM_CAP_PPC_HTM:
+               r = cpu_has_feature(CPU_FTR_TM);
+               break;
        default:
                r = 0;
                break;

Adding a new capability requires changing linux/kvm.h but I believe we can
avoid incrementing KVM_API_VERSION at this stage since kernels that don't yet
support it will simply return false. However, due to the ambiguity of that
result I've included Anton's initial fallback approach to be used in that case.
Once the API version is incremented (and support for the capability is
guaranteed) the ambiguity would be gone and we should be able to remove the
fallback. As long as that happens before KVM PR supports HTM, this should
address Paul's concern about using the PVINFO capability to discover KVM-HV.

Note: I'm not sure how to handle the change to linux/kvm.h, I've included the
patch here because it's needed to compile, but I suspect it needs to go via the
kernel. Let's see if this part looks good first.

Note also: I've changed TM to HTM where possible in an attempt to be consistent.


Sam Bobroff (3):
  spapr: Disable ibm, pa-features HTM bit
  Add KVM_CAP_PPC_HTM to linux/kvm.h
  spapr: Set ibm, pa-features HTM from KVM_CAP_PPC_HTM

 hw/ppc/spapr.c            |  3 ++-
 linux-headers/linux/kvm.h |  1 +
 target-ppc/kvm.c          | 27 +++++++++++++++++++++++++++
 target-ppc/kvm_ppc.h      |  6 ++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.1.0
