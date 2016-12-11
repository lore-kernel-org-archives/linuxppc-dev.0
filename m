Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tbqCG6Nm3zDvk4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Dec 2016 13:08:58 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 3so6667870pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 18:08:58 -0800 (PST)
Subject: Re: [PATCH v3 00/15] livepatch: hybrid consistency model
To: Josh Poimboeuf <jpoimboe@redhat.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <1481348777.28041.1.camel@gmail.com> <20161210171707.cpupmxyuhob4tc3i@treble>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@kernel.org>, live-patching@vger.kernel.org,
 Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Chris J Arges <chris.j.arges@canonical.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <aac5fa04-c15c-5210-bce7-c72e16373964@gmail.com>
Date: Sun, 11 Dec 2016 13:08:33 +1100
MIME-Version: 1.0
In-Reply-To: <20161210171707.cpupmxyuhob4tc3i@treble>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/12/16 04:17, Josh Poimboeuf wrote:
> On Sat, Dec 10, 2016 at 04:46:17PM +1100, Balbir Singh wrote:
>> On Thu, 2016-12-08 at 12:08 -0600, Josh Poimboeuf wrote:
>>> Dusting the cobwebs off the consistency model again.  This is based on
>>> linux-next/master.
>>>  
>>> v1 was posted on 2015-02-09:
>>>  
>>>   https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com
>>>  
>>> v2 was posted on 2016-04-28:
>>>  
>>>   https://lkml.kernel.org/r/cover.1461875890.git.jpoimboe@redhat.com
>>>  
>>> The biggest issue from v2 was finding a decent way to detect preemption
>>> and page faults on the stack of a sleeping task.  
>>
>> Could you please elaborate on this? Preemption of a sleeping task and
>> faults as in the future (time) preemption and faults?
> 
> The normal way for a task to go to sleep is to call schedule().  objtool
> ensures the stack trace is reliable in that case, by making sure that
> all functions save the frame pointer on the stack before calling out to
> another function.
> 
> But a task can also go to sleep in a few other ways.  One way is by
> preemption, where an interrupt handler interrupts the task and calls
> preempt_schedule_irq().

It's preempted, not sleeping. It's on_rq but not on_cpu.

  Another way is by a page fault exception.  In
> both cases, there's no guarantee that the interrupted function saved the
> frame pointer on the stack beforehand.  So the stack trace might be
> unreliable.  Fortunately, interrupts and exceptions leave evidence
> behind on the stack.  So when walking the stack of a sleeping task, we
> can detect when an IRQ or exception occurred, and consider such a stack
> unreliable.
> 

Thanks for the explanation. I presume a whole lot of this is arch specific
code? I'll look at the patches as well

Balbir
