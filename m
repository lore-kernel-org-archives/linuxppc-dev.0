Return-Path: <linuxppc-dev+bounces-21756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0936CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 11:03:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSHQ71LLNz2y1Y;
	Sat, 30 May 2026 21:03:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780138991;
	cv=none; b=Luxqw1rrKD17fj+y7IIizCKwblKOxcxKqvcBilFfv/iO8DtI0qUHwcz1kG+vD2VOZNSUkojnkjPCqHb05UK6WZr8ZDWBvSfFO5hYQpbj5u+gAXOhhp60kXmiktmAmnb+wvfaOnluclBRrmI+SSv7CZ1C4K3FjZ11fcvOrc4Fl16z7bA0mOZn7TLNTHehDnzHPdkVNoRLA0fMWDDLDa8TOostN3rCM0BpWSpIwIdNOVNGD5puQLwNuOHOOJftUkmVw5WOD06brpwW1De0OPS6H6RQL/sAYpnVZUeTgdx1FLq6hzjdh9579GMqRqnuVw/V795PCRcoRHnDBjWRfUdhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780138991; c=relaxed/relaxed;
	bh=dp/mGIPuzMQgF9N9UpzPuL55AQoFcQOM3dm4eEgb0Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBXqDZaiCNqFwNpQfy84CYQvIqhmxlaFoRrY1tqMZMI4SV9yb0A4rkHGVucvpX8M6a0rw8CW5VgBL6kFbPb56fsgV4fgiWAjrf5Bi+W2XUWuq0J1JLARurg+3pQek1Ewcic410+lHO79aHm89ShWJqIbGlwHlw7LHUDAgnvstwK/tmITh8tgRlW50zfzt+Xebl34dZzkQ6xXBg9Y6zrQGgM+BE4HC1BOfad949hjOEL+MsAhxNIk8EaskrZayRZjviMeugVGDI4uT1dk4qk41vMq+aMpGWu7kE7dKov0b/r+gf9VYfitnvIqTmyg04IadNQetVl6RTOGdFzhWbbYOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJP/ESTb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJP/ESTb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSHQ56XRrz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 21:03:09 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-45ef4223be7so803774f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138986; x=1780743786; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp/mGIPuzMQgF9N9UpzPuL55AQoFcQOM3dm4eEgb0Pg=;
        b=GJP/ESTbjwoNhaqiavUepf7u65oiqwAfpNdan/hiEAfvzVjL9iCuFYeb1rmvQMaEPF
         5vHbFQWxK0fruWAwKsO9D0p1BPuHPWZ6roTlLM4AMIBvxVqcY1GhCyDyBEHegp84qDsa
         ZNG/3/GUtmDoaxHrvXOU3sg2/v3BAAjsAMjg7ftQdHtSEX/afrORZjZetaKn4rZy4KPl
         XCwrO/VZU4P5WlTm9juRX/h5B/6BfQTxJN3AW/sfmYA4O0r4Iko5CHEf9fNaK2QFX0uF
         v/2mH60IXOEeiiFwFWxzVMjAaJ1gq6KXObXVBNHtCi9sY8VqU/ShOWAr2pC/i2LUSn5l
         Tm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138986; x=1780743786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp/mGIPuzMQgF9N9UpzPuL55AQoFcQOM3dm4eEgb0Pg=;
        b=VcnmcTOwZlIZRjR7/sppwlJUJgBLABpYBlmobKL2EEV0GxDAr2uIK+oHwfAzUS+06/
         nIqnGAAb1B2Mi8zUu9K6QOgqedyNWxiwR1FjU3IcIUATtycT4teHxXqNfXMPAeF1EjQ3
         kPN8zTAaCi94aQADDSE1JzRqSfLOiLkXX8w5xol3i4BkbV3Nfg5sC0BNWG0ZOl2etq4b
         KASrQUfYF9/pbZb2Vd2aZAOac8lGa/jxouwaXQZ4m2IfMQSoXF6ll5EVCGNPdGNWEzYD
         kJ3npNhAMNpgp/yTrGVSQzW6T2YzaZ2w4Fi69itPAGnlGEQtDHD6IHClosgZNgAWciDH
         OV/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Uii9e2V1Jun4O+uqZPwLyLFmcItLMP9vZAOXYII3zATODyO4pYvCxfO+JYhmrPz3c9YxQuPuw1SWd5/Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1ekHUc+5sQPbVyj/25AMArqSU6j9bKrSzHKpd4Hbpjroidxvu
	q+WhSCebXPR2EPAHC2LK958HC8hWGCdMqYn5cYv7sW6PQJIMcDIFKn7Y
X-Gm-Gg: Acq92OHY4tfl4KtUrIRo9tx63P4QQkdCLBZUpCMpAZN80GEjgR8q9YwAexiUp2xdiyu
	h/1aMvmSIbydmTuFZZb63O9R8Clo8kJvbJFaKsBAUaIWIPYaidLXxnQBbGy9jHmdjFfHIpNZdzi
	xnq++ypwTCPPMKuTRANcoDhRFQ5BZmSiDymtw4DUrO2yLL/2AjLNMljM7pvXytbOhUZi6OL9J3p
	ksZwuV3JHgzX/NaauEUzQGSx7+hFx8icRPoUksL5qF8xmPlfNuHOhUyTdfqFATBLNjbZQWThvXF
	q8UkB0EfrGvHL/ApsCh2ef/WnUGz0XcsAY9cI15o3tz28xTXr0x1/x3flZ/6UVoQgBIxJDNLQcH
	+D0CvIGQq1JMSyzAbHG1qGxTjrxiHATk9zOj0su770EsAjjjGSsUZ3SeCHkpLijkw6XxUPlvUDV
	kmzAR0B2J7JGQiHoBLHSmyn6cdArrNvDWXtGtWcS2X59ad8X9O1w1HAhSeI/xf41/fk8znWNB1Y
	evJHjWyxA==
X-Received: by 2002:adf:e00b:0:20b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45ef6b4f949mr4179217f8f.20.1780138985680;
        Sat, 30 May 2026 04:03:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm10805363f8f.10.2026.05.30.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:03:05 -0700 (PDT)
Date: Sat, 30 May 2026 12:03:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 selinux@vger.kernel.org, rppt@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on
 Power11
Message-ID: <20260530120303.1b441fdc@pumpkin>
In-Reply-To: <CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
	<8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
	<20260529171855.7966b752@pumpkin>
	<CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 14:23:06 -0400
Paul Moore <paul@paul-moore.com> wrote:

> On Fri, May 29, 2026 at 12:18=E2=80=AFPM David Laight
...
> > PAGE_SIZE is not the length of the buffer.
> > Should be PATH_MAX. =20
>=20
> Yes, as discussed earlier in the thread some additional work needs to
> be done, and verified, but since we are at the end of -rc5 I simply
> reverted the patch.  We can chase this down next dev cycle.
>=20

Emails crossed in the afternoon...

Like many of these changes the buffer size should never have been PAGE_SIZE.
Clearly here PATH_MAX is the best way to say 4096.
But I suspect some of the others should be (say) BUF_4K.

I wonder how much userspace code is left that does 'char buf[BUFSIZE]' and
just assumes it is 'big enough'.

-- David

