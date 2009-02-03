Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 637D0DDF6F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 05:59:36 +1100 (EST)
Date: Tue, 3 Feb 2009 21:59:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH v2] ftrace: On PowerPC we don't need frame pointers for
	CALLER_ADDRs
Message-ID: <20090203185933.GA9878@oksana.dev.rtsoft.ru>
References: <20090131190650.GA4284@oksana.dev.rtsoft.ru>
	<1233534919.18767.69.camel@pasglop>
	<1233583455.16878.3.camel@localhost.localdomain>
	<20090203145649.GA19955@oksana.dev.rtsoft.ru>
	<20090203160645.GA9020@elte.hu>
	<20090203161955.GA776@oksana.dev.rtsoft.ru>
	<1233678738.16878.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1233678738.16878.5.camel@localhost.localdomain>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 03, 2009 at 11:32:18AM -0500, Steven Rostedt wrote:
> 
> On Tue, 2009-02-03 at 19:19 +0300, Anton Vorontsov wrote:
> > On Tue, Feb 03, 2009 at 05:06:45PM +0100, Ingo Molnar wrote:
> 
> > [1] Btw, why exactly do we need the -fno-omit-frame-pointer for
> > "FUNCTION_TRCER" tracer? Why just -pg isn't sufficient?..
> > 
> 
> The problem is this that is in the toplevel Makefile:
> 
> 
> ifdef CONFIG_FRAME_POINTER
> KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> else
> KBUILD_CFLAGS	+= -fomit-frame-pointer
> endif
> 
> 
> -pg is incompatible with -fomit-frame-pointer

Ah...

$ gcc -pg -fomit-frame-pointer -S c.c
gcc: -pg and -fomit-frame-pointer are incompatible

It's hard-coded in gcc, in the code that don't know about
architecture details.

But on PowerPC -O1 implies -fomit-frame-pointer, that is

gcc -pg -O1 -fno-omit-frame-pointer
and
gcc -pg -O1

produce different outputs. Thus -pg -O should be the same
as "-pg -O -fomit-framepointer".

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
