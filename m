Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E76A61A2B48
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 21:35:37 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEBF9140161
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 21:35:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 20:35:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BAA552BB0040
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 21:35:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NAZOmO16318664
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 21:35:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NAYvtY003227
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 21:34:58 +1100
Message-ID: <550FEC36.8080803@linux.vnet.ibm.com>
Date: Mon, 23 Mar 2015 16:04:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com> <548578A8.5020901@linux.vnet.ibm.com>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
 <1426718702.4866.2.camel@neuling.org> <1426719027.4866.4.camel@neuling.org>
In-Reply-To: <1426719027.4866.4.camel@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 peterz@infradead.org, palves@redhat.com,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 shuahkh@osg.samsung.com, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, davem@davemloft.net, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/19/2015 04:20 AM, Michael Neuling wrote:
> On Thu, 2015-03-19 at 09:45 +1100, Michael Neuling wrote:
>> On Wed, 2015-03-18 at 13:53 +0100, Ulrich Weigand wrote:
>>> Michael Neuling <mikey@neuling.org> wrote on 23.02.2015 05:51:50:
>>>
>>>> Sorry for the slow response.
>>>
>>> Same here :-(
>>
>> I'm going to break the cycle and respond in a few hours :-)
>>
>>
>>>> I think what you're proposing with running the inferior function in
>>>> suspend mode may end up corrupting the stack in this way.  You'd need to
>>>> be really careful to make sure the inferior function is run on the stack
>>>> pointer of the checkpointed registers.
>>>
>>> On the other hand, if code called a subroutine after the tbegin, if we
>>> were using the checkpointed r1, this might corrupt the stack of the
>>> transactional code.  (This code will never actually *run* again since
>>> the transaction is doomed, but we can still *inspect* it in GDB after
>>> the inferior call has returned, so the stack should remain unchanged.
>>> Well .. if the transaction is suspended, the code might in fact still
>>> run, so it should remain unchanged either way.)
>>>
>>> I guess we could use the minimum of transactional and checkpointed r1
>>> in that case, to be safe either way.
>>
>> Sounds good.
>>
>> <snip>
>>
>>>>> Using the combination of (A)+(A') would be easiest to implement
>>>>> in GDB without modifying a lot of common code, and would have the
>>>>> advantage that the inferior function always executes in the same
>>>>> state (suspended), while leaving information about the interrupted
>>>>> transaction visible.
>>>>>
>>>>> Using the combination of (B)+(B') would be a bit more difficult
>>>>> to implement (but certainly feasible), and would have the advantage
>>>>> that the inferior function always executes in nontransactional state
>>>>> (which is what it would most likely expect, anyway).  However, the
>>>>> disadvantage is that after the inferior call returns, GDB is unable
>>>>> to fully restore the visible inferior state as it was before (since
>>>>> we're now in nontransactional state, and there is probably no way
>>>>> to force us back into transactional/suspended state ...).
>>>>
>>>> Yep.
>>>
>>> So right now I'd tend to prefer (A)+(A'), but the important thing is
>>> that the kernel seems to provide all features required for GDB to
>>> implement any of the above, so we can still make that decision later.
>>>
>>>> Getting back to the kernel interface, are you happy with what Anshuman
>>>> has proposed in the current series?
>>>
>>> Given the discussion above, this seems fine to me now.
>>
>> Great, we'll push through with this in mind.
> 
> Anshuman,
> 
> With that in mind, do we have a way to set the top 32bits of the MSR
> (which contain the TM bits) when ptracing 32 bit processes?  I can't
> find anything like that in this patch set.

No, we dont have that yet. When ptracing in 32-bit mode the MSR value
which can be viewed or set from the user space through PTRACE_GETREGS
PTRACE_SETREGS call is it's lower 32 bits only. Either we can club
the upper 32 bits of MSR as part of one of the ELF core notes we are
adding in the patch series or we can create one more separate ELF core
note for that purpose. Let me know your opinion on this.
