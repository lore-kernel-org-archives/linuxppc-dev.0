Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 06:40:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE947610A7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 06:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE947610A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9kq51yWXz2yw2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 16:40:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=YOgXTKw5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=YOgXTKw5; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9kpL0ktbz2xtk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2021 16:39:51 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id
 lb1-20020a17090b4a4100b001993f863df2so6620556pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2021 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=rEF4KYUdSb5CWBi6MI5v/Pak8z3lDENUWkOSW0EU0nE=;
 b=YOgXTKw5WQhv6gotfGLJz97sNh+w8aU1MrjRRelJzCmatBOKDQaInhO8v9CkdXf0yi
 u6D/qwXExXAieVJOfD7QeBF9nztmiLcZxu/kIfcxi3DhOSdqh/TWHPFrEo/z2XeHdJ0M
 n2Odtg1OIhVOVtndGMM6FWJz+MkS90y0ciukw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=rEF4KYUdSb5CWBi6MI5v/Pak8z3lDENUWkOSW0EU0nE=;
 b=sMocLZPJvugsQWuDbQsmYSKcdd7BZ2cNHwVDtgJgESWLUjtZiffrvo1wi/yCFZofP9
 zPrWYo1iL2uvb30sXe8OqKAFah//bURxPgUoYnztWfd+rw415VKzuuUxoh+xeQWpdjer
 Rk/1nF6bENUO69bwZkF0mBhLJAXWa6J339yPbZLQ92/tCZvXlRtZVisCu5DyVMF3SyGZ
 UhEbB0DKpHj9cxytKcUnHluxTTvVJ63JKi/T7qKSExhDx914tu6D6J2x8RFdnUz579Fk
 KcpPZ2MTMQROQ2vPGQCvfx3lfyL7CNMKI0Hi0z1V76OdkQzpRKMVO+mZTboH6Yb2avZc
 Dv5Q==
X-Gm-Message-State: AOAM530ie82C6FQc9+oSlZr9ysRinUnz+EkUMPaPQZ31VFcHw9/IW3hM
 8BT3HgEmVeScwvdMw8AdvbNw1w==
X-Google-Smtp-Source: ABdhPJwL7NgQ/nAgb/LP3qJ3Xedur9JOPRw142BxAWhI1wZK/kRRuOne07p/sXkXJk6jkvRCtpeopg==
X-Received: by 2002:a17:90a:7:: with SMTP id 7mr10692678pja.0.1631860788641;
 Thu, 16 Sep 2021 23:39:48 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:f1a1:4b0:6139:723d])
 by smtp.gmail.com with ESMTPSA id j23sm4058728pfr.208.2021.09.16.23.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 23:39:48 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2] powerpc/mce: Fix access error in mce handler
In-Reply-To: <20210909064330.312432-1-ganeshgr@linux.ibm.com>
References: <20210909064330.312432-1-ganeshgr@linux.ibm.com>
Date: Fri, 17 Sep 2021 16:39:45 +1000
Message-ID: <87lf3v903y.fsf@linkitivity.dja.id.au>
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
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>, mahesh@linux.ibm.com,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ganesh,

> We queue an irq work for deferred processing of mce event
> in realmode mce handler, where translation is disabled.
> Queuing of the work may result in accessing memory outside
> RMO region, such access needs the translation to be enabled
> for an LPAR running with hash mmu else the kernel crashes.
>
> After enabling translation in mce_handle_error() we used to
> leave it enabled to avoid crashing here, but now with the
> commit 74c3354bc1d89 ("powerpc/pseries/mce: restore msr before
> returning from handler") we are restoring the MSR to disable
> translation.
>
> Hence to fix this enable the translation before queuing the work.

[snip]

> Fixes: 74c3354bc1d89 ("powerpc/pseries/mce: restore msr before returning from handler")

That patch changes arch/powerpc/powerpc/platforms/pseries/ras.c just
below this comment:

    /*
     * Enable translation as we will be accessing per-cpu variables
     * in save_mce_event() which may fall outside RMO region, also
     * leave it enabled because subsequently we will be queuing work
     * to workqueues where again per-cpu variables accessed, besides
     * fwnmi_release_errinfo() crashes when called in realmode on
     * pseries.
     * Note: All the realmode handling like flushing SLB entries for
     *       SLB multihit is done by now.
     */

That suggests per-cpu variables need protection. In your patch, you
enable translations just around irq_work_queue:

> +	/* Queue irq work to process this event later. Before
> +	 * queuing the work enable translation for non radix LPAR,
> +	 * as irq_work_queue may try to access memory outside RMO
> +	 * region.
> +	 */
> +	if (!radix_enabled() && firmware_has_feature(FW_FEATURE_LPAR)) {
> +		msr = mfmsr();
> +		mtmsr(msr | MSR_IR | MSR_DR);
> +		irq_work_queue(&mce_event_process_work);
> +		mtmsr(msr);
> +	} else {
> +		irq_work_queue(&mce_event_process_work);
> +	}

However, just before that in the function, there are a few things that
access per-cpu variables via the local_paca, e.g.:

memcpy(&local_paca->mce_info->mce_event_queue[index],
       &evt, sizeof(evt));

Do we need to widen the window where translations are enabled in order
to protect accesses to local_paca?

Kind regards,
Daniel
