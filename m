Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 769902C0383
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:06:39 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 18:36:36 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DF82C1258051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:36:46 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RD8pKR16646240
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:38:51 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RD6WFd002179
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:36:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 07/11] kvm: powerpc: book3s: pr: move PR related
 tracepoints to a separate header
In-Reply-To: <C02177CF-C8A0-4E84-82FE-1994742B8EBD@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C02177CF-C8A0-4E84-82FE-1994742B8EBD@suse.de>
Date: Fri, 27 Sep 2013 18:36:31 +0530
Message-ID: <87wqm29zxk.fsf@linux.vnet.ibm.com>
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
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This patch moves PR related tracepoints to a separate header. This
>> enables in converting PR to a kernel module which will be done in
>> later patches
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/kvm/book3s_64_mmu_host.c |   2 +-
>> arch/powerpc/kvm/book3s_mmu_hpte.c    |   2 +-
>> arch/powerpc/kvm/book3s_pr.c          |   3 +-
>> arch/powerpc/kvm/trace.h              | 234 +--------------------------
>> arch/powerpc/kvm/trace_pr.h           | 297 ++++++++++++++++++++++++++++++++++
>> 5 files changed, 308 insertions(+), 230 deletions(-)
>> create mode 100644 arch/powerpc/kvm/trace_pr.h
>> 
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
>> index 329a978..fd5b393 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
>> @@ -27,7 +27,7 @@
>> #include <asm/machdep.h>
>> #include <asm/mmu_context.h>
>> #include <asm/hw_irq.h>
>> -#include "trace.h"
>> +#include "trace_pr.h"
>> 
>> #define PTE_SIZE 12
>> 
>> diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
>> index d2d280b..4556168 100644
>> --- a/arch/powerpc/kvm/book3s_mmu_hpte.c
>> +++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
>> @@ -28,7 +28,7 @@
>> #include <asm/mmu_context.h>
>> #include <asm/hw_irq.h>
>> 
>> -#include "trace.h"
>> +#include "trace_pr.h"
>> 
>> #define PTE_SIZE	12
>> 
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index 2a97279..99d0839 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -41,7 +41,8 @@
>> #include <linux/vmalloc.h>
>> #include <linux/highmem.h>
>> 
>> -#include "trace.h"
>> +#define CREATE_TRACE_POINTS
>> +#include "trace_pr.h"
>> 
>> /* #define EXIT_DEBUG */
>> /* #define DEBUG_EXT */
>> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
>> index a088e9a..7d5a136 100644
>> --- a/arch/powerpc/kvm/trace.h
>> +++ b/arch/powerpc/kvm/trace.h
>> @@ -85,6 +85,12 @@ TRACE_EVENT(kvm_ppc_instr,
>> 	{41, "HV_PRIV"}
>> #endif
>> 
>> +#ifndef CONFIG_KVM_BOOK3S_PR
>> +/*
>> + * For pr we define this in trace_pr.h since it pr can be built as
>> + * a module
>
> Not sure I understand the need. If the config option is available, so
> should the struct field. Worst case that happens with HV is that we
> get empty shadow_srr1 values in our trace, no?

That is not the real reason. trace.h get built as part of kvm.ko or as
part of kernel. These trace functions actually get called from
kvm-pr.ko. To make they build i would either need EXPORT_SYMBOL or move
the definition of them to kvm-pr.ko. I did the later and moved only pr
related traces to kvm-pr.ko

>
> If your goal is to make it more obvious whether we are tracing in PR
> or HV land (which is a reasonable goal), then you should also split
> off all non-common trace points into a special hv trace header so that
> it's obvious whether we are looking at HV or PR.

-aneesh
