Return-Path: <linuxppc-dev+bounces-22148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792BACD8C88
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 03:22:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXNsY6LNcz2xM7;
	Sat, 06 Jun 2026 13:22:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780716161;
	cv=none; b=J9ZQOL+cegtzmw82S4x7bRKjW3xWLHyldkF/T6AKKxCHKban/PXcHQqotpczOFjd7lNnwqPwjt9p4YTmMVJfWDekLhKC2bid3lD86gpqGIiX4XLpfEFVHyOuvPncj3LoEZMTgOAqkZ3S1+9Wg+V3M9Kpv/HXddS8T87i6IuAzgfOAh4Ui5pL4KWPERNakZ3SLNQUT0wjSciZilooov7pI6zmR6ny27rDgvxThDdY2PwjhOS+Gss8oqJ3VdWrvfPQI2Rpb7+siGvFTA7N4CPfgTjsHXdv2GkiE52KCdNBatf7I54UyuTTbIAwRL/QatzUyGjrg6sSjSY3p/UYkHZYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780716161; c=relaxed/relaxed;
	bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=V8gp2G5rILsyb0XbtgmNecNhGb/4V/HdTIyl1BQ0zvTATt4OeEVxmsz/afsBBDkH90alGW7xSPfzDlQEDA0MbR58ZH078W46dbrqrEEkQEZB7b8scLDrnrQBfHLbk7HJgsMku4KPrVGGhpXpWzUv2WBBTsVHzEO8sC609NChPfhkqJe4ZEcBedpTTy5g4rWe8BvQ5/UacznrctDqHdnvItoi7nGSoGY2lRe1XemBBhWeo5clq2SEkx17OYWAaudrhlSajgIMqRnP51ncnWg/qx4lr0571yJrKAzYSdBcjx6pHUpTIzJr8p557y3szYP+yT4LgscOxpzShS1PR4e82w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DoibHwHv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DoibHwHv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXNsX1rbHz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 13:22:39 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-36d8b644473so2633143a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780716156; x=1781320956; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
        b=DoibHwHvDS8k93b9F19D8xkwjfhLEtVR9g9ixhSJmKaJvzwbe4t/kfU+XdGyculy5P
         UjtQ1VETrz5HD100jD1mkdSPRy5Pdte0APfRPYdP37/2lt2lKRzvhN0YWRYgwe7nG7mt
         293VtZrrmCCY4kXqSRqkQgkPrHNgLahyeTTgrf0GBaum851u2po7eXXPRnICYxknosx4
         7Pean3rwhDXHQJdI13exDcdZnnpm2luh1NJw35W7znzwEfmxd+TtvB4Jy3jHnbRMKuI0
         9POMlvsakHlm41abznhjsrnFLIrWb2jmDaAe1suvQ6lQjHELEDgTeZl6vcVSjeZ2OLxx
         EwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780716156; x=1781320956;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
        b=FwhiRGd4XoOCee1k4PDoBvpKRK66b34/ZVdjwJogwPAHs8SrYJIv7JSDmgCI3oRNSE
         eBXXJQs4WSQeOZR0GG2FUw0U/hOzUX1WlC5HptUI8+/qrXrYHuphJF5+mwhhfWvHTwrK
         UCn/kgP5VOcM4YyHYzcRuhmou5xYJAw0tf45eYpzkakN0CTeMw9ZPi5M0xnw+soVhzSQ
         sdksPGf4t7a7cNjSyJxzVBluGiD7rPptDCDqrD0vawmpHpizqJtcSCvaWCKvao8POnoM
         kvr5aauvrfDxK7Ph16WXrLeMkX1E81eFBxFJiND+yLSXg8XGZUgQyzzr8N4ch0yvEWRs
         16Gg==
X-Forwarded-Encrypted: i=1; AFNElJ+uUElS3AH8EF9j/eI+st/sSUEOk3ufCHzeFDLq/cFsYdeNLtLEIx3+7ckp9LwVET4AnyHahM4X8UBmKIU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtQIwbYLB1v7WjCJvKk1I9RwRAfeNrzofjTI8nOhilZTViUn7J
	H4Mcck2Yg5KKAlukT9oeFI6HcB2SycU10HGhgfjEo9k8khlmHdmgeMkc
X-Gm-Gg: Acq92OGM21eg08YyQoK1ng51R3ZGtzqDAdCmgUaVRbdASGMFTH8OSOSbAXsSG246eyT
	mTZjLg3J+o0lF3YvaoA06ePMJMHKqbkbsIIgr+4def2tZmvrvf51frSJFol928m67bsRUguthQK
	tAstyv4QxEVzI0Uov6x3b0dpMOmbjkKTOXcNvxRiZrhTdLlzpZMMlrLtyTedlTyq+KUbC4r4Tt6
	Y/Mdp1nowKc4Kj1sTBBWIvOHsnU1k7UWFESw6B+VV2VrgOiYrJfUIhetSf6htQd4E1YWMs6xLnD
	KMa5Rc/yER1JWF21GUPjg0F2jBnRPCU97jWoMaq/rJE7aG3/jZveCgseClPcIbguF0Yj7S8Jd8o
	UOUdSGbhUEvqBLOq1++8pBn82HaQu7ggVghti4hynAD1gizQvUeCHThaFVrDyyQAPyEc+RAGx+b
	1I73M3XvXWia2aV3wzAHGaRn9gTXkXia0k
X-Received: by 2002:a17:90b:35c1:b0:36b:9daf:1504 with SMTP id 98e67ed59e1d1-370f0772850mr6916406a91.14.1780716156242;
        Fri, 05 Jun 2026 20:22:36 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371341170c7sm2319688a91.1.2026.06.05.20.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 20:22:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, harshpb@linux.ibm.com, stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
In-Reply-To: <20260602121706.8423-1-gautam@linux.ibm.com>
Date: Sat, 06 Jun 2026 08:37:49 +0530
Message-ID: <o6ho8iyi.ritesh.list@gmail.com>
References: <20260602121706.8423-1-gautam@linux.ibm.com>
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

Gautam Menghani <gautam@linux.ibm.com> writes:

> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
>
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
>
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")

Not really a fix per-se. So we need not add this fixes tag.

> Cc: stable@vger.kernel.org # v6.13+

I think the stable tag like above is sufficient for stable tree
maintainers to pick this up.

-ritesh

