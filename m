Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Jul 2013 23:58:10 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
Message-ID: <20130723135809.GG31944@concordia>
References: <51ECD91D.7090903@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51ECD91D.7090903@asianux.com>
Cc: Michael Neuling <mikey@neuling.org>, "paulus@samba.org" <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jovi.zhangwei@huawei.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 03:02:53PM +0800, Chen Gang wrote:
> Hello Maintainers:
> 
> With allmodconfig and EXTRA_CFLAGS=-W", it reports warnings below:

> 
> arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
> arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]

In both these cases we are inside the body of a for loop and we do a
if (setjmp) / else block. Although looking at the source the value of i
is not modified by the setjmp, I guess it's possible that the compiler
might reorder the increment of i inside the setjmp and loose the value
when we longjmp.

> arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]

This one I can't see, but I assume it's a similar case.

> Excuse me, I am not quite sure about it whether can cause issue or not.

I've never seen it get stuck in those loops or anything, but I guess
it's possible.

The first thing to do would be to analyse the generated assembler code
to determine if there really is any possiblity of the value being
clobbered, or if it's just a theoretical bug.

cheers
