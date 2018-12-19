Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301DDC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 17:05:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD91214C6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcQZKlQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD91214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Kh923qxpzDqsG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 04:05:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TcQZKlQv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="TcQZKlQv"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Kh0L0j9xzDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 03:57:53 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id t6so20063358wrr.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ipk70XgawFq2DrKpbmaNeO7sDiuavgSWfwjNSok6DcE=;
 b=TcQZKlQvs15wtS/CjJG+zHvmHWgqRhWd5WtBB0rf1SA/d9trc8i9CNFsrsjzkCV08q
 cbuvtNAryuks1vQLynHEmEk76xrKaavnxOaIoDgn67BbsD0QKkAZqVy9G9NgQfitfhaW
 UobZwQ7I4D4Ea0fwx+sD+MtA3hohdf73Ol9L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ipk70XgawFq2DrKpbmaNeO7sDiuavgSWfwjNSok6DcE=;
 b=KfzIDdnSPawZ7ScGlO/KCuz25Z3z8KvfbLNiLVYtsoAbqKzh0PxBkB/ZQv0OD7lGAV
 YGkgT08DOl6+Hs5q9IbZKhQxMwIMfE3a7OHpkg7rQEZiH/BNGtBDWHVstAJ5sqSeS2ht
 JbiQ23ud+zUdT5R9IbXCdGqQffLAB/c7bAHDcUzM0Axnpogr62GOvvb98k/X3OfzCCHe
 Bnm4YSssTMBLk0DGwRVOlTLE/LGYH4/p3ZlxUYZDBYe333Lpr1io1EHMRkPbk4IGzJwE
 JUFSvwNvVttcdLr38w8Xa3CIGea2U6mijXMHdyHpSMaM5n3rQOVNWlZUAygzb8r6w3aD
 KeKg==
X-Gm-Message-State: AA+aEWbAyZ9g4z0vN76P0pXFobyogLeIqCbV6XrLGhicYj1Tam1bE4O7
 kShmFI6AXw3sI5siS3KnB/UNSQ==
X-Google-Smtp-Source: AFSGD/XjZvuL++qgyIW7v0Q2ysTDCEM2AfwE2T3EJAL2l/D6YqsYNA1o+odv8TMGq3csAsF4CgI6mw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr20128419wro.262.1545238670653; 
 Wed, 19 Dec 2018 08:57:50 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id z9sm5494906wrs.63.2018.12.19.08.57.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 08:57:49 -0800 (PST)
Date: Wed, 19 Dec 2018 16:57:47 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 2/2] kgdb/treewide: constify struct kgdb_arch
 arch_kgdb_ops
Message-ID: <20181219165747.ltfs65vt3tycrl7x@holly.lan>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
 <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180716
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
Cc: Rich Felker <dalias@libc.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, nios2-dev@lists.rocketboards.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>,
 kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 08:07:40PM +0000, Christophe Leroy wrote:
> checkpatch.pl reports the following:
> 
>   WARNING: struct kgdb_arch should normally be const
>   #28: FILE: arch/mips/kernel/kgdb.c:397:
>   +struct kgdb_arch arch_kgdb_ops = {
> 
> This report makes sense, as all other ops struct, this
> one should also be const. This patch does the change.
> 
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I've not heard any objections from the arch/ maintainers so...

Applied! Thanks.


> -
> ---
>  v2: Added CCs to all maintainers/supporters identified by get_maintainer.pl and Acks from Daniel and Paul.
> 
>  arch/arc/kernel/kgdb.c        | 2 +-
>  arch/arm/kernel/kgdb.c        | 2 +-
>  arch/arm64/kernel/kgdb.c      | 2 +-
>  arch/h8300/kernel/kgdb.c      | 2 +-
>  arch/hexagon/kernel/kgdb.c    | 2 +-
>  arch/microblaze/kernel/kgdb.c | 2 +-
>  arch/mips/kernel/kgdb.c       | 2 +-
>  arch/nios2/kernel/kgdb.c      | 2 +-
>  arch/powerpc/kernel/kgdb.c    | 2 +-
>  arch/sh/kernel/kgdb.c         | 2 +-
>  arch/sparc/kernel/kgdb_32.c   | 2 +-
>  arch/sparc/kernel/kgdb_64.c   | 2 +-
>  arch/x86/kernel/kgdb.c        | 2 +-
>  include/linux/kgdb.h          | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 9a3c34af2ae8..bfd04b442e36 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -204,7 +204,7 @@ void kgdb_roundup_cpus(unsigned long flags)
>  	local_irq_disable();
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* breakpoint instruction: TRAP_S 0x3 */
>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  	.gdb_bpt_instr		= {0x78, 0x7e},
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index caa0dbe3dc61..21a6d5958955 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -274,7 +274,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>   * and we handle the normal undef case within the do_undefinstr
>   * handler.
>   */
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifndef __ARMEB__
>  	.gdb_bpt_instr		= {0xfe, 0xde, 0xff, 0xe7}
>  #else /* ! __ARMEB__ */
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..fe1d1f935b90 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -357,7 +357,7 @@ void kgdb_arch_exit(void)
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  {
> diff --git a/arch/h8300/kernel/kgdb.c b/arch/h8300/kernel/kgdb.c
> index 1a1d30cb0609..602e478afbd5 100644
> --- a/arch/h8300/kernel/kgdb.c
> +++ b/arch/h8300/kernel/kgdb.c
> @@ -129,7 +129,7 @@ void kgdb_arch_exit(void)
>  	/* Nothing to do */
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trapa #2 */
>  	.gdb_bpt_instr = { 0x57, 0x20 },
>  };
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 16c24b22d0b2..f1924d483e78 100644
> --- a/arch/hexagon/kernel/kgdb.c
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -83,7 +83,7 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>  	{ "syscall_nr", GDB_SIZEOF_REG, offsetof(struct pt_regs, syscall_nr)},
>  };
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* trap0(#0xDB) 0x0cdb0054 */
>  	.gdb_bpt_instr = {0x54, 0x00, 0xdb, 0x0c},
>  };
> diff --git a/arch/microblaze/kernel/kgdb.c b/arch/microblaze/kernel/kgdb.c
> index 6366f69d118e..130cd0f064ce 100644
> --- a/arch/microblaze/kernel/kgdb.c
> +++ b/arch/microblaze/kernel/kgdb.c
> @@ -143,7 +143,7 @@ void kgdb_arch_exit(void)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifdef __MICROBLAZEEL__
>  	.gdb_bpt_instr = {0x18, 0x00, 0x0c, 0xba}, /* brki r16, 0x18 */
>  #else
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 31eff1bec577..edfdc2ec2d16 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,7 +394,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
>  #else
> diff --git a/arch/nios2/kernel/kgdb.c b/arch/nios2/kernel/kgdb.c
> index 117859122d1c..37b25f844a2d 100644
> --- a/arch/nios2/kernel/kgdb.c
> +++ b/arch/nios2/kernel/kgdb.c
> @@ -165,7 +165,7 @@ void kgdb_arch_exit(void)
>  	/* Nothing to do */
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trap 30 */
>  	.gdb_bpt_instr = { 0xba, 0x6f, 0x3b, 0x00 },
>  };
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..bdb588b1d8fb 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -477,7 +477,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  static int kgdb_not_implemented(struct pt_regs *regs)
>  {
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 4f04c6638a4d..a24c48446e98 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -382,7 +382,7 @@ void kgdb_arch_exit(void)
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trapa #0x3c */
>  #ifdef CONFIG_CPU_LITTLE_ENDIAN
>  	.gdb_bpt_instr		= { 0x3c, 0xc3 },
> diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
> index 639c8e54530a..7580775a14b9 100644
> --- a/arch/sparc/kernel/kgdb_32.c
> +++ b/arch/sparc/kernel/kgdb_32.c
> @@ -166,7 +166,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  	regs->npc = regs->pc + 4;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: ta 0x7d */
>  	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x7d },
>  };
> diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
> index a68bbddbdba4..5d6c2d287e85 100644
> --- a/arch/sparc/kernel/kgdb_64.c
> +++ b/arch/sparc/kernel/kgdb_64.c
> @@ -195,7 +195,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  	regs->tnpc = regs->tpc + 4;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: ta 0x72 */
>  	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x72 },
>  };
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..e7effc02f13c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -804,7 +804,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: */
>  	.gdb_bpt_instr		= { 0xcc },
>  	.flags			= KGDB_HW_BREAKPOINT,
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index e465bb15912d..3bf313311cca 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -281,7 +281,7 @@ struct kgdb_io {
>  	int			is_console;
>  };
>  
> -extern struct kgdb_arch		arch_kgdb_ops;
> +extern const struct kgdb_arch		arch_kgdb_ops;
>  
>  extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
>  
> -- 
> 2.13.3
> 
