Return-Path: <eranian@google.com>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A6D42C0090
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 23:38:22 +1000 (EST)
Received: by mail-oa0-f45.google.com with SMTP id j6so4330044oag.4
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 06:38:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369203761-12649-5-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369203761-12649-5-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 23 May 2013 15:38:20 +0200
Message-ID: <CABPqkBTP+eP8hMsL=HWJHUjK-pup_Q8OGUtJ7RSFXg1=SssrFA@mail.gmail.com>
Subject: Re: [PATCH 4/5] x86, perf: Add conditional branch filtering support
From: Stephane Eranian <eranian@google.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 8:22 AM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> This patch adds conditional branch filtering support,
> enabling it for PERF_SAMPLE_BRANCH_COND in perf branch
> stack sampling framework by utilizing an available
> software filter X86_BR_JCC.
>
Reviewed-by: Stephane Eranian <eranian@google.com>

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/x86/kernel/cpu/perf_event_intel_lbr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/perf_event_intel_lbr.c b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> index d978353..a0d6387 100644
> --- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> +++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> @@ -337,6 +337,10 @@ static int intel_pmu_setup_sw_lbr_filter(struct perf_event *event)
>
>         if (br_type & PERF_SAMPLE_BRANCH_IND_CALL)
>                 mask |= X86_BR_IND_CALL;
> +
> +       if (br_type & PERF_SAMPLE_BRANCH_COND)
> +               mask |= X86_BR_JCC;
> +
>         /*
>          * stash actual user request into reg, it may
>          * be used by fixup code for some CPU
> @@ -626,6 +630,7 @@ static const int nhm_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
>          * NHM/WSM erratum: must include IND_JMP to capture IND_CALL
>          */
>         [PERF_SAMPLE_BRANCH_IND_CALL] = LBR_IND_CALL | LBR_IND_JMP,
> +       [PERF_SAMPLE_BRANCH_COND]     = LBR_JCC,
>  };
>
>  static const int snb_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
> @@ -637,6 +642,7 @@ static const int snb_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
>         [PERF_SAMPLE_BRANCH_ANY_CALL]   = LBR_REL_CALL | LBR_IND_CALL
>                                         | LBR_FAR,
>         [PERF_SAMPLE_BRANCH_IND_CALL]   = LBR_IND_CALL,
> +       [PERF_SAMPLE_BRANCH_COND]       = LBR_JCC,
>  };
>
>  /* core */
> --
> 1.7.11.7
>
