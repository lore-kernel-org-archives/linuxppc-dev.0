Return-Path: <linuxppc-dev+bounces-25399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911FCC2A09B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 02:27:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFDpK5xgQz2xnp;
	Wed, 05 Aug 2026 12:27:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785896857;
	cv=pass; b=bDPQHn4lCoR9/O2kQvXxcKs9JWmhREc9eM3MHT2FTHJpYE5P8QhYImJ2RbmcCF+u6pb16NtQmF1F5kJy46HgprBcHJAOmBAGXSN7PcGXAauzKvT8oB0QupkZ44oR8QCDglxGw8RYfS7pBdz3iBxyDcoG5Sb9xiVIwz/Ca4dUl8T8gDaeht0ZCp9V42lj5wnHybt2Qj085byhicHJte24lBFrHJoGYsU+37PZrqS+81CF39Gmly+UbTW7kXtifq2HIb5IO70QxByKNvcHOmw/BQBbvgHy/uRv5EhuzLMhfrAvxodhQrssrIE9rU3rB4QtPF1AkpI2qldYjQQL46Zrqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785896857; c=relaxed/relaxed;
	bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMzONu4tk8hFZAH+i2GMSsqpmanH12OMI9KyI2Dg+aJAnaMVFWxToiByJkx2xpOTCehe50rFb8YQDteRPZhvtMlZ7blYk+ROT3zfNZBciSIepWciFcf+ncBjtz9qnpb1/yMMko3BVFVBsnffzI9QsTQtNsPkN83Chm0eEt6BawJiMrFyecc2IF5yxtDRTkD08YxM3DpWxI4sT3Th5bptQIqFlS/S5DX8G33IybE/BlCGF7nhiUa5dtdPcXId0AqFL2PvRgQ/P/KZoAsT8/OLK4PerAa5x5qDGo2JQVI9X7IVesT3qd2cU8P2uG7yda8uNgyI08bEDU/2S7nnFb/Svw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DtF7JqnP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DtF7JqnP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFDpJ3H1nz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:27:35 +1000 (AEST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-51c01c79467so165391cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785896853; cv=none;
        d=google.com; s=arc-20260327;
        b=cvp1OrJl7X5YFuXENg3O9LDOKkM3C7H51JU/Y+nNl0V7JH5Qt74kUzV1SJssuTnIh1
         0tISgouvQL6hmC/eQ2tT2BZB2KIJfqMJ/nTatpFVtVfBOdgXYsR7ybP48aT274/y2lHE
         LtHuK6s6ccT+JXQDDM0fV8JIn7T6fewxlEVq5EYHhO0cdjbbMfjUAkh6UEpQ5dByzcke
         F11m8CT4pqSZa1hsFAb/ZOism/mT2ejXAoD4BSdaubZRzzzrCL+oR5ZdvlquvRZ9bOkD
         j+zzIQVCjxbt0o0ZwWK8SfhEJdnusx9J4hO/qoO6RbKxMfH0I4ajvSIKnBrMsTI7ZP3U
         652A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        fh=pT3FN2wWj9nm1wKBXuLS/K04H2UQGRiehwM9cb0yazQ=;
        b=BejGldkItkfIQGIsQJETdD9QZus/kwnSeAhFM+3sugqVR2InWEayV0R15Mx/fZHrNh
         +WO4NaOfkPJAXhrwHqtzUMwpCQBezJazEXMs/OG49TSX+wErybsO5ngd2Xh/wZdiPiTv
         cp3jjbRqmtZ3u0gtEiW0H+sBaUf63tk9pLMFdoRNa7yS2BWPSu+/Kkri3lfu7+uutEH1
         ft6rppu5+ltoo8/ENG6YY6oPbUzqHFm9i1015w68mH/WBbqe+D5wiVfyqIisV3SMw9Ue
         0yr+TY6bnpd/K0N/M5IY2FvNxEICDvaBv1ilDsSVrPavyvLKTNd+7tIfCTHAgHUE6a9H
         p1Ww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785896853; x=1786501653; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        b=DtF7JqnPF8SHq2u9PthnhZ33axnHV5JB6/mY2Y1iV5YU18YNUlsF9g7sZkcEcFcFeN
         ia+AjcpO+Sm8q1yvm0PUdepjLzB1c8GaVTh6MQh5QLHzHl1TbDPayMV45VqSYhUY4Bke
         q2/idQInf9Q/Mg2kEarf04DsyyUws8ydi2IMAUyo7KXbeCGiwIb+YJGqRrd10x05WA4e
         Y5u2abcAfU9OdnRHaOl5oVti8UeEahava6GkjE1kMfOavR/jnMSQ4q1Ym0ySH4Tmk072
         UU63lY4lFjnx65mDJiZ07LI/xmziu6AkSXVw/WYl8bwgXZozA22+VJy1YOgScWaLCS8I
         ZIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896853; x=1786501653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2CaDp2rjS/geQ4fdg6p1s3ePeoEZLt0A86LHj/pTVM=;
        b=Z3HqQj45EosrXt4OD12ft5imutHYJvk/8X/XfzTHJTx952r5pqCf5G2CHZkVXWs35m
         xO0CHRm8RmIrCrVN7p9BO7w86aN/0GiIVc5p1gxp+yBSozh2T0LmHGO24+me5XwcnfXg
         o+tK379USUMm1fkl+SBoKbo0vMM10K6kPaq/NqDEA/sgIowvuCHq+4vpCGgYgSvf90GO
         6BS6H2CCA7ZgKYzOCMWwUSyfIU3s9jQmPpSvKnQtRtXgOVf8T3X4rCieSeJ8fP38mNRe
         q99F1MTwA2zw/pma22ZxnuX03p8Mhnoq5iBxv+zrzKJgCIUDQXahxbQIS+reSeLfd7Hw
         tiwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/b53VO6oXZOqkdxftcnOG+8Ur/ahi+pLHKwemOLRgYcgyS1FwSnzQ2QylZLP85hF9/rjlp91zsrN62xQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/ndMe3IP2pRUI4EYXdFDClD/+38838J4t4+HBC/1kFvAgmQ7i
	a/Q2CwwuksyynMll2bBbE++JDOkKVF2xjNauVU3Tr0HXrs4l1vmfA9y0XKvJNtYsqVADhi09jw7
	PrgR9oYTOZKWKbaj4yXwcSUaBTAshbgzTqrQgMPZo
X-Gm-Gg: AR+sD10G3OITNTFWyTCElUQlyyIS6kPohWda/E4iVJJ4Of2tEeGvsL+ZOdmDv0fsYEn
	3HoAiu+mQr6wqPCqY0crqBKok9PVqrQNnTJNUTvj9j/Mnnn8aRvn4qYbr7pTFRufun9wg+qKxtH
	MQSwblx3aW23C/3iJ2lfkcc2zHcTFWchoYXJmBxCmopOjsDsct30PgnUe2m1sApuW2l7/Zkvy9T
	5Dq8MF2L1IYHLPai1xtygGdc2OyrWtXg+Qf4g6l7TjgLVNpLSwPqO3N2Ut+fSnq1uVacfGV3BNe
	ckEp2bYrJYg8/EYh14Pk9kZmBmOGvPOriIHb0n89gz38yw==
X-Received: by 2002:a05:622a:8309:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-52ce97216aemr6211561cf.9.1785896852545; Tue, 04 Aug 2026
 19:27:32 -0700 (PDT)
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
References: <20260802180801.65183-1-tshah@linux.ibm.com> <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
In-Reply-To: <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Aug 2026 19:27:19 -0700
X-Gm-Features: AUfX_myTD5ZxPyYhY7fyqtz7oDkG2IG_NGA1QsGB0ouLOxTOOKws0HluA10mb_o
Message-ID: <CAP-5=fV0Y=__y11kmcLBo+1yAMraUKf6pUpdNUfav4NJEocwGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Add perf.data tracepoint events to trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:07=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> On Sun, Aug 2, 2026 at 11:08=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.c=
om> wrote:
...
> > v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tsh=
ah@linux.ibm.com/
>
> Thanks again Tanushree for pursuing this. I see on sashiko.dev that
> sashiko couldn't review the v2 patches because they failed to apply:
> https://sashiko.dev/#/log/baseline/53604/2
> The SHA of perf-tools-next that sashiko.dev was trying was
> d04ef71492fad7230d474efe33d05f4c0563d409, which corresponds to "perf
> machine: Check snprintf truncation for guest kallsyms path," added 4
> days ago:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/commit/?h=3Dperf-tools-next&id=3Dd04ef71492fad7230d474efe33d05f4c0563d4=
09
> Could you rebase the patches so that we can benefit from the Sashiko revi=
ew?

Fwiw, I went through the individual patches in case I could give some
useful early feedback. Everything looks great, and thanks for adding
the test!

Thanks,
Ian

