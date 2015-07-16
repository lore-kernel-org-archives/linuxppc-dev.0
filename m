Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5050E1A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 06:10:33 +1000 (AEST)
Message-ID: <1437077417.2993.108.camel@freescale.com>
Subject: Re: [PATCH v5 1/2] perf,kvm/ppc: Add kvm_perf.h for powerpc
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <acme@kernel.org>, <mingo@kernel.org>, <mpe@ellerman.id.au>,
 <sukadev@linux.vnet.ibm.com>, <maddy@linux.vnet.ibm.com>,
 <warrier@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>, <paulus@samba.org>
Date: Thu, 16 Jul 2015 15:10:17 -0500
In-Reply-To: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-16 at 21:18 +0530, Hemant Kumar wrote:
> To analyze the exit events with perf, we need kvm_perf.h to be added in
> the arch/powerpc directory, where the kvm tracepoints needed to trace
> the KVM exit events are defined.
> 
> This patch adds "kvm_perf_book3s.h" to indicate that the tracepoints are
> book3s specific. Generic "kvm_perf.h" then can just include
> "kvm_perf_book3s.h".
> 
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> ---
> Changes:
> - Not exporting the exit reasons compared to previous patchset (suggested 
> by Paul)
> 
>  arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
>  arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>  create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h 
> b/arch/powerpc/include/uapi/asm/kvm_perf.h
> new file mode 100644
> index 0000000..5ed2ff3
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> @@ -0,0 +1,6 @@
> +#ifndef _ASM_POWERPC_KVM_PERF_H
> +#define _ASM_POWERPC_KVM_PERF_H
> +
> +#include <asm/kvm_perf_book3s.h>
> +
> +#endif
> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h 
> b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> new file mode 100644
> index 0000000..8c8d8c2
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
> @@ -0,0 +1,14 @@
> +#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
> +#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
> +
> +#include <asm/kvm.h>
> +
> +#define DECODE_STR_LEN 20
> +
> +#define VCPU_ID "vcpu_id"
> +
> +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
> +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
> +#define KVM_EXIT_REASON "trap"
> +
> +#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */

Again, why is book3s stuff being presented via uapi as generic 
<asm/kvm_perf.h> with generic symbol names?

-Scott
