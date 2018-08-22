Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wL6j0GTkzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 18:19:08 +1000 (AEST)
Subject: Re: Odd SIGSEGV issue introduced by commit 6b31d5955cb29 ("mm, oom:
 fix potential data corruption when oom_reaper races with writer")
To: Ram Pai <linuxram@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>
References: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
 <871sasmddc.fsf@concordia.ellerman.id.au>
 <20180821175049.GA5905@ram.oc3035372033.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <633145ae-162c-9e03-6e8d-7442cbc8356c@c-s.fr>
Date: Wed, 22 Aug 2018 10:19:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180821175049.GA5905@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/08/2018 à 19:50, Ram Pai a écrit :
> On Tue, Aug 21, 2018 at 04:40:15PM +1000, Michael Ellerman wrote:
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> ...
>>>
>>> And I bisected its disappearance with commit 99cd1302327a2 ("powerpc:
>>> Deliver SEGV signal on pkey violation")
>>
>> Whoa that's weird.
>>
>>> Looking at those two commits, especially the one which makes it
>>> dissapear, I'm quite sceptic. Any idea on what could be the cause and/or
>>> how to investigate further ?
>>
>> Are you sure it's not some corruption that just happens to be masked by
>> that commit? I can't see anything in that commit that could explain that
>> change in behaviour.
>>
>> The only real change is if you're hitting DSISR_KEYFAULT isn't it?
> 
> even with the 'commit 99cd1302327a2', a SEGV signal should get generated;
> which should kill the process. Unless the process handles SEGV signals
> with SEGV_PKUERR differently.

No, the sigsegv are not handled differently. And the trace shown it is 
SEGV_MAPERR which is generated.

> 
> The other surprising thing is, why is DSISR_KEYFAULT getting generated
> in the first place?  Are keys somehow getting programmed into the HPTE?

Can't be that, because DSISR_KEYFAULT is filtered out when applying 
DSISR_SRR1_MATCH_32S mask.

> 
> Feels like some random corruption.

In a way yes, except that it is always at the same instruction (in 
ld.so) and always because the accessed address is 0x67xxxxxx instead of 
0x77xxxxxx
I also tested with TASK_SIZE set to 0xa0000000 instead of 0x80000000, 
and I get same failure with bad address being 0x87xxxxxx instead of 
0x97xxxxxx

Christophe

> 
> Is this behavior seen with power8 or power9?
> 
> RP
> 
