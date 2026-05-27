Return-Path: <linuxppc-dev+bounces-21603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5746FCD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 17:41:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQcNX5PXwz2yRn;
	Thu, 28 May 2026 03:41:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779903660;
	cv=none; b=NqCx2EQciGCS9ziAnvivqZGdWEgXhBEQXkMlnGtlAy5/FbLyQ75EJQKSVuilXnvZAiW0Bdiw0GVzak+DD/3gidDLzOadOefqCabTSSQZFKfKiBtsCEou2SGutYZGizsPOJaT80zz6YDHkaZbyZQ/rolXCleL1elwYz0ePjOrct1JMb645mvy2SKis8ErY6QC9oSYU2MnVudkDIkJEeuX6u7FQ6y9tKlwnk+G2vXB9PejVMt1tfZjd2/kYpC5htQw5DZsYSkNhZ54xWlzcEseyyo0err7VhuUuK5fHQMa/hqW8SjFSc4d96SFRlidvztYNcOeqjkBGxkN/3u3zVf5og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779903660; c=relaxed/relaxed;
	bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/XV4lrAm0p8yJZ8+pfwQg8OAxUBA+tI8gwGqgLHO1dIcGL2wWK9O1I3dMRuGU3HHXSe66qSP0NHxbrnPLHxCibQvgDkkzzKPz9wEWiN2Qse1WUhBmtJ6KT+9YbBEBngvH2oMP7S/M2Q0Xcs89vt/r0QlLzR6nMyzdgoLs075uUxt1U70/MzkECFT6fG8S6mpzfSy55zEeqouFmdezjQCgQIoov+pyYuHiX/+kuabT/1MtcqRB101gLmcTFJsCpSRQYemjOEj0blOwB0OtUYRQdtkVOORt4u9pqUuhtY5fgCPWCwX+RlJC4MpEgI1gj1K5iNomkTR97vE+mArWMSeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LhW6ijoz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3pywxagykdlqmyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LhW6ijoz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3pywxagykdlqmyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQcNW3xhgz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 03:40:58 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2ba268cb5e6so126506345ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903656; x=1780508456; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=LhW6ijozT07a5awVyg+6C6d7Grifr3T0BklpIhBaUDl/7qeDiS46QlnjZcbeAF3R6M
         QrxVgcRffg+yW38cK2mGzlrPPJL2c87m6uKGbRFLmU0xy8NAMTzL4bU4SMZgiS+hEkfr
         Ov/VEVJ4HWWqSnSyh5mqmPqMKUUo5dv7HKRnQRF0VgpQ+3CcvVxBqSuWZJF+K/3O9BfK
         uRDDD8ETgPzQrKSf7ybuN2BSxXwgiVe5GKT8OHCrWNwvpRPojptsPVaDV8EDxAE9v4+5
         inXRljpiZSiJ0BhGaNxZhhRH89xH+Xdhoao9w/z3Fy/5znri7sx8nrnFQ4twWzImNGUr
         Uqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903656; x=1780508456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=g3vlq60sTEQnRCN6HS2Pc+NVL848H/7W1OnimLPa6gMZNQe5x5RLjVclRvjTTotFet
         Yio+BaQ6tYZowS/ynQJrywba3qz+K+Eyw6gKV5ytYK81PVX+cEGhxJDNlvhPaBapxf0y
         1ciXNoYZiM6hM1XRcEapORy5lAZ21Y9jNScrKm9kjOf++UkMfyiKfKPrwJ80cplFgrRA
         whvUPXUJbuxzQvDZ/Nmx2yvGPs9g9envaGlxGK63Xe7i7F3Qsh8h3OQbUvT1Sd/XbsZR
         ch0A5xnxbo34k1b4+Zx/Aigy3YzT6/kDE5u3OR9Q3ywWG8fIOHSo+tAw2HaF6yJU/lkH
         5ung==
X-Forwarded-Encrypted: i=1; AFNElJ9RpbKfu4R2fbVAhqHy4pOHB9ykWFKSSEJfCf5R+8M3v/ntuDcJ9Hgkgm7n17Csicva/K2aidWSVQItS1o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKTsVC8eME41TV6sXubBSxkVI9PmjsHDFcq1w1/o35rI+q+swh
	XsZbO4AqByMrBlEGO7aw5KNgCuADs4ze8yIF1j4hj0GtekIGL4IQ2IzatLgMVZO1RuI06jrrNhP
	o5v+anw==
X-Received: from pgii35.prod.google.com ([2002:a63:2223:0:b0:c79:22b6:a344])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9d91:b0:39f:9eb3:1d09
 with SMTP id adf61e73a8af0-3b328ee2e52mr24673521637.37.1779903655856; Wed, 27
 May 2026 10:40:55 -0700 (PDT)
Date: Wed, 27 May 2026 10:40:55 -0700
In-Reply-To: <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
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
Mime-Version: 1.0
References: <20260518044150.34632-1-gautam@linux.ibm.com> <agu2UAi6lWclxFYh@google.com>
 <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
Message-ID: <ahcsp0tfST5AGdMb@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Gautam Menghani wrote:
> On Mon, May 18, 2026 at 06:01:04PM -0700, Sean Christopherson wrote:
> > On Mon, May 18, 2026, Gautam Menghani wrote:
> > > Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> > > vpa-pmu driver cannot be used since it is not enabled in distro configs.
> > 
> > That seems like a problem to take up with distros, no?
> 
> Rather than enabling individually for different distros, wouldn't it be
> better if it is enabled with KVM automatically? I can rephrase the
> commit log to emphasize that this config option is only relevant for
> KVM (similar to CONFIG_KVM_BOOK3S_HV_PMU).

Not if you can't turn it off.  As proposed, CONFIG_VPA_PMU gets forced to
whatever CONFIG_KVM_BOOK3S_64_HV is set to.  At that point, the existence of
the VPA_PMU Kconfig is pointless.

If you want it enabled by _default_, then turn it on by default, e.g.

diff --git arch/powerpc/platforms/pseries/Kconfig arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- arch/powerpc/platforms/pseries/Kconfig
+++ arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
        tristate "VPA PMU events"
        depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+       default m
        help
          Enable access to the VPA PMU counters via perf. This enables
          code that support measurement for KVM on PowerVM(KoP) feature.

