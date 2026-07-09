Return-Path: <linuxppc-dev+bounces-23912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F8CC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwn5M15ybz3c9q;
	Thu, 09 Jul 2026 17:43:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783583015;
	cv=none; b=WAtbo6pqFxF+Jyj3cVlhxyH4kMxrgO62azHeMwE8ckuXDyc5hHEmvWv5rOYN7nKpk9nJTg6Blx+EoWirnS74vuh3o/93djOiEcRx/nKmGPi+1FuiG6MJXJHP7oMRDjDVy7O5u7T+iAcXLeXBBcPhmrhzay1Qzs/oErDJCtP+yIJkHb1lGE/sFvOZjC64bYSzbNRLFidPOwn2KlKzAn5ZFowBLfqG2TTrD5a5QHvC/YIBcxL0XTQDOhjdzHm6dWcSBX4tkpE0+v6gzBVTg+z/yXUeHpxQv+4AzoqTMJVM5fg6eakdIuxTikjuZELSRPOv0k/8syb7OnVCF4KI7khRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783583015; c=relaxed/relaxed;
	bh=N7eUSdR0DyIiI153j39Qwy65OXz9wuC4shQvA/Svox8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfKB3gP1V014pNBuJFVrMhFGVOI27gNJBxa/GkTO6a6pJT1mtr+UnCl3hcVp1mrPTDxz340O9QQtMJqsO8KhKnwE5aE4uG31nv4JwmRs3x3bKT/kVPzJfobJ1SqSCD6X9SbErWnB2U0KGH50oraemr5XIh1sMWAem3M2gGNEum9jZq6lawlDXY6O1mWc7PV1frAc7AKcweQ13Ohv0E/pCYg0A26YRxMRn6IKgquTGdod8IPI2DQHvNeFDToi5tfQDzOvIv9udVNwCtwLsNs5WTaUOcoeEM5FxX5OF2BQq67NnITGDjYRnFwmwolrBwXev31Pd9TAH8bTSK2P21V+JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VmcTPxFq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VmcTPxFq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwn5K5nXQz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:43:33 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so11737415e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783583010; x=1784187810; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7eUSdR0DyIiI153j39Qwy65OXz9wuC4shQvA/Svox8=;
        b=VmcTPxFqQdLEv6jhCwemSUQxw/Sp8miCCGIQMfuDpiuuRjzJxwFQ0ybqERUyFHrr3w
         jl+mpNxU6JYNpKnTEtlyYJhKH1vf3XB2d0jKgFlHEPUMjsvRPk1hJNiScRSN4iOj2XgQ
         9Qlqc/bJUg92J5JM+KZOzJgb0dqIbZJlmtN/QldZxJwcGjnELEzy7R7fHyc8U0gOneY8
         GcZO23mrVZBgW1tdKgCmr5NDYF8q2g5qTwhvwHyAxTOTQSCHnAwOYX/f/akUELuE9WuI
         EgqzXbdkrrFbuGeEsE0uYI0ZvqoziRA2oGh09eNj82OBPqNt9wq8xritoiwc0R2CrRq/
         hnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583010; x=1784187810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7eUSdR0DyIiI153j39Qwy65OXz9wuC4shQvA/Svox8=;
        b=QC2Jyb0iLjDhDHeBFuIfpWkVjeepCV2kNBdNwderCvIT07l3vlimWL5aP7wP10BdxE
         QbL1KSOoh+8VljN9ASFWwvplW5dUBkSlSBK33073EO4P8X16qQ9UKPHpjqLTeuL/BwYT
         8VXBED8CaLFqK3BrSdLj2HfC4nIS8vcQpLgoayKNwfLRf1UPRXQTuY+FxJvlbqslwtVv
         8FjuCvA5vrTcVOyQTDVCTYt5tHm4DbXrCgUpp33rPJwb6/6qRvnP/TzH0h2k0N0WNpVY
         qunXEEg25HJm7aQZdzXMdYYh1MDfwsjQwth4mr0pVYx4U3p8JUg0xkEMIMGSnZ8e9Ve3
         vAlA==
X-Forwarded-Encrypted: i=1; AHgh+RrY+OjeHTpaitOzIKk07a+POZY9H2qiBs4BR44IhTabuh14q7S1Oy22F45RYUWF1j+VghaWdd53b5LG0Ko=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNwiDG91h0jioguxaznaz/69sFQaHWiRFHat9DD29hjADkAo8k
	HMClCxk/ITXXpXKhIaHDPHoJewiTkPEcmrVn4xVRZMFNH/33Q2qlouZd
X-Gm-Gg: AfdE7cmlABlF8w4L1qIWTFJ/c081pMfuPDRZthRJabr/G69DxUl9XUJgMkbuHh2yh0a
	9ocNFMlJ1E3/auyC58pu0z29N3bh6bTSrc3xyB/iHMfGlWfbJOu/QtVuPlHiqg81CpuC7MQml5I
	hEcxyuz/l6Oi/lZbQRTNjTVHtGckozwp3Db+QD4sjonlqaeNUK/bFGXEJiJ9idK2CVEzBuKArIZ
	tyGYys/Nl4vTsV3owgMcgbO2Rcw23JoZiYRVOLefkQDduo+Q8TXEt0hc3Ru45ecUa4L9cG1SMfp
	0W6DQjEcxyrAPnMMkfEbL5TR/8sJNHdCILO3ji+3qeqMwV2X/y/7qCpw3ILr7Wsw3fElOWA0WtP
	w+RXCZatc6j3YhyiB3n0GWjcOt1AlykVbR+Ggr+DnRj1saHLUSkUZvA+cCKupN6uwlgc+HcXNvw
	i62IpSQzh49FwkK0UUMIlAmII1q2W3N8826A1pftScQ9YzpSHv1HabQBFlu5LWNDcXCW3+AFex5
	kbwxxCM2B4zEx8OJ3bEvNGDm7rZ5i6IgsleRQJn+CBGOyLKg1Y5uc6FyyanehDG4W3iwXq+uojh
	TjBFukBlvoFj4/lG1kxdi4OR8MBU
X-Received: by 2002:a05:600c:83c6:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-493e6853dbfmr61124025e9.0.1783583009667;
        Thu, 09 Jul 2026 00:43:29 -0700 (PDT)
Received: from z16 ([2400:adc5:134:ba00:f774:65ea:79e2:617b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ff6casm50109985e9.5.2026.07.09.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:43:29 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: amachhiw@linux.ibm.com
Cc: chleroy@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	salman.farooq3310@gmail.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  9 Jul 2026 12:43:23 +0500
Message-ID: <20260709074323.77322-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709125357.49cafeb6-1b-amachhiw@linux.ibm.com>
References: <20260709125357.49cafeb6-1b-amachhiw@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Regardless, since this patch has no functional or code change, you may
> want to add a 'trivial' suffix to the patch title, e.g.:
>
>   KVM: PPC: Book3S HV: trivial: Fix comment typos

Thanks for pointing that out, and for the very useful references.
I wasn't aware of this convention. I will follow it and read up on
other conventions for future patches.

Salman

