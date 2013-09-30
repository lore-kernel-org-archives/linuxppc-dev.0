Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id EF7DC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 20:02:48 +1000 (EST)
Subject: Re: [RFC PATCH 07/11] kvm: powerpc: book3s: pr: move PR related
 tracepoints to a separate header
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87wqm29zxk.fsf@linux.vnet.ibm.com>
Date: Mon, 30 Sep 2013 12:02:42 +0200
Message-Id: <BAB3B542-A47C-49A8-B2D5-26C461A4E12D@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C02177CF-C8A0-4E84-82FE-1994742B8EBD@suse.de>
 <87wqm29zxk.fsf@linux.vnet.ibm.com>
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


On 27.09.2013, at 15:06, Aneesh Kumar K.V wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>>=20
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>=20
>>> This patch moves PR related tracepoints to a separate header. This
>>> enables in converting PR to a kernel module which will be done in
>>> later patches
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>> arch/powerpc/kvm/book3s_64_mmu_host.c |   2 +-
>>> arch/powerpc/kvm/book3s_mmu_hpte.c    |   2 +-
>>> arch/powerpc/kvm/book3s_pr.c          |   3 +-
>>> arch/powerpc/kvm/trace.h              | 234 =
+--------------------------
>>> arch/powerpc/kvm/trace_pr.h           | 297 =
++++++++++++++++++++++++++++++++++
>>> 5 files changed, 308 insertions(+), 230 deletions(-)
>>> create mode 100644 arch/powerpc/kvm/trace_pr.h
>>>=20
>>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c =
b/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> index 329a978..fd5b393 100644
>>> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
>>> @@ -27,7 +27,7 @@
>>> #include <asm/machdep.h>
>>> #include <asm/mmu_context.h>
>>> #include <asm/hw_irq.h>
>>> -#include "trace.h"
>>> +#include "trace_pr.h"
>>>=20
>>> #define PTE_SIZE 12
>>>=20
>>> diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c =
b/arch/powerpc/kvm/book3s_mmu_hpte.c
>>> index d2d280b..4556168 100644
>>> --- a/arch/powerpc/kvm/book3s_mmu_hpte.c
>>> +++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
>>> @@ -28,7 +28,7 @@
>>> #include <asm/mmu_context.h>
>>> #include <asm/hw_irq.h>
>>>=20
>>> -#include "trace.h"
>>> +#include "trace_pr.h"
>>>=20
>>> #define PTE_SIZE	12
>>>=20
>>> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
>>> index 2a97279..99d0839 100644
>>> --- a/arch/powerpc/kvm/book3s_pr.c
>>> +++ b/arch/powerpc/kvm/book3s_pr.c
>>> @@ -41,7 +41,8 @@
>>> #include <linux/vmalloc.h>
>>> #include <linux/highmem.h>
>>>=20
>>> -#include "trace.h"
>>> +#define CREATE_TRACE_POINTS
>>> +#include "trace_pr.h"
>>>=20
>>> /* #define EXIT_DEBUG */
>>> /* #define DEBUG_EXT */
>>> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
>>> index a088e9a..7d5a136 100644
>>> --- a/arch/powerpc/kvm/trace.h
>>> +++ b/arch/powerpc/kvm/trace.h
>>> @@ -85,6 +85,12 @@ TRACE_EVENT(kvm_ppc_instr,
>>> 	{41, "HV_PRIV"}
>>> #endif
>>>=20
>>> +#ifndef CONFIG_KVM_BOOK3S_PR
>>> +/*
>>> + * For pr we define this in trace_pr.h since it pr can be built as
>>> + * a module
>>=20
>> Not sure I understand the need. If the config option is available, so
>> should the struct field. Worst case that happens with HV is that we
>> get empty shadow_srr1 values in our trace, no?
>=20
> That is not the real reason. trace.h get built as part of kvm.ko or as
> part of kernel. These trace functions actually get called from
> kvm-pr.ko. To make they build i would either need EXPORT_SYMBOL or =
move
> the definition of them to kvm-pr.ko. I did the later and moved only pr
> related traces to kvm-pr.ko

I fail to see why we wouldn't have a trace_hv.h file then, as that can =
also be built as a module, no? And at that point I don't see why we =
would need any conditionals at all in trace.h anymore, as it would only =
cover generic code.


Alex
