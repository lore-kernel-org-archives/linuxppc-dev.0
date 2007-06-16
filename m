Return-Path: <SRS0+5a82b16ffd545f977f24+1392+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2159BDDE3C
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 04:20:58 +1000 (EST)
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
In-Reply-To: <1181992681.25228.683.camel@pmac.infradead.org>
References: <1181992681.25228.683.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 19:20:44 +0100
Message-Id: <1182018044.2808.75.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-16 at 12:18 +0100, David Woodhouse wrote:
> Every time I build a ppc kernel it bitches at me that
> sys_sync_file_range is unimplemented. Shut it up...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> ---
> The compat bit is untested although the assembly looks right, when
> compared with 32-bit calls to sys_sync_file_range(). Test kernel
> building now, although I leave for the airport within 24 hours and may
> not get round to actually testing it. 

+asmlinkage long compat_sys_sync_file_range(int fd, int dummy,
+                                  unsigned offset_hi, unsigned offset_lo,
+                                  unsigned nbytes_hi, unsigned nbytes_lo,
+                                  int flags)

Pants. It doesn't work because the 'flags' argument ends up in r9, and
we can only use r3-r8 for syscall arguments. We'll need to do it the
same way as ARM does, with the flags as the second argument.

I _wish_ people would remember that not all the world's an i386 when
they add new syscalls.

And I wish Linus would refuse to merge anything which just says "I wired
it up on i386" without even thinking about 32-on-64 compatibility.
Once we've merged it, it's too late to change the ABI to be sane.

Or is it? Can we ditch sys_sync_file_range now and implement a new
sys_sync_file_range2 with the two 32-bit arguments first?

-- 
dwmw2
