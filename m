Return-Path: <SRS0=GP0G=II=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 23:42:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AF364F84
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 23:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AF364F84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DwpX401vJz3d2p
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 10:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VsvkqZwD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=amodra@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VsvkqZwD; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DwpWY3y7dz30Hc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2021 10:41:42 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id
 ga23-20020a17090b0397b02900c0b81bbcd4so8127313pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 15:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=OhE9A5Au8YXDk/nctLEnkZXW+Ihu2QNqqTqW2KwYPHo=;
 b=VsvkqZwDY0Y2DMRxEz83oxJJTYKXYj8IPnK2ertssuutSi4X9bdw6Ec7TgBjj+oLNK
 sgRCVFA/gfIepe0bnE7P3pHBTfQgAR3WfTFxtcNAHGf2LsxJqeU+nm3PpgpMppWFE6Sg
 HbkPARXC0B1Edy2amGuwc0SlFp7ira3KerAmCI1lSoZljHjbyMfdg10SC8BH+bHRJoEl
 2EXrTN8QzMRlS9XOGkjSdRH3unk1L3zY5rI2kdMMtLyEDDlO6+o8cQK77HoxioFrNBCd
 Q5GVIuPvYkrDTeUUZDl2cYLWGpxlgiUMLqizvb0Oi9JNUxAo6tLiCnk7VbfXrd7OhocN
 8JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OhE9A5Au8YXDk/nctLEnkZXW+Ihu2QNqqTqW2KwYPHo=;
 b=CXqMWVjokTjjwbufd56WRNL2OMaA9JKxOvCV4Q7+4B2kw6jJ/MqWIaNgps5MZTAPrH
 Ycz86CgNoCZCkTHhedUGQxS7YFJV93Igp/5EkLZ+axCScnVQJH0axu65YCQRk7krK83S
 jvGQGXlKMScsDsQfNTYdiJxeJu2WDWy2Zzg1Jw1vdOjgY/VtOdgYp80XsCR8GSbfleEf
 6f5B5XQbIFtHj2L0XTQPKHk+ooqe19GFpdgt+KjidcCky1joRTsE3Jo9S3eQ9AMLRL3J
 j1xXWrPUi9YELI16i2/YFIhmzmxFjUXS3WBsqo0LSD4RBih2LHuWL7Tb0m6IDEPp89n9
 D/aA==
X-Gm-Message-State: AOAM533IiEcbW9/JeQJfMp/S1aYiB0shu2rSMeCR6zUb7CyzEJQ7kX1M
 YWGD6jHX/uoc3XkLGap5AP8=
X-Google-Smtp-Source: ABdhPJyZi49r/GiQ7mgRxNi9gpCAs/zXjluTq8TRLgqFqjBoZX6xRifLY9mxyYxMOTYIBgkES3yG3w==
X-Received: by 2002:a17:90a:2a41:: with SMTP id
 d1mr5829233pjg.164.1615419699553; 
 Wed, 10 Mar 2021 15:41:39 -0800 (PST)
Received: from bubble.grove.modra.org (158.106.96.58.static.exetel.com.au.
 [58.96.106.158])
 by smtp.gmail.com with ESMTPSA id i1sm491375pfo.160.2021.03.10.15.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Mar 2021 15:41:39 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id 5389641A81; Thu, 11 Mar 2021 10:11:35 +1030 (ACDT)
Date: Thu, 11 Mar 2021 10:11:35 +1030
From: Alan Modra <amodra@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: PowerPC64 future proof kernel toc, revised for lld
Message-ID: <20210310234135.GC29645@bubble.grove.modra.org>
References: <20210309045638.GI6042@bubble.grove.modra.org>
 <20210310034813.GM6042@bubble.grove.modra.org>
 <3c92968f-7c61-8d36-4001-91f8630de4b1@linux.ibm.com>
 <20210310050722.GN6042@bubble.grove.modra.org>
 <5aa60950-d93c-f700-3b0b-a01f947e8a22@linux.ibm.com>
 <20210310122513.GB29645@bubble.grove.modra.org>
 <df863fb6-2fd6-00d7-b6f3-94a49c2a5405@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df863fb6-2fd6-00d7-b6f3-94a49c2a5405@csgroup.eu>
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
Cc: alexey@au1.ibm.com, Alexey Kardashevskiy <aik@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ellerman@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 10, 2021 at 01:44:57PM +0100, Christophe Leroy wrote:
> 
> 
> Le 10/03/2021 à 13:25, Alan Modra a écrit :
> > On Wed, Mar 10, 2021 at 08:33:37PM +1100, Alexey Kardashevskiy wrote:
> > > One more question - the older version had a construct "DEFINED (.TOC.) ?
> > > .TOC. : ..." in case .TOC. is not defined (too old ld? too old gcc?) but the
> > > newer patch seems assuming it is always defined, when was it added? I have
> > > the same check in SLOF, for example, do I still need it?
> > 
> > .TOC. symbol support was first added 2012-11-06, so you need
> > binutils-2.24 or later to use .TOC. as a symbol.
> > 
> 
> As of today, minimum requirement to build kernel is binutils 2.23, see https://www.kernel.org/doc/html/latest/process/changes.html#current-minimal-requirements

Yes, and arch/powerpc/Makefile complains about 2.24.  So for powerpc
that means you need to go to at least 2.25.  Oh the horror of needing
such new tools!

-- 
Alan Modra
Australia Development Lab, IBM
