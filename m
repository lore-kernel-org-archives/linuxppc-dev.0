Date: Mon, 17 Jan 2000 16:23:26 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000117232325.ZM16866@saguaro.lan>
In-Reply-To: "D.J. Barrow" <barrow_dj@yahoo.com>
        "regarding gdb stack trace problems in mozilla etc." (Jan 17,  1:35pm)
References: <20000117213543.25985.qmail@web205.mail.yahoo.com>
To: "D.J. Barrow" <barrow_dj@yahoo.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: regarding gdb stack trace problems in mozilla etc.
Cc: Sean Chitwood <darkmane@w-link.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 17,  1:35pm, D.J. Barrow wrote:

> Some mozilla developer was asking about gdb not
> displaying stack traces properly in mozilla. The most
> common reason for this is compiling -g with
> optimisation ( -O2 or whatever ), when compiling -O2
> gcc doesn't copy register parameters to the stack,
> this means that the stack backtrace will not work & if
> you view one of the parameters passed into the
> function it will be incorrect as soon as the register
> is reused.
> 
> To avoid this just compile as much of the code as
> possible without optimisation, you may not be able to
> compile it all without optimisation in mozilla as
> inline functions will not work compile without
> optimisation

D.J.,

You give sound advice.  Normally, when gdb is giving me strange
results for values of parameters and whatnot, I do exactly as you
suggest.

In the case that you're referring to however, gdb is giving incorrect
information about the line number being called from.  The person
reporting the bug (Sean Chitwood) states that the line number refers
to a closing curly brace and that often times the curly brace being
referred to doesn't even below to the calling function!

This looks like a bug that I worked on for several weeks last fall. 
In a nutshell, the linker is creating shared objects with zero-valued
N_FUN symbols.  gdb had/has a mechanism for resolving the symbols
under these circumstances, but there were some problems with the code. 
You can find a detailed analysis of the problem at

    http://sourceware.cygnus.com/ml/gdb/1999-q3/msg00325.html

If you read the above analysis, you'll see a proposed patch at the end
of the message.  This patch made its way into the current gdb source
tree with few (if any) changes.  I'm not sure it'll apply cleanly to
the gdb-4.18 sources though.  If it doesn't, I have another one that
might work better.  (The fix is the same, but the diff was taken
relative to something which might be closer to 4.18.)

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
