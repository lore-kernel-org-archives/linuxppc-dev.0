Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:05:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDE62080A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX6VSrP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDE62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lj7t0cvWzF3Kt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 09:05:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eX6VSrP5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eX6VSrP5"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lj4z2YHCzF31Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 09:02:59 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id c25-v6so8270524pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
 b=eX6VSrP5jr3ebobFPu8mkzOocEIGmM5qPE5p74+wGHr9YyBSLjT06ItmcchYyiR85y
 FXxmzmyrgWHkQgBKfNqtTq9dq6yIERA4x19Pfp7d3AKAg5CSyhxqivbNpS7yKCX+hqKV
 mOqZg+ugCoIAPvh98FNcB5u0vmFa5n8+suXYA34YdnNHoMKlRrSCYYL1FRf9++2Yibkn
 yAlVCnUmOKzOk5SqMrsAVMeslpnKW0/kaehkSZ7DNB2M218fjlcNg+HABi+fevxuRoLK
 PGcBlT+KpnthEkk2HsdmmJQoDZeJ+3st59Bwm8CW7sXCxHVkePD/yEg7brB5DkYvPtk6
 F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
 b=Lvzm3nlz+BI5vtSx8ki4OS2g/fTTGdC+PJAJuA32z2ymGQ9DJUdG4wd1S6eE7/1QZY
 eRWeAR8OH9nwzClTwtKxtJMSSiAiGUm7VZKpuKGSYaY9uIRrm99Pm5nsypW4YMCcLDIi
 0pOig2Wu/rEm0n+BNoQfLFCHHdrFv1f7tTXNAX1WwzoUQSa8UEMqLfPt47psYEWGrDvb
 3chU4bkG43yFlxv04nTpI7hfkbehHICYCVIJGh5lNGrCc/Wz4X9kJG7BG0SEknrT4Nbd
 X5OC5VF5XVpYvEYeWA7g7KCV5cyCSDDgjiCeeqBE3+q2w9VHb7m0XLiZVYeDXgcdNtRC
 eJQg==
X-Gm-Message-State: AGRZ1gKGi5/SGXFSBKVUNjYNcphXXwCX4jkoUdAk+0lhZ+c+qku5FL0U
 Qt3Wb3/okuH/0Ce04rwRix4=
X-Google-Smtp-Source: AJdET5eEsyeFs/lpJXpJYu/HYdX2RxwOsfZDwN5MUryd3bU0YO93jcAbvzClWY6bJOjVIthccDcfRw==
X-Received: by 2002:a65:47cb:: with SMTP id
 f11-v6mr4900412pgs.166.1541023377095; 
 Wed, 31 Oct 2018 15:02:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q76-v6sm60412618pfa.18.2018.10.31.15.02.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 15:02:55 -0700 (PDT)
Date: Wed, 31 Oct 2018 15:02:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Burton <paul.burton@mips.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181031220253.GA15505@roeck-us.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
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
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 31, 2018 at 09:32:43PM +0000, Paul Burton wrote:
> Hi Guenter,
> 
> On Wed, Oct 31, 2018 at 12:52:18PM -0700, Guenter Roeck wrote:
> > +/*
> > + * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
> > + * Takes u64 parameters.
> > + */
> > +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
> > +{
> > +	raw_spinlock_t *lock = lock_addr(ptr);
> > +	unsigned long flags;
> > +	u64 prev;
> > +
> > +	raw_spin_lock_irqsave(lock, flags);
> > +	prev = READ_ONCE(*ptr);
> > +	if (prev == old)
> > +		*ptr = new;
> > +	raw_spin_unlock_irqrestore(lock, flags);
> > +
> > +	return prev;
> > +}
> > +EXPORT_SYMBOL(__cmpxchg_u64);
> 
> This is only going to work if we know that memory modified using
> __cmpxchg_u64() is *always* modified using __cmpxchg_u64(). Without that
> guarantee there's nothing to stop some other CPU writing to *ptr after
> the READ_ONCE() above but before we write new to it.
> 
> As far as I'm aware this is not a guarantee we currently provide, so it
> would mean making that a requirement for cmpxchg64() users & auditing
> them all. That would also leave cmpxchg64() with semantics that differ
> from plain cmpxchg(), and semantics that may surprise people. In my view
> that's probably not worth it, and it would be better to avoid using
> cmpxchg64() on systems that can't properly support it.
> 

Good point. Unfortunately this is also true for the architectures with
similar implementations, ie at least sparc32 (and possibly parisc).

The alternatives I can see are
- Do not use cmpxchg64() outside architecture code (ie drop its use from
  the offending driver, and keep doing the same whenever the problem comes
  up again).
or
- Introduce something like ARCH_HAS_CMPXCHG64 and use it to determine
  if cmpxchg64 is supported or not.

Any preference ?

Thanks,
Guenter
