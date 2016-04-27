Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvvxx5lC4zDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:37:25 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qvvxx2Z5Mz9t50
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2016 19:37:25 +1000 (AEST)
Date: Wed, 27 Apr 2016 11:37:20 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Balbir Singh <bsingharora@gmail.com>
cc: Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Vojtech Pavlik <vojtech@suse.com>, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Torsten Duwe <duwe@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nikolay Borisov <kernel@kyup.com>
Subject: Re: [PATCH v2] livepatch: Add some basic LivePatch documentation
In-Reply-To: <571F3A7C.5050701@gmail.com>
Message-ID: <alpine.LNX.2.00.1604271120480.3836@pobox.suse.cz>
References: <1461597275-32120-1-git-send-email-pmladek@suse.com>
 <571F3A7C.5050701@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Apr 2016, Balbir Singh wrote:

> > +  + Anything inlined into __schedule() can not be patched.
> > +
> > +    The switch_to macro is inlined into __schedule(). It switches the
> > +    context between two processes in the middle of the macro. It does
> > +    not save RIP in x86_64 version (contrary to 32-bit version). Instead,
> > +    the currently used __schedule()/switch_to() handles both processes.
> > +
> > +    Now, let's have two different tasks. One calls the original
> > +    __schedule(), its registers are stored in a defined order and it
> > +    goes to sleep in the switch_to macro and some other task is restored
> > +    using the original __schedule(). Then there is the second task which
> > +    calls patched__schedule(), it goes to sleep there and the first task
> > +    is picked by the patched__schedule(). Its RSP is restored and now
> > +    the registers should be restored as well. But the order is different
> > +    in the new patched__schedule(), so...
> > +
> > +    There is a work in progress to remove this limitation.
> > +
> 
> I am afraid the example requires more clarification. I don't quite get the order is different

Different order is not inevitable but perfectly possible (even probable). 
GCC may simply generate different object code for patched__schedule() than 
it did for __schedule(). The problem is when the prologue and epilogue are 
different.

Miroslav
