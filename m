Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BA452C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:08:46 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 18:38:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4493EE0053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:39:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RD8dk545613240
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:38:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RD8fXK012923
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:38:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 08/11] kvm: powerpc: book3s: Support building HV and
 PR KVM as module
In-Reply-To: <32B8402B-25D1-41F4-A3FB-B945B72EDC4C@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <32B8402B-25D1-41F4-A3FB-B945B72EDC4C@suse.de>
Date: Fri, 27 Sep 2013 18:38:40 +0530
Message-ID: <87txh69ztz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
>> index fd5b393..775d368 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
>> @@ -27,6 +27,7 @@
>> #include <asm/machdep.h>
>> #include <asm/mmu_context.h>
>> #include <asm/hw_irq.h>
>> +
>
> Stray whitespace change
>

will fix

>> #include "trace_pr.h"
>> 
>> #define PTE_SIZE 12
>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>> index b9841ad..20d03c2 100644
>> --- a/arch/powerpc/kvm/book3s_emulate.c
>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>> @@ -172,7 +172,7 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>> 			vcpu->arch.mmu.tlbie(vcpu, addr, large);
>> 			break;
>> 		}
>> -#ifdef CONFIG_KVM_BOOK3S_64_PR
>> +#ifdef CONFIG_KVM_BOOK3S_PR
>
> Why?

If i have CONFIG_KVM_BOOK3S_64_PR=m  #ifdef CONFIG_KVM_BOOK3S_64_PR will
not work. There is a runtime check I can use IS_ENABLED(). But didn't
want to do those. Hence moved to the symbol which will be set as
CONFIG_KVM_BOOK3S_PR = y

-aneesh
