Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 98FFBDDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 00:03:39 +1000 (EST)
Received: by gxk14 with SMTP id 14so7992897gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 07:03:38 -0700 (PDT)
Date: Fri, 26 Sep 2008 10:02:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Cleanup 32/64 bit syscall int sign ext.
Message-ID: <20080926140228.GA5687@yoda.jdub.homelinux.org>
References: <1222326096.8277.178.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1222326096.8277.178.camel@pasglop>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 05:01:36PM +1000, Benjamin Herrenschmidt wrote:
>I noticed that our ABI says callers are responsible for sign extending.
>That means that all int, long or similarly signed arguments to syscalls
>must be explicitly sign-extended.
>
>We already have wrappers to do that for -some- syscalls in arch code.
>Those are in C and pretty ugly, copy/pasting a bunch of identically
>useless comments all over, and are missing a lot of potential
>candidates.
>
>sparc64 uses a nicer macro system to generate trampolines in asm. It
>also has a more complete list. But it's also missing some :-)
>
>Now, there is a good point to be made that we don't absolutely need to
>always sign extend. In many cases, the called function will just do a
>cmplw for example, or an and to test bits in flags, and so it looks like
>sign extension is not necessary. One could say that sign extending file
>descriptors for example isn't terribly useful
>
>But that sounds like a fragile approach to me. We don't know for sure
>what new tricks the compiler will learn for example. In fact, when
>taking the sparc64 list, I noticed that in some cases it -did- already
>sign extend file descriptors and flags .. and in some cases not.
>
>So I've spent a few hours combing through all of syscalls.h (and one
>more that seems to be missing from this file, ie, pipe2, there may be
>others) for anything using int, long or pid_t (which is signed, at least
>on our 32-bit platforms).

You might want to look at functions that take clockid_t as well.  It's also
a signed int.  We recently ran into a case of this for clock_getres on ppc64
using a 32-bit glibc.  Albiet, on a quite old kernel but looking at it briefly
it seems to still be an issue, so probably worth fixing.

josh
