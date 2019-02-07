Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F67C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:11:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D587C2147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hag8r4X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5y76dcHzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:11:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w4Tp1yWxzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hag8r4X9"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w4Tp1DMTz8x7Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:05:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w4Tp0qnGz9sN8; Thu,  7 Feb 2019 15:05:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hag8r4X9"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w4Tn4yP6z9sN6
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:05:17 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id s198so3938648pgs.2
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=B0wtF3sSRSm/68OmNC5h/4yL0bfl5FGAERaGnqZWqJw=;
 b=hag8r4X9KDcEf0YEtUk6J3MIsBterJGCDNAT65FeM5QQDUqaem4wYieAiiktLWl6O0
 sn9oJsS7EOZxGfIojbPzdrGnLZFSAzADMm4AipmUZBw3NCpytGrDWL/BurBXCb4PsSZu
 SM9pYBBp6sdFtWaOWqyJKfUEcm1+NoKYGy6SLhtNHNltLIHeTsJ0tNXNsRWz1CaU6z69
 zGXuANLtMgGJ1gAv2yC4x1Qh8aFBOTanmMQh3AV9IEp5uw0FcrCVT9Nqk8VRichtZQjA
 QdlvrR2k7Y8XfpwkOaAGlfY1N1+Dm4sW+LGdsQmjr5RpQw52E+vFCsltlDU0UE5W6cFR
 2rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=B0wtF3sSRSm/68OmNC5h/4yL0bfl5FGAERaGnqZWqJw=;
 b=XH/KZC2M4871DkAYEbnusxnsHKlHpFsupLm6DUNqG3Khj2pcyqFAsWefOpN+U7wuUS
 0e08vuCAhhK2fyuQ1Yw6Mko9uHFBjX+DtDcQtLq+JRLgCiBk/CKtzPHq39ALMHBeBT5S
 nUTAsuq6BS8YOcT1TZjxvJkeCehglULEWt7YjEc98OfTpjhjoUoTvcVG/9zn3y1aOMC/
 IH5Z/nVNtDYSjfb5NHFPV3w3TNlWA1hA/sD+laxFe750q250ecGTByD+HUrGRs8Khf3W
 RE3fGxDi9ieFlQyMAj7uXdJGFTVzbHFqWkvASVltcBCtZKyjI7uWYfFocq/L0893FtoZ
 RGBw==
X-Gm-Message-State: AHQUAuaN8azolzWESTwesfUj6FP3SKRcDaG5XwKQEHOEX20pfH1d+0Fg
 2ixrQHLHdt/ABJShbwYSQSsnqDPrBFg=
X-Google-Smtp-Source: AHgI3IbJZNaduNYwxfE/z5B/l3baKblHVLRrXhd9NlvBUwhfHauIwTDJGDvhF9mnAYo0+l6igsetHA==
X-Received: by 2002:a62:670f:: with SMTP id b15mr14076219pfc.212.1549512315687; 
 Wed, 06 Feb 2019 20:05:15 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id d16sm8899608pgj.21.2019.02.06.20.05.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:05:15 -0800 (PST)
Date: Thu, 07 Feb 2019 14:05:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 05/21] powerpc: prep stack walkers for
 THREAD_INFO_IN_TASK
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-6-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-6-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549512130.yd2el3fiq5.astroid@bobo.none>
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

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> [text copied from commit 9bbd4c56b0b6
> ("arm64: prep stack walkers for THREAD_INFO_IN_TASK")]
>=20
> When CONFIG_THREAD_INFO_IN_TASK is selected, task stacks may be freed
> before a task is destroyed. To account for this, the stacks are
> refcounted, and when manipulating the stack of another task, it is
> necessary to get/put the stack to ensure it isn't freed and/or re-used
> while we do so.
>=20
> This patch reworks the powerpc stack walking code to account for this.
> When CONFIG_THREAD_INFO_IN_TASK is not selected these perform no
> refcounting, and this should only be a structural change that does not
> affect behaviour.
>=20
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Seems to do what is advertised and asked for by the CONFIG option. I=20
don't see any other code that uses non-current stack.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
=
