Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE6C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 06:13:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0135561A0A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 06:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0135561A0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6BVR2jjNz3bxM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 17:13:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=BN177VN4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=BN177VN4; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6BTz0wYPz30HV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 17:12:52 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so2080780pjq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Mar 2021 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=HVffRheGZvUm096i8rL3qZdYAPWZa2jcLg62qh4EMbg=;
 b=BN177VN4tIki5x7mq197cJpgGWmB/tDhiLj5PpVbW40dTDlstqyj7/uB0+ZhaiN21g
 I7v0gN6JcwN1MgwK2tedFC1HTPpxiphCtz8xY9bk2hM54Z6Ju8Z+Xe0Aty8lqcrtdrxK
 SgKSnZxr2DfpvYwnjTLteEdgC4wSmExC0ATxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=HVffRheGZvUm096i8rL3qZdYAPWZa2jcLg62qh4EMbg=;
 b=OstNYpSwy/t1QrO31BSTNNdV4neuVwyCkQzw0V6WIBhXca9ZPw4Scdy/ATIJtcW3lp
 omcQGdvG7UczsKRb50GJjSnx/bqScaAh2P8nJ+KQG8iymbewwfswptrmLwBAJ0x6qlyA
 7hZ89hUMcgWLSRqSb398GE+jWsKPPgo6d9R4+WiubG/FWWNsvjxmsIY1xwk4ZfokNxM3
 Jh0648RyP5s9X7hTsJyuUwhKz/70Zvwq0/bfAaIskIrpMDbGxR7DvxPSqz91K9zo1r/S
 aOWo7d2ISwZSe4gNBB4tHImeiIYQ8Zuxv9sNZRsJ+T769cI4cJ50lsqKxBwWvITwIEaS
 CyBA==
X-Gm-Message-State: AOAM530xxG8hv2oi3jIVjb4oieZ1zXXfvZmT1cM1DQgByMnvmzwKn8h1
 5ucuXWKgZ/xVxsZdH2QLIZqjNQ==
X-Google-Smtp-Source: ABdhPJznKFGDHVIciDMw0fp2LT9xK3z4ixOcU51t08f2cxF1LZ/qGOqz6Ubsp1k9rldJ9Yal+YCtBQ==
X-Received: by 2002:a17:90b:307:: with SMTP id
 ay7mr12146056pjb.110.1616739168822; 
 Thu, 25 Mar 2021 23:12:48 -0700 (PDT)
Received: from localhost
 (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
 by smtp.gmail.com with ESMTPSA id m5sm8157716pfd.96.2021.03.25.23.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 23:12:48 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/iommu/debug: Remove redundant NULL check
In-Reply-To: <87r1k2795x.fsf@linkitivity.dja.id.au>
References: <1616406217-94635-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <87r1k2795x.fsf@linkitivity.dja.id.au>
Date: Fri, 26 Mar 2021 17:12:45 +1100
Message-ID: <87lfaa789u.fsf@linkitivity.dja.id.au>
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:

It looks like the kernel test robot also reported this:
"[PATCH] powerpc/iommu/debug: fix ifnullfree.cocci warnings"
Weirdly I don't see it in patchwork.

I'm not sure which one mpe will want to take but either would do.

>> Fix the following coccicheck warnings:
>>
>> ./fs/io_uring.c:5989:4-9: WARNING: NULL check before some freeing
>> functions is not needed.

(Also, while unimportant, that's technically not the error you fix here
as it's for a different file!)

>
> This looks correct to me, and matches the description of debugfs_remove
> in Documentation/filesystems/debugfs.rst.
>
> If you have a number of similar fixes it might be helpful to do them in
> a single bigger patch, but I'm not sure if coccicheck reports much else
> as I don't have coccinelle installed at the moment.
>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
>
> Kind regards,
> Daniel
