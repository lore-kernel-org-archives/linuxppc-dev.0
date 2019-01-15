Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24833C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 12:05:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360F620657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 12:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IM1vVjUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360F620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f8Cz5PnZzDqbq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 23:05:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="IM1vVjUk"; dkim-atps=neutral
X-Greylist: delayed 403 seconds by postgrey-1.36 at bilbo;
 Tue, 15 Jan 2019 23:00:34 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f86p0HmFzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 23:00:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtkYBYQEV0zkIFWjLE1poFjLAMViJ0i4p6XlDuJkXsA=; b=IM1vVjUkT2Gq+IQyLcV94IGss
 VtFPaeJpVR2fEyZVwujSerg4Seq6FO3zEOGQGEoLPTih8ZfkI1OgcXiVThLTXH6ywv/mCCYfQbn6s
 5LjPwUFbGDKpZOAL3FvnHuHzh6EKBskLbN1V26J3AqolhRE4flIFk6O1QcBr6gzftzQuQ=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35742 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gjNGg-0005RZ-3L; Tue, 15 Jan 2019 11:52:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gjNGf-0004ui-4x; Tue, 15 Jan 2019 11:52:29 +0000
Date: Tue, 15 Jan 2019 11:52:29 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
Message-ID: <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110162435.309262-16-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, linux@dominikbrodowski.net,
 linux-mips@vger.kernel.org, jcmvbkbc@gmail.com, deepa.kernel@gmail.com,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 dave@stgolabs.net, y2038@lists.linaro.org, deller@gmx.de, x86@kernel.org,
 mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, will.deacon@arm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
> 
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.

I was lambasted for adding the pkey syscalls for 32-bit ARM in 2016,
which will probably never support it.  Why has the attitude towards
this kind of thing now apparently become acceptable?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/include/asm/unistd.h         | 4 ----
>  arch/alpha/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/ia64/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/parisc/include/asm/unistd.h        | 3 ---
>  arch/parisc/kernel/syscalls/syscall.tbl | 4 ++++
>  arch/s390/include/asm/unistd.h          | 3 ---
>  arch/s390/kernel/syscalls/syscall.tbl   | 3 +++
>  arch/sh/kernel/syscalls/syscall.tbl     | 4 ++++
>  arch/sparc/include/asm/unistd.h         | 5 -----
>  arch/sparc/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/xtensa/kernel/syscalls/syscall.tbl | 1 +
>  12 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
> index 564ba87bdc38..31ad350b58a0 100644
> --- a/arch/alpha/include/asm/unistd.h
> +++ b/arch/alpha/include/asm/unistd.h
> @@ -29,9 +29,5 @@
>  #define __IGNORE_getppid
>  #define __IGNORE_getuid
>  
> -/* Alpha doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #endif /* _ALPHA_UNISTD_H */
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index b0e247287908..25b4a7e76943 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -452,3 +452,7 @@
>  521	common	pwritev2			sys_pwritev2
>  522	common	statx				sys_statx
>  523	common	io_pgetevents			sys_io_pgetevents
> +524	common	pkey_alloc			sys_pkey_alloc
> +525	common	pkey_free			sys_pkey_free
> +526	common	pkey_mprotect			sys_pkey_mprotect
> +527	common	rseq				sys_rseq
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 2e93dbdcdb80..84e03de00177 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -339,3 +339,7 @@
>  327	common	io_pgetevents			sys_io_pgetevents
>  328	common	perf_event_open			sys_perf_event_open
>  329	common	seccomp				sys_seccomp
> +330	common	pkey_alloc			sys_pkey_alloc
> +331	common	pkey_free			sys_pkey_free
> +332	common	pkey_mprotect			sys_pkey_mprotect
> +333	common	rseq				sys_rseq
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 5354ba02eed2..ae88b85d068e 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -388,6 +388,10 @@
>  378	common	pwritev2			sys_pwritev2
>  379	common	statx				sys_statx
>  380	common	seccomp				sys_seccomp
> +381	common	pkey_alloc			sys_pkey_alloc
> +382	common	pkey_free			sys_pkey_free
> +383	common	pkey_mprotect			sys_pkey_mprotect
> +384	common	rseq				sys_rseq
>  # room for arch specific calls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl
> diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
> index c2c2afb28941..9ec1026af877 100644
> --- a/arch/parisc/include/asm/unistd.h
> +++ b/arch/parisc/include/asm/unistd.h
> @@ -12,9 +12,6 @@
>  
>  #define __IGNORE_select			/* newselect */
>  #define __IGNORE_fadvise64		/* fadvise64_64 */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #ifndef ASM_LINE_SEP
>  # define ASM_LINE_SEP ;
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 9bbd2f9f56c8..e07231de3597 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -367,3 +367,7 @@
>  348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
>  349	common	statx			sys_statx
>  350	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
> +351	common	pkey_alloc		sys_pkey_alloc
> +352	common	pkey_free		sys_pkey_free
> +353	common	pkey_mprotect		sys_pkey_mprotect
> +354	common	rseq			sys_rseq
> diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
> index a1fbf15d53aa..ed08f114ee91 100644
> --- a/arch/s390/include/asm/unistd.h
> +++ b/arch/s390/include/asm/unistd.h
> @@ -11,9 +11,6 @@
>  #include <asm/unistd_nr.h>
>  
>  #define __IGNORE_time
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_OLD_READDIR
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 428cf512a757..f84ea364a302 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -391,6 +391,9 @@
>  381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
>  382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
>  383  common	rseq			sys_rseq			compat_sys_rseq
> +384  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
> +385  common	pkey_free		sys_pkey_free			sys_pkey_free
> +386  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
>  # room for arch specific syscalls
>  392	64	semtimedop		sys_semtimedop			-
>  393  common	semget			sys_semget			sys_semget
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 6d0b84e3ef2d..3f96ad0424e1 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -391,6 +391,10 @@
>  381	common	preadv2				sys_preadv2
>  382	common	pwritev2			sys_pwritev2
>  383	common	statx				sys_statx
> +384	common	pkey_alloc			sys_pkey_alloc
> +385	common	pkey_free			sys_pkey_free
> +386	common	pkey_mprotect			sys_pkey_mprotect
> +387	common	rseq				sys_rseq
>  # room for arch specific syscalls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl
> diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
> index 5194d86ef72d..08696ea5dca8 100644
> --- a/arch/sparc/include/asm/unistd.h
> +++ b/arch/sparc/include/asm/unistd.h
> @@ -59,9 +59,4 @@
>  #define __IGNORE_getresgid
>  #endif
>  
> -/* Sparc doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #endif /* _SPARC_UNISTD_H */
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 8c9580302422..24ebef675184 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -407,6 +407,10 @@
>  359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
>  360	common	statx			sys_statx
>  361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
> +362	common	pkey_alloc		sys_pkey_alloc
> +363	common	pkey_free		sys_pkey_free
> +364	common	pkey_mprotect		sys_pkey_mprotect
> +365	common	rseq			sys_rseq
>  # room for arch specific syscalls
>  392	64	semtimedop			sys_semtimedop
>  393	common	semget			sys_semget
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index f8befa11b0c4..c699e014e0dd 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -372,3 +372,4 @@
>  349	common	pkey_alloc			sys_pkey_alloc
>  350	common	pkey_free			sys_pkey_free
>  351	common	statx				sys_statx
> +352	common	rseq				sys_rseq
> -- 
> 2.20.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
