Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E19CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:13:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9E620850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOb/y+96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9E620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439cyZ6V17zDrNM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:13:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOb/y+96";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOb/y+96"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439csc4kJ6zDr5Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:09:08 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id y185so14214210wmd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o+Hi5qCu1RLhwE+bPLc/5fSsJZ+tnZVQIQpuolGNy+I=;
 b=QOb/y+96Q7IteY/fkJLo/FOu/I+/Jb5bFWJhFIHgRf+yYO6ntmupLCcUbcM3sliKY6
 gvn53nnFJIrS2KgQXJGITmUE16w0pz86fzm1ardMfOz/7nb5pt8dv3CeKk3GU4d/ZqoY
 hXXrD5o6czjIspu3J6g/Mr08JNMmh12TmlSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o+Hi5qCu1RLhwE+bPLc/5fSsJZ+tnZVQIQpuolGNy+I=;
 b=tHKHK6qE5Bk4/JYKd41ydHLZ/IKZ7zAJtBhScfxcCbzFrzUlhEJaZ9Y6KT1x94yZue
 WRaAMNA3GWL2wpmoYUQrA7u4ksmn3a0VXf7itJSUH99Guy48AxJajTUaXl1iQWP0XjlP
 Dz8mPSR9bhPDV7W6WazPvK+t8h5480sbXg+eGnsv8jQBXK7LaPIgYgdtoi42v019Cjc4
 SQOE0/YdQVXN6K6jJ5lJXiu3kj8a+TC1G7yowTGwjt1T928yXUHbggbOXXYRs3XZn/JS
 BjIHE7xZkt/gsymoHenFZZAJiOfnKErIWRo2HAitWFOCevf0w+DjmkIJVAgkJOz2vAeR
 yFNQ==
X-Gm-Message-State: AA+aEWZIZEaoukLLnUjZ3KVnIOVJQYKeDXpXEnXjl/gCMs1ee9LYG9uk
 YhZf8llbnQ6fIeobrnxXC0t6fQ==
X-Google-Smtp-Source: AFSGD/UQuiS5csAvXCzX7Gg/NJF+Mb7FYKtRsrKksKqVmjR5yEOe8mkXTbm+LRpso34mCUfFdz199w==
X-Received: by 2002:a1c:8089:: with SMTP id
 b131mr20179449wmd.141.1544105346072; 
 Thu, 06 Dec 2018 06:09:06 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id t5sm1380222wmd.15.2018.12.06.06.09.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 06:09:05 -0800 (PST)
Date: Thu, 6 Dec 2018 14:09:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Message-ID: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
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

On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> MIPS is the only architecture modifying arch_kgdb_ops during init.
> This patch makes the init static, so that it can be changed to
> const in following patch, as recommended by checkpatch.pl
> 
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

From my side this is
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Since this is a dependency for the next patch I'd be happy to take via
my tree... but would need an ack from the MIPS guys to do that.


Daniel.

> ---
>  arch/mips/kernel/kgdb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..31eff1bec577 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +struct kgdb_arch arch_kgdb_ops = {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
> +#else
> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
> +#endif
> +};
>  
>  int kgdb_arch_init(void)
>  {
> -	union mips_instruction insn = {
> -		.r_format = {
> -			.opcode = spec_op,
> -			.func	= break_op,
> -		}
> -	};
> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> -
>  	register_die_notifier(&kgdb_notifier);
>  
>  	return 0;
> -- 
> 2.13.3
> 
