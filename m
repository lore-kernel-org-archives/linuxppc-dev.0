Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 00:03:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E0206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 00:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFu9ELsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NTBb0tRlzDqxD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 10:03:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::744;
 helo=mail-qk1-x744.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fFu9ELsM; dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NT7y41p1zDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 10:00:46 +1000 (AEST)
Received: by mail-qk1-x744.google.com with SMTP id b6so774492qkh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=wKnP4cRDwV5pisveNqypr4DPC2I8ojFUWdJ2DYvbn+s=;
 b=fFu9ELsMYEGcxZpGuSbxGZ5BhePy8a4gaFOp/1xFDw22VuQQ9hU73GRZaeoVCzX9EN
 69pqPdn/N0gZmRsUpxGKx6E35AmCwnb869I6uvf9KIZ7Jo3PcMtRPDk5tSb4RZVOgaxs
 7/AsJfkG9my8BEBrUp5rMnHJaGgxSyVxK9VUjXu7XuRc8yliTk3iFR+m+gaaNTvbqgsw
 +unSpk4sF0Tv+u1e1LTp6O6Whkz0ZrTrgncSheaLDLYKW9y85JjkmsNpUvQiBWNREqW0
 PARvxwirZ6IRnkX877H14Fxgx7hYyuOnn45UXNLduOebj5/4rWkL+l1ep03TTvQiX1/v
 qIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=wKnP4cRDwV5pisveNqypr4DPC2I8ojFUWdJ2DYvbn+s=;
 b=o2SEJaOGQy7MWL0fv+bToM1jroMUniQwCSOlE3AMKUamyykR+xh32clFq8G3Q6uyUS
 cXJwSsOq7Vkwbn1rhbsp5fGtwZVg3LzLnKfbf/5rdmjRWHEEe5ImnYCM1S1cJGlzNGny
 eJ96sfnuALMOseEqbNwO0ggtxFAgxo/PAfYjRB+eh3CQ/qfnHjqgNGWeq1fN5OyKI/JL
 IYw4/pCryrHR35McUuNzg9CXJUnw3k04yKewgh5D09zXph7HvCxTkaNMBmQwLjpjHN1O
 KLCUJQUoNCZt8D9rBFechLxipKenCGiLrtDvYpRPrBBI27vKdiBh5iJkAqOkVTPqH4z3
 Vfaw==
X-Gm-Message-State: AOAM530XQ2XFlNlPTk5BEc/kw3eaNOG7RS/jgaLZcQx/7Yr4rOGJnadU
 qLHKumNCnwN0RIXR/3xFePc=
X-Google-Smtp-Source: ABdhPJxzlVVZEyGno1YM1Z74EjtIzkmN8CMMFZ3IbQ1B4TaEKsA5p63EFbGw0iIYxgkADVp1jJ1hgg==
X-Received: by 2002:a37:a1c7:: with SMTP id k190mr826162qke.469.1589500841967; 
 Thu, 14 May 2020 17:00:41 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br.
 [179.125.143.209])
 by smtp.gmail.com with ESMTPSA id c25sm330412qkm.119.2020.05.14.17.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 17:00:41 -0700 (PDT)
Message-ID: <344838598649fd638c9408606efe8db4c69db9cb.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/rtas: Implement reentrant rtas call
From: Leonardo Bras <leobras.c@gmail.com>
To: Nathan Lynch <nathanl@linux.ibm.com>
Date: Thu, 14 May 2020 21:00:29 -0300
In-Reply-To: <fc13b26ff3d2ea2e84049eabda0c60a60d851b40.camel@gmail.com>
References: <20200514011245.127174-1-leobras.c@gmail.com>
 <20200514011245.127174-3-leobras.c@gmail.com>
 <878shu2vjp.fsf@linux.ibm.com>
 <fc13b26ff3d2ea2e84049eabda0c60a60d851b40.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-05-14 at 20:28 -0300, Leonardo Bras wrote:
> Yes, you are right.
> I will also add preempt_{dis,en}able, which in most kernels will
> compile out, but it will be kind of 'ready' if we ever decide to
> support PREEMPT.
> 
> Thanks for the feedback!

v4:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200514235138.150722-3-leobras.c@gmail.com/

