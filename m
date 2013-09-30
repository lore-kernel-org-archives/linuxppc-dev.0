Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C5B802C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 20:04:06 +1000 (EST)
Subject: Re: [RFC PATCH 08/11] kvm: powerpc: book3s: Support building HV and
 PR KVM as module
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87txh69ztz.fsf@linux.vnet.ibm.com>
Date: Mon, 30 Sep 2013 12:04:02 +0200
Message-Id: <9CCFAB0B-A05C-4C70-AA87-6339D1BA1471@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <32B8402B-25D1-41F4-A3FB-B945B72EDC4C@suse.de>
 <87txh69ztz.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.09.2013, at 15:08, Aneesh Kumar K.V wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>>=20
>>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c =
b/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> index fd5b393..775d368 100644
>>> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> @@ -27,6 +27,7 @@
>>> #include <asm/machdep.h>
>>> #include <asm/mmu_context.h>
>>> #include <asm/hw_irq.h>
>>> +
>>=20
>> Stray whitespace change
>>=20
>=20
> will fix
>=20
>>> #include "trace_pr.h"
>>>=20
>>> #define PTE_SIZE 12
>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c =
b/arch/powerpc/kvm/book3s_emulate.c
>>> index b9841ad..20d03c2 100644
>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>> @@ -172,7 +172,7 @@ int kvmppc_core_emulate_op_pr(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
>>> 			vcpu->arch.mmu.tlbie(vcpu, addr, large);
>>> 			break;
>>> 		}
>>> -#ifdef CONFIG_KVM_BOOK3S_64_PR
>>> +#ifdef CONFIG_KVM_BOOK3S_PR
>>=20
>> Why?
>=20
> If i have CONFIG_KVM_BOOK3S_64_PR=3Dm  #ifdef CONFIG_KVM_BOOK3S_64_PR =
will
> not work. There is a runtime check I can use IS_ENABLED(). But didn't
> want to do those. Hence moved to the symbol which will be set as
> CONFIG_KVM_BOOK3S_PR =3D y

Ah, I see. The naming starts to get really confusing. Could you please =
give this a slightly better name, such as CONFIG_KVM_BOOK3S_PR_POSSIBLE =
or such, so that it's obvious that this #ifdef doesn't mean "option is =
enabled", but instead means "option can potentially be enabled through a =
module".


Alex
