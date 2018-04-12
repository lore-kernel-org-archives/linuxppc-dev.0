Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MSP05RQvzF1S5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 03:21:07 +1000 (AEST)
Date: Thu, 12 Apr 2018 18:20:52 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Dmitry V. Levin" <ldv@altlinux.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412172051.GK16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2018 at 09:50:26AM -0700, Linus Torvalds wrote:
> Does this attached patch perhaps fix the ARM case?
> 
> It just uses FPE_FLTUNK as the default si_code for SIGFPE, which seems
> sane enough. And then gets rid of FPE_FIXME, which should resolve the
> nasty case.
> 
> Hmm? Entirely untested, and I didn't really look at the test-case in
> question since I can't really run it anyway.

I'll test tomorrow and let you know.

>  arch/arm/include/uapi/asm/siginfo.h | 7 -------
>  arch/arm/vfp/vfpmodule.c            | 4 ++--
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
> index d0513880be21..d87beeedb4c4 100644
> --- a/arch/arm/include/uapi/asm/siginfo.h
> +++ b/arch/arm/include/uapi/asm/siginfo.h
> @@ -3,11 +3,4 @@
>  
>  #include <asm-generic/siginfo.h>
>  
> -/*
> - * SIGFPE si_codes
> - */
> -#ifdef __KERNEL__
> -#define FPE_FIXME	0	/* Broken dup of SI_USER */
> -#endif /* __KERNEL__ */
> -
>  #endif

This file was created to contain FPE_FIXME, by the "signal/arm: Document
conflicts with SI_USER and SIGFPE" commit so if we're removing it, it
would be better to remove the whole file.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
