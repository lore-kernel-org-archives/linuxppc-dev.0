Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E7981A117C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 21:56:44 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 May 2015 17:26:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A5844125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 17:28:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t46BueiZ63766658
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 17:26:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t46BN2Vf016429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 16:53:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Subject: [PATCH 2/3] kvm/x86: report guest steal time in host
Date: Wed,  6 May 2015 17:26:35 +0530
Message-Id: <356cdc25b8339ab742b349d1432c69fbdeeb204d.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, agraf@suse.de, mingo@redhat.com, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Report guest steal time in host task statistics. On x86, this is just
the scheduler run_delay.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c73efcd..7107b7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2128,6 +2128,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.st.steal.steal += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.steal.version += 2;
+	current->gstime += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.accum_steal = 0;
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-- 
2.3.7
