Return-Path: <linuxppc-dev+bounces-22113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA8CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWtqB37STz2yR5;
	Fri, 05 Jun 2026 17:48:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::233" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780645734;
	cv=pass; b=I0r9wYam/ZOj3sDT+mt3HstFwWTekOk2BqJX3UsL8xkVqaZM7Zt81upNubTXVWJMxObFLGoUuSk245sBI7t5Q3AUwMxaE0Z6Bwju19DwJ0NmcGCQahLQiCDI45gc7FPjXeyX6SH0myyMZB3P0vMukTiO3YR7ec8zp03WsyuozS/S47FxI5yQljCeXgO+pp1SYTuVnfoBsiY2LJpA9MSYw1ZKw2wuRWZfsK//rJOn9zktPCAgH0hji1JjhjMNGnLJomvYHgPEio4iQe+gBFYyTSF2QaH3QExAUQzauM0/BbZLSrdHrsMB4F2HE+iv2+crLZlj8a+0PgZJedATRAhf9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780645734; c=relaxed/relaxed;
	bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkwZARCbbyAtuYURDgwZkuxhtAueFLcm4RHDb9ULkiJB1dxI/jVgjNFFlMsfX6p9kZJSjX8FVvnskGRi4ROfDBkQz2NaOgikoqlBN4NHb2gQQ8Jq4W56QU4juxICxMWf0Iw6tks1WI8Qgj/4dbP5yVck0uv57FWi9mMHvnK5qk6YGF8vC/55YWnGYE/d4Jx+dX1c2TqGnBkjXE2/53cwEu8FZPrFQgeZMUvYGFskrnqJYnsp6gbeBEjak8NiQYuwm+LQrdpO+62dveZqAO0S199dErS3XGoRhsv+igJ7uphuqkMvzIYnBrq7Fek4KMU9aeYeWm/qVgg8j9ttAAIVTA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Gb92Ne8v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Gb92Ne8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWtq91CpCz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:48:52 +1000 (AEST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-39677c80386so17657651fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780645724; cv=none;
        d=google.com; s=arc-20240605;
        b=BU0qEN3TPQ3kDAgGSn7JET2RFXyN6cabYg/8/t8QzyUeqd36nc30+oJZ3POOahNrSN
         tSCSMtkUjLgmuq889fJQoeRGfXpE8mucACk+NjKn+bN0nSv43BEwj5Ka5bk1UYR/alCh
         p0QNppC5pfA8w+pxi7GJdRAsd8Gc1cJUq2e0XnagiG2Uvs/mwe87SWHqjjbqf61OID8+
         cs1BHVwIKFskkhRSliykHNyGW/8dqtV2cMo1J2lbJ4nJHEkASq9X86Jot0OeBXCnd0Gt
         VG0ta52zWqHkj0jxr0WuuPQqUar6SuX8CThFTddDMCLyi8A2q2EmhcocqMK0zqsjw33m
         +2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        fh=P8eE1ytph5kpDBuR8RCvZ7oknm+/xbANb4kkJ2/vrNU=;
        b=SaJAnH4m4dEgwCx4Queb7tqgLmkSrQr0zxRktBjePX1WXbCLG4NhUK6TYVcVoc9Nhv
         oIG7x5MjeTrUn9JzfKjEH0J+0Im0n9QeKZuD+UOFXIbnaLXwf7gzsTtU0NOMx0wIRCg9
         RgFJolIh7mjpYwHCyZI/9+EyV7332m5omyjFpMqwwxIIuG8abHl7v/0vRZ/BzQCLLjJE
         4txXfu2UYkQPSbRCgixsBlfjEmax/XhzVI4Nz8fda7LGdfgE4RU+czeJ3XfsnpsVQRQp
         llEEHviXEF+QA99aW6nYg33rqYC/k4cwHDM19s8U7cWKVRLbNTSWTBhSNamipmDX9DTb
         P8zg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780645724; x=1781250524; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        b=Gb92Ne8vtykbcO3ckpWd9Z/Rwq/zElYlFqX6XaKtdWbuJRZmoSXvn5Dtxz+RS6soWW
         yLxbB/i9iIN7dtm/cb5lNLUGozeSV1by2ImrYx7hPkEQTDTF01QIOM4q9vtriOykWbtW
         2mYEpNmjKdwzzQwzM+eRZpYWaQZplD7jDltb58B6BY4nEzyVd+i4F7zvzIV69pRfa02r
         z+e0UK41hqF1czNV3wShfMf3Dvcm2Su24PNFM0Skn34FP4n9T+E4eAL+bv35SCJW8nZq
         yMc6tEdpIYV7RHf68As5B5BLjwJHkMCf+F6SUTLOuYMf49AQ8086haCqIU5B5N3G5IQD
         uxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645724; x=1781250524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        b=SE/Kskbyn503QjInCEJ/T92/QUMq6wrBUyL3i/MWjLRFPj+5BLl9VJ1K2ZMN/pW8Ih
         LvjFH2/F45SQ0raoyYCfA9NN/p/GcSH7VSQ0lAS5rO8L7oSAMHuB9zjJYvK7C+UcSOnQ
         9TqDgQzai5lqrxGqiChN5QcAjwbStCmSb6b7qeHDvLlyO1diiFLEXINIkSZfH7kmC2cN
         H+2xbxwSILD4NSlVMphqmHgYapMRfCNyyg7dCEnajbyc4ie7cG+gcQROWlA4PXK4XQ3N
         kDmyIpcTU6Byy+elLnHZbzE6DX3Co+2yUKjFQ7E69nwMnXN1AYGWeSteyr2vAEBPZXYP
         6l4g==
X-Forwarded-Encrypted: i=1; AFNElJ8CrQmrvZc0IpZCwZDWma/mZwh+x8+6BJy+N6mcpE64wSMqmB/wsY3mxMC2Vl4E19lYlvw8qTNoZ8sw2Ds=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0Vl0/ozprCnfK1iriUnUaZVcgyurwg39WWPm3otNYhazVQNop
	DeScmHLJ2cMGkkL6FrMgZBLpKi93mPp54hG2K+RIep19ALaqzBu17aAJwlfHNLmfZO9IUGEWGB8
	gmoX5bLd0FWLX07oGFBtcJj39uzR0OQ/uiOJWSgL1Gw==
X-Gm-Gg: Acq92OH71DDu5O/bRxIAr0oUUknUAFsDWwHP8J4oL06f6ufRbmmPUAeprzxrG8rudG1
	Ejzoe93GbLF/ONGfzWOpYzuUl2xtVQDbuYgwm0/WC2lKDcaxGe3X7gSjMH2BR9JYaHBNz8kJ1ES
	CKGydFTn1VVaA47HPkNP2k8+9uT+h63fpdI/WT2U4yOG5DIOxBy0eipPAAReORIEqUyU3AqnC4P
	9GyFoXUmx4eU1L+jr/ilqcjB1jlBh8Rlk9Tbm4kN9fg7fAodoMbsPnvYELAKnix7Tu0R7FVW0wO
	1ojH/VNBaFDXwBb7/7veLwoKjlopN5r3FFGuwn+H386nn8ZDt6g=
X-Received: by 2002:a05:6512:2523:b0:5aa:854c:61e8 with SMTP id
 2adb3069b0e04-5aa87bd7921mr758422e87.40.1780645723936; Fri, 05 Jun 2026
 00:48:43 -0700 (PDT)
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
References: <20260511092846.120141-1-marco.crivellari@suse.com> <20260511092846.120141-2-marco.crivellari@suse.com>
In-Reply-To: <20260511092846.120141-2-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 09:48:33 +0200
X-Gm-Features: AVVi8CeCNaXxzJViaFHzMhO0fpnrVI-OJr9XPkVyccta7hRQi1pQd_D8MH43Wpg
Message-ID: <CAAofZF7xvJ4tjUPk1NeG7fhxa8vXA=KX=QNvPDhg0Yx-rTzqhg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2026 at 11:28=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
>
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound wor=
ks")
>
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
>
> Cc: Haren Myneni <haren@linux.ibm.com>
> Cc: Rick Lindsley <ricklind@linux.ibm.com>
> Cc: Nick Child <nnac123@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs

