Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E171C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 12:54:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AF2218D8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 12:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mOjKTXgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AF2218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ym2V3WSVzDqGn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:54:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ylyV2dBjzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 23:50:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="mOjKTXgt"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43ylyS1hZ6z8t1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 23:50:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43ylyS1b0Hz9sMr; Mon, 11 Feb 2019 23:50:56 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amarulasolutions.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=andrea.parri@amarulasolutions.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="mOjKTXgt"; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43ylyK5FVPz9sN1
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2019 23:50:47 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id j125so2147593wmj.1
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2019 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IYdfIO659ekfh2qmLfnVYKVVL3PIdT/ZrVUac+z4oGw=;
 b=mOjKTXgtmgHAhlNXAqDAQAFOc+ck/i25D/+GnzI0Fy1ZLymU2QEvUYCDXAYnwu6u4l
 PUMInCv94IXFGCoN1qPmnzLC6O/0gO2GpVIjX6n1zjvomuMm2YJMKOO+5rQuMmo3tIbe
 OjTvBj/JnQcvU//axxJNcXT3iz0oXP2OcmJoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IYdfIO659ekfh2qmLfnVYKVVL3PIdT/ZrVUac+z4oGw=;
 b=LvZxxqVV3ysIGUZzCfS17QX9axvZDlYzjd/Qyylfymg3X3J7Xgat+5R2PRBa3yn+RP
 Sjg3W/gyPyBB2LSiote3sBAZSBEIRKwz8f8YPsvlSwTTeZfuuFD0VFuSX5QVWOXMVot3
 2v/I7+9JVRRCGtVb4wTUpxd4dIjRUJaJBt6sNP5JJ+ui5bzkdxo5OF98TqAIPO4DA2dK
 vR8lYbp53ifvXhmim3qvZ5HDmVvCNQ1hZJqU0H0b1xqgqvzmlGx5muK85etqAZJrjzbl
 Jk6aCAsMRo+hIBPGNVTGVAhdwm/6RvgNiUsiuLkGi1U9quDg5Lf2LlYdN5fVav0ldrsV
 /y9w==
X-Gm-Message-State: AHQUAuaqN6lNay2KULABi9wihDSIc2v6KxoEot7TEFc6mu/g3VPpxgCi
 g2dZ3lr4SXGpyV9vJjGmCwgNwg==
X-Google-Smtp-Source: AHgI3IZJewIdt3nWijY55oJ6pYTlFyID0dljRwI5euSZ2hc2v8NZnsiQe1AgML2F2QrtY42LopQLww==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr9037104wmg.2.1549889445404;
 Mon, 11 Feb 2019 04:50:45 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
 by smtp.gmail.com with ESMTPSA id c186sm12040999wmf.34.2019.02.11.04.50.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:50:44 -0800 (PST)
Date: Mon, 11 Feb 2019 13:50:35 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190211125035.GA1562@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Hi Michael,


On Thu, Feb 07, 2019 at 11:46:29PM +1100, Michael Ellerman wrote:
> Arch code can set a "dump stack arch description string" which is
> displayed with oops output to describe the hardware platform.
> 
> It is useful to initialise this as early as possible, so that an early
> oops will have the hardware description.
> 
> However in practice we discover the hardware platform in stages, so it
> would be useful to be able to incrementally fill in the hardware
> description as we discover it.
> 
> This patch adds that ability, by creating dump_stack_add_arch_desc().
> 
> If there is no existing string it behaves exactly like
> dump_stack_set_arch_desc(). However if there is an existing string it
> appends to it, with a leading space.
> 
> This makes it easy to call it multiple times from different parts of the
> code and get a reasonable looking result.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  include/linux/printk.h |  5 ++++
>  lib/dump_stack.c       | 58 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> v3: No change, just widened Cc list.
> 
> v2: Add a smp_wmb() and comment.
> 
> v1 is here for reference https://lore.kernel.org/lkml/1430824337-15339-1-git-send-email-mpe@ellerman.id.au/
> 
> I'll take this series via the powerpc tree if no one minds?
> 
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

The comment doesn't say _why_ we need to order these stores: IOW, what
will or can go wrong without this order?  This isn't clear to me.

Another good practice when adding smp_*-constructs (as discussed, e.g.,
at KS'18) is to indicate the matching construct/synch. mechanism.

  Andrea


> +		 */
> +		smp_wmb();
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
> 
