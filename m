Return-Path: <nilayvaish@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNtZX1LYGzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 02:02:28 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id f128so2627397ith.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 09:02:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
From: Nilay Vaish <nilayvaish@gmail.com>
Date: Tue, 30 Aug 2016 11:01:45 -0500
Message-ID: <CACbG3094rSX9qfngBPSzetG21_=yW1pdxcAeVZOyNj=AJmdL6Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Add support for perf_arch_regs
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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
> Patchset to extend PERF_SAMPLE_REGS_INTR to include
> platform specific PMU registers.
>
> Patchset applies cleanly on tip:perf/core branch
>
> It's a perennial request from hardware folks to be able to
> see the raw values of the pmu registers. Partly it's so that
> they can verify perf is doing what they want, and some
> of it is that they're interested in some of the more obscure
> info that isn't plumbed out through other perf interfaces.
>
> Over the years internally we have used various hack to get
> the requested data out but this is an attempt to use a
> somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).
>
> This would also be helpful for those of us working on the perf
> hardware backends, to be able to verify that we're programming
> things correctly, without resorting to debug printks etc.
>
> Mechanism proposed:
>
> 1)perf_regs structure is extended with a perf_arch_regs structure
> which each arch/ can populate with their specific platform
> registers to sample on each perf interrupt and an arch_regs_mask
> variable, which is for perf tool to know about the perf_arch_regs
> that are supported.
>
> 2)perf/core func perf_sample_regs_intr() extended to update
> the perf_arch_regs structure and the perf_arch_reg_mask. Set of new
> support functions added perf_get_arch_regs_mask() and
> perf_get_arch_reg() to aid the updates from arch/ side.
>
> 3) perf/core funcs perf_prepare_sample() and perf_output_sample()
> are extended to support the update for the perf_arch_regs_mask and
> perf_arch_regs in the sample
>
> 4)perf/core func perf_output_sample_regs() extended to dump
> the arch_regs to the output sample.
>
> 5)Finally, perf tool side is updated to include a new element
> "arch_regs_mask" in the "struct regs_dump", event sample funcs
> and print functions are updated to support perf_arch_regs.
>

I read the patch series and I have one suggestion to make.  I think we
should not use 'arch regs' to refer to these pmu registers.  I think
architectural registers typically refer to the ones that hold the
state of the process.  Can we replace arch_regs by pmu_regs, or some
other choice?

Thanks
Nilay
