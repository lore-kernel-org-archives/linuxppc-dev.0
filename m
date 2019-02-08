Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F0C282CC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 18:57:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35332077B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 18:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35332077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x4Dd09n8zDq77
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 05:57:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x4BR1ltnzDqbf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 05:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43x4BR0MdNz8x4q
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 05:55:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43x4BQ6Z3lz9sNJ; Sat,  9 Feb 2019 05:55:26 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=juhz=qp=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43x4BP6sGCz9sMr
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2019 05:55:25 +1100 (AEDT)
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 08AE92081B;
 Fri,  8 Feb 2019 18:55:22 +0000 (UTC)
Date: Fri, 8 Feb 2019 13:55:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tj@kernel.org,
 akpm@linux-foundation.org, dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 07, 2019 at 11:46:29PM +1100, Michael Ellerman wrote:
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 77740a506ebb..d5fb4f960271 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -198,6 +198,7 @@ u32 log_buf_len_get(void);
>  void log_buf_vmcoreinfo_setup(void);
>  void __init setup_log_buf(int early);
>  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
> +__printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...);
>  void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack(void) __cold;
> @@ -256,6 +257,10 @@ static inline __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...)
>  {
>  }
>  
> +static inline __printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...)
> +{
> +}
> +
>  static inline void dump_stack_print_info(const char *log_lvl)
>  {
>  }
> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index 5cff72f18c4a..69b710ff92b5 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -35,6 +35,64 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +/**
> + * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
> + * @fmt: printf-style format string
> + * @...: arguments for the format string
> + *
> + * See dump_stack_set_arch_desc() for why you'd want to use this.
> + *
> + * This version adds to any existing string already created with either
> + * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
> + * existing string a space will be prepended to the passed string.
> + */
> +void __init dump_stack_add_arch_desc(const char *fmt, ...)
> +{
> +	va_list args;
> +	int pos, len;
> +	char *p;
> +
> +	/*
> +	 * If there's an existing string we snprintf() past the end of it, and
> +	 * then turn the terminating NULL of the existing string into a space
> +	 * to create one string separated by a space.
> +	 *
> +	 * If there's no existing string we just snprintf() to the buffer, like
> +	 * dump_stack_set_arch_desc(), but without calling it because we'd need
> +	 * a varargs version.
> +	 */
> +	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
> +	pos = len;
> +
> +	if (len)
> +		pos++;
> +
> +	if (pos >= sizeof(dump_stack_arch_desc_str))
> +		return; /* Ran out of space */
> +
> +	p = &dump_stack_arch_desc_str[pos];
> +
> +	va_start(args, fmt);
> +	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
> +	va_end(args);
> +
> +	if (len) {
> +		/*
> +		 * Order the stores above in vsnprintf() vs the store of the
> +		 * space below which joins the two strings. Note this doesn't
> +		 * make the code truly race free because there is no barrier on
> +		 * the read side. ie. Another CPU might load the uninitialised
> +		 * tail of the buffer first and then the space below (rather
> +		 * than the NULL that was there previously), and so print the
> +		 * uninitialised tail. But the whole string lives in BSS so in
> +		 * practice it should just see NULLs.
> +		 */
> +		smp_wmb();

This shows me that this can be called at a time when more than one CPU is
active. What happens if we have two CPUs calling dump_stack_add_arch_desc() at
the same time? Can't that corrupt the dump_stack_arch_desc_str?

-- Steve

> +
> +		dump_stack_arch_desc_str[len] = ' ';
> +	}
> +}
> +
>  /**
>   * dump_stack_print_info - print generic debug info for dump_stack()
>   * @log_lvl: log level
> -- 
> 2.20.1
