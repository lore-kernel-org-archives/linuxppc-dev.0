Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B236C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 00:52:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFE1613C1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 00:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFE1613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G07qP4Xz9z3bwr
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 10:52:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=NYAGWBb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NYAGWBb4; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G07pp5zxYz2yxX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 10:51:44 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id g12so11899746qvx.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=ZRT8zrQ2N9SjTzmLEJcU4+KmU9ocAxkuy2bveBueYwo=;
 b=NYAGWBb4/K4c7eykm4A+8Rr2kdej77JpxU9svLenVqJEjU/93VhMDPF+MIcPnYv31E
 4/l17VYX914tDAGbq52G/8GflBEBfS0uhf2aH4fjZQA1E3eNJWd1Yfe+Ldhqb0pZPZhW
 RNQvzdHdsIae8EWMxmEBl1BPJsi/4FlCts+FDcANdq5H7FszJo6SgZcs8+/Yqmkux6AZ
 /6xWX8lAcmQUerWPZ1diRnzTYqS4EYkKl8Y4/CUxMwxWo3ye8dch5AJ7b7O+0xO3vBWn
 K1SZNidDcISOj/ZBBhWte68Q6/PxQFmdytGMfGyN0lZ6ub03d82Ykx7GL9sfVxq/ixqK
 f9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=ZRT8zrQ2N9SjTzmLEJcU4+KmU9ocAxkuy2bveBueYwo=;
 b=ZpSY8yx9TLqfnsOCnNRH3GQ+j1fzGRSfFwZSPKtCz3Q74qUXthBaB1Y8N7RKil6DHF
 lJOmdm0RQhEJrST4+wQR+TztA5/dBWRZzWgR9vjG0+S2bVMJHT5kHFQppEkT9s0Hf9Fw
 HxN520Cb/Qj4m/CFLbwVDcfybwPGnOCGCvs+EhbHHRYQD6d4f2Wg/IyjRmjSIPl+dJHP
 wnxBCT2ITUV46ERvzNjBctb+mustYDBbU7/b5tei8fc3WgbC6QpoBgHiqTqCBkjaClbi
 Un9jnhcElfsGo4dkf4ckSnHkX0NIe+un/A61AWlsvSHCJuVKnHq8yq4QeJ4TWCIK8l1+
 hllg==
X-Gm-Message-State: AOAM530cm4MCR9ZgrQvXtGTv33R9O0+MZa5L7rlHcfc3pUib7HlAGOXN
 WqYVFJXEGADeSAutAO3HYPM=
X-Google-Smtp-Source: ABdhPJz9r33GyMkS6NiGQnyNqezGP+ixa/GbLHKfeN6icVFxqKcSM6aeKs8NdbGSE17Qj6fuBvxLjg==
X-Received: by 2002:a0c:eda5:: with SMTP id h5mr3227067qvr.26.1623199899716;
 Tue, 08 Jun 2021 17:51:39 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1002? ([2804:14c:482:87bb::1002])
 by smtp.gmail.com with ESMTPSA id m199sm12011191qke.71.2021.06.08.17.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 17:51:39 -0700 (PDT)
Message-ID: <648b382159009c5f4277d9b9c3f896142ea75d6c.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/mm/hash: Avoid resizing-down HPT on
 first memory hotplug
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 08 Jun 2021 21:52:10 -0300
In-Reply-To: <YL2obsnp4rWbW6CV@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
 <20210430143607.135005-2-leobras.c@gmail.com> <YL2obsnp4rWbW6CV@yekko>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Scott Cheloha <cheloha@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sandipan Das <sandipan@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2021-06-07 at 15:02 +1000, David Gibson wrote:
> On Fri, Apr 30, 2021 at 11:36:06AM -0300, Leonardo Bras wrote:
> > Because hypervisors may need to create HPTs without knowing the
> > guest
> > page size, the smallest used page-size (4k) may be chosen,
> > resulting in
> > a HPT that is possibly bigger than needed.
> > 
> > On a guest with bigger page-sizes, the amount of entries for HTP
> > may be
> > too high, causing the guest to ask for a HPT resize-down on the
> > first
> > hotplug.
> > 
> > This becomes a problem when HPT resize-down fails, and causes the
> > HPT resize to be performed on every LMB added, until HPT size is
> > compatible to guest memory size, causing a major slowdown.
> > 
> > So, avoiding HPT resizing-down on hot-add significantly improves
> > memory
> > hotplug times.
> > 
> > As an example, hotplugging 256GB on a 129GB guest took 710s without
> > this
> > patch, and 21s after applied.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> 
> Sorry it's taken me so long to look at these
> 
> I don't love the extra statefulness that the 'shrinking' parameter
> adds, but I can't see an elegant way to avoid it, so:
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

np, thanks for reviewing!

Best regards,
Leonardo Bras

