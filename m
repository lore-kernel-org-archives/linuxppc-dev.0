Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1996606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=N9zbiKAt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR0v773rrz2xQr;
	Sat, 14 Nov 2026 02:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794582355;
	cv=none; b=n1CcQCccwCfCegwJCGvh5Oru296v9/ObCpZ9M4VhUdPMIOPxvK+YqL9VWGCW5a3pdHAa2DriS8xGKkfwGrQl/+jsA/luHPTv8itwH9axyXAx1E+ZfVeYN89BIkRKAyQ4lEA/BNZKnbCiwcM1g1MM2LPZDsPA8uwSE13biR7kjQ4PEGB7vfqZd4T/OU5V8M/dCNEBKGbIrTUaSv1kLhn6RNnq5kUUxbhGpaiVvuwAkB7U8woZ9X6hz8dh7H7NQza3jddNG6b9kqU16oTVVJZLsx8p7BNgGY0aTFQ5DoEX2XfXGXIisJDbW2PiZHFEgODnBanWJZYF+k2lYQlM50jnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794582355; c=relaxed/relaxed;
	bh=x+Xd1db6zPqMxOaxpQfVku2qqOYSO4cm/68ivCtsVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzDgxGvOCLWID5Yv3ehLnZawTWLmVIxSqoOoK/YjVML1sRTe2sNjPkTNW/02ozNuPXX2D6xHbGB5ByZqNKVHiIRE9soAxaWjJMNtc4j/nKWeeYO6WX0z48x1m3T8puJablPNKti9CNjF8EkB89oMHSxzi4Pp55UuHh2Aovf74ARcRYMn381BgyBjMXgYPrYoDXWfRUBYFBv2/nzMohrg2CxfN/3vBWyTq+cPd7Oy+v+01NJ872qiJTXiNoC/suiqyaEvwFhv8nOEA/MAzXLwmj8rbc3Y5T9zgHwYk3B33W4BqWTPgc6YxI1ZCunlu5sQOpVduKginTT61gOwILjZKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=N9zbiKAt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=N9zbiKAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR0v62WT0z2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 02:05:53 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4b467581b98so8502125e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 07:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794582349; x=1795187149; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x+Xd1db6zPqMxOaxpQfVku2qqOYSO4cm/68ivCtsVLQ=;
        b=N9zbiKAtND7M9woo4hIa/KZ9yr7SsbA7qW1fvuFVgENPPCn6LlLNpOzB7Xhb7zv2p3
         Y5Gvvzd4IJtee1mVv4p9W6HrgCXez2CqzTNKIYvH9aPOToZQ1vUnDWFHfG7sT7ivZMT/
         IINxy0JOlbRbjul1OonyYmUQL0dinOW10neUVla3KFPdlE92sZdm7SfCVUqXGfgM06Hb
         nt72eeWGNaH1Z3Ge2Dt9Fb0tFwnOx+xX181+DM53hBad9ngx5bXRo/JvQG62W0XoXGSD
         ZTylUN0ts+yfXGeCYQOVA2poCNpX9KBruyEWxPJW3YDBlQ4qbBu6QwbhmXPoeXwhjNXz
         c46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582349; x=1795187149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+Xd1db6zPqMxOaxpQfVku2qqOYSO4cm/68ivCtsVLQ=;
        b=tZQOK61xf0ZQBPxx7zKnlUto/jl203gNfvpdzopxVn2RzowcZ+dr1Jt98I2HQQAPo8
         EnQKpSoWNFF9ugKo1N1HZEVllAdTpf2vB0VMpgYWoBBT1u/jjDtFJU6N1EXbqRQtiYoS
         EqRC6O1iOF11vW+1BQzWmPXrmyYGn6w+oJ5Ww+RjK2Hr7+za8pmdpKAgakD0Ka4RB8kO
         2XWPrrg3VOjvBZMdpESz+NtCJm3eNLrnIu2bGf0m+bz580hGVTS+CyNXFnNb9VI1O/tX
         lV6VlpnUswD5XfBEYzOUW/z8kyvZe0dTG6oebke1f7wokRDyYsy29BMbjCzn8yqKy1uo
         BVXA==
X-Forwarded-Encrypted: i=1; AL+hErHRuFpW0DU0MLkoHf/meEIff2gXHYEuLhuh1MgrPFUZMY/jcMbaUQgdPc25YDMr9sQD3sAd/oQsYHtslys=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9iuQAodnKsy17DiheRHN1UjosThpcgMVC1YLbRTMgO78MjcKK5
	/Qm0TdLD/KOTryJZdJ3b28DNyryFovDkwdJznH8EXD274AAtqiVxv2R5nZiDbv051kU=
X-Gm-Gg: AYBFou3s3k9rsU8zm7JGmWfBhZl8S9JLjDILH5DQQKKB+66Y6DMnoBKwW3/5FTx5NpX
	ig5R4wDt5+RcuMLeWdwwVlF5OArgEzZXIWaU2s7lirIFt1eGN9j5kT85S/QVoc5ImifWLywqb/8
	hhqXkX8j2W0rBu0zXekuI0FSXSCxRZAP9KO7bSKooofhhocJK6YTyhwwnyXMar1WWpHwt6G+f4M
	t0hfxMqO3voMYQjqs46WPninYSlAVY3hVjmz4hVx0yIHKrWBnh/gMwdY38hruA3RLo1qE28EZNl
	TxluWi8iWauN7wZKSe2CL1Ht3KLYM/CRd495VEYUoxh0YZFAUMqOBaHRk9ZiPKzMKS0pDA7jG4l
	VBox+ZWkvOKAweKgVfR/CnxyFc/RcFeeG/vOQpnY7sggpmydVHAZj0aOJ/YGSi7JuJU5ReIc5tP
	TxSeVk92z5iT4bZ5GUf6+l80FJfi+qQ3jJbquRkBys4h7/4R4Z9x9YXpNQUJBULs5WSgsXDz4/T
	ZndqFZPGiRe2XZI41syXUnSerEnBC5vLoQfcHuUkHg5xh2+2ZO6YUIUOI6+2WyZvzO+T8srq4oq
	/zaUQiDsQAEA1S9ODWYtnghiuuYVPVc=
X-Received: by 2002:a05:600c:46d5:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4bb55a8329amr58179765e9.13.1794582349341;
        Fri, 13 Nov 2026 07:05:49 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm270777285e9.1.2026.11.13.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:05:48 -0800 (PST)
Date: Fri, 13 Nov 2026 16:05:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>, printk@lists.linux.dev,
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 1/6] printk: Introduce and specify flush reasons
Message-ID: <avcnSjj2P9UfsBn7@pathway.suse.cz>
References: <20261111181942.593695-1-john.ogness@linutronix.de>
 <20261111181942.593695-2-john.ogness@linutronix.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111181942.593695-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 2026-11-11 19:25:17, John Ogness wrote:
> Prepare for per-console atomic flushing policies by introducing
> enum pr_flush_reason to classify various reasons for performing a
> printk backlog flush. The reasons are specified for
> printk_trigger_flush() and console_flush_on_panic().
> 
> For atomic printing from printk_trigger_flush(), propagate the
> reason down to __nbcon_atomic_flush_pending_con(), where the actual
> atomic flushing is executed.
> 
> For legacy printing, use a new global variable @legacy_flush_reason
> to track the reason in case nbcon consoles are using legacy
> printing.
> 
> Update all printk_trigger_flush() and console_flush_on_panic()
> call sites as well as any explicit lower-level atomic flush calls
> to specify the reason.
> 
> Note that PR_FLUSH_RUNTIME is used for cases where the reason for
> the flush is not clearly defined.

> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -145,6 +145,24 @@ void early_printk(const char *s, ...) { }
>  
>  struct dev_printk_info;
>  
> +/**
> + * enum pr_flush_reason - Reason for a flush
> + * @PR_FLUSH_RUNTIME:	A flush while the kernel is running
> + * @PR_FLUSH_RESTART:	The kernel is ending, but another instance should
> + *			follow (reboot, kexec)
> + * @PR_FLUSH_HANG:	The kernel is ending and will enter an infinite loop
> + * @PR_FLUSH_KDB:	Printing while KDB is active
> + *
> + * Flush reasons are used to determine if unsafe atomic flushing should be
> + * performed, based on individual console policies.
> + */
> +enum pr_flush_reason {
> +	PR_FLUSH_RUNTIME = 0,
> +	PR_FLUSH_RESTART,
> +	PR_FLUSH_HANG,
> +	PR_FLUSH_KDB,
> +};

This entire patchset adds a lot of complexity just to enable all
4 new policy flags for netconsole in the last patch.

There already have few dimensions which affect console flushing:

   + console_loglevel
   + nbcon_prio

This patchset adds 8 new terms in pr_flush_reason and
nbcon_unsafe_flush_flags just to explicitly set all
flush_flags in netconsole.

Let's start with pr_flush_reason. I am not sure if it is worth it:

  + PR_FLUSH_RUNTIME is the default

  + PR_FLUSH_RESTART can be detected by system_state > SYSTEM_RUNNING

  + PR_FLUSH_HANG has only one caller currently distinguished by
	the global panic_nbcon_allow_unsafe_takeover

  +  PR_FLUSH_KDB can be detected by kdb_trap_printk and
     kdb_printf_cpu, see vprintk() implementation.


IMHO, it makes things worse because nbcon_atomic_flush_pending() has
to use PR_FLUSH_RUNTIME in vprintk_emit(). But I think that we
would like to flush it the same way as an explicit flush called
in the given context.

Best Regards,
Petr

