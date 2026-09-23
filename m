Return-Path: <linuxppc-dev+bounces-27963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B732EC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:26:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRmw0gLYz2xs1;
	Wed, 23 Sep 2026 16:26:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144768;
	cv=none; b=UVXALFcTgqO3Uu9OCDQqOAHFrBdi7OYOgYuJP015t1lPU5CCMpbGYDGEkQZQW/+N3VqgQIp0BjkoBw2TCzwBPrzob2rq3NCOF/eQvFPyP8/+P8Qd7xUdZDoS8RVMAgN943LzR9aQH1+qj4NGYLNkNk9nnteJq+6YdeGVQkdB4KwOMpLFH/sXn31xa4boVlOz/xk/EtnpNgr1el5jDz2mJvij/tQcHZaYo2udh0xGi9VzwJDKqvCjhWTQSecXIo73mvagDVyxV4VFpKbhfCt2/4/zZ2urimutQ1pFHcnGA1gJF2pl8Gfqn0zUD0obERVGSQlyGYGyWVFImI3rCR/Asw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144768; c=relaxed/relaxed;
	bh=huX+29UHnUwz1P2Ua+5tHqg+gProJN9PFNzUtPLwHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koAGvwrsY/Q7nG8ebVz8Zl1oQMR7YJPxzJwcBt6H542O604vuMx9+LHYBL2vmj3Z35JkJN+mRHD42pjMbqcLlUnckqeBVnQ+m59QjGadQ5mtANU2klyksHotGeqO7Y/dyzzlgrdxx8j/oxeK5yfVM/XWy2FP5ojwvmpjkCZymWo0UcBC93XJIE+XQhB83GNEB+LyGgqBxfxRI/e3bfDaLM0P5/HeNGSbHm3379dqw/eXIdw8uUHdnVyzeFl1g5HyBsVQvvmfjs6WKM6XLE+9+ofSceixF7ezBpwY/L4pAapMMqbH6KooIkoEC91kGi7h648pGrL9AuAE3LT976f8xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dvLfIOY6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dvLfIOY6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRmt6g45z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:26:05 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33c11ef641aso725496eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 23:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144763; x=1790749563; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=huX+29UHnUwz1P2Ua+5tHqg+gProJN9PFNzUtPLwHh4=;
        b=dvLfIOY6dW0bov/XU1gm5bMlcGI9HbmfOKJ1VEGPvvWk/9I1WXUH+KqtXrh1XCUPV+
         xaXn6qNTSN5vAbLKPj+qyPYr5s8lF84TIKkYgJFh10fAdJH03NN6xQOGrA69pGLpbueK
         J3gsPdnafaxyuvtbSghEeuLdkAc/qdHLlUUIoAsYVUR5CoxkICPX4kFNeRilOUNE4Jvm
         Qbe0kK+buJl4zlKNdrTXWpCmJ95x/IJ9FOC9NEhdvEJ7YEcEcUS0rPhceUyOMzBosj6H
         UJInLC7qbQMEzjWrwBp2y81tygNiWL19p+FHYYRilwmhh/nOS9SBlX/qLSp5fa3r8qNb
         grJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144763; x=1790749563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=huX+29UHnUwz1P2Ua+5tHqg+gProJN9PFNzUtPLwHh4=;
        b=S8lsqTWr7u+nZ8hQr4VMRj/yp7Wdszp5YSh1qQKPFaVwLfa/lUXlcr2RWQda42YZuQ
         5ykk7goFT6GyNKTmMkn0vkaVnPyX3HsPQFpSYIZlcdLmYeKhNMM8H5PV7a5fw3vvqYP2
         +WSDTYauETGuTY4J0/D/K6eQQyf98jA+yldHy2e1/gg+fCj2sEFWeWOVF4vvSdU5oka2
         P463J8+cBV2Jz3xqX69D4bCE6Zrc6nOlZro2dPqp9qi9r26yuUcRFdRP/9oL8dnW/DKu
         p+Pa8UbkA48mjc6jFUyTKGOiYgSK+O7PF7WU6aQZzrJ1HELS75ZEWV262U/DsSQTEu2P
         Fb/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqahSQDxZMu9uLj+jRSAGC7D3IASKPYHEBDCvLFLY47jyBUn/T3AOAFeapjP83wCwz98nZ6Uo1TAT4DRE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ki+gAa3+FqO7gGBNrg8CJkiS4FBinzZR/UOa04UTFQi/d5SMl3
	nC7fysF0Z8W+l1tWamlVy4r/h5Vpc7kPysf70V3LMhwEQScm2LfUmbLL
X-Gm-Gg: AYBFou0Vea83wo52WgvKxxapGX6ruqRVuC3X0gIa/n1J0RLGWWaJMCP1aj30ZQrAzmt
	CU0adNrZ3eq37WaMxpICi50OyCPV4QkXbERDXeRRTQWkNhPlPJwkRY5f4KnSNQY/DKGJSb2I9qK
	VzNPdPKJ4LdnxVeloEOqOltvHbAC8iYhUHx36BnGcxfuOEAv0l4WAIEBKuDwv3aPOYeyww9z1Uw
	dZpyKCoAiHp8FbdhEwYGkcArMCUr/CPnYyOmJWWPdPhVXVth5jKf0Hsp+lckLoBK21iyb2QzkcJ
	Z/K+7Q72uRBSnugphXE1VsMQGqcqncaNi38rY/VrzkfkajHtMCKGN6pI4+5j+nGrGpu9WuRxzpX
	ZnTsHxBETHcgjYEjv16QR0M2w1i614B1eEPplfAtKvvHx+Q1Y7dJgIEexBAwTlHy963IoFy/mZb
	Xc8ExmN+kzcQAxVXE8j8t4Iv94fkTs0EPeQwYtItX+t3Bl8pUAzN/mwOQZ/1Lf2HAY5Y/ynHw/w
	im4E1N5ZZuiPL/E2DWgNc/94Pl88v2d2S0f3A5JxTP1IZvZqpnH5Q==
X-Received: by 2002:a05:7300:3a94:b0:334:222:a5eb with SMTP id 5a478bee46e88-33e8e1b69a6mr1466658eec.32.1790144761251;
        Tue, 22 Sep 2026 23:26:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258978sm3416582eec.14.2026.09.22.23.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:26:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:55:55 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: 7.3.0-rc4: DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
Message-ID: <arNweLIOp6IKriw-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922150619.lwWqj1AO@linutronix.de>
 <d8d9ee29-e871-4657-9951-36a3b2b2ea56@linux.ibm.com>
 <20260922151946.4eUhMiz7@linutronix.de>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922151946.4eUhMiz7@linutronix.de>

On Tue, Sep 22, 2026 at 05:19:46PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-22 20:43:14 [+0530], Shrikanth Hegde wrote:
> > Hi Sebastian.
> Hi Shrikanth,
> 
> > What do you mean nothing on recent one? You don't see the lockdep warning?
> 
> I do as seen below. I wasn't sure if this new that nobody triggered or
> the same thing in different shape (and a new report isn't needed).
> 
> …
> > IIRC, it is tricky to fix since softreplay is a unique thing on its own
> > and tracking right context gets tricky.
> > 
> > Mukesh had spent some time on it. Lets wait to hear from him.
> > 
> > Plus we had some more lockdep warnings too. There is effort ongoing to fix
> > them. Hopefully soon.
> 
> I see. In that case I lay low. Thanks.
> 
> Sebastian
> 
Hey Sebastian,

It's really tricky to fix due to soft replay mechanism as we go into a
nested interrupt context during replay. As of now I don't have a fix for
this. I am working towards this. Hopefully we'll have some solution
soon.

Regards,
Mukesh

