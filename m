Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6E05A67B1B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 02:50:07 +1000 (EST)
Date: Fri, 26 May 2006 09:49:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: mel@csn.ul.ie (Mel Gorman)
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
Message-Id: <20060526094924.10efc515.akpm@osdl.org>
In-Reply-To: <20060526151214.GA5190@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mel@csn.ul.ie (Mel Gorman) wrote:
>
> (Resending with Andrew's email address correct this time)
> 
>  For the last few -mm releases, kernels built for an old RS6000 failed to
>  compile with the message;
> 
>  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function `vrsqrtefp':
>  : undefined reference to `__udivdi3'
>  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function `vrsqrtefp':
>  : undefined reference to `__udivdi3'
>  make: *** [.tmp_vmlinux1] Error 1

A function with a name like that doesn't _deserve_ to compile.

But actually vrsqrtefp() doesn't call __udivdi3 - the error lies somewhere
else in the kernel and the toolchain gets it wrong, so we don't know where.

The way I usually hunt this problem down is to build the .s files (make
arch/powerpc/kernel/foo.s) and then grep around, find the offending C
function.

If the problem is specific to powerpc then a

	diffstat 2.6.17.rc4-mm3 | grep powerpc

will narrow down the number of files to be searched by rather a lot.

>  2.6.17-rc5 is not affected but I didn't search for the culprit patch in
>  -mm. The following patch adds an implementation of __udivdi3 for plain old
>  ppc32. This may not be the correct fix as Google tells me that __udivdi3
>  has been replaced by calls to do_div() in a number of cases. There was no
>  obvious way to do that for vrsqrtefp, hence this workaround. The patch should
>  be acked, rejected or replaced by a ppc expert.

Yes, we've traditionally avoided adding the 64-bit divide library functions.
