Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426KGf1y5mzF3HT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 00:15:37 +1000 (AEST)
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sparse@vger.kernel.org
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
Date: Fri, 7 Sep 2018 16:15:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180907135817.GF24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/09/2018 à 15:58, Peter Zijlstra a écrit :
> On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
>>
>>
>> On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
>>> On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
>>>> On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
>>>> out of scope. The following sparse warning is encountered:
>>>>
>>>>     CHECK   arch/powerpc/kernel/process.c
>>>> ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
>>>
>>> Urgh... what compiler is that? I've not seen anything like that from the
>>> build bots.
>>>
>>
>> [root@pc16082vm linux-powerpc]# sparse --version
>> 0.5.2
>>
>> [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
>> ppc-linux-gcc (GCC) 5.4.0
> 
> Ah, that's a sparse warning. But does your GCC agree? The thing is,
> sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> and it all works fine.
> 

Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?

Anyway, is it really correct to put this constant inside that enum, 
after PERF_SAMPLE_MAX  ?

Christophe
