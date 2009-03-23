Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 226DEDDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 15:39:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18887.4715.765245.409925@drongo.ozlabs.ibm.com>
Date: Mon, 23 Mar 2009 15:39:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: davidastro <davidastro@hotmail.com>
Subject: Re: Fix for __div64_32 locks when using some 64 bit numbers
In-Reply-To: <22581509.post@talk.nabble.com>
References: <22567864.post@talk.nabble.com>
	<1237330984.25062.164.camel@pasglop>
	<22581509.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

davidastro <davidastro@hotmail.com> writes:

> Basically, the numbers shown above was causing the 64 by 32 bit algorithm to
> divide by zero making the unit spin and also giving incorrect results.
> Here is the code as it was before.
[snip]
>         cntlzw  r0,r5           # we are shifting the dividend right
>         li      r10,-1          # to make it < 2^32, and shifting
>         srw     r10,r10,r0      # the divisor right the same amount,
>         add     r9,r4,r10       # rounding up (so the estimate cannot
>         andc    r11,r6,r10      # ever be too large, only too small)
>         andc    r9,r9,r10      #THIS CODE COULD STORE A ZERO IN r9
>         or      r11,r5,r11
>         rotlw   r9,r9,r0
>         rotlw   r11,r11,r0

That bug was fixed in October 2005 in commit 344480b99730bfd2, and the
fix is in v2.6.15-rc1 and all later kernels.  I fixed it a bit
differently to your suggestion though - see

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=344480b99730bfd205e306d3fd168cdcebe83425

You must be working from an old kernel tree - which kernel version are
you using?

Paul.
