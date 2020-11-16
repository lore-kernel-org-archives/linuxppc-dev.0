Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6BC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 01:51:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0EC22265
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 01:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1XiwTKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0EC22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZBqr3pDCzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 12:51:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=B1XiwTKY; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZBng0PQvzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 12:49:09 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so3370437ple.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2020 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=dwf4L1qwHkkiE8Qr6IfZkqYtpEVJ5wghNmjsqqSTRBc=;
 b=B1XiwTKYjUgE+/mAp4kiu26thv7ahq9rDf4oPdhAyuGegHghLtTgR5vyYuWkLOcPM1
 6671K7TtFw+Hw2ayTTTQGo1Iz5S0Cpvz76zSfVjSW1Ssd0u5qbB309W4SwlJt1oucziw
 urkfqy30eLgajtePU6K858M4Re9SMfnHrqakYjIaC1MrbEI1bdHt0q0DujbRFQ1j7gGb
 F5yFYv3GBEBTFlXNBwNvFW3M/9kV7B4ByNjQ66OAP47TUFcP/Ci54GAN0x4ibg9YkWha
 jZqFToWxP31WsGnR50kYVjZbXa2QmvJqAkCJgdqkKEotTxWcNb2B2G7udtgLWeIdH9X0
 5BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=dwf4L1qwHkkiE8Qr6IfZkqYtpEVJ5wghNmjsqqSTRBc=;
 b=Kp3Vu/JFymi+pyYypXZXrg2dUFjHacl6Gh+WZ+qS+MbB2oh+TIc8zF/qFbiMyQsH9c
 yA15NTYSSBhFGJhb1tC4zhJSYBdZzC6TICW4H7azlgR52oaOxEd1yTnXd6eRCUjvYIdi
 cVEOlBKhVbyTHsir77q95LSpMN3JUqjPzQHCdm4+ZHSZFQmzjqAz5M/HeUbZ18YxorUa
 rp4AbtqdX1I6LmTjnjbZV0e37AeByFMFwSmrEAtsFG67e8kIn+8AZ1wsYHrIcLJge54a
 zLUrINKZenKZ44vFfZ7mlJJ40SqV2T87lol72jLKYgYr34Xj7rbRokZ33WDTXlfJbox1
 s+cw==
X-Gm-Message-State: AOAM531seGW1QZsP3EuoIuW63Perse8Pi0Lv8O8GOc8wj0YzXxFWbk+k
 /c0FG8ziY3SAN3bVtUljumM=
X-Google-Smtp-Source: ABdhPJw8wcYZ5fS5uDas78NkRnt336UK2Awawhc0c+GdfEv77aJJsBQSVnVn7t+uWhNF3OxG966FRw==
X-Received: by 2002:a17:902:9042:b029:d6:fe3f:6688 with SMTP id
 w2-20020a1709029042b02900d6fe3f6688mr10636858plz.75.1605491345753; 
 Sun, 15 Nov 2020 17:49:05 -0800 (PST)
Received: from localhost (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id h5sm16037129pfn.12.2020.11.15.17.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2020 17:49:05 -0800 (PST)
Date: Mon, 16 Nov 2020 11:48:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra
 <peterz@infradead.org>
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-2-npiggin@gmail.com>
 <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
 <20201111134412.GT2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201111134412.GT2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1605491118.ek4lw8ppgq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Peter Zijlstra's message of November 11, 2020 11:44 pm:
> On Wed, Nov 11, 2020 at 02:39:01PM +0100, Christophe Leroy wrote:
>> Hello,
>>=20
>> Le 11/11/2020 =C3=A0 12:07, Nicholas Piggin a =C3=A9crit=C2=A0:
>> > This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
>> > both before and after powerpc is converted to use ARCH_ATOMIC.
>>=20
>> Can you explain what this change does and why it is needed ?
>=20
> That certainly should've been in the Changelog. This enables atomic
> instrumentation, see asm-generic/atomic-instrumented.h. IOW, it makes
> atomic ops visible to K*SAN.
>=20

Right. This specific patch doesn't actually "do" anything except
allow generic atomic64 to be used with ARCH_ATOMIC. It does that
by re-naming some things to avoid name collisions and also providing
the arch_ prefix that ARCH_ATOMIC expects.

I don't know what should be in the changelog. I suppose the latter,
the former is discoverable by looking at ARCH_ATOMIC code and
patches but I guess it's polite and doesn't hurt to include the
former as well.

I'll send an update before long.

Thanks,
Nick
