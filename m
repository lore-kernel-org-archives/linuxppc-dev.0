Return-Path: <fweisbec@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id 8A897DDE98
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 03:50:27 +1100 (EST)
Received: by fxm4 with SMTP id 4so3808507fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 08:50:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090204153643.GA16681@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150840.GC30027@oksana.dev.rtsoft.ru>
	<c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
	<20090204153643.GA16681@oksana.dev.rtsoft.ru>
Date: Wed, 4 Feb 2009 17:50:24 +0100
Message-ID: <c62985530902040850u5f9e7ca2w6ffbf553ec15eec5@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros should
	select FRAME_POINTER
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: avorontsov@ru.mvista.com, Steven Rostedt <srostedt@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/2/4 Steven Rostedt <srostedt@redhat.com>:
>
> >From ftrace.h:
>
> #ifdef CONFIG_FRAME_POINTER
> /* TODO: need to fix this for ARM */
> # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> # define CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
> # define CALLER_ADDR2 ((unsigned long)__builtin_return_address(2))
> # define CALLER_ADDR3 ((unsigned long)__builtin_return_address(3))
> # define CALLER_ADDR4 ((unsigned long)__builtin_return_address(4))
> # define CALLER_ADDR5 ((unsigned long)__builtin_return_address(5))
> # define CALLER_ADDR6 ((unsigned long)__builtin_return_address(6))
> #else
> # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> # define CALLER_ADDR1 0UL
> # define CALLER_ADDR2 0UL
> # define CALLER_ADDR3 0UL
> # define CALLER_ADDR4 0UL
> # define CALLER_ADDR5 0UL
> # define CALLER_ADDR6 0UL
> #endif
>
> Yep!
>

Ok.

2009/2/4 Anton Vorontsov <avorontsov@ru.mvista.com>:
> It depends on the architecture. On PowerPC we always have frame pointers,
> thus __builtin_return_address(1..) will always work. On x86 it won't work
> that way.
>
> Thanks,
>
> --
> Anton Vorontsov

Thanks for your answers!
