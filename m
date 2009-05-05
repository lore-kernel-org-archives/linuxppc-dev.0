Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80462DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 17:51:23 +1000 (EST)
In-Reply-To: <1241316249.4243.22.camel@localhost.localdomain>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
	<20090502001421.GA9342@oksana.dev.rtsoft.ru>
	<68B2EF73-0FD2-41F9-966B-9A54965AFBA6@kernel.crashing.org>
	<1241316249.4243.22.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6A6BE346-925C-4F73-ABFA-C6110070F071@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Date: Tue, 5 May 2009 09:56:02 +0200
To: Steven Rostedt <srostedt@redhat.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yeah, I agree. This needs a better description. I only know what's  
> going
> on because I was there for the start of the discussion.
>
> But just to be sure, this is what I think is happening.
>
> When we add "-pg" to gcc, it automatically causes frame pointers to be
> used.

Nope, it does no such thing.

> But with PPC, it always has frame pointers and there's no problem.

Well, what do you call a "frame pointer"?  In the general meaning
of "some register that points to the incoming function arguments
and the function local variables", PowerPC can _usually_ use GPR1,
the stack pointer (and indeed it is called "stack frame pointer"
in the ABI).  In the more narrow meaning of "what GCC calls the
frame pointer", "the thing that -fomit-frame-pointer optimises
away" -- on PowerPC (and many other targets), -fomit-frame-pointer
is the *default* when optimisation is enabled!

There is a GCC bug here though: it won't allow both -pg and
-fomit-frame-pointer be set at the command line at the same time,
even on targets where that is not problematic.

> But with Linux, when you add CONFIG_FRAME_POINTER, it automatically
> adds:  -fno-omit-frame-pointer. Thus the config will add
> "-fomit-frame-pointer" when CONFIG_FRAME_POINTER is not set, or it  
> will
> add "-fno-omit-frame-pointer" when it is set.
>
> The problem with PPC is that "-fno-omit-frame-pointer" is buggy and
> causes gcc to produce bad code.

It's a deeper problem that is only _exposed_ by -fno-o-f-p (and can be
hidden by -mno-sched-epilog in the one spot where it hit us).

> Perhaps a better name would be:
>
> HAVE_FRAME_POINTER_AS_DEFAULT

NO_NO_OMIT_FRAME_POINTER ?  Or better, just never use -fno-o-f-p,
I don't see why you would ever need it.


Segher
