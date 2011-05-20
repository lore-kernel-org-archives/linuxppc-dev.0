Return-Path: <richardcochran@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 477E1B71A1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 00:33:10 +1000 (EST)
Received: by fxm1 with SMTP id 1so3191869fxm.15
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 07:33:06 -0700 (PDT)
Date: Fri, 20 May 2011 16:32:59 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20110520143259.GB5785@riccoc20.at.omicron.at>
References: <1305777978.7481.37.camel@pasglop>
	<20110520132328.GA5785@riccoc20.at.omicron.at>
	<20110520135845.GG25179@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110520135845.GG25179@zod.rchland.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 20, 2011 at 09:58:45AM -0400, Josh Boyer wrote:
> On Fri, May 20, 2011 at 03:23:29PM +0200, Richard Cochran wrote:
> >When I try to build 'next' (now at 208b3a4c), it does not compile due
> >to a change from the following commit.
> >
> >> Benjamin Herrenschmidt (1):
> >>       powerpc/smp: Make start_secondary_resume available to all CPU variants
> >
> >I would appreciate your help in getting this fixed...
> 
> Could you try the patch below?

Yes, and it both compiles and boots.

Thanks,
Richard

> 
> Commit 69e3cea8d5fd526 introduced start_secondary_resume to misc_32.S,
> however it uses a 64-bit instruction which is not valid on 32-bit
> platforms.  Use 'stw' instead.
> 
> Reported-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
> 
> diff --git a/arch/powerpc/kernel/misc_32.S
> b/arch/powerpc/kernel/misc_32.S
> index 402560e..998a100 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -700,7 +700,7 @@ _GLOBAL(start_secondary_resume)
> 	rlwinm  r1,r1,0,0,(31-THREAD_SHIFT)     /* current_thread_info() */
> 	addi    r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
> 	li      r3,0
> -	std     r3,0(r1)                /* Zero the stack frame pointer */
> +	stw     r3,0(r1)                /* Zero the stack frame pointer */
> 	bl      start_secondary
> 	b       .
>  #endif /* CONFIG_SMP */
> 
