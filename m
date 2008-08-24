Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	by ozlabs.org (Postfix) with ESMTP id A421BDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 01:00:52 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Random crashes with 2.6.27-rc3 on PPC
Date: Sun, 24 Aug 2008 17:00:22 +0200
References: <200808231610.46473.mb@bu3sch.de> <200808241544.12412.mb@bu3sch.de>
	<je7ia6bhdd.fsf@sykes.suse.de>
In-Reply-To: <je7ia6bhdd.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808241700.22815.mb@bu3sch.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 24 August 2008 16:46:38 Andreas Schwab wrote:
> Michael Buesch <mb@bu3sch.de> writes:
> 
> > The following workaround seems to fix the crashes on powerpc.
> > However, this patch is clearly not what we want for other architectures,
> > as they might need -fno-omit-frame-pointer to function properly.
> 
> This has a better chance to be accepted. :-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 8b5a7d3..f9a2e48 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -394,7 +394,7 @@ config LOCKDEP
>  	bool
>  	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
>  	select STACKTRACE
> -	select FRAME_POINTER if !X86 && !MIPS
> +	select FRAME_POINTER if !X86 && !MIPS && !PPC
>  	select KALLSYMS
>  	select KALLSYMS_ALL

This is not what my patch is doing.
Your patch always forces FRAME_POINTER off. At least as far as lockdep is concerned.
What about other parts of the kernel that enable FRAME_POINTER?

I think this should be fixed in the makefile by substitution of
-fno-omit-frame-pointer on PPC (and probably depending on the compiler
version).

Otherwise, if somebody else decides to do select FRAME_POINTER in some other
code, the bug will reappear.
I'm also not sure if it's desired to always force FRAME_POINTER off.

-- 
Greetings Michael.
