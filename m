Return-Path: <linuxppc-dev+bounces-28409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F188BC9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:44:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htjGM21Ffz2y2B;
	Mon, 28 Sep 2026 23:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603067;
	cv=none; b=jHu6tgNTsQoxYSgjKqHTUZG2cAPnALcN9A71oYOzo9tU6/kf24jBxbRtZY8AcrvXTqqn7G/XM5L1p5Uu0wVt407NPyraEyobInP1VAnmmfM5EivTprl7tQkKlzueYkepCGs8Iiz2YtjHE5Z7IK8zq9I6WzSzRO3cEZKImrKugYHw7ttJxY0S8av7tHikwI5zlVNzKiwiYXEwzq5sWtu9Sn11Dq/IFt4Y3tbocD8Na7cLpOL2NUwZYBAL/LXahm2FxZQacqx6y7JsfGoyBc3hTs0TCFGyQ0RzL9HGtCH+Ob+XE9j0a8+yDnq6CrSn65GRFPEfkdY/RgM/a99T2q9mPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603067; c=relaxed/relaxed;
	bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mcDE7qEwDvx7yqgN64hmiR9bGVOHs/qZX3d+PFpFlXHfwxI4yj8vzFWdjGqanhCUYuTT3+OAFJd5cYW0Puwv06PZcW3DNVv08TWVsyghSoS46tg0LgDoSyVGhRc973cvqhWT9ve9JY6awE6x0qt6wFyVyy7W24jL4XKPigO2RK7OC39KLEdIX4wzCtI6LsT6fr/2N82z4EorRTP/73CG9d3fp71NwLcoiuai8bwBsWvbYBqkezJewsiSaUfCVqZo34ZAyV7eDoSNqTHac/V6hTaBNmyHVQE4f8O30CGYelfM+A+5sl2R0BQcLJ49VFKAfGUTJ7ECzwOs3YuIi6Cc6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipUNQKJ3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:30::f; helo=mail-oa2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ipUNQKJ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:30::f; helo=mail-oa2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com [IPv6:2607:f8b0:4864:30::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjGL0jtZz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:44:24 +1000 (AEST)
Received: by mail-oa2-x0f.google.com with SMTP id 586e51a60fabf-493cf6d8e60so1127328fac.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603062; x=1791207862; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=ipUNQKJ3aL71oHmU4Mqu19jbFJgfepngVNb8WUp9D+fqRDPi00ftiVj0FfKrosuJGA
         JwnduBJXgvsx8jqAe7Qv2aF6n3gs/6Opg95DlnfNzGrSGn9M2HY+UZ/3YcutVx3iPPgj
         8YHkD0hotfBzT1GCoxX4jp5J5nhMAOJvzzWC4es2J5WzcmtExWAB/Ny4MH6lhOgxgejO
         2SF+TSYHKSPRstI4GkEgA1n3YBqolszUTvWVRSmOQVOHUfROfUfzytOSCcWjqwCXDTXt
         EMwV3I3wUPXtzuXKOddwARR3kRmLu7KWWf582md9Cny8C1cobgGmYAZBnYeaiCUrAA/y
         OtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603062; x=1791207862;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=hvGTPQin2Zm10F6DcCIPDGlB8M3i7DgYhlu+fhkxqhOkZgJNUgl9a2s77p+yU6L+Bd
         FZ1T42upZah7prCllyb5t1LkQsbArQpcTSfrQCPxQu+C02mFm35Z3fETnInJ+eEy4ZCM
         gdAWwuAQIRGDCbErncgUTzfC9e9F2QlgTILtX7HFsMuXBueIhvG907L//NBUtAzZnwDZ
         V+alLuNxE86LN1otHH/P+TC3pUi53JvjCZgPZbcARIZoiS9X5V6jzDP3VIGMuydG2cnH
         BenQ3/FEJExHFYW8kQiJ8kGctDIAeNu98ZrTyKejAcdM6MIsLb0+obXg/+/XJUtAT7KS
         v3HA==
X-Forwarded-Encrypted: i=1; AKwUvBzTjuQeBQmUDvW32d3Ru6UIJxi25tZNd/YBPPnwGdEn9wfIETirSkJk1mXvtG4wOwTnpZjym+w4lQ77Cd4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ljzQHPsonQKx8Vm6TzKCmQNKWyy+MqnolC2QCDmN7KqS2as0BB
	fNu0GPPJ/KMh5/qZqyTv7/gcaHJmU1eLotVXyelAuEmH04q/IOLNh3PG
X-Gm-Gg: AYBFou2F3GZkMw7uDKSubEhwb5AfmjX8GgwsYlC1BLZ4EVblUE8fSxEQENYt+AG/tLH
	4d0N2pdc++nXmEEhiH566i1wRtRUzLE2lwLuecCoCaz0WI3JEOLc4S5vMOItXHhqva/em5/SA3b
	GASRPyBkGlmVwZQAGDPlCtkJ5CdtIQdL7n46R8q3m8lW3slBzII8Y2It5XNtiDCpaaZl3JQH+D3
	VbTtti3C8QDQzD+Md0SBy/G08NsGERwWJhkU6eSqRJRq6qEfW7Um0vaAEOKqHv+jycee3ByAK8X
	CRQ416UBlew+wQAYSgzKQ51oiJBg9f2/h0QDtkgeTnAQRdZdOEEKfSfTewEn2CJCpyR4KJP61Rd
	1qZzMGzr+fOiYK/H32DT70MNFwG2HLtZ8cyq+NLog0YLBuDPa3rGjOXorGz7GIMxPG60MC/mfnR
	WOBySmZSZjUe5avxdOB3h0VJ1TM8Na4o0yL/XP8eHcV/RqTTcsAF5cZS9jsTB3eZYKBLp/WPq8n
	+19Lsvz6bqP3I31zw4OL00v72pyun73MIaLBnVoRrcJvlmguoLOiA==
X-Received: by 2002:a05:6871:eb03:b0:48f:e0f6:c46a with SMTP id 586e51a60fabf-49358a317cfmr9008681fac.56.1790603062123;
        Mon, 28 Sep 2026 06:44:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm10053356fac.9.2026.09.28.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:44:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
In-Reply-To: <20260928122837.8782-3-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 19:12:53 +0530
Message-ID: <tsn9jxuq.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-3-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule.
>

That make sense. LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


