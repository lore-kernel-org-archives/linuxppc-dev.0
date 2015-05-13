Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 934931A0314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 13:22:38 +1000 (AEST)
Message-ID: <1431487345.3868.2.camel@freescale.com>
Subject: Re: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Date: Tue, 12 May 2015 22:22:25 -0500
In-Reply-To: <555224A4.5050502@linux.vnet.ibm.com>
References: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1431382120.16357.471.camel@freescale.com>
 <555224A4.5050502@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, agraf@suse.de,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 21:34 +0530, Hemant Kumar wrote:
> Hi Scott,
> 
> On 05/12/2015 03:38 AM, Scott Wood wrote:
> > On Fri, 2015-05-08 at 06:37 +0530, Hemant Kumar wrote:
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
> >> new file mode 100644
> >> index 0000000..30fa670
> >> --- /dev/null
> >> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> >> @@ -0,0 +1,15 @@
> >> +#ifndef _ASM_POWERPC_KVM_PERF_H
> >> +#define _ASM_POWERPC_KVM_PERF_H
> >> +
> >> +#include <asm/trace_book3s.h>
> >> +#include <asm/kvm.h>
> >> +
> >> +#define DECODE_STR_LEN 20
> >> +
> >> +#define VCPU_ID "vcpu_id"
> >> +
> >> +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
> >> +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
> >> +#define KVM_EXIT_REASON "trap"
> >> +
> >> +#endif /* _ASM_POWERPC_KVM_PERF_H */
> > Please make sure that anything book3s-specific is named that way.
> 
> Are you suggesting to name it to something like _ASM_POWERPC_BOOK3S_PERF_H ?

My concern is seeing a generically named "kvm_perf.h" include a file
called "trace_book3s.h" which defines "kvm_trace_symbol_hcall" with
presumably book3s-specific content, as well as wondering how much of the
rest of the file would be applicable if booke PPC were to implement perf
kvm.

I don't know enough about perf kvm to answer that question, but I've
seen enough cases of book3s or pseries specific code that was apparently
written with the belief that no other ppc64 implementations exist, or
that no other ppc implementations would want to implement a certain
feature, to be suspicous.  Usually such cases can be dealt with after
the fact (albeit not as easily as if things were organized/namespaced
properly from the beginning), but this is uapi...

-Scott
