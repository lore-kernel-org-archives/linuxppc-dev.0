Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7FDE1A07D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 19:26:46 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 13:56:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0F1AA125801E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:56:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9Q8QcSk54001852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:56:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9Q8Qb22011277
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:56:38 +0530
Message-ID: <562DE3BD.3010303@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2015 13:56:37 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: acme@kernel.org
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scottwood@freescale.com, sukadev@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org,
 mingo@redhat.com, yarygin@linux.vnet.ibm.com, borntraeger@de.ibm.com,
 srikar@linux.vnet.ibm.com, dsahern@gmail.com
Subject: Re: [PATCH v9 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Could you please take a look at this series and pull it?

---
Thanks,
Hemant

On 10/07/2015 07:55 AM, Hemant Kumar wrote:
> Its better to remove the dependency on uapi/kvm_perf.h to allow dynamic
> discovery of kvm events (if its needed). To do this, some extern
> variables have been introduced with which we can keep the generic
> functions generic.
>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> ---
> Changelog:
> v8 to v9:
> - Removed the macro definitions.
> - Changed the access of kvm_entry_trace and kvm_exit_trace
> - Removed unnecessary formatting.
> v7 to v8:
> - Removed unnecessary __unused_parameter modifiers.
>
>   tools/perf/arch/s390/util/kvm-stat.c |  8 +++++++-
>   tools/perf/arch/x86/util/kvm-stat.c  | 14 +++++++++++---
>   tools/perf/builtin-kvm.c             | 32 ++++++++++++++++++++++----------
>   tools/perf/util/kvm-stat.h           |  5 +++++
>   4 files changed, 45 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
> index a5dbc07..b85a94b 100644
> --- a/tools/perf/arch/s390/util/kvm-stat.c
> +++ b/tools/perf/arch/s390/util/kvm-stat.c
> @@ -10,7 +10,7 @@
>    */
>
>   #include "../../util/kvm-stat.h"
> -#include <asm/kvm_perf.h>
> +#include <asm/sie.h>
>
>   define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
>   define_exit_reasons_table(sie_icpt_insn_codes, icpt_insn_codes);
> @@ -18,6 +18,12 @@ define_exit_reasons_table(sie_sigp_order_codes, sigp_order_codes);
>   define_exit_reasons_table(sie_diagnose_codes, diagnose_codes);
>   define_exit_reasons_table(sie_icpt_prog_codes, icpt_prog_codes);
>
> +const char *vcpu_id_str = "id";
> +const int decode_str_len = 40;
> +const char *kvm_exit_reason = "icptcode";
> +const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
> +const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
> +
>   static void event_icpt_insn_get_key(struct perf_evsel *evsel,
>   				    struct perf_sample *sample,
>   				    struct event_key *key)
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index 14e4e66..babefda 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -1,5 +1,7 @@
>   #include "../../util/kvm-stat.h"
> -#include <asm/kvm_perf.h>
> +#include <asm/svm.h>
> +#include <asm/vmx.h>
> +#include <asm/kvm.h>
>
>   define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
>   define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
> @@ -11,6 +13,12 @@ static struct kvm_events_ops exit_events = {
>   	.name = "VM-EXIT"
>   };
>
> +const char *vcpu_id_str = "vcpu_id";
> +const int decode_str_len = 20;
> +const char *kvm_exit_reason = "exit_reason";
> +const char *kvm_entry_trace = "kvm:kvm_entry";
> +const char *kvm_exit_trace = "kvm:kvm_exit";
> +
>   /*
>    * For the mmio events, we treat:
>    * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
> @@ -65,7 +73,7 @@ static void mmio_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
>   				  struct event_key *key,
>   				  char *decode)
>   {
> -	scnprintf(decode, DECODE_STR_LEN, "%#lx:%s",
> +	scnprintf(decode, decode_str_len, "%#lx:%s",
>   		  (unsigned long)key->key,
>   		  key->info == KVM_TRACE_MMIO_WRITE ? "W" : "R");
>   }
> @@ -109,7 +117,7 @@ static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
>   				    struct event_key *key,
>   				    char *decode)
>   {
> -	scnprintf(decode, DECODE_STR_LEN, "%#llx:%s",
> +	scnprintf(decode, decode_str_len, "%#llx:%s",
>   		  (unsigned long long)key->key,
>   		  key->info ? "POUT" : "PIN");
>   }
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index fc1cffb..5104c7e 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -31,7 +31,6 @@
>   #include <math.h>
>
>   #ifdef HAVE_KVM_STAT_SUPPORT
> -#include <asm/kvm_perf.h>
>   #include "util/kvm-stat.h"
>
>   void exit_event_get_key(struct perf_evsel *evsel,
> @@ -39,12 +38,12 @@ void exit_event_get_key(struct perf_evsel *evsel,
>   			struct event_key *key)
>   {
>   	key->info = 0;
> -	key->key = perf_evsel__intval(evsel, sample, KVM_EXIT_REASON);
> +	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);
>   }
>
>   bool kvm_exit_event(struct perf_evsel *evsel)
>   {
> -	return !strcmp(evsel->name, KVM_EXIT_TRACE);
> +	return !strcmp(evsel->name, kvm_exit_trace);
>   }
>
>   bool exit_event_begin(struct perf_evsel *evsel,
> @@ -60,7 +59,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
>
>   bool kvm_entry_event(struct perf_evsel *evsel)
>   {
> -	return !strcmp(evsel->name, KVM_ENTRY_TRACE);
> +	return !strcmp(evsel->name, kvm_entry_trace);
>   }
>
>   bool exit_event_end(struct perf_evsel *evsel,
> @@ -92,7 +91,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
>   	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
>   						  key->key);
>
> -	scnprintf(decode, DECODE_STR_LEN, "%s", exit_reason);
> +	scnprintf(decode, decode_str_len, "%s", exit_reason);
>   }
>
>   static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
> @@ -358,7 +357,12 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>   	time_diff = sample->time - time_begin;
>
>   	if (kvm->duration && time_diff > kvm->duration) {
> -		char decode[DECODE_STR_LEN];
> +		char *decode = zalloc(decode_str_len);
> +
> +		if (!decode) {
> +			pr_err("Not enough memory\n");
> +			return false;
> +		}
>
>   		kvm->events_ops->decode_key(kvm, &event->key, decode);
>   		if (!skip_event(decode)) {
> @@ -366,6 +370,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>   				 sample->time, sample->pid, vcpu_record->vcpu_id,
>   				 decode, time_diff/1000);
>   		}
> +		free(decode);
>   	}
>
>   	return update_kvm_event(event, vcpu, time_diff);
> @@ -386,7 +391,8 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
>   			return NULL;
>   		}
>
> -		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample, VCPU_ID);
> +		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample,
> +							  vcpu_id_str);
>   		thread__set_priv(thread, vcpu_record);
>   	}
>
> @@ -575,7 +581,7 @@ static void show_timeofday(void)
>
>   static void print_result(struct perf_kvm_stat *kvm)
>   {
> -	char decode[DECODE_STR_LEN];
> +	char *decode;
>   	struct kvm_event *event;
>   	int vcpu = kvm->trace_vcpu;
>
> @@ -584,9 +590,14 @@ static void print_result(struct perf_kvm_stat *kvm)
>   		show_timeofday();
>   	}
>
> +	decode = zalloc(decode_str_len);
> +	if (!decode) {
> +		pr_err("Not enough memory\n");
> +		return;
> +	}
>   	pr_info("\n\n");
>   	print_vcpu_info(kvm);
> -	pr_info("%*s ", DECODE_STR_LEN, kvm->events_ops->name);
> +	pr_info("%*s ", decode_str_len, kvm->events_ops->name);
>   	pr_info("%10s ", "Samples");
>   	pr_info("%9s ", "Samples%");
>
> @@ -605,7 +616,7 @@ static void print_result(struct perf_kvm_stat *kvm)
>   		min = get_event_min(event, vcpu);
>
>   		kvm->events_ops->decode_key(kvm, &event->key, decode);
> -		pr_info("%*s ", DECODE_STR_LEN, decode);
> +		pr_info("%*s ", decode_str_len, decode);
>   		pr_info("%10llu ", (unsigned long long)ecount);
>   		pr_info("%8.2f%% ", (double)ecount / kvm->total_count * 100);
>   		pr_info("%8.2f%% ", (double)etime / kvm->total_time * 100);
> @@ -615,6 +626,7 @@ static void print_result(struct perf_kvm_stat *kvm)
>   			kvm_event_rel_stddev(vcpu, event));
>   		pr_info("\n");
>   	}
> +	free(decode);
>
>   	pr_info("\nTotal Samples:%" PRIu64 ", Total events handled time:%.2fus.\n\n",
>   		kvm->total_count, kvm->total_time / 1e3);
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index ae825d4..dd55548 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -136,5 +136,10 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
>   extern const char * const kvm_events_tp[];
>   extern struct kvm_reg_events_ops kvm_reg_events_ops[];
>   extern const char * const kvm_skip_events[];
> +extern const char *vcpu_id_str;
> +extern const int decode_str_len;
> +extern const char *kvm_exit_reason;
> +extern const char *kvm_entry_trace;
> +extern const char *kvm_exit_trace;
>
>   #endif /* __PERF_KVM_STAT_H */
