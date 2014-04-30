Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@kernel.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] powerpc/pseries: init fault_around_order for
 pseries
In-Reply-To: <20140429070632.GB27951@gmail.com>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com>
 <20140429070632.GB27951@gmail.com>
Date: Wed, 30 Apr 2014 16:34:11 +0930
Message-ID: <87d2fz47tg.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, riel@redhat.com, ak@linux.intel.com,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 mgorman@suse.de, Linus Torvalds <torvalds@linux-foundation.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ingo Molnar <mingo@kernel.org> writes:
> * Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Performance data for different FAULT_AROUND_ORDER values from 4 socket
>> Power7 system (128 Threads and 128GB memory). perf stat with repeat of 5
>> is used to get the stddev values. Test ran in v3.14 kernel (Baseline) and
>> v3.15-rc1 for different fault around order values.
>> 
>> FAULT_AROUND_ORDER      Baseline        1               3               4               5               8
>> 
>> Linux build (make -j64)
>> minor-faults            47,437,359      35,279,286      25,425,347      23,461,275      22,002,189      21,435,836
>> times in seconds        347.302528420   344.061588460   340.974022391   348.193508116   348.673900158   350.986543618
>>  stddev for time        ( +-  1.50% )   ( +-  0.73% )   ( +-  1.13% )   ( +-  1.01% )   ( +-  1.89% )   ( +-  1.55% )
>>  %chg time to baseline                  -0.9%           -1.8%           0.2%            0.39%           1.06%
>
> Probably too noisy.

A little, but 3 still looks like the winner.

>> Linux rebuild (make -j64)
>> minor-faults            941,552         718,319         486,625         440,124         410,510         397,416
>> times in seconds        30.569834718    31.219637539    31.319370649    31.434285472    31.972367174    31.443043580
>>  stddev for time        ( +-  1.07% )   ( +-  0.13% )   ( +-  0.43% )   ( +-  0.18% )   ( +-  0.95% )   ( +-  0.58% )
>>  %chg time to baseline                  2.1%            2.4%            2.8%            4.58%           2.85%
>
> Here it looks like a speedup. Optimal value: 5+.

No, lower time is better.  Baseline (no faultaround) wins.


etc.

It's not a huge surprise that a 64k page arch wants a smaller value than
a 4k system.  But I agree: I don't see much upside for FAO > 0, but I do
see downside.

Most extreme results:
Order 1: 2% loss on recompile.  10% win 4% loss on seq.  9% loss random.
Order 3: 2% loss on recompile.  6% win 5% loss on seq.  14% loss on random.
Order 4: 2.8% loss on recompile. 10% win 7% loss on seq.  9% loss on random.

> I'm starting to suspect that maybe workloads ought to be given a 
> choice in this matter, via madvise() or such.

I really don't think they'll be able to use it; it'll change far too
much with machine and kernel updates.  I think we should apply patch #1
(with fixes) to make it a variable, then set it to 0 for PPC.

Cheers,
Rusty.
