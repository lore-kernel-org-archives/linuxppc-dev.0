Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6279A1A0C14
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 16:45:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 11:15:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CFE6B394005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 11:15:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA45jaXr16580784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 11:15:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA45jYeb023379
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 11:15:35 +0530
Subject: Re: [PATCH V3 2/3] perf/powerpc :add support for sampling intr
 machine state
To: Michael Ellerman <mpe@ellerman.id.au>, Anju T <anju@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
 <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
 <1446542195.23081.5.camel@ellerman.id.au>
Cc: hemant@linux.vnet.ibm.com, acme@redhat.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 jolsa@redhat.com, khandual@linux.vnet.ibm.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <56399B6E.8050909@linux.vnet.ibm.com>
Date: Wed, 4 Nov 2015 11:15:18 +0530
MIME-Version: 1.0
In-Reply-To: <1446542195.23081.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 03 November 2015 02:46 PM, Michael Ellerman wrote:
> On Tue, 2015-11-03 at 11:40 +0530, Anju T wrote:
>
>> The perf infrastructure uses a bit mask to find out
>> valid registers to display. Define a register mask
>> for supported registers defined in asm/perf_regs.h.
>> The bit positions also correspond to register IDs
>> which is used by perf infrastructure to fetch the register
>> values.CONFIG_HAVE_PERF_REGS enables
>> sampling of the interrupted machine state.
>> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
>> new file mode 100644
>> index 0000000..0520492
>> --- /dev/null
>> +++ b/arch/powerpc/perf/perf_regs.c
>> @@ -0,0 +1,92 @@
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/bug.h>
>> +#include <linux/stddef.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/perf_regs.h>
>> +
>> +#define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
>> +
>> +#define REG_RESERVED (~((1ULL << PERF_REG_POWERPC_MAX) - 1))
>> +
>> +static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR1, gpr[1]),
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR2, gpr[2]),
> <snip>
>
> I realise you're following the example of other architectures, but we have
> almost this exact same structure in ptrace.c, see regoffset_table.

That won't work because we want to add more regs to the perf version but
not the ptrace version.

Maddy

> It would be really nice if we could share them between ptrace and perf.
>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
