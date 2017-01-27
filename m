Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v953m4083zDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 04:13:56 +1100 (AEDT)
Date: Fri, 27 Jan 2017 11:13:46 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20170127171346.o7wuvycriajdpixc@treble>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <dfe1419dc06f37e1f4aec5bf81d5b60e505a8d0f.1484839971.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1701270943420.1563@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1701270943420.1563@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 27, 2017 at 09:47:08AM +0100, Miroslav Benes wrote:
> 
> > diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> > index 0a34489..8e8b67b 100644
> > --- a/include/linux/stacktrace.h
> > +++ b/include/linux/stacktrace.h
> > @@ -18,6 +18,8 @@ extern void save_stack_trace_regs(struct pt_regs *regs,
> >  				  struct stack_trace *trace);
> >  extern void save_stack_trace_tsk(struct task_struct *tsk,
> >  				struct stack_trace *trace);
> > +extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> > +					 struct stack_trace *trace);
> >  
> >  extern void print_stack_trace(struct stack_trace *trace, int spaces);
> >  extern int snprint_stack_trace(char *buf, size_t size,
> > @@ -29,12 +31,12 @@ extern void save_stack_trace_user(struct stack_trace *trace);
> >  # define save_stack_trace_user(trace)              do { } while (0)
> >  #endif
> >  
> > -#else
> > +#else /* !CONFIG_STACKTRACE */
> >  # define save_stack_trace(trace)			do { } while (0)
> >  # define save_stack_trace_tsk(tsk, trace)		do { } while (0)
> >  # define save_stack_trace_user(trace)			do { } while (0)
> >  # define print_stack_trace(trace, spaces)		do { } while (0)
> >  # define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
> 
> Is there a reason you did not define empty save_stack_trace_tsk_reliable() 
> here? Right, it should not be needed now as livepatching is the only user, 
> but still.

Agreed, thanks.  I'll make the stub return an error, since an empty
stack trace isn't very reliable.

-- 
Josh
