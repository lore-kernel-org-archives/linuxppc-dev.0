Return-Path: <anju@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 995BC1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 16:18:43 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 22:18:41 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5532619D803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 22:06:47 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tA45HTDN9699586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 22:17:30 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA45Ib5P014996
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 22:18:38 -0700
Subject: Re: [PATCH V3 2/3] perf/powerpc :add support for sampling intr
 machine state
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
 <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
 <1446542195.23081.5.camel@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, acme@redhat.com, dsahern@gmail.com,
 jolsa@redhat.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
From: Anju T <anju@linux.vnet.ibm.com>
Message-ID: <56399529.5030804@linux.vnet.ibm.com>
Date: Wed, 4 Nov 2015 10:48:33 +0530
MIME-Version: 1.0
In-Reply-To: <1446542195.23081.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
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
>
> It would be really nice if we could share them between ptrace and perf.
>
> cheers
>


Thank you for reviewing the patch.

That is a great suggestion.

In ptrace.c the structure doesn't include ORIG_R3. So,in that case what 
should we do?



Thanks and Regards

Anju
