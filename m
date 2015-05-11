Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C92191A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 08:08:54 +1000 (AEST)
Message-ID: <1431382120.16357.471.camel@freescale.com>
Subject: Re: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
From: Scott Wood <scottwood@freescale.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Date: Mon, 11 May 2015 17:08:40 -0500
In-Reply-To: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, 2015-05-08 at 06:37 +0530, Hemant Kumar wrote:
> From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 
> perf kvm can be used to analyze guest exit reasons. This support already
> exists in x86. Hence, porting it to powerpc.
> 
>  - To trace KVM events :
>   perf kvm stat record
>   If many guests are running, we can track for a specific guest by using
>   --pid as in : perf kvm stat record --pid <pid>
> 
>  - To see the results :
>   perf kvm stat report
> 
> The result shows the number of exits (from the guest context to
> host/hypervisor context) grouped by their respective exit reasons with
> their frequency.
> 
> This patch makes use of the guest exit reasons available in
> "trace_book3s.h". It records on two already available tracepoints :
> "kvm_hv:kvm_guest_exit" and "kvm_hv:kvm_guest_enter".
> 
> Note : This patch has a dependency on the patch "kvm/powerpc: Export
> kvm exit reasons" which exports the KVM exit reasons through the uapi.
> 
> Here is a sample o/p:
>  # pgrep qemu
> 19378
> 60515
> 
> 2 Guests are running on the host.
> 
>  # perf kvm stat record -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 4.153 MB perf.data.guest (39624 samples) ]
> 
>  # perf kvm stat report -p 60515
> Analyze events for pid(s) 60515, all VCPUs:
> 
>        VM-EXIT    Samples  Samples%     Time%    Min Time         Max        Time         Avg time
> 
> H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
> HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
>        SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
> RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
>       EXTERNAL        240     1.69%     0.00%        0.69us     10.67us      1.33us ( +-   5.34% )
> 
> Total Samples:14182, Total events handled time:49264158.30us.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> ---
> Patch has a dependency on : https://patchwork.ozlabs.org/patch/469839/
> which exports the exit reasons to perf through uapi.
> 
> Changes:
> - Original series split into two patchsets now : perf and powerpc
>   side changes.
> 
>  arch/powerpc/include/uapi/asm/kvm_perf.h | 15 +++++++++++++++
>  tools/perf/arch/powerpc/Makefile         |  1 +
>  tools/perf/arch/powerpc/util/Build       |  1 +
>  tools/perf/arch/powerpc/util/kvm-stat.c  | 33 ++++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)
>  create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>  create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
> new file mode 100644
> index 0000000..30fa670
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
> @@ -0,0 +1,15 @@
> +#ifndef _ASM_POWERPC_KVM_PERF_H
> +#define _ASM_POWERPC_KVM_PERF_H
> +
> +#include <asm/trace_book3s.h>
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
> +#endif /* _ASM_POWERPC_KVM_PERF_H */

Please make sure that anything book3s-specific is named that way.

And shouldn't this be part of the arch/powerpc-side patchset?

> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
> index 7fbca17..21322e0 100644
> --- a/tools/perf/arch/powerpc/Makefile
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -1,3 +1,4 @@
>  ifndef NO_DWARF
>  PERF_HAVE_DWARF_REGS := 1
>  endif
> +HAVE_KVM_STAT_SUPPORT := 1

Does this stuff fail gracefully if used on a PPC target that doesn't
support this?

-Scott
