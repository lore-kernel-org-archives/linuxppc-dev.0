Return-Path: <linuxppc-dev+bounces-22732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4BECD98E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 02:25:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg74j5zmSz2ysW;
	Wed, 17 Jun 2026 12:25:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781663141;
	cv=pass; b=ag3dtSv+BRqehg4ZueIdA4k9eH9twM/9BcjMgHT+xvndST1ltrQePKBayTLY5Ac43HKAdlu2gVG0X4dZ/N5tXSXehohAMWZ91oZ6n6xHaGxH6v4z0Rya6/lcJnEb92OahDUqqmyHMSlzAFu/JAVvS4oZWyrRWlL07RIRW1ExY6Og1Y+aDl07BQCZFdb6c0wyvjenpekz4F+FcA2CVYBHSmZJWQU7x3EtgywFR8kOWjfSEZiHWS9Mz+bki63bOxsyXbgICO+3Aq3IDqCphBe7SGIW4Xd6p4Momu4KwEwHQDhCRjslsqPGirwZTG+kQA1U0ASxiS8oWCgPuYu6hOUIlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781663141; c=relaxed/relaxed;
	bh=I9jkNgg69cYp9Gmed8dyPc4oJRxJqglqMoz9LIyCVkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlcT0UziqwbocVsE6ceNzl3SKJ5pOn2PDGan+xkxORI+cNphu83ZpRI2NgjiLjPbCmkn8BJNF+MW99fjriodk1Gyv8l9ZjYMoAOXBsXQ7cBNaM1YGKUurIK52MCHzWFmt9YnsBahmH1eIG+pk4t0twiGeG86ci+R5KEeOKQ01pnIE/n7SRiauRgdb9a40fMtNlKadrBm4G9PGgjsvOIpo7pbJwRpORMOhT1eYElyMefrLy6XtboOvF3y6No1Xjpo4PBuTbkLiMR3tOaT3ova8wkvIQ3l8lL2FjKKC9WgnCnAs3PE9Q5F42/vtF+X2gqYXgPBFkf/VAs2c6iMDoDkXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r/eEgh89; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r/eEgh89;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg74g3ycBz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 12:25:38 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8452a597afcso47724b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 19:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781663137; cv=none;
        d=google.com; s=arc-20240605;
        b=dyGocVIJ7d2J+9ub2BgoSLJrNYiWWByzjZwidVBe23edNphrxDhbOZF2+ad+WGb0PW
         QWy/10zUXnTc634IwnFKuEkhp7+r8RoP1+/K2xQ8ijV1FP10s8JnUvGeRWHwJk/e3d9C
         ymZ/tFLe9ceV4ULdSj33yTOr7jCKZ3YLMFCtS8xdMA4To+hTi4j3HpBoGOigDBH9oBZn
         30VUoApO6meUzPoo7bj2f3zs4FO4lF8mRxM9xuxO0Caj+CtuV8QiW/Qcts2HdqaE1Ewj
         d30PWkzKLyJzajHnfUCB6O4V1c98AU2w6zaOXWMmCorqUiq8ugwOC+gr0+q4dcTxHDLW
         5Mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I9jkNgg69cYp9Gmed8dyPc4oJRxJqglqMoz9LIyCVkM=;
        fh=rftLJDsEdSenVRZIlmwFhodDIpwkIYEA8fiA2j0hv2o=;
        b=NPd+fQvHjMWFKns6qYtnb5sLPXcBUZ0/tcE51uEM1J1yxtYFo1mHJ+ZMmE8juKpxz/
         SgbladEC3s0Uggyahwnl15qwhIZMyeY/rnscJiMFBF+8D1EqOiPzi3hdS5biAN/Z7Xg+
         g28c7LlJqxXc+jTN1HjA19G9/ODQYEXEVRu802VBnM5TWn3lpN9iZsW/pkoGlR+GEknb
         JDQrJ0EUP/WW1aIp1usAR5ncAxBkBIGsQIz5uAukcVf5VlHcRNlqsso5kOxtCZfHCSqg
         KAqfBbotYdUyc36otLuwwZobYAW95LoWNIwX2RBZNA61y5Exdxpe2686g8mOJghEtp+t
         7MNQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781663137; x=1782267937; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9jkNgg69cYp9Gmed8dyPc4oJRxJqglqMoz9LIyCVkM=;
        b=r/eEgh8926n1AmHI7vpBddeHd3b4H+CyqBtkqfxW+8M0+hO1zo+tnqiLDzNaXQQKsI
         ABumw2atfeJteAFIfLZQWZ+siUe0uYGGGcNWuz9ckG1idqPCCDGj7jpIRsBlpydLvE2F
         IjZJ2TJOgosY5JxHCNnXS5yei1o1KRFWIEyCo8oZqCyz6wPMUYogLoL9VTF+nlIQcYJP
         pOGlcogS0PD/2i0TYLtVlkNp6v+6h7Pt2WEAQWk6xX+6erVLrJbkxCn06d0PO4HI8gWb
         L63t8CK11koijwrGGwI3LXO/4qA9e/+nvu0t8OrDGeRN9aAaVZ3wVX5W6ab6PJFJ7CEQ
         yjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663137; x=1782267937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9jkNgg69cYp9Gmed8dyPc4oJRxJqglqMoz9LIyCVkM=;
        b=AhfMCk4zJj0onH+xGZtZoHPjCb/kimV4YtZDmTQTwfk3XBbkxnzcQiLfASoNyGivpH
         eWZRo7sSKJay75l5BW3jC9d3rY6Tdy3JPITRlTAbe5wXS+stiplu01mc7Hyy9/8nVkHn
         rhwxaH8hBvq0w330IuQr9EWLb7s7G/7FbzvJbsdCCsr5E15qHd+dl8pRzr4WJ/LegJWq
         eCJ5LULubmf+69HAGOd6xKXp6hwbfQhAGlN3jMGukzR2zEfnkqgIgceEHSYzDIogdgJk
         syRX2+y91ZeCj+ghmgqGcClK9SLDl3Gna9AyJSwXV1snnH57TIpqTWe96rg/X1Cpv4cI
         /05g==
X-Forwarded-Encrypted: i=1; AFNElJ9txzGMHw1hb+CKho05CgEfJrcczuH222zmgS/KQp/uD8/6uE4P+e84JhaX3jsmq4T4Ol/Yeco5hvQUSqk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxG7IeEDSIthVAOnX9zrWq5eKzsxBpHww858VXomwNArLFmyOmx
	UwDrMNXHh6i+YqHSl34k/MG8dwXnzQgrUvZMdSjCptxWZ7sy7/gf+OVjeUf9uWiNLnrDd8O2uIi
	yKVoQAX++1jZWqe05IaGeBE9WXp0XXgg=
X-Gm-Gg: Acq92OE9v81mSjbyO84GUiCV3h17/kmTT7acZSeLxTPw0BvLnONr5OFjAuKoEX1HJTf
	LzPAL9IMavB40BVDpClEvRJIVyfeaRixXmVh/Q4/8u31qIJFHsGU9IrXNZb5STrd9vJ3L+OpVhm
	Zgae3z4d8ZnefoCNcggdLEceZ28vd1fJQQoD5WGVvX3J1DjDK9S38Ud0jUsqMgyaTM4juE4nz5y
	jItMYVd6UWqqnwtbwKKhWJBYcpTrXxOP2hK7SwUmhMMog8NDbZlMkLukpayIKUnf03qwUOsNzpp
	6Yh0wuYYHsyGVsshpZjMEzaaAfQ=
X-Received: by 2002:a05:6a00:b89:b0:842:5da3:9b8b with SMTP id
 d2e1a72fcca58-845245994cfmr1624839b3a.36.1781663136820; Tue, 16 Jun 2026
 19:25:36 -0700 (PDT)
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
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-2-phucduc.bui@gmail.com> <ajAJt-EV1sSfG3OC@SMW015318>
In-Reply-To: <ajAJt-EV1sSfG3OC@SMW015318>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 17 Jun 2026 09:25:23 +0700
X-Gm-Features: AVVi8CdoNbD47oGFTWSfJEm9Lr238WEoMJ3mqPMc2xN9snSeNNUZupbWD1q6iqo
Message-ID: <CAABR9nHNLchAnkeuGrDWoS4+sAKnqQMgx9b0cuv7rOHzC8P6Pw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ASoC: fsl_asrc: Use guard() for spin locks
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>

Thank you for taking the time to review the series and for providing
the Reviewed-by tags.

Best regards,
Phuc

