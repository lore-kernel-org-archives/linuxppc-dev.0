Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5mJG43dxzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 23:28:46 +1000 (AEST)
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org, jolsa@kernel.org,
 peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 kan.liang@intel.com, ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
 <20170710131049.GA13471@gate.crashing.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5a0bee30-dd48-8cb1-df72-8175a26ccc4e@linux.intel.com>
Date: Mon, 10 Jul 2017 21:28:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170710131049.GA13471@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Following branch types should be common enough, right?

+	PERF_BR_COND		= 1,	/* conditional */
+	PERF_BR_UNCOND		= 2,	/* unconditional */
+	PERF_BR_IND		= 3,	/* indirect */
+	PERF_BR_CALL		= 4,	/* call */
+	PERF_BR_IND_CALL	= 5,	/* indirect call */
+	PERF_BR_RET		= 6,	/* return */

I decide to only define these types in this patch set. For other more 
arch-related branch type, we can add it in future.

Is this OK?

Thanks
Jin Yao

On 7/10/2017 9:10 PM, Segher Boessenkool wrote:
> Hi!
>
> On Mon, Jul 10, 2017 at 07:46:17PM +0800, Jin, Yao wrote:
>> 1. We all agree these definitions:
>>
>> +	PERF_BR_COND		= 1,	/* conditional */
>> +	PERF_BR_UNCOND		= 2,	/* unconditional */
>> +	PERF_BR_IND		= 3,	/* indirect */
>> +	PERF_BR_CALL		= 4,	/* call */
>> +	PERF_BR_IND_CALL	= 5,	/* indirect call */
>> +	PERF_BR_RET		= 6,	/* return */
>> +	PERF_BR_SYSCALL		= 7,	/* syscall */
>> +	PERF_BR_SYSRET		= 8,	/* syscall return */
>> +	PERF_BR_IRET		= 11,	/* return from interrupt */
> Do we?  It does not map very well to PowerPC branch types.
>
>> 2. I wish to keep following definitions for x86.
>>
>> +	PERF_BR_IRQ		= 9,	/* hw interrupt/trap/fault */
>> +	PERF_BR_INT		= 10,	/* sw interrupt */
>>
>> PERF_BR_INT is triggered by instruction "int" .
>> PERF_BR_IRQ is triggered by interrupts, traps, faults (the ring 0,3
>> transition).
> So your "PERF_BR_INT" is a system call?  And PERF_BR_IRQ is not an
> interrupt request (as its name suggests), not what we call an "external
> interrupt" either; instead it is every interrupt that is not a system
> call?
>
> It also does not follow the lines of "software caused interrupt" vs.
> the rest.
>
>> 4. I'd like to add following types for powerpc.
>>
>> 	PERF_BR_COND_CALL	/* Conditional call */
>> 	PERF_BR_COND_RET	/* Condition return */
> Almost all PowerPC branches have a "conditional" version (only "syscall"
> and "sysret/iret" do not -- and those last two are the same, just like
> PERF_BR_INT seems to be the same as PERF_BR_SYSCALL).
>
> So how should those PERF_BR_* be used?  It cannot be used in an
> architecture-neutral interface the way you define it now.
>
>
> Segher
