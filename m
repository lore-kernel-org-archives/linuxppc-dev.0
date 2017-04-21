Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8JR40b0BzDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 11:43:11 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3L1cxun010851
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:43:08 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29xwu7402x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:43:08 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Fri, 21 Apr 2017 11:43:05 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3L1gsDP50725088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 11:43:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3L1gODe027839
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 11:42:25 +1000
From: Michael Ellerman <michaele@au1.ibm.com>
To: paulmck@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, oleg@redhat.com,
 peterz@infradead.org, fweisbec@gmail.com, bobby.prani@gmail.com,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, josh@joshtriplett.org, dhowells@redhat.com,
 edumazet@google.com, "paulus\@samba.org" <paulus@samba.org>,
 rostedt@goodmis.org, dipankar@in.ibm.com,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 mingo@kernel.org
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
In-Reply-To: <20170421003834.GA14351@linux.vnet.ibm.com>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
 <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
 <20170421003834.GA14351@linux.vnet.ibm.com>
Date: Fri, 21 Apr 2017 11:42:01 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zifatu3a.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> On Thu, Apr 20, 2017 at 05:28:32PM +0200, Paolo Bonzini wrote:
>> On 20/04/2017 05:40, Michael Ellerman wrote:
>> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
>> > 
>> > This change seems to have had the non-obvious effect of breaking the
>> > powerpc KVM build.
...
>> 
>> Michael, if you want to move the two srcu structs at the end of struct
>> kvm, that would be fine by me.  Please send a patch yourself so you can
>> test it on PPC.  Thanks,
>
> On the off-chance that it is at all helpful, I have added the commit
> shown below to -rcu.

As shown below :)

> If it helps, I am happy to push this, but am just as happy to drop it
> in favor of some other fix. If at all possible, I would like to get
> this into the upcoming merge window.

Thanks, this looks perfect to me, and if you're happy to put it on top
of your tree that would limit the breakage to a smaller history window,
so that would be ideal.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


>From a19a6617e2817e485ccc2f7cc5a97bd7ff769b87 Mon Sep 17 00:00:00 2001
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 17:30:06 -0700
Subject: kvm: Move srcu_struct fields to end of struct kvm

Parallelizing SRCU callback handling increased the size of srcu_struct,
which moved the kvm_arch field within the kvm struct out of reach of
powerpc's current assembly code, resulting in the following sort of
build error:

arch/powerpc/kvm/book3s_hv_rmhandlers.S:617: Error: operand out of range (0x000000000000b328 is not between 0xffffffffffff8000 and 0x0000000000007fff)

This commit moves the srcu_struct fields in the kvm structure to follow
the kvm_arch field, which again allows powerpc's assembly code to
reach it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <michaele@au1.ibm.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2c14ad9..96c8e29 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -375,8 +375,6 @@ struct kvm {
 	struct mutex slots_lock;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
-	struct srcu_struct srcu;
-	struct srcu_struct irq_srcu;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 
 	/*
@@ -429,6 +427,8 @@ struct kvm {
 	struct list_head devices;
 	struct dentry *debugfs_dentry;
 	struct kvm_stat_data **debugfs_stat_data;
+	struct srcu_struct srcu;
+	struct srcu_struct irq_srcu;
 };
 
 #define kvm_err(fmt, ...) \
-- 
cgit v1.1
