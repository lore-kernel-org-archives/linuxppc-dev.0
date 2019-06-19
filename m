Return-Path: <SRS0=CHEA=US=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C955C31E49
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 08:48:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B9820823
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcFHZpeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B9820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TJW0700YzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 18:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VcFHZpeh"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TJSv3R6VzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 18:46:06 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id bh12so6914898plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=MVBCdREMBNYNEnWVCzogqzDqCMkTw7vmZ+cXXGxz8CY=;
 b=VcFHZpehVd+joyRSAOchGhrYzOerRhWBKEm01I4yxu9OhP82/A3Xj8AOQflpXqzHYN
 6iNpFUIftOjhFx6y4cK4ouAx75hYQw/RrRefDGDPTF5ZvSpJYLR1DcMc8dVNg2n3WPxR
 f2p0Zduq2TBbXCcfuWfvB2kf289Th1ePGt9pX/A56oj5tHyaH4aM6iLpy5/IUKFXIYBs
 yVoHg3QgUE3nFkHKR2ai9VN1mKKgbp5OdbNK4gB/pzMW9Oz3FBvoVJgocxhIfoiTu6zU
 EcApuQy7jEDQNz2EAjqlEyfaAKXatTPc172TcQVavvfoTID2JAZ2qUlP5XwCDPRMbfDW
 a74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=MVBCdREMBNYNEnWVCzogqzDqCMkTw7vmZ+cXXGxz8CY=;
 b=Q7kopzQcQ1lXj3RfajWHr3oXbSqiAuoOGIlgIaWkmEF8Py6Wfj+mUfjCfPckM1uLtR
 xJnVjV8oD/1MHS59PxSEov2HhTHossovBmYGHzL9ZHs5gFS6mnL/RuHeZWa2wRjhCTXw
 MmLXD859atJ5E1wxr8TTZbxQNIWHFRH/9VduuuXO99OOQPOcpbvDSbX9Y21GgfenHYZD
 bKsGRGPWazV/CGfGm8W7K4Slx4EX92zvNRFIeVg/MwnW074ve4C4mrVPOvBMKLk+hU4+
 4g8l32P33JQ/d58c2VC3dczj7GC9qCSHRFZIO70duGG012bfLVk2cvIwy3/My8T7MvZr
 Vtzg==
X-Gm-Message-State: APjAAAUuRtJCLErg2Arb5ZE2Wwgyn7lrXn6fVhfCB9nUD4bjb7eQwwVN
 rFFN6GlXX0GDUHC0LqSRX+mSCYBX
X-Google-Smtp-Source: APXvYqwtc+X7Zy/fHHfZkd1c2arIyrrM3B1oJzf+rcp//XyvI9efvehdAo4dlEzqnY6k+aN8Zgm2lQ==
X-Received: by 2002:a17:902:5a4c:: with SMTP id
 f12mr38765834plm.332.1560933963270; 
 Wed, 19 Jun 2019 01:46:03 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
 by smtp.gmail.com with ESMTPSA id n17sm32255163pfq.182.2019.06.19.01.46.01
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 01:46:02 -0700 (PDT)
Date: Wed, 19 Jun 2019 18:40:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 06/28] powerpc/64s/exception: remove the "extra" macro
 parameter
To: linuxppc-dev@lists.ozlabs.org
References: <20190611143040.7834-1-npiggin@gmail.com>
 <20190611143040.7834-7-npiggin@gmail.com>
In-Reply-To: <20190611143040.7834-7-npiggin@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560933396.zhudswbcjr.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin's on June 12, 2019 12:30 am:
> @@ -265,7 +275,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
>  EXC_REAL_END(machine_check, 0x200, 0x100)
>  EXC_VIRT_NONE(0x4200, 0x100)
>  TRAMP_REAL_BEGIN(machine_check_common_early)
> -	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
> +	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXMC, 0, 0x200
>  	/*
>  	 * Register contents:
>  	 * R13		=3D PACA

This is a little bug here, machine check is an EXC_STD exception. It
does not show up as generated code problem because EXCEPTION_PROLOG_1
does not actually do anything with this parameter if KVM is false,
which it is here.

Still, it's wrong. I may just resend the series, because it caused a
few conflicts in subsequent patches, and I have a few more to add to
the end.

Thanks,
Nick

=
