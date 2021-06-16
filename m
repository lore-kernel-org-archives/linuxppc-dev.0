Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AFC48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 04:42:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CED610CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 04:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CED610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4XbR1hQtz3bx6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 14:42:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=lKJIvf6p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=lKJIvf6p; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4XZy4Tbhz2xZW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 14:41:46 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id b12so466372plg.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=yNLs0De7jThuF+2jQNPxEWOcx6TgeD4ov6vuIyTpd+A=;
 b=lKJIvf6pt1/GdaW2KeqS7wKBIja3w5kpORjD4jLrNWSEFfEOkW3onHIDqBu0GFngkS
 lxkWv44pwySHTfYWybvEhaBirmSWSJMqraifs7VnqCLsdljizzbcTlkUb4DkuOyQKb70
 r/j3tlzKy+Tk59kdBEbDxcnNRfRigkfAmLaJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=yNLs0De7jThuF+2jQNPxEWOcx6TgeD4ov6vuIyTpd+A=;
 b=YPhBa07yGZKWnjy2jwHYEbaVm85aIQEwqaHd1qVvHbgiE48HsI+wRlyYMr1aAwobEs
 KBQj0H7alfi9QDXn3dpT0ujJgW5COsxYYHLbeWUs6UxvxrglqoLgIuLG4j1LtibnZa9l
 LIRIbK2/ebGGh6VAhpm1bkNoSagi1plI+qzRZyviCktb2vn8BaduVSB2dpxlHyh1woBf
 2ziodQd1J8I/DEhCiKHtopv+HjI73F7K/uucAsPgSu1RA4WFKeN0P1dgFwaQH9Sv+Rhc
 BSZsCqHG4eZB7+wS1NeBVMEwVCjNFrMVKlMBd9f7vwUuZU8wd6sNDu9CQWbGfMSbRKHy
 902A==
X-Gm-Message-State: AOAM531vRQx9MbCLSTrR0rGwa6BwNnvJgdsm9B7zGBomkHYallI90iet
 0gtpwkEIbauuEPJazRP0lCcRZQ==
X-Google-Smtp-Source: ABdhPJxh2trs7JHKAmnz6ypTMfnczKQwyngda5/fDSTUi8HksJLDs/vs/uzec4cWsIlm+tLEn9utjQ==
X-Received: by 2002:a17:903:228e:b029:101:af04:4e24 with SMTP id
 b14-20020a170903228eb0290101af044e24mr7415002plh.3.1623818503317; 
 Tue, 15 Jun 2021 21:41:43 -0700 (PDT)
Received: from localhost ([203.206.29.204])
 by smtp.gmail.com with ESMTPSA id v10sm726962pgb.46.2021.06.15.21.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 21:41:42 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Marco Elver <elver@google.com>
Subject: Re: [PATCH v12 2/6] kasan: allow architectures to provide an
 outline readiness check
In-Reply-To: <CANpmjNN2=gdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB=s_ZWndJLg@mail.gmail.com>
References: <20210615014705.2234866-1-dja@axtens.net>
 <20210615014705.2234866-3-dja@axtens.net>
 <CANpmjNN2=gdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB=s_ZWndJLg@mail.gmail.com>
Date: Wed, 16 Jun 2021 14:41:39 +1000
Message-ID: <87fsxiv2t8.fsf@dja-thinkpad.axtens.net>
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
Cc: aneesh.kumar@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Marco,
>> +       /* Don't touch the shadow memory if arch isn't ready */
>> +       if (!kasan_arch_is_ready())
>> +               return;
>> +
>
> What about kasan_poison_last_granule()? kasan_unpoison() currently
> seems to potentially trip on that.

Ah the perils of rebasing an old series! I'll re-audit the generic code
for functions that touch memory and make sure I have covered them all.

Thanks for the review.

Kind regards,
Daniel

>
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANpmjNN2%3DgdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB%3Ds_ZWndJLg%40mail.gmail.com.
