Return-Path: <eranian@googlemail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 273561A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 01:42:34 +1100 (AEDT)
Received: by oigi82 with SMTP id i82so4510302oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2015 06:42:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: eranian@gmail.com
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
Date: Thu, 5 Nov 2015 15:42:31 +0100
Message-ID: <CAMsRxfJLLV9pOr3iL8KXqVPk0dk3t_fkueW-9WHf6WiyP6DHrA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
From: Stephane Eranian <eranian@googlemail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
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

Hi,

On Wed, Nov 4, 2015 at 9:46 PM, Madhavan Srinivasan
<maddy@linux.vnet.ibm.com> wrote:
>
> This patchset extend the perf sample regs infrastructure
> to include architecture specific regs. Current perf_sample_regs_intr
> exports only registers in the pt_regs to perf.data using
> PERF_SAMPLE_REGS_INTR sample type. But sometimes we end up looking
> for or prefer raw register values at the interrupt during debug.
>
I don't quite understand this explanation here.
What do you mean by raw register values?
The content of pt_regs is also raw register values at interrupt.

The API does not say that the content of perf_sample_regs_intr can ONLY
contain names of registers coming from pt_regs. The meaning of each bit
is arch specific and you are free to map to whatever is relevant for your arch.
All the API says is that the values captured in the sampling buffer for these
registers are taken at PMU interrupt.

>
> This patchset extends the perf_regs to include arch specific struct,
> and makes perf_sample_regs_intr in kernel/event/core.c as __weak__
> function. This way, an arch specific implementation of
> perf_sample_regs_intr() can update the arch specific data to
> the perf_regs.
>
> First patch defines a new structure arch_misc_reg and updates the same
> in the struct perf_regs. Patch also modifies the perf_reg_value()
> and perf_output_sample_regs() to take perf_regs parameter instead of pt_regs.
>
> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> and adds offsetof macro for the same. It extends perf_reg_value()
> to use reg idx to decide on struct to return value from.
>
> Third patch adds arch specific perf_sample_regs_intr() in arch/powerpc
> to hook up the arch_misc_regs to perf_regs.
>
> This patchset depends on the recent posting by Anju T in
> linuxppc-dev@lists.ozlabs.org to enable PERF_SAMPLE_REGS_INTR
> support in arch/powerpc.
>
> https://patchwork.ozlabs.org/patch/539242/
> https://patchwork.ozlabs.org/patch/539243/
> https://patchwork.ozlabs.org/patch/539244/
>
> Would appreciate comments and feedback.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Stephane Eranian <eranian@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>
> Madhavan Srinivasan (3):
>   perf/core: extend perf_regs to include arch specific regs
>   perf/powerpc: update macros and add regs to arch_misc_reg struct
>   perf/powerpc: Functions to update arch_misc_regs
>
>  arch/arm/include/asm/ptrace.h               |  2 ++
>  arch/arm/kernel/perf_regs.c                 |  4 +++-
>  arch/arm64/include/asm/ptrace.h             |  2 ++
>  arch/arm64/kernel/perf_regs.c               |  4 +++-
>  arch/powerpc/include/uapi/asm/perf_regs.h   | 10 ++++++++++
>  arch/powerpc/include/uapi/asm/ptrace.h      | 11 +++++++++++
>  arch/powerpc/perf/core-book3s.c             | 29 +++++++++++++++++++++++++++++
>  arch/powerpc/perf/perf_regs.c               | 28 ++++++++++++++++++++++++++--
>  arch/x86/include/asm/ptrace.h               |  2 ++
>  arch/x86/kernel/perf_regs.c                 |  4 +++-
>  include/linux/perf_regs.h                   |  5 +++--
>  kernel/events/core.c                        |  8 ++++----
>  tools/perf/arch/powerpc/include/perf_regs.h | 16 ++++++++++++++++
>  13 files changed, 114 insertions(+), 11 deletions(-)
>
> --
> 1.9.1
>
