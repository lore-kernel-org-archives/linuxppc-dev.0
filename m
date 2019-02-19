Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD73C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 23:41:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694D121479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 23:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WreWninV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694D121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443y1M244KzDqJH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 10:41:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443xzG5qxhzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 10:39:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="WreWninV"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 443xzF6nnBz8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 10:39:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 443xzF5QfTz9sDr; Wed, 20 Feb 2019 10:39:37 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amarulasolutions.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=andrea.parri@amarulasolutions.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="WreWninV"; dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 443xzD5g88z9sDX
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 10:39:34 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id q1so23874804wrp.7
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2019 15:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=saahwx25cNTC84d6ArNl8JcwQIssCDuZhzTfhHa6Z/c=;
 b=WreWninVtedI49gXBVI7c4m3pw6FBKaBLJroDRo2yMgjI+xpEDTTBPxaXC4BC8pshn
 JqSYC9TnU86m+GIj8s+UsfKpmpCV+B8ZegnNEYFdStpH1czIVMaPp1JEag2H/UudlI/d
 wxuLk4P23AaPDCS8fycX5L7KQjd9GezIC/I8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=saahwx25cNTC84d6ArNl8JcwQIssCDuZhzTfhHa6Z/c=;
 b=RklKuMshFK6ZliexnTAUugEI7I6b3bKuaXRI1f6IhkGOACAcE+373uhcxfe/P/WuFt
 1iYQR2sDkgbz+6N+p24TidEwvaIJVPLYA8H3BHPkQ0Cq5MKlGWy92WvyNG/KWkHhlHU+
 YDoJbZLJRX9JNSTTjLiOrYy9hRYUyEM/DSqb6Ii8QqRBl5V8OI35VTIuq8NSHZxiNGIc
 RK+hFlzCsZMr0BNBNmfj4HpCuvl5zfZO9g4kC+MpkG6FcHHG/EGNdH4syzRSjQS8FO7U
 q8nNaiTGAO5mf7zHtLPTj2GZ6oqDBSmI+b77ehDco3lukQVqvWGgQeaSt9lJhqdw+vfa
 liCg==
X-Gm-Message-State: AHQUAuah8fioAP88q76+lJTAfCrPGpGid522GprTeSevotKG0n+GAz/B
 U4RO2moZ94nPEeo14UlqwEqXuA==
X-Google-Smtp-Source: AHgI3IZH4jvKMeEu3ALoN2V8+wD0ZFY5Rlah7Tr4GGR60A1ybdDHK8NRxqCWWBG2rHKQdq4oXW9PDg==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr4896033wru.140.1550619572028; 
 Tue, 19 Feb 2019 15:39:32 -0800 (PST)
Received: from andrea ([89.22.71.151])
 by smtp.gmail.com with ESMTPSA id h137sm7064072wmg.41.2019.02.19.15.39.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:39:31 -0800 (PST)
Date: Wed, 20 Feb 2019 00:39:25 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190219233925.GA5648@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
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
Cc: linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@ozlabs.org, tj@kernel.org, akpm@linux-foundation.org,
 dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 03:38:59PM +0100, Petr Mladek wrote:
> On Mon 2019-02-11 13:50:35, Andrea Parri wrote:
> > Hi Michael,
> > 
> > 
> > On Thu, Feb 07, 2019 at 11:46:29PM +1100, Michael Ellerman wrote:
> > > Arch code can set a "dump stack arch description string" which is
> > > displayed with oops output to describe the hardware platform.
> > > 
> > > It is useful to initialise this as early as possible, so that an early
> > > oops will have the hardware description.
> > > 
> > > However in practice we discover the hardware platform in stages, so it
> > > would be useful to be able to incrementally fill in the hardware
> > > description as we discover it.
> > > 
> > > This patch adds that ability, by creating dump_stack_add_arch_desc().
> > > 
> > > If there is no existing string it behaves exactly like
> > > dump_stack_set_arch_desc(). However if there is an existing string it
> > > appends to it, with a leading space.
> > > 
> > > This makes it easy to call it multiple times from different parts of the
> > > code and get a reasonable looking result.
> > > 
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > ---
> > >  include/linux/printk.h |  5 ++++
> > >  lib/dump_stack.c       | 58 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 63 insertions(+)
> > > 
> > > v3: No change, just widened Cc list.
> > > 
> > > v2: Add a smp_wmb() and comment.
> > > 
> > > v1 is here for reference https://lore.kernel.org/lkml/1430824337-15339-1-git-send-email-mpe@ellerman.id.au/
> > > 
> > > I'll take this series via the powerpc tree if no one minds?
> > > 
> > > 
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index 77740a506ebb..d5fb4f960271 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -198,6 +198,7 @@ u32 log_buf_len_get(void);
> > >  void log_buf_vmcoreinfo_setup(void);
> > >  void __init setup_log_buf(int early);
> > >  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
> > > +__printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...);
> > >  void dump_stack_print_info(const char *log_lvl);
> > >  void show_regs_print_info(const char *log_lvl);
> > >  extern asmlinkage void dump_stack(void) __cold;
> > > @@ -256,6 +257,10 @@ static inline __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...)
> > >  {
> > >  }
> > >  
> > > +static inline __printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...)
> > > +{
> > > +}
> > > +
> > >  static inline void dump_stack_print_info(const char *log_lvl)
> > >  {
> > >  }
> > > diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> > > index 5cff72f18c4a..69b710ff92b5 100644
> > > --- a/lib/dump_stack.c
> > > +++ b/lib/dump_stack.c
> > > @@ -35,6 +35,64 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
> > >  	va_end(args);
> > >  }
> > >  
> > > +/**
> > > + * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
> > > + * @fmt: printf-style format string
> > > + * @...: arguments for the format string
> > > + *
> > > + * See dump_stack_set_arch_desc() for why you'd want to use this.
> > > + *
> > > + * This version adds to any existing string already created with either
> > > + * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
> > > + * existing string a space will be prepended to the passed string.
> > > + */
> > > +void __init dump_stack_add_arch_desc(const char *fmt, ...)
> > > +{
> > > +	va_list args;
> > > +	int pos, len;
> > > +	char *p;
> > > +
> > > +	/*
> > > +	 * If there's an existing string we snprintf() past the end of it, and
> > > +	 * then turn the terminating NULL of the existing string into a space
> > > +	 * to create one string separated by a space.
> > > +	 *
> > > +	 * If there's no existing string we just snprintf() to the buffer, like
> > > +	 * dump_stack_set_arch_desc(), but without calling it because we'd need
> > > +	 * a varargs version.
> > > +	 */
> > > +	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
> > > +	pos = len;
> > > +
> > > +	if (len)
> > > +		pos++;
> > > +
> > > +	if (pos >= sizeof(dump_stack_arch_desc_str))
> > > +		return; /* Ran out of space */
> > > +
> > > +	p = &dump_stack_arch_desc_str[pos];
> > > +
> > > +	va_start(args, fmt);
> > > +	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
> > > +	va_end(args);
> > > +
> > > +	if (len) {
> > > +		/*
> > > +		 * Order the stores above in vsnprintf() vs the store of the
> > > +		 * space below which joins the two strings. Note this doesn't
> > > +		 * make the code truly race free because there is no barrier on
> > > +		 * the read side. ie. Another CPU might load the uninitialised
> > > +		 * tail of the buffer first and then the space below (rather
> > > +		 * than the NULL that was there previously), and so print the
> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> > > +		 * practice it should just see NULLs.
> > 
> > The comment doesn't say _why_ we need to order these stores: IOW, what
> > will or can go wrong without this order?  This isn't clear to me.
> >
> > Another good practice when adding smp_*-constructs (as discussed, e.g.,
> > at KS'18) is to indicate the matching construct/synch. mechanism.
> 
> Yes, one barrier without a counter-part is suspicious.

As is this silence...,

Michael, what happened to this patch? did you submit a new version?


> 
> If the parallel access is really needed then we could define the
> current length as atomic_t and use:
> 
> 	+ atomic_cmpxchg() to reserve the space for the string
> 	+ %*s to limit the printed length
> 
> In the worst case, we would print an incomplete string.
> See below for a sample code.

Seems worth exploring, IMO; but I'd like to first hear _clear about
the _intended semantics (before digging into alternatives)...

+rostedt,  who first raised the question about "parallel accesses"

  http://lkml.kernel.org/r/20190208185515.r6vkrezbd3odhpxt@home.goodmis.org

  Andrea


> 
> 
> BTW: There are very few users of dump_stack_set_arch_desc().
> I would use dump_stack_add_arch_desc() everywhere to keep
> it simple and have a reasonable semantic.
> 
> 
> This is what I mean (only compile tested):
> 
> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index 5cff72f18c4a..311dd20cc6a7 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -14,9 +14,10 @@
>  #include <linux/utsname.h>
>  
>  static char dump_stack_arch_desc_str[128];
> +static atomic_t arch_desc_str_len;
>  
>  /**
> - * dump_stack_set_arch_desc - set arch-specific str to show with task dumps
> + * dump_stack_set_arch_desc - add arch-specific str to show with task dumps
>   * @fmt: printf-style format string
>   * @...: arguments for the format string
>   *
> @@ -25,13 +26,32 @@ static char dump_stack_arch_desc_str[128];
>   * arch wants to make use of such an ID string, it should initialize this
>   * as soon as possible during boot.
>   */
> -void __init dump_stack_set_arch_desc(const char *fmt, ...)
> +void __init dump_stack_add_arch_desc(const char *fmt, ...)
>  {
> -	va_list args;
> +	va_list args, args2;
> +	int len, cur_len, old_len;
>  
>  	va_start(args, fmt);
> -	vsnprintf(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str),
> +
> +	va_copy(args2, args);
> +	len = vsnprintf(NULL, sizeof(dump_stack_arch_desc_str),
> +			fmt, args2);
> +	va_end(args2);
> +
> +try_again:
> +	cur_len = atomic_read(&arch_desc_str_len);
> +	if (cur_len + len > sizeof(dump_stack_arch_desc_str))
> +		goto out;
> +
> +	old_len = atomic_cmpxchg(&arch_desc_str_len,
> +				 cur_len, cur_len + len);
> +	if (old_len != cur_len)
> +		goto try_again;
> +
> +	vsnprintf(dump_stack_arch_desc_str + old_len,
> +		  sizeof(dump_stack_arch_desc_str) - old_len,
>  		  fmt, args);
> +out:
>  	va_end(args);
>  }
>  
> @@ -44,6 +64,8 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
>   */
>  void dump_stack_print_info(const char *log_lvl)
>  {
> +	int len;
> +
>  	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
>  	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
>  	       kexec_crash_loaded() ? "Kdump: loaded " : "",
> @@ -52,9 +74,11 @@ void dump_stack_print_info(const char *log_lvl)
>  	       (int)strcspn(init_utsname()->version, " "),
>  	       init_utsname()->version);
>  
> -	if (dump_stack_arch_desc_str[0] != '\0')
> -		printk("%sHardware name: %s\n",
> -		       log_lvl, dump_stack_arch_desc_str);
> +	len = atomic_read(&arch_desc_str_len);
> +	if (len) {
> +		printk("%sHardware name: %*s\n",
> +		       log_lvl, len, dump_stack_arch_desc_str);
> +	}
>  
>  	print_worker_info(log_lvl, current);
>  }
> 
> Best Regards,
> Petr
