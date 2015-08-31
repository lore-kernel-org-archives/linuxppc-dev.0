Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 72F041A0BF9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 06:13:05 +1000 (AEST)
Date: Mon, 31 Aug 2015 17:13:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, mingo@kernel.org, mpe@ellerman.id.au,
 sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 warrier@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, paulus@samba.org
Subject: Re: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
Message-ID: <20150831201300.GG4423@kernel.org>
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Aug 31, 2015 at 12:18:00PM +0530, Hemant Kumar escreveu:
> To analyze the exit events with perf, we need to export the related
> tracepoints through kvm_perf.h. kvm_perf.h is to be added in the
> arch/powerpc directory, where the kvm tracepoints needed to trace the
> KVM exit events are defined.
> 
> To indicate that the tracepoints are book3s_hv specific, suffix _HV has
> been added to the tracepoint macros. Additionally, we also need to
> define the generic macros (albeit, with null strings) suffix, because
> the preprocessor looks for them in the generic code in builtin-kvm.c.
> 
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>

humm, there are two patchkits, this one with two patches, the other with
3, this one for the kernel, the other one for tools/, but for the tools/
part to work, does this one needs to be applied first?

Should I try to process the 5 together, applying thest two first?

I see there are no acks from powerpc arch maintainers, how should we
proceed here? If there are no problems with the arch bits, and if it is
just to enable the tooling part, again, should I process the 5 as just
one series?

- Arnaldo

> ---
> Changes since v5:
> - Moved back the tracepoint definitions from kvm_perf_book3s.h to kvm_perf.h
> 
>  arch/powerpc/include/uapi/asm/kvm_perf.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
> new file mode 100644
> index 0000000..68f105e
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> @@ -0,0 +1,21 @@
> +#ifndef _ASM_POWERPC_KVM_PERF_H
> +#define _ASM_POWERPC_KVM_PERF_H
> +
> +#include <asm/kvm.h>
> +
> +#define DECODE_STR_LEN 40
> +
> +#define VCPU_ID "vcpu_id"
> +
> +/* For Book3S_HV machines */
> +#define KVM_ENTRY_TRACE_HV "kvm_hv:kvm_guest_enter"
> +#define KVM_EXIT_TRACE_HV "kvm_hv:kvm_guest_exit"
> +#define KVM_EXIT_REASON_HV "trap"
> +
> +/* This is to shut the compiler up */
> +#define KVM_ENTRY_TRACE ""
> +#define KVM_EXIT_TRACE ""
> +#define KVM_EXIT_REASON ""
> +
> +
> +#endif /* _ASM_POWERPC_KVM_PERF_H */
> -- 
> 1.9.3
