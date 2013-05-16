Return-Path: <eranian@google.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 610CE2C00E1
 for <linuxppc-dev@ozlabs.org>; Fri, 17 May 2013 01:36:14 +1000 (EST)
Received: by mail-ob0-f181.google.com with SMTP id dn14so3548757obc.26
 for <linuxppc-dev@ozlabs.org>; Thu, 16 May 2013 08:36:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130516111634.GA15314@twins.programming.kicks-ass.net>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
 <8578.1368699317@ale.ozlabs.ibm.com>
 <20130516111634.GA15314@twins.programming.kicks-ass.net>
Date: Thu, 16 May 2013 17:36:11 +0200
Message-ID: <CABPqkBSCXJN7gLK_e_Q3YVVVFVGS78fo4j2z0+MmriqoXszH+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf, x86,
 lbr: Demand proper privileges for PERF_SAMPLE_BRANCH_KERNEL
From: Stephane Eranian <eranian@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 16, 2013 at 1:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 16, 2013 at 08:15:17PM +1000, Michael Neuling wrote:
>> Peter,
>>
>> BTW PowerPC also has the ability to filter on conditional branches.  Any
>> chance we could add something like the follow to perf also?
>>
>
> I don't see an immediate problem with that except that we on x86 need to
> implement that in the software filter. Stephane do you see any
> fundamental issue with that?
>
On X86, the LBR cannot filter on conditional in HW. Thus as Peter said, it would
have to be done in SW. I did not add that because I think those branches are
not necessarily useful for tools.

>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index fb104e5..891c769 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -157,8 +157,9 @@ enum perf_branch_sample_type {
>>       PERF_SAMPLE_BRANCH_ANY_CALL     = 1U << 4, /* any call branch */
>>       PERF_SAMPLE_BRANCH_ANY_RETURN   = 1U << 5, /* any return branch */
>>       PERF_SAMPLE_BRANCH_IND_CALL     = 1U << 6, /* indirect calls */
>> +     PERF_SAMPLE_BRANCH_CONDITIONAL  = 1U << 7, /* conditional branches */
>>
>> -     PERF_SAMPLE_BRANCH_MAX          = 1U << 7, /* non-ABI */
>> +     PERF_SAMPLE_BRANCH_MAX          = 1U << 8, /* non-ABI */
>>  };
>>
>>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index cdf58ec..5b0b89d 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -676,6 +676,7 @@ static const struct branch_mode branch_modes[] = {
>>       BRANCH_OPT("any_call", PERF_SAMPLE_BRANCH_ANY_CALL),
>>       BRANCH_OPT("any_ret", PERF_SAMPLE_BRANCH_ANY_RETURN),
>>       BRANCH_OPT("ind_call", PERF_SAMPLE_BRANCH_IND_CALL),
>> +     BRANCH_OPT("cnd", PERF_SAMPLE_BRANCH_CONDITIONAL),
>>       BRANCH_END
>>  };
>>
