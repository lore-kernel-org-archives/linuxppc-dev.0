Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by lists.ozlabs.org (Postfix) with ESMTP id 9223D1A0DFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:26:44 +1000 (AEST)
Message-ID: <55AE1E5D.5010904@hitachi.com>
Date: Tue, 21 Jul 2015 19:26:37 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: ananth@in.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kprobes: Mark OPTPROBES n/a for powerpc
References: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
 <55AB09BE.5040506@hitachi.com> <1437447187.30722.2.camel@ellerman.id.au>
 <20150721043416.GA4082@in.ibm.com>
In-Reply-To: <20150721043416.GA4082@in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/07/21 13:34, Ananth N Mavinakayanahalli wrote:
> On Tue, Jul 21, 2015 at 12:53:07PM +1000, Michael Ellerman wrote:
>> On Sun, 2015-07-19 at 11:21 +0900, Masami Hiramatsu wrote:
>>> On 2015/07/16 19:56, Ananth N Mavinakayanahalli wrote:
>>>> Kprobes uses a breakpoint instruction to trap into execution flow
>>>> and the probed instruction is single-stepped from an alternate location.
>>>>
>>>> On some architectures like x86, under certain conditions, the OPTPROBES
>>>> feature enables replacing the probed instruction with a jump instead,
>>>> resulting in a significant perfomance boost (one single-step exception
>>>> is bypassed for each kprobe).
>>>
>>> The OPTPROBE is not only for bypassing the single-step exception, but also
>>> the breakpoint exception.
>>> Please see commit 0dc016dbd820260b (ARM: kprobes: enable OPTPROBES for ARM 32) too,
>>> which shows how it is done on RISC processor.
>>>
>>>> Powerpc has an in-kernel instruction emulator. Kprobes on powerpc uses
>>>> this emulator already and bypasses the single-step exception, with a
>>>> lot less complexity.
>>>
>>> So, this might miss the point. Since it is impossible to do on some RISC
>>> processor, I agree with this change, but it should be committed with
>>> correct comments.
>>
>> I don't think it's impossible on powerpc.
>>
>> So we should leave it as a TODO for now.
> 
> OK. I put it on my TODO list.

I see, thanks Ananth! :)


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
