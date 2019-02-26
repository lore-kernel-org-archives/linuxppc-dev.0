Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 00:15:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E852184D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="a2VGNR5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E852184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447fVD04jmzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 11:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="a2VGNR5V"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447fSX3J03zDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 11:14:18 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id m2so5278259pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Wq6jS9d3I1UJjw6p/TlUWwebE/MBBo8c+1jDjBKs8ls=;
 b=a2VGNR5VzBt9nFsCVXFaehciLD9jLS+l68ghfVQ+vz4B5tHaD2N2+JjIpNVPyzBbzN
 aXSmhlju6RYOAvl6yn2cSEiObAfnJD7Eis3OC7mKgHD1WGIdK3Ra1YeDhsTIDGrmgUL2
 MQfGQz3UpvVnvQb0iEBH7bbkc59N7ngfz4wtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Wq6jS9d3I1UJjw6p/TlUWwebE/MBBo8c+1jDjBKs8ls=;
 b=Zx2KFt3whr7xBF6ioJryW2FVwYPwRhCsDQD6Bl+ar47bHIXfgzWOZ/OoevPyYSOjLH
 L8hsw/B0Y8IdYV+AGYRtIv0Z6wg6aq4zg66bLZ04r0tPk7hufvzDSikMZO7gDQur4MI8
 bZCucB52X1wieNt6Ut+fVJQWf67SF1vmoQ2MBIKhd3QESFpEN/v71MiOvx0kDDZ8SgZR
 ujhMQVa+u6tw4uDwMtxBUcz03p/CMwBo7usEb4hVr1Li4EDnr96/+VE3AlM6a6dS/GQ2
 GMbE/f8ZFuEYga9yydR4mtXxeGCWSPYI/mg7Zs3oqbNMjAVBb4gyYZmP/3MrVgFN1B5c
 qlVg==
X-Gm-Message-State: AHQUAuaBFQTF4EmXs//18ZrtFTtttBn2fVeqvEY9rzeR65SWV/A4Snh2
 dUwYMT62XUqrUDX/H8jKK9+Kbg==
X-Google-Smtp-Source: AHgI3IbWGIGRdgKSWlxv/RELxN4oXbzKHEJvTrzuxVZ2TCG16SIcWpr/p3ZYmVoBR1mls0D61gLAEA==
X-Received: by 2002:a62:4287:: with SMTP id h7mr4952760pfd.110.1551140055044; 
 Mon, 25 Feb 2019 16:14:15 -0800 (PST)
Received: from localhost (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
 by smtp.gmail.com with ESMTPSA id
 186sm18334289pga.36.2019.02.25.16.14.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 16:14:14 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
Subject: Re: [RFC PATCH 3/5] kasan: allow architectures to provide an outline
 readiness check
In-Reply-To: <4ff60641-684a-8e86-0193-ef5380602096@c-s.fr>
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-4-dja@axtens.net>
 <dd65d283-5f6b-8e07-37ba-8ebc24cd5294@c-s.fr>
 <87zhqt39pl.fsf@dja-thinkpad.axtens.net>
 <4ff60641-684a-8e86-0193-ef5380602096@c-s.fr>
Date: Tue, 26 Feb 2019 11:14:10 +1100
Message-ID: <87imx72yp9.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>>> Unless somebody minds, I'll do the change and take this patch in my
>>> series in order to handle the case of book3s/32 hash.
>> 
>> Please do; feel free to take as many of the patches as you would like
>> and I'll rebase whatever is left on the next version of your series.
>
> I have now done a big step with v7: works on both nohash and hash ppc32 
> without any special feature in the core of kasan. Have to do more tests 
> on the hash version, but it seems promissing.
>
> I have kept your patches on sync on top of it (allthough totally 
> untested), you can find them in 
> https://github.com/chleroy/linux/commits/kasan

Thanks - I've got sidetracked with other internal stuff but I hope to
get back to this later in the week.

Regards,
Daniel
>
>> 
>> The idea with the macro magic was to take advantage of the speed of
>> static keys (I think, I borrowed it from Balbir's patch). Perhaps an
>> inline function will achieve this anyway, but given that KASAN with
>> outline instrumentation is inevitably slow, I guess it doesn't matter
>> much either way.
>
> You'll see in the modifications I've done to your patches, we can still 
> use static keys while using static inline functions.
>
> Christophe
