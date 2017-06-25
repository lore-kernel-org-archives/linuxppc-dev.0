Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwm176tlyzDqkx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 07:44:27 +1000 (AEST)
Date: Sun, 25 Jun 2017 16:44:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 4.6.3 miscompile on ppc32 (was Re: Regression in kernel
 4.12-rc1 for Powerpc 32 - bisected to commit 3448890c32c3)
Message-ID: <20170625214408.GT16550@gate.crashing.org>
References: <655d304e-e455-6e0c-56e1-f127653ea13c@lwfinger.net>
 <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
 <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
 <20170625095351.GU10672@ZenIV.linux.org.uk>
 <20170625111404.GV10672@ZenIV.linux.org.uk>
 <20170625205324.GW10672@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170625205324.GW10672@ZenIV.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 25, 2017 at 09:53:24PM +0100, Al Viro wrote:
> Confirmed.  It manages to bugger the loop immediately after the (successful)
> copying of iovec array in rw_copy_check_uvector(); both with and without
> INLINE_COPY_FROM_USER it has (just before the call of copy_from_user()) r27
> set to nr_segs * sizeof(struct iovec).  The call is made, we check that it
> has succeeded and that's when it hits the fan: without INLINE_COPY_FROM_USER
> we have (interleaved with unrelated insns)
>         addi 27,27,-8
>         srwi 27,27,3
>         addi 27,27,1
>         mtctr 27
> Weird, but manages to pass nr_segs to mtctr.

This weirdosity is https://gcc.gnu.org/PR67288 .  Those three instructions
are not the same as just  srwi 27,27,3  in case r27 is 0; GCC does not
figure out this cannot happen here.

> _With_ INLINE_COPY_FROM_USER we
> get this:
>         lis 9,0x2000
>         mtctr 9
> In other words, the loop will try to go through 8192 iterations.  No idea where
> that number has come from, but it sure as hell is wrong.

8192*65535, even.  This is as if r27 was 0 always.

Do you have a short stand-alone testcase?  4.6 is ancient, of course, but
the actual problem may still exist in more recent compilers (if it _is_
a compiler problem; if it's not, you *really* want to know :-) )


Segher
