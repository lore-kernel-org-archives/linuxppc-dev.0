Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A6C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 06:36:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B877B21A4A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 06:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL7JEVE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B877B21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442HMp6283zDqBh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 17:36:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hL7JEVE1"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442HKx16tSzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 17:35:00 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id e5so7128647plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 22:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+RvM31ML5GWoYLjXbOkQf//ZzvbBj45wQlkIuTWzNyY=;
 b=hL7JEVE1voaP97vTCtc1VwjXO9GVvqwVYgxco04D+H5ErHp0HkAezvh5cC39fNZM53
 M/lTkvoIKeRPgbuAnNkRoSSuY01WC4P+LMuM/++9rbphY7Me5/2SGCE/QwQyb94SOowa
 ZirJ5r8avOT7kgHC9wJsGALS3hC3rn8kJ62Oe+OiRooHvzAUTnS6X+61Ix2qW45RiLJQ
 EzR11XK9+XtgTw/L8uBZJ3hBZ97T9GUsVW0SjfA3+VAnHR990K3IMBJy75KdREQlDvuy
 U3nQZE6n/52h/v4iDvA9dCcQZ6Om1ZoCMRWyRZVcc9X0JuhMJxnF59J2xxMjsdSJhVTt
 CrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+RvM31ML5GWoYLjXbOkQf//ZzvbBj45wQlkIuTWzNyY=;
 b=UwCjOvk5PFu+93soJIY9smzWNmDoCT7N3MN7LstP+fEHEiM2YJttWDOVHyO9x65199
 NdjH/H7SRV2yhS8+yVjistKUqn9M02AHxUv5WDtWGU5qnyknVWM/6Lf84O0tj4nghghc
 yUkqLjXGpEv7qB9bdYTbOqLasd5fBHI+IHLuIU6PYcWXtxLqXWFem+TDRfq5Ev6LiYvw
 HQPcfxOdsbZe1AfNVsfnGbiNf1EujdqWUPkZm6hPlav46YfZ2kU0EB9jmfP2giRGG0wM
 1fvmwtJMeY0pDdQJlxZzL/BQGWDDQQCyj5i4Ivsqf46Aa47ohlOL0h8F4jsE7tqmt5jY
 PobA==
X-Gm-Message-State: AHQUAuaom/r43/YiKksv/ti4D2jU9xYcOljiXM7jWOYzXeO8tFEA97wE
 mJIVOc21Ob2xom4oAZ4sqSU=
X-Google-Smtp-Source: AHgI3IZYUWw6X71waWAKx1N3CDWjclLSs/d/Wpz2r5DgawX7wMedf/Dj9D944/ytldPzvtTBYMN5sw==
X-Received: by 2002:a17:902:2a66:: with SMTP id
 i93mr18904051plb.128.1550385298491; 
 Sat, 16 Feb 2019 22:34:58 -0800 (PST)
Received: from localhost (220-245-128-230.tpgi.com.au. [220.245.128.230])
 by smtp.gmail.com with ESMTPSA id b197sm9854438pga.89.2019.02.16.22.34.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 22:34:57 -0800 (PST)
Date: Sun, 17 Feb 2019 17:34:54 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC PATCH 0/5] powerpc: KASAN for 64-bit Book3E
Message-ID: <20190217063454.GD31125@350D>
References: <20190215000441.14323-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215000441.14323-1-dja@axtens.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 11:04:36AM +1100, Daniel Axtens wrote:
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to the e6500, a 64-bit Book3E processor which doesn't have a
> hashed page table. It applies on top of Christophe's series, v5.
> 
> It requires some changes to the KASAN core - please let me know if
> these are problematic and we see if an alternative approach is
> possible.
> 
> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> To do this we require that vmemmap be disabled. (This is the default
> in the kernel config that QorIQ provides for the machine in their
> SDK anyway - they use flat memory.)
> 
> Only outline instrumentation is supported and only KASAN_MINIMAL works.
> Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
> ioremap areas (also in 0x800...) are all mapped to a zero page. As
> with the Book3S hash series, this requires overriding the memory <->
> shadow mapping.
> 
> Also, as with both previous 64-bit series, early instrumentation is not
> supported.
> 
> KVM, kexec and xmon have not been tested.
> 
> Thanks to those who have done the heavy lifting over the past several years:
>  - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
>  - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
>  - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/
> 
> While useful if you have an Book3E device, this is mostly intended
> as a warm-up exercise for reviving Aneesh's series for book3s hash.
> In particular, changes to the kasan core are going to be required
> for hash and radix as well.
>

Thanks for following through with this, could you please share details on
how you've been testing this?

I know qemu supports qemu -cpu e6500, but beyond that what does the machine
look like?

Balbir Singh. 
