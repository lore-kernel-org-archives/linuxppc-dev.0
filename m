Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAC606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc97Mn4q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQq771SSz2xqJ;
	Wed, 18 Nov 2026 00:40:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794922851;
	cv=none; b=RRiG+3NmPUNTzEyUk26cP/0DCFJRREwCRYbW9VSWyEhDx7oAPCb5nANXTYpS9maDGOh+SlBslz5T+TN4vi4vmrH0gNwaoYJheKnSBHvcXXlM/4ufuElXiSOwRR3jRrvPK8xP0vBneJwZZCsJ8DAVT1bY/kfvAUysH4hJUoUugfPnacwC5zkk619IRLSdb8hTtgJNp4fGmBGJFP8l2rItcAk0FMDFLAZBaqoQiO/Oc86hZylmhJEWO+KGD4Sli3mbBNZeoiEUBYiBStU/ejTxGuFXHGhyFChDLl3PlpSX9YSeLkyis4ZESXYdKQ31ZsFlrTsRK/1lr9OXO7oecPOKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794922851; c=relaxed/relaxed;
	bh=2onvA3w1AX2T652rmvjKcErttBTJ29lM7H+Z12l/3jk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JaQpmlHNGMD2SMIvufNxdE/xFpwGyuP2zIXJjANce+sNSD3MKAXuMWvqsaKnGbkJB2Y2IZw78u3OGPInX26wLZ2odlNeP1P+mI6sIR8LcQcTUesmPkR/QiGpyV9GMnN8m9RWFOUNVhiY0CdG+wqidlejiGV1JMWcLxt06vqZEmQ0MyhT4zoQ8rkEZiMF1peI9L0RmfKdF9IFBPKwM4fY2Ln8PDRxgHUNHeUPdXBI8LJQSWQTzzvvtGrFjKseBBMqQ4qsHZeOdMJqnojcxvd6H7rFELE6QgRiEsESJ7ULhz37gZzECze0GjmVR5uNGttZKwifh3m2IjxPoBfpa6P14g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc97Mn4q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc97Mn4q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQq70Y8pz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:40:50 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-380b40319bdso2203516eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794922848; x=1795527648; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2onvA3w1AX2T652rmvjKcErttBTJ29lM7H+Z12l/3jk=;
        b=pc97Mn4qMWnxXZdefz1VJyVPw7en1FN/PjlzgDHrPBGoPWm2QPSFhR1jD/nCe1AHrP
         nREsZZCfDtoXz3ThGmVOLgdvQ4s5KgxuTsbK/W+VyX1yqdaVsxQ/OhFzjfw0xzNIHZmW
         KFoc+XTyNVyr1HJrR3KFTIZoFga6VUmGyxCIeFmzUd8i97cFNh++/ePt1Sg9qGQYqcod
         kaOlqAwWKAkSRsmPh4Rfu6fnPqCOyIMr852jkQI+XtG3zxnOYIYjfBtJRROitW0q2WiV
         n4Stw7aWvPtmtmDDL0X56AGhf29jJN932viFSBMo6e2XPQjETYq7nxbVCLBkGNJZE3Au
         hDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794922848; x=1795527648;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2onvA3w1AX2T652rmvjKcErttBTJ29lM7H+Z12l/3jk=;
        b=FCvIfVzEVx25maZA4MO9Lrvi8ZeAkDut4myBkRTKmoV29JmF0SfwjCtBxvMhHelsVx
         7iak3u6e/xmjZXHiZgVDHcXAcPQprhfZGF/UZp128txFJXaQkDsEhDJZS8cdDjxUPN7e
         3YYHqSEsUyizfjsh/ynsqdP8a4iJXWt4yuXUljoLYYHa0EchhF4oHQwLcPanRDRN4IQu
         oYNKRZx3fraZRa2WycAXYQQSzc1z3qRmb3DQ5kBUEHjpOCxzC59Q/VLIqs1QJTHD0wgh
         QXA74NhnVAauHHwmZpiHQglYXKxFYD/E8DcdTAij4rCCXsxGVCT+T0WmTkzx3InhW6m3
         da0g==
X-Forwarded-Encrypted: i=1; AL+hErHwzv9cLPbKsyXIdgP/m+tqvc+7cauc5YZZDd2qI3jYUB5I+bAg/IRr1XF889AiCIFIZl7HNfYF7icEFUU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8AMkJrK8U7Cdw/gXI/CYkKIw44nG7bIxLcCv6mUQiFUH6f1JyO
	PFBYEnD4SC/dXWfiyzJFKWJXniW3yRq+ajp44rkp2NvjuPosStcigpu2
X-Gm-Gg: AZFdTZfWdBlcdLUlqEe/wFsL3EHt1tDaKrzzJlAnruOnYgy8G4wRgvWVHood+gTcsXR
	+W3mPC7fdj9K4GdZUJE+pmGZvH84owkrhP8nSN1EScnW+yYnp27JLN3WdgkV9Fxk9mmmOZeC0kD
	AwVhuPWPqe7JHFg+eFokrtR/2IyEugntlSI+xwenIIqNslNuxJue7r4asH45XPU3eVDE/NkEWnH
	piwrhTIkv3HJEMEkQGCOHze0zefrBI9PMauvZJipgz5aDomrECtkyA5Nk2Z4LvAZwXYvl/sT1M3
	gkNaYksY2jaAqkL1W9uxnKB23Tjto3PS5Nfuxbudrzn7f0htohRaLQEwZK4oPzl3NGOc4Kt6d8j
	TtO1yCmOYxN7z6GH3iMs+w5EGF/geuO6kjduZNUSWB9zHBEzV1dbrX68S/GRq1RnuzC6GhnS7UP
	1O9aFPXPpAjkfhHZA2YCeFAbah3wV6FRsrERZQebYytQua+sWiCaSlMHJ+yzQ3w09bKLcm6pwyx
	SdMbe7NKSuzp3mD+IZ2c7K73jrtEWdV6Rx/HOrYB4kUwCp/w1P0/68hbHl8v04IViRab1wuYdSM
	6l83R3+svsBpMelA2wFfaHo5MA4=
X-Received: by 2002:a05:7300:e9cb:10b0:369:f9da:a70f with SMTP id 5a478bee46e88-3796676acefmr15663596eec.17.1794922848321;
        Tue, 17 Nov 2026 05:40:48 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3815045b90esm6193856eec.13.2026.11.17.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:40:47 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v4 1/3] PPC32: Fix hard_irq_disable to follow tracing and lockdep state
In-Reply-To: <20261117131612.707038-2-sshegde@linux.ibm.com>
Date: Tue, 17 Nov 2026 18:58:41 +0530
Message-ID: <y0ar7fjq.ritesh.list@gmail.com>
References: <20261117131612.707038-1-sshegde@linux.ibm.com> <20261117131612.707038-2-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On PPC32, the code for hard_irq_disable has diverged and it doesn't
> do lockdep/tracing anymore, leading to use of both local_irq_disable
> and hard_irq_disable on PPC32 to overcome those.
>
> That is un-necessary, instead simply calling local_irq_disable is
> enough. It disables EE bit and does lockdep tracking.
>
> Subsequent patch uses this API in KVM code to avoid the warnings.
> Wider use of it is possible, but it will be taken subsequently.
>
> Fixes: 5d38902c4838 ("powerpc: Add irqtrace support for 32-bit powerpc")
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> PS: Fixes tag is based on the historical analysis done by Ritesh.
> I haven't got a chance to delve deep into it. Note that it is old
> commit and lot of code interleave would have happened since 
> including local_irq_disable at some would have added proper
> lockdep support.
>

Yes, not sure whether we really want this this fix to go back to that
old change?

Maybe we can add CC: stable and keep the minimum kernel version to it,
so that it gets applied >= vX.Y+ sort of. Instead of stable backports
picking this change and taking it all the way to a very a old kernel
release - which in my opinion is not worth it. Thoughts?

Do we know from when we started hitting this problem? Should this be
after we merge generic entry/exit? Or was there any previous kernel
version too, where we were hitting this?

>  arch/powerpc/include/asm/hw_irq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

BTW, thanks for taking it forward.

The change looks good to me. So, please Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

However, note that we should still get the stable tag / fixes thing
sorted, for stable backports to do it's right thing.


