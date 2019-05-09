Return-Path: <SRS0=tA1z=TJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFC7C04AB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 16:25:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7C5217D7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7mGhWaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7C5217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450JbH6q1tzDqQs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 02:24:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7mGhWaT"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450JYt4r5FzDqQf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 02:23:45 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id a3so1472891pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 May 2019 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZqtYzU+O8xkixnBvEVTSy+ri8OBdl4QumvuY5tE8XIc=;
 b=P7mGhWaTiYff5q21bj5lLDmC80NzqeYtynH9pGrv56pMqnqMe6x9XiUvvQOylVQbqI
 7XOgv8YB0HQs0drTR6fomNtAsnS14yt+SZOUgW+5v9a9rCmUxR9bSbJOsyXNZwqNkeN7
 /QUn4AhkLoABGtb6BAfUaZrui/beRCk94NOgqq7u9b4OlkLTH0+DQQfMOZ9kzWGePbz/
 +sr+FIxM4lyETLle2RZ/4hwe7HPBwAlQpmR1fnlAsOLNoq13Y9dQIYEVzuPp1Fr71eYs
 6IVE0QNsweXFMXeM7dAVOfvhtaUcJ85LHhvoIlLHzsO4o3tkJ0TExmbfcklFzpMQOlxc
 T+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZqtYzU+O8xkixnBvEVTSy+ri8OBdl4QumvuY5tE8XIc=;
 b=RsKhoZ9BhuFqQoi5f/XdIC1nFPXTqJ7HT2zEoooLs3qVDqLPqU45u6UI2ovnQiBMcd
 5z/kQQuZL4UWh0m7uMk6ABaUxUnyaZ8dhBhCIsRATX/jaaZHOL3tG8MUv8gZSRB9gtpZ
 XhHD1F88SfQggxxGIgB4rid+vKqk74d065Q1E+57k9IMaZUz1/WJJChh6onIcp3eyJwk
 lvNYZSGX4LFSOF4dxCWGPHEMxHZ+4qqhiCAeI+RzplBepqbjPvFUsYW+VfiUI3BBp0sN
 sIrfd2wSX0DVT6mNszaGbzvbmC4B7YjwN/agwy1BJVKbiYr/Z2odqWF7o2g9wh++xSTR
 iBtw==
X-Gm-Message-State: APjAAAUnCIdR9Pm+CPNn82WajMvMuXIxiu+yPqPb/DXjbUqDpDxIWWvV
 v5UrzsT6m1aJQdYdYjD/0Qw=
X-Google-Smtp-Source: APXvYqzESeutcijMnEm2P+b1iANtkkHPtp13kowxdgDlWSg6cEleh1W2tHq9o/AhxuatkxPD8eC0mQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr6819806pgt.334.1557419022431; 
 Thu, 09 May 2019 09:23:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o10sm4251633pfh.168.2019.05.09.09.23.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 May 2019 09:23:41 -0700 (PDT)
Date: Thu, 9 May 2019 09:23:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Build failure in v4.4.y.queue (ppc:allmodconfig)
Message-ID: <20190509162340.GB24493@roeck-us.net>
References: <20190508202642.GA28212@roeck-us.net>
 <20190509065324.GA3864@kroah.com>
 <87zhnvvgwm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhnvvgwm.fsf@concordia.ellerman.id.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 10, 2019 at 12:31:05AM +1000, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Wed, May 08, 2019 at 01:26:42PM -0700, Guenter Roeck wrote:
> >> I see multiple instances of:
> >> 
> >> arch/powerpc/kernel/exceptions-64s.S:839: Error:
> >> 	attempt to move .org backwards
> >> 
> >> in v4.4.y.queue (v4.4.179-143-gc4db218e9451).
> >> 
> >> This is due to commit 9b2d4e06d7f1 ("powerpc/64s: Add support for a store
> >> forwarding barrier at kernel entry/exit"), which is part of a large patch
> >> series and can not easily be reverted.
> >> 
> >> Guess I'll stop doing ppc:allmodconfig builds in v4.4.y ?
> >
> > Michael, I thought this patch series was supposed to fix ppc issues, not
> > add to them :)
> 
> Well it fixes some, but creates others :}
> 
> > Any ideas on what to do here?
> 
> Turning off CONFIG_CBE_RAS (obscure IBM Cell Blade RAS features) is
> sufficient to get it building. Is that an option for your build tests
> Guenter?
> 
I could turn it off unconditionally, meaning it would affect all other
branches. I would rather stop building ppc:allmodconfig for v4.4.y.

Guenter
