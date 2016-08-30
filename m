Return-Path: <nilayvaish@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNtpF5RxWzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 02:12:37 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id n75so2645196ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 09:12:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1472418058-28659-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-5-git-send-email-maddy@linux.vnet.ibm.com>
From: Nilay Vaish <nilayvaish@gmail.com>
Date: Tue, 30 Aug 2016 11:11:55 -0500
Message-ID: <CACbG308C-mCLxQbZ2ZmXFiC4FdV=e-k6gKMgHeyUZ9E53epu8g@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf/core: Extend perf_output_sample_regs() to
 include perf_arch_regs
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 August 2016 at 16:00, Madhavan Srinivasan
<maddy@linux.vnet.ibm.com> wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 274288819829..e16bf4d057d1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5371,16 +5371,24 @@ u64 __attribute__((weak)) perf_arch_reg_value(struct perf_arch_regs *regs,
>
>  static void
>  perf_output_sample_regs(struct perf_output_handle *handle,
> -                       struct pt_regs *regs, u64 mask)
> +                               struct perf_regs *regs, u64 mask)
>  {
>         int bit;
>         DECLARE_BITMAP(_mask, 64);
> +       u64 arch_regs_mask = regs->arch_regs_mask;
>
>         bitmap_from_u64(_mask, mask);
>         for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
>                 u64 val;
>
> -               val = perf_reg_value(regs, bit);
> +               val = perf_reg_value(regs->regs, bit);
> +               perf_output_put(handle, val);
> +       }
> +
> +       bitmap_from_u64(_mask, arch_regs_mask);
> +       for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
> +               u64 val;
> +               val = perf_arch_reg_value(regs->arch_regs, bit);
>                 perf_output_put(handle, val);
>         }
>  }
> @@ -5792,7 +5800,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>                 if (abi) {
>                         u64 mask = event->attr.sample_regs_user;
>                         perf_output_sample_regs(handle,
> -                                               data->regs_user.regs,
> +                                               &data->regs_user,
>                                                 mask);
>                 }
>         }
> @@ -5827,7 +5835,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>                         u64 mask = event->attr.sample_regs_intr;
>
>                         perf_output_sample_regs(handle,
> -                                               data->regs_intr.regs,
> +                                               &data->regs_intr,
>                                                 mask);
>                 }
>         }
> --
> 2.7.4
>

I would like to suggest a slightly different version.  Would it make
more sense to have something like following:

@@ -5792,7 +5800,7 @@ void perf_output_sample(struct perf_output_handle *handle,
                 if (abi) {
                        u64 mask = event->attr.sample_regs_user;
                        perf_output_sample_regs(handle,
                                                data->regs_user.regs,
                                                mask);
                }
+
+              if (arch_regs_mask) {
+                   perf_output_pmu_regs(handle,
data->regs_users.arch_regs, arch_regs_mask);
+              }
        }


Somehow I don't like outputting the two sets of registers through the
same function call.

--
Nilay
