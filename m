Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92CC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:16:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252F061404
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F061404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3r4226q8z3bTX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 11:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=Cvlgs+Np;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=Cvlgs+Np; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3r3V1Plsz2ysk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 11:15:33 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id s14so11969825pfd.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=RKwyIi/K5XaETzqoqm4WMdqe7E/KhHuq7Le7Ka2YjZo=;
 b=Cvlgs+NpqEcTvOMV5P6/+mUVRIysv58TIOVonXthVSAh7wJ3jE3HZ/o6C3jpuKvCgu
 48mLKRKQ1Y7YVMrEfpdVsrbrx2peVeArbCa/E5txnNO5isSq/PVQWdThKfQWZHBopitR
 KRLbNQpnkxXG4MwAz7TDmt2uY8F12u2Lq1F2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=RKwyIi/K5XaETzqoqm4WMdqe7E/KhHuq7Le7Ka2YjZo=;
 b=K40BmnEbLtMr+HiU5OoDOpMI6iETuczCsq7Pf20G2hRYXwu81UtPmvRW8zlDaW1ESl
 CeQPkUZt68f5PhD60DyV+l4gZKJBhlzHQSw9RDH8oUXHUSfRRSiEb5QwuSwvd4/Vy34B
 OXS5apJnN0PK47nGeyRUp2hocwdarE3/lpmgK/O/Zbi0Lx38bmrJjxM8fo8O2bGjODt7
 sotSAf+SAKMN8BXfO0NzM7eOTeHOafyA1gbxSRmLBmvafebrdX10mxwEu/m1aA5ZQ8iY
 oFa/y9rWnAG50Ve3TGp5TLbhB43X/NikwgD8QjRvRM17LmmeNIFkGHNpp1MjOnJC5JPw
 +SZg==
X-Gm-Message-State: AOAM530714maLbKqGXL7kmUxB02mK8jnNqyIBO+0BeuZ4FWwLuDeIEnC
 1lxwiq1sbgy5CrtEhtpyDRFIQAKhHamMMQ==
X-Google-Smtp-Source: ABdhPJyVslC2xB3LtbnQtrHIFgFOuA6bn7Sl67sXE45qYcgaIc6sq9fdwoodYtmRF6HP23WnVeIe/w==
X-Received: by 2002:a63:1453:: with SMTP id 19mr19661812pgu.270.1623719728077; 
 Mon, 14 Jun 2021 18:15:28 -0700 (PDT)
Received: from localhost ([203.206.29.204])
 by smtp.gmail.com with ESMTPSA id y29sm3203776pff.161.2021.06.14.18.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 18:15:27 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix initrd corruption with relative jump labels
In-Reply-To: <20210614131440.312360-1-mpe@ellerman.id.au>
References: <20210614131440.312360-1-mpe@ellerman.id.au>
Date: Tue, 15 Jun 2021 11:15:23 +1000
Message-ID: <87v96gx710.fsf@dja-thinkpad.axtens.net>
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
Cc: r.bolshakov@yadro.com, a.kovaleva@yadro.com, groug@kaod.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

> The fix is simply to make the key value relative to the jump_entry
> struct in the ARCH_STATIC_BRANCH macro.

This fixes the boot issues I observed. Thank you very much!!

Tested-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
