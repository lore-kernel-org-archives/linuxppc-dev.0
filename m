Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46E7FDDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 00:46:47 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: Random crashes with 2.6.27-rc3 on PPC
References: <200808231610.46473.mb@bu3sch.de>
	<1219531969.21386.205.camel@pasglop> <200808241544.12412.mb@bu3sch.de>
Date: Sun, 24 Aug 2008 16:46:38 +0200
In-Reply-To: <200808241544.12412.mb@bu3sch.de> (Michael Buesch's message of
	"Sun, 24 Aug 2008 15:44:11 +0200")
Message-ID: <je7ia6bhdd.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Michael Buesch <mb@bu3sch.de> writes:

> The following workaround seems to fix the crashes on powerpc.
> However, this patch is clearly not what we want for other architectures,
> as they might need -fno-omit-frame-pointer to function properly.

This has a better chance to be accepted. :-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8b5a7d3..f9a2e48 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -394,7 +394,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !X86 && !MIPS
+	select FRAME_POINTER if !X86 && !MIPS && !PPC
 	select KALLSYMS
 	select KALLSYMS_ALL
 

> Index: linux-2.6/kernel/Makefile
> ===================================================================
> --- linux-2.6.orig/kernel/Makefile	2008-08-24 11:50:23.000000000 +0200
> +++ linux-2.6/kernel/Makefile	2008-08-24 12:15:54.000000000 +0200
> @@ -92,13 +92,13 @@ obj-$(CONFIG_SMP) += sched_cpupri.o
>  ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
>  # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
>  # needed for x86 only.  Why this used to be enabled for all architectures is beyond
>  # me.  I suspect most platforms don't need this, but until we know that for sure
>  # I turn this off for IA-64 only.  Andreas Schwab says it's also needed on m68k
>  # to get a correct value for the wait-channel (WCHAN in ps). --davidm
> -CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
> +CFLAGS_sched.o := $(PROFILING)

CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER is already enabled on powerpc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
