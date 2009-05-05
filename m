Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49A36DDE07
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 23:46:10 +1000 (EST)
In-Reply-To: <1241530382.11379.12.camel@localhost.localdomain>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
	<20090502001421.GA9342@oksana.dev.rtsoft.ru>
	<68B2EF73-0FD2-41F9-966B-9A54965AFBA6@kernel.crashing.org>
	<1241316249.4243.22.camel@localhost.localdomain>
	<6A6BE346-925C-4F73-ABFA-C6110070F071@kernel.crashing.org>
	<1241530382.11379.12.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <299D7402-29D3-4602-8F42-58FDF034DEC5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Date: Tue, 5 May 2009 15:51:48 +0200
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

>>> When we add "-pg" to gcc, it automatically causes frame pointers  
>>> to be
>>> used.
>>
>> Nope, it does no such thing.
>
> Well, mcount is expected to be able to get to not just who called
> mcount, but also the parent of that function. The way mcount is
> implemented does not let you do that. If mcount was the first thing to
> be called in a function, then it would have been perfect. We could get
> to the caller, its parent, and even the parameters. But unfortunately,
> mcount is called after the stack is set up. Thus, without frame  
> pointers
> (the way to find a previous frame) there's no way (on some archs) to
> find the parent. Nor can we figure out the parameters, which really
> sucks.

Yes, and this is (supposedly) why GCC does not like seeing -pg and
-fomit-frame-pointer at the same time -- because that cannot work
*on some architectures*.  These are the same architectures that
do not enable -fomit-frame-pointer automatically at -O.

>> NO_NO_OMIT_FRAME_POINTER ?  Or better, just never use -fno-o-f-p,
>> I don't see why you would ever need it.
>
> Because on x86_64 it gives better back traces. x86_64 has no way to  
> get
> to the previous frames without it. There's code to use other debug
> metadata to get back tracing, but for uses of things like the stack
> tracer, we need to be able to use the actual stack frames.
>
> As you said above, -fomit-frame-pointer is default when we  
> optimize, and
> that is how the kernel is built. If we optimize on x86_64 and do  
> not use
> -fno-omit-frame-pointer, the stack tracer is useless.

No.  -fomit-frame-pointer is only the default when optimising on
archs/ABIs where it doesn't hinder debugging and -pg and all that
goodness; specifically, you do not get it by default on x86, not
at any optimisation level.


Segher
