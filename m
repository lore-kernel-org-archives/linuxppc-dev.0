Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slB0s3h09zDsj9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 20:40:13 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8TAcmeU112121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:40:11 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ry2snpux-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:40:10 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 29 Sep 2016 11:40:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9F17D1B08070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 11:42:01 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8TAe6eL17039850
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 10:40:06 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8TAe580006388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 04:40:06 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
 <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com, Heiko Carstens <heiko.carstens@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Sep 2016 12:40:04 +0200
MIME-Version: 1.0
In-Reply-To: <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f521d8cb-c38b-a608-eca8-a5c45184bbca@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/29/2016 12:23 PM, Christian Borntraeger wrote:
> On 09/29/2016 12:10 PM, Peter Zijlstra wrote:
>> On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
>>> change from v2:
>>> 	no code change, fix typos, update some comments
>>>
>>> change from v1:
>>> 	a simplier definition of default vcpu_is_preempted
>>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
>>> 	add more comments
>>> 	thanks boqun and Peter's suggestion.
>>>
>>> This patch set aims to fix lock holder preemption issues.
>>
>> So I really like the concept, but I would also really like to see
>> support for more hypervisors included before we can move forward with
>> this.
>>
>> Please consider s390 and (x86/arm) KVM. Once we have a few, more can
>> follow later, but I think its important to not only have PPC support for
>> this.
> 
> Actually the s390 preemted check via sigp sense running  is available for
> all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can no
> longer buy s390 systems without LPAR.
> 
> As Heiko already pointed out we could simply use a small inline function
> that calls cpu_is_preempted from arch/s390/lib/spinlock (or smp_vcpu_scheduled from smp.c)

Maybe something like
(untested and just pasted, so white space damaged)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 63ebf37..6e82986 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -21,6 +21,13 @@ _raw_compare_and_swap(unsigned int *lock, unsigned int old, unsigned int new)
        return __sync_bool_compare_and_swap(lock, old, new);
 }
 
+int arch_vcpu_is_preempted(int cpu);
+#define vcpu_is_preempted cpu_is_preempted
+static inline bool cpu_is_preempted(int cpu)
+{
+       return arch_vcpu_is_preempted(cpu);
+}
+
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e5f50a7..260d179 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -37,7 +37,7 @@ static inline void _raw_compare_and_delay(unsigned int *lock, unsigned int old)
        asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
 }
 
-static inline int cpu_is_preempted(int cpu)
+int arch_vcpu_is_preempted(int cpu)
 {
        if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
                return 0;
@@ -45,6 +45,7 @@ static inline int cpu_is_preempted(int cpu)
                return 0;
        return 1;
 }
+EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
 void arch_spin_lock_wait(arch_spinlock_t *lp)
 {



If ok I can respin into a proper patch.
