Return-Path: <linuxppc-dev+bounces-18721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8BAF54AD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:00:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgF9b5Y9Pz2ynP;
	Wed, 25 Mar 2026 03:00:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774368003;
	cv=pass; b=Ya2X2L+Cr1GszML8wNIp7gJN087UVICrD7JFF+5BkX1VaFP6jk/osA8t3lOQQexOf8mFtl9/jhiy/o3W0jt0iKIpSzVK3J5xKYl/NtxET4PlHWAxy8WuK/ZmYVZVxHgvoTrcDipQjhxiU9ooj9GyAM+roQHicjeDLhdBTra1P5rlqoZDNk5MdlpjorOK2JD/Fi+pwcgEaotoyNBAmDoepq/eRhjH8j/Jd7CQzGAPlIa6s7poYD3LUGb2mESZHiKSNRpWj1nFUHZk+h5txucTz5aAvZ3Sgtr90kaAyTDtEfpF3eGLHqjpvl2MrO7KkSTm/7/K1u3762+CF9Gk6qdADw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774368003; c=relaxed/relaxed;
	bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1BLzk9Gqn5RwrRgoyFuUrBZ7BxeluGk3E3ammlaw5An3QxTC9Phib2Ta2Jxni0FrqxpVVYdzmkIVaNfjKploqe79a+8mG7++ohn+cyfKpatIGvuSHzvW7JgVDLjECVbkIjJeMzfNeWeVXnwOS9tWfKynRJ+CjmeS+wvzREHR7d01dHuO4fZfPkAggf+Kd8aBDX3ZtRY0fxtrVIlnZrWpfvYZzHMX/qKCXyXz4iU3Z2q+KvVSDQwdlo6rRLeMQ7qdpzUb/xtdsYj0mtp1dKBWUg6cRNXglPkenciY4RpcyqQrZutMfZnGfasoCa5LW9Djw4PUCXWfq24DLVokPsI5A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NLV39c87; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NLV39c87;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgF9Z1MG6z2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:00:01 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-50b6c45781aso832601cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 09:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367999; cv=none;
        d=google.com; s=arc-20240605;
        b=CvBjX5rv0UJsbd1oXs7mPRvP2E5O0ZjE8WQwScYI7FOFab0v9nFhNHg2NbvIszUZ/B
         rYgsQ0osR/TfJKDWaElPwRElPq1++DEoR/RT253ACFO88AxXHZizaZQvf5qIAc57OABi
         0VSL8nTUoPSz1iXvWPtl2JssTqCNfIEodChGFLZcSl1Pnd+lvtQz0JGgnfKjluSk1ecX
         7W6FiDTXO9sk8QpzroEaQmtlNCn+hWeGrhtcc4nOLe0sBiC2Rc4dmGgeT/0K3YHXs7Em
         CMTV+p9Hs+CCdh0SIcsku1Mn7z+Sj89HBoxiyex0aUJYecco/NBbcjkFgXp5hgM4glSZ
         Jm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        fh=wzZU2niOOfGC3kBpBce+wU++wFumAiVkbSi/ctFcezE=;
        b=fFyMLSc9yT3s25FuJRXIUpF+WuV63tcXLoLurXO40/q85iGOza2ksv2jTvVK/2P+At
         vjkTrZNgSvEC+Bf/0++A0KLfEoWt3mCqfPnWiquO+4Y1Zn7F6xc8/W0pPhBq4TUgHn7V
         8h/Tu1IihztWLq3XXhBxbQUwD9nlvBYaIDt18Mn24m9ZXW3Pklm1mq0Rz/WmGpIXZ56L
         EiM2k2SMZ7/ZWo5Hgv05ZWlHcwGRcpkMvXP0yXVcSxDhLKD2dvW/TYV1r1tjDPW9S+fA
         n09ANrf1yWt2YHPLQp64bBQk7B8NrQMosXg0vFmRA/LdYuhegRwG3HHg1VXKb0HBBSWc
         rURg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774367999; x=1774972799; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=NLV39c87C7gj5fELZc1hSwaz15vdMq+Md6heJ6LK7ydvq5e2qyvy4ySW/TmBNo3AiC
         45raeVwUadHqq3K/nax5mpT9pA5r6LVm5nJ1sMuG0lBZZ5zWrG8C8viIg7knzbsCjDZS
         38IJK6MwsX3Ga9QbtJ+iYf2ELLiEIz5pepr4Fs2VyywGG9DrdnSU+s0vmymkCgX+VWx0
         YtSQBWMHnorsnVg9bUQi8OfO0heqTyayy9r6tkMTqjdp9w/uAPCLTZb1jSnSFpGFsysL
         Q46Pbz/8nClx46d5dXsM4W6cHffJyO1UExHY7TFjbaNR4scZ1Ff9vvoMWd/Y2ZAN/9qa
         q3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367999; x=1774972799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=Bn949cwGCGCKdA2FJKacRM+Kpx2S6Ro+dTevmY+yuKTUD06HvEXhC5mQiLIULt0AG7
         J6kHg8OsRxRM+z6ljzMX7m5rkLTbD+66JD8od1Zt3K7xNe/qz7+l7Ir+u7BWAUrqcsv8
         SK4Sd2CLfX/QDUPPDiGaqv14+GzSxD59B+BHxb1zlNrDQ5coo6ZkQ8b7u/W4aSGz64Ij
         ex2GPG9Z+BzWOhVjvucvO8DQ0sBO8BCw0OR3X4oZWWhJ1CfK9itu7JJLK24WF8bhSyg1
         AdX0z4k7tA9ajXCCgieOBWlJapgA8J6NLyVGit54JDTQrWWZ16ifOF8AIprNsEuA+CAU
         G3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3oidYd50Egnh7QSaE4E/TDzT1nPM1HfXeQPqrfJ290cP/vcLuK51NzouQvWAVUZ2dTInj6CSNsCZ/WAw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyq1HnAZ9yybzRqsbqJq90PMhkOjfIwJH5y17O9rV3jRks7jUai
	Ebo1/vjogBviF/YebfO7j+j2Iq7v++z3R6BCM9QvuDKuIzoagJBHX9OpIPucvoau3TvcFwpCcA6
	LANnuFbfcAF9fbzr5KDB0+69W+tI0kWzbXmo3Jxgw
X-Gm-Gg: ATEYQzztfR++AtaiXqB1GgTorwvMUHKamGx1qAVzVabLlrh49XikS47klkIDk6l7y7L
	63rNdubED8w/cO6VgMycDHOl63BfPfeUdcxltbxtTxlxgHuUUW6Lv9GHkoKVHRaqu8Mgf3bqj2/
	qhE5Rxpzz5VA9KLuOanGj9POXKxXzFpRoOc48mt2jAqhUnZTQ6ZAx5QG0Zf3/iCRRQpdeuGmBxr
	K0WDvH6EdJ7iBlZ0SIx+onDT4y3rS8CMSyxRgc5vf0Uw1F2T3Me+l4B1ggx42XmcsmpIgX3clkm
	bAEi4eAuw8zEe0NtuE78sQUebAxHUD/Q+icJCQ==
X-Received: by 2002:a05:622a:8d15:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50b6fab570emr14738871cf.2.1774367998125; Tue, 24 Mar 2026
 08:59:58 -0700 (PDT)
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
 <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Mar 2026 08:59:47 -0700
X-Gm-Features: AQROBzAMqgNkN_nl_EndICe5F5XJG6Br11eHuUlOIjfDgcmYOvJ6ZgT0J1pHfxM
Message-ID: <CAJuCfpHQ6ru79hjnRnz6vpb2-Rjff8QsM9d_4g9jd+_jb9-qvw@mail.gmail.com>
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Roman Gushchin <kfree@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Now that we have vma_start_write_killable() we can replace most of th=
e
> > > vma_start_write() calls with it, improving reaction time to the kill
> > > signal.
> >
> > Thanks.  Sashiko review raised a few possible issues:
> >         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@g=
oogle.com
>
> Thanks! This Sashiko dude is good :)

Interestingly Sashiko had one false flag: "Does this code leave
mm->locked_vm permanently corrupted if vma_start_write_killable()
fails?"

In mlock_fixup() the path that we call vma_start_write_killable()
happens only if both new_vma_flags and old_vma_flags have their
VMA_LOCKED_BIT set. In such case nr_pages is 0, so "mm->locked_vm +=3D
nr_pages;" does not change the value of mm->locked_vm and we are fine.
Perhaps this can be used to improve the model?

CC'ing Roman.

