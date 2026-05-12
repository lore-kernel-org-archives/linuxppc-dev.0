Return-Path: <linuxppc-dev+bounces-20792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A1ACD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 15:58:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFLqQ3Xwpz2xH9;
	Wed, 13 May 2026 01:58:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778601522;
	cv=pass; b=gla2j2ci0Zy8+U/G35PnLerUgNjzMMRnYmkO6prS+gYm8ifiOsTEutVSCJJxAl8lDAI2/XrPH8SlyZVALXKGnTfLEf5iL9sEhnpizMoTLUTLZSNzs+gBHcP51SrGIDWtqeLlfu/XKnuHmnjw3h+bFd/XzXaokKWPKRqhruh9yglUbDIngEjkmkMe/1XRkOw0N9hhgSBGwLw//70TpKPduFYsO5tntLmL2gzuoGFpI0FVg8V93oZwXOJ41Dl+4JW6x012MP9WT3qH7VWgO+fWWGG+P8VfNAwSRgBiElI+J77UysDn3nrn5agloGQazCW83r+ywx4Wm7t9+rhuL7aH6w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778601522; c=relaxed/relaxed;
	bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILIvdXP8zQY/t1VBkWbzOqcRy3wDKeDh9WTgc86wvNOkP7g6vcFEvxK1lMvCVMQ94okDTgWhDoe1wGN6MKH3zHtcG5wFcSyxWbo1VpVONA06U/yCVabgFH/N+3VPLyN2Ga/CnBkWJW9pn621+qoVMzjem0DI/WTMOAXUxx8WsPZkrTQ/baJ2HSOtBMNp+QXbKHZ6tfDeZoo5d7EzMgKXWB23VSytDYOZ8/ZTPk2zs39wso5Ji2d2gbI3OBaoPWTahDJVkLodknCGxvsrZHcht9E2MIyITYFEbYeETysEC/kvDxt+uWS/bmoz1FdZpNHpdKXNA8HzSjdFtL7j/ZbN5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Y6BrNyOR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Y6BrNyOR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFLqP19vrz2xGX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 01:58:40 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2670796a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 08:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778601518; cv=none;
        d=google.com; s=arc-20240605;
        b=R7hGST0xyhrulkUYB/hXtb3SmCXPja/JYrQTUPnXflwD9HN/vBx1JUCQnMWBmpeYB0
         3lIM7KcqRDs+dE2k9bR7ZRmiOfuShfpgWlmuscenH2BhdgdhMIACdo2+tJf4gAdBjh4J
         01Ci0XPjPEal3eJUjo9MhO3pkzb6fGbW/3w8gLFLSEMsBbRzUzd8cA9BZ4zf6qL9rrDB
         zmKZ6wZ/+eVQATfBQyMb+wmunH+x9B9dxJchKSYRfu685PRQh/t63Xpz/OlhjyfyFT4D
         +f7tOLjWIajt7CAo6rLh8uMH+qKDB3y8nsHrcO0jmS64eMkk6/SQYSaZGK+juqAIcXHi
         bY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        fh=AY2a8ntjJ1mgnzUWD6/0aXK6Mz3sc5y4Aw3Hda0OkhU=;
        b=QxhgsIXn1i5lhFvt7Cs280/Myf60/ZwyluQhERw7Xz+rwasHfP/TEL1lEXy5uR1CK0
         0U5Q+VS29VppuqsZr3i7SOo8vfXbaAoL16ItIB/1JC2M48z9p8obUfxpo+E/M37V6Tt5
         WlTDX1i+cWUcURQi2qqFmjYIWiyu2z3orBeQvgwX79PO8d1RHiKeyNzmU2HMJPV6C1O4
         oQNWexgEg+XGinHf0o1FGigzoVO2v0pWbu25PovosFOIz4Y+uKj32duCpykGePOijYo0
         j03aothCK6j7MC9GO83lV9difUMRUzYDwpec2Z1yl14Z0DUsCjI1+nHPi2TyeWn1FK9C
         RUdg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778601518; x=1779206318; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        b=Y6BrNyORnilXDKMrIEtIGxOxX6tBZI2cWqdfhkRmjYgyR2sMaRXfhgraDuVzrbJJzO
         m+DaKT2xe4sfXy6QtrGauPTsmHQsmDq1Qr0WYrpFyt6fXsP5lGw9eD4dRlxR183LWkxq
         YTm1P3BCqd1vL3TYT8gNEREZRsYuUIr5oYso6vfq/qVPGEAshBit3EF6YiwYjueSuv9V
         4C+wTGER5o4BtReZAdHVPnNDi2RborCxteDbSgcIAeu5UwtvgJI3s90S/SW3PVHzLOVD
         /SkpYZPrC4Hwc7Wey0CdrnfWNrpF8lnJwnEpYdSAkDSZaDkuqqZtpuSWWX8D7ndsuGth
         EmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601518; x=1779206318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMSNZK3767pT4X+z5y5WvqKuf0fNy1CkRFtgBN2R5Uc=;
        b=mNBK8Ne8axsv3Pr8AUuy3LZl5EMMCwiHuWNJygOS0EKdbO9cJzehUVvOT7jpRtjZu3
         Ufv1W+1Q4ZezpiWXAq0YMt8+TUnVEQc47IYXMciVQlcvXSTQCDFYyEL0j4B/rWHIKL7P
         ooO73EtR7r4RbTwwasp/YbdtWigTxVs5/YPTr9cLinrKgEG4rT3jVsHEZGlS3bN1TJbn
         oowjU7YyqS+6fNp0v0EA6ywUBGCAohNKwuRVwW1ABYFHMxJqhmrtSATUC0cUOmXC+Uj2
         oB2u9EtlkUyXWYpEq+fpwerbgodG9hw78poUh+oxbY6Nb+R08dgHOIXUtFbSPnrxsdPx
         AO8A==
X-Forwarded-Encrypted: i=1; AFNElJ8VW31izqN8/OJcIcToLncrzNsm7YoKznZBSV21rZQnmOpIpR+9JjslYP1F/uyjCvfihZIRt962ckd82hg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywfh8KzI4ClYq6xkR+CXxdoYnE21wFtaPlJ702yWS9k5pWxpUZJ
	VGUclihsfMCUZeD/V1GuaDPrZ77egCEhM4hi/NyKvrhqTEdRkXKGD357cu6Eo88l/NegtTnKRg3
	Rd7tFzt/kwinYxGHWL6TGXqCQ3C302gzFGMw/rUmz
X-Gm-Gg: Acq92OEN5QTHwlYdtwxz+8O6t4uyLXtOgGYu8R4LxO1p3ZstaBE9eiD53YL5Wpqv1x/
	jMB4ng2BQk6LaYwlx5LOqK3uWsUnl2119jSWgRktfHALBh2eUsg95g33UIN8wvA9fdrmOnwUxOp
	FNjyAv8YLkA/81RPzHAi9x4tXDCbWlXiSBpNCYEl1l+hEJZaml4eF921urrFVK2QO34xDlcd1A6
	Sty6qC4U3j9oqeP6++FcJDk7lenixLb33PdKvnDSev1tuqAWhgt5kNKDeM9HQK7Y6YsjloYiGlp
	rVF8hG4=
X-Received: by 2002:a05:6a20:12ce:b0:393:74ed:7de9 with SMTP id
 adf61e73a8af0-3aa5a458774mr36680654637.3.1778601517961; Tue, 12 May 2026
 08:58:37 -0700 (PDT)
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
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
In-Reply-To: <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 11:58:25 -0400
X-Gm-Features: AVHnY4I275P3CzSroklxl1VjTCxBzyxSQmhvt1UdsgCWsDYxXPS271nl7VghH8o
Message-ID: <CAHC9VhTjSFKEZNgd-w3Gh=qENW7KL-CYq_syozTqD05iAMubqw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Eric Paris <eparis@redhat.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 12:28=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
>
> On Tue, 10 Mar 2026 16:08:07 +0100, Christophe Leroy (CS GROUP) wrote:
> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> > targets") added generic support for AUDIT but that didn't include
> > support for bi-arch like powerpc.
> >
> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
> > added generic support for bi-arch.
> >
> > [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>       https://git.kernel.org/powerpc/c/f26ad12356a275ab303d5d3af4790ad94a=
cc20d7

I never saw a follow-up demonstrating that the audit test suite runs
clean with this change.

Madhavan, did you test this before merging?

--=20
paul-moore.com

