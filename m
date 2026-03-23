Return-Path: <linuxppc-dev+bounces-18567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401DCD58CBE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 04:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffKvf4y8Nz2ySb;
	Mon, 23 Mar 2026 15:29:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774240190;
	cv=pass; b=jjT8A2Vvp1Nn3oVRuU6Aspz5DhDV4QdVF2kd/EYB1/eewXl1+O/moMWbnqbwOYyvuiDPmE0bWf45oCdDJHMGvjUBblEFm756agJW1D53p/k79PUien3u/BXFQH+ZWxFdeaR+Ztgp5h7Lw6Ni3GnP5Wi1BbHiT4ZtzWMlUr4yiE+nD3nSyiQLFgzqA8wruZ6bJD8m1K3KF5EougRaJ4BolVJrOz7DWPSGCxYTS4P0cncoI/BUZdwFVdOTomwPhD7BELQing6re88EKXFQjsY+bvE4yHfrzsjkY+GDhkcW+DcKoDutTrhSYIfliFY2AinbypMEfmsm6ip/mGv9c2oXhw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774240190; c=relaxed/relaxed;
	bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3lWCvzG+KlPCvqc1ZJNCbDrwS4zVQ9m28LhCqKKPdOQn6ntw/4X9ElYHvrs0U4jZKNWdCQWgX35lVaKEwboX+cq1xhP/QGKCzhCPEbjyu+RDlzyz08XR6YUCysJrpVyKhnBw9chJIIbWOGZmQF1HV8frBdm8NelzZmr8Il22yVLhO/jHSvxnO0wTxiAsZcUq8DIgiW1ytxPZ5G5/8TgEnQN8mZHDov+rfm19C+uIh171Es+tDMRsJNk1afuoZq8uKDivWzZ/Un4Mxv/xyzKI8R6XL81T4lBUdkJxFMHqubI89PFTfnwur6Ca7mIWkPQWGfdHXuRPUoB3SltOKrXyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KDBg9JpR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KDBg9JpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffKvd1HtDz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 15:29:48 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-50b30d61be6so1155631cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 21:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774240186; cv=none;
        d=google.com; s=arc-20240605;
        b=cIe76+qL8yvvCDylI4TRNZXHgyhJrb/Ok1Or8qQBNryV0U8vxEwkCWMbTyPT4rgWpQ
         kvNbNh42cHPNJ1wopvfuWlyInDZydgHvtxpPDvrztJ4ZRuLItxHOjCRZ6ipifLo3p82g
         Nwc4yeQkDuHhtTQKbhJFi/ygC2EnmNBYmnvHJht8esO5KMROdI5LGLHpYCunjOEO0x5O
         kGfISDel+Iy6gjqopa1R2oLZ9TmPnCkj2qG6ZSAdweiPn/vSJ9kQUMyKukh51iVhIhcg
         98NOXyMk3MDKknBKEh+AQt9YwTCeCoCCX1Tex9Ig6u2wAXMP5X87AOAI7vEdWlKp0veF
         JnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        fh=mOnrub7K/NORz0UoUiVp4yRo0RhtlMwQi0w5n/u4TTA=;
        b=VFLO5TrTox2Z2xzmDr0MbbbXingszeTta7tMqr9lAPvwXhhmcUb2uvvKnCvgaUrGNq
         QzJy864m/zYIec7inwIyGF7cgoh8nWpGTI7P6onVlB68fnA8OzkqrBOJsaa5Nj3KBw9m
         I/s06de7fcYJZRT8pUSQK6aC6vPvvrzF/WkY+mDOGuu1auwkixUuwi4iTR15uA/kd1oI
         iInZJ5E8fo4k7A+S5d743VEO1IHYNPjl9J61H1BLrGGaYduWnCItbO/TIZoTjAPHSBtk
         wqbBLKv/qluO/Be/0e/bMGCuJk0IAT3K7jyQQJE26smbzCT8hOzCuVNpsG6T/alOkijJ
         Ss+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774240186; x=1774844986; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=KDBg9JpRweTg/ZQcTkq2XJwTvI/MaOjUEc6T5OeLhXyr9LkJhxjMnIKqvBQ0GFC6Nf
         L4k3oDi5N9oU8/EvRh3fpf26E8Yu1fWgM1HEFXdPnyNpSVzOZaoAND4dyM2KI8XZ+n5p
         fzG9Bl6J9JhR7NGKaYgUgk6CFuS83BQQQF+KVEQ/ZXtu31ALgUw5pLSC4Fm44CVuUIoB
         k53DYPAQ6BnwF770UzKErTiTNCCwaNe1Tp7tFfRxcqhja383v0leh73TuC8C2uQaJ4Vs
         N82BW2o+TDH5KFLNVPWRlVPnmahHLeqq5jkn0MvyW0axGsBicEYiexJ4lj4X/p1t2d9k
         MYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774240186; x=1774844986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=HwMPhp4qPQqRACztx865crgF0RXdwfrGNVrOm0LJBnuEN/ofotL9VaCaTiKYCOYV+H
         smunj9qg73xe65fj22mebMgkVTur0TVsqg0fBUvKbCwTwxjmooasItGaOC3nMqqjVwDA
         ruPRgRqwQ8Rg+EOo2y7QfUft/SL2kCMjs097SH5L5rPSI6JhJpMcdIh0aHrXU5Qk0aXZ
         9EuWJy1/PhRg+htDcUZMlCewLxdvTVAIEGCBuS3wW+zsqRzJ4bDZhqz/LURmF6SBew79
         zVa3/eDoNvI21qakbzAfdoR4OkxbNJGAaer9MuzpDqbpdDe5Bg5LZa/bebiHkf837G4a
         b/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWYQGqBXFnsSIRE5TPRhbscyql0vuj3wiLNuGTVpT0d3SX44o3/xvku1J9+aFrQWsZ8pPdIly1zbRMCVho=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSh0j3EgWOCMU0I9Vj1U+8pMVKDwLZnd21c6lNZdgX9kpkpHd7
	LOuwcW768otBUxMXZaYGG8SZcb2zzKlCL5a6O1rE7UoQ+ndm+NyjdvcmJ1YOL7cMrQag/ep3Zev
	qCFFPFE+ktCedVlseRKQIlcksJNPLhC48NBhge7Zf
X-Gm-Gg: ATEYQzzP2N9txBClE3PQfV/SnyEdQ55UWi8XuTsxC3UvsA/o7FmbNg9g3jXXojFTvIT
	+L7R5EDQofExkc83nqGizi7ItLv+klxhyhyUYwVLwLp+RxfpYJkSDOzXRrcnB7AuwAEhMVxb7q0
	+lUlNNdNjkt693b++iaWc5axZLUoW3yO+FcilTeNp+9HF7C7ZJ08qNUftudxIb0Op00M0LdSCas
	h24466p63u0F+TkDeqDyYFICg3j/iuvcTJVfDCIKlZm8tEUtt06/fYbbOFK+wRQpSsr1DaoemeV
	Nb/MMw==
X-Received: by 2002:a05:622a:5597:b0:509:123c:f317 with SMTP id
 d75a77b69052e-50b46a6754emr23046811cf.0.1774240185749; Sun, 22 Mar 2026
 21:29:45 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
In-Reply-To: <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Mar 2026 21:29:34 -0700
X-Gm-Features: AQROBzBY2-_fJYphsyTdxWc7XCwazEP7y-d_Omc4v7H9yVwU181BEprIAh7MNYs
Message-ID: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
>
> Thanks.  Sashiko review raised a few possible issues:
>         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@goo=
gle.com

Thanks! This Sashiko dude is good :)

