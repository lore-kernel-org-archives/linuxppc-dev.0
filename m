Return-Path: <linuxppc-dev+bounces-19221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56701CC6B3E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 15:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmlh25Gz4z2xc8;
	Fri, 03 Apr 2026 02:12:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775142722;
	cv=pass; b=DnPfEEqJuQ5qlscgBGhlJXyzSM+HNQhuTE1RnVYzs/4lKZSjg/WdW9CAaSR6tf0LlBfcURpalZi17w3yOeVqfkKqOpOxMMOPVjZlHsQcDu6Mmvn5ofCs7CNG5w0knnflbHvGVzYXIDfXAdpUNKSr6hyJ6gEWpre+YN3j0yGoyMmqYcGkzk9vLMMHfC2jw/t0DaiC84FVNCYVeC4w4fm6z0m6f5gZfu513gsRhZgkOZJHsMV2n+0nOinUt05hFiaXnw5aOOmXJO+sadrCwKsO+eRKCNHUGhQ90sJXNxDy81Yws/7vFZ6OEMFnpgO7Ypnk9CX8k0uSGQLQNJ7L648oeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775142722; c=relaxed/relaxed;
	bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijj7z4iZgzqeNlbvQiIHdVwgnVrZrDuXI+NqzaDSN72XPR6OFon6fQbThky3EA9EVv7n69rk3/ffQKzWIhnAnrGiOLOXfQ5wHEVxt67Bt1zI0FSGScLgWotvGTOEchr729X+qddrp3X+OnPniJApneFiybk6g5XlPNQsexXyUZlp3eE4E06bB9kSh0zZtn7fYEQinNFT2qpYOny2SpX3mAon4mCwOLbZQzuorwwN8tHvUKDSSzyvvTKTlTWKMhc0xnEGRgxs0HMDAp+W6UtFO+Mtkcm3vcqcg4J8vVwJgLPSvhrXUddVKr6f8STPJwQIZbpq6/f2GkGUdmrBoFwSew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eoNF/3uD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eoNF/3uD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmlh05rPTz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 02:12:00 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-50b6c45781aso752481cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 08:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775142717; cv=none;
        d=google.com; s=arc-20240605;
        b=Fj/WP/qwct/GFed0+bESArRDrAw9ibPBydVdTQ+8EKb07NqasfoICo9lPi+sQT2Qm2
         BJK7DBTC11YZlyuGu72hGwC5tUHcjjfScYPHvHGN6cIA7jFOoL28szwdmHsxRRFxMYWl
         yNOjHIBagRb/V9BNEDeDyEGNEa7m4olESjvrNuBmIIR8gchyf9WI3Q1KCfFD61hBoTAF
         B0kLjG+gCeVaDgQUxVi8THnIhKHdrvDgQ2Ewfpj45yEucm0SpiNyCf7wdxCm3lu6KNWU
         +mAmyfATAG6pPU+/TFEQMqBa2t/WFga1hePBqY8QclD1zYqnndM8em777wa/z6ql8CLG
         4zcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        fh=O2UCSusvgsq7xn3eKp/bzauh4cVU/N3GFYGq2CQ01Ns=;
        b=WAd23ZpLHg/YnYU5ldin9T6AagLcBDorkaPUPtUpK7hnXSpzf3EhYhq3527FF66jTR
         vYHF5A+pbjDk3U0bsU5lwdJ97tHjYU1qTY8QtT3eEzh20+MCemuGys2vGbITL/MmL5MP
         AvXRhGKmbrSk5xBAscYXzgVm9IfVgTjTY5LQngEYDDCaYh3TPBBFex1DtDzMc8lr+Zz6
         skysdI5ZdlfQw04qSVYBHJls7NRlXl6MpYN06M2U6CMWWaICzl7Eqk6tLSvvM1Rc8A3O
         8PnnZ1WUloPn7Gp44tKMwh+PuFZSdfI6FPOMseDeapfrFDh8RjspIYJ3zEc84/6h5r7L
         gLaw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775142717; x=1775747517; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=eoNF/3uDFP6gksftmMqQe53su1ygWpagE8rCXpSFtnKdzUGwDx2zg74rYE9uce5W1p
         d9fORQLwjeN4FbMr/Hd9KRF7rjFhoMBBX5lHodciECD3hqZ/vhcyqhuXm5djIwzlyYUr
         VnEqmR8p6smB5Dnpkine0Fw/Si2oPHVqyZVvx/mzbmD35g06qrGkzGhzAxKdsX4Xf9rr
         ElwNvdx6XonBvsi9Db9VHCU97m/obywT2vEet8DyHX+R+XzwK1l55iTL4azVkOeydw08
         jecWrB9ZVbbWFWACqbc4Rj+z2sIUlTCh6pTpkzHnmJXXsgEVEsiRtw2MbNxNxT+s2fNM
         3WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142717; x=1775747517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=higSWsaqBT3M4SmDNnR/sAAMDCdCLefY3HYhZTkODqO2WdYQ0QVK0t+ew6b7CzopVb
         4l3ZAU+EKOJ9YaOR/K6cK9FsymKtkF9RFur0wq9SKQuVCjC5qpku7YYkqV7u+fX2+KHK
         dyXDP5HxcDlOncny+ynA06arerGf2dKOmwsuxvs9x5LaKHrSIU7mQph6wdBv1nr0JKeO
         DvgT4JS9t2NQJmyLaj2CApSb0iOdK/OQsOKYLcWwamN4cKGU3eWrtKGfNJEKcBn7krbV
         4wDjGvyI5DdJUHrVLswOi9QXRD8jKegaZBdFKoSn+5yQeKjSWKyU85+8oy+ic/dhIr1/
         HEYg==
X-Forwarded-Encrypted: i=1; AJvYcCUKiM79MDsGL2U32eR8rjz+slyuWv99eABDH2DvQLnfuLV27ZMe64lTpRSsxaNIrreOSPXV6Z1wSjKNRpE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6EtqVRiVuzL5CVAsSP/24N5E0oxHqVFwFN60Eeq4ALKsvy7Di
	6mGekfar5DMyUukAmLtv9T//xvhIGkeL/VFtTra9iJCm/Q5eTg5pK6pbfB4vuPrt/ZJSjcgbGtG
	osk09cMo8hJH0EP9dqV5wOk1mSkLimXGURKPuqWWN
X-Gm-Gg: ATEYQzxthtouiZpPikIBvshrQ3w72Owq0+oWsxHFy1KJhDx1thRSmCpsD81H0nsWEgz
	WMoH71FBJ6+U9lazehrJrq4WvShDvMmXEw37B703aCIupEgCwjZiio1H8kaCeFkaZeKEhyiRSxO
	Ujy0abixPBAeom6OdBRzgdJiUmCd+xv0V8PEigNO3V2GyIlR/nZJbf7urZrHLuHG7soSStcy+AJ
	xo2dapaTudrdeCdLoYP8y9nV1ZYKkrmjE0w+MQPhd5rLcsycbpkHpwZNTmmCjptANpRp1wy4jZd
	mVu2IidVRKnneq8pw8RHx9YFA8kWUlZ3Xt6a9Q==
X-Received: by 2002:ac8:6907:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-50d504ad8ddmr11393801cf.3.1775142716382; Thu, 02 Apr 2026
 08:11:56 -0700 (PDT)
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
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
 <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local> <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
 <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
In-Reply-To: <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 2 Apr 2026 08:11:44 -0700
X-Gm-Features: AQROBzDDBiQJXBj1ghnJLgm5n9vUtQ0-AtJqWv_KWozRinmr8YW0M_6ikqdSFOA
Message-ID: <CAJuCfpEn53AgKkjLBN2AeaHxxV8vHVj697Cb=Hb-U8LisNztxw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:19=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kernel=
.org> wrote:
>
> On Tue, Mar 31, 2026 at 01:14:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
> > <ljs@kernel.org> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > > > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > >
> > > > > > Instead? That is, assuming we really need to care about this at=
 all.
> > > > > >
> > > > > > But I think I don't like this change at all?
> > > > >
> > > > > Yeah, this was the part I wasn't sure if it's worth adding. With =
your
> > > > > vote confirming my scepticism I'll go ahead and remove the parts =
I
> > > > > added to avoid extra vma_start_write_killable() call (3 instances=
 in
> > > > > all) and will post v7.
> > > >
> > > > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advic=
e on
> > > > v7.
> > > >
> > >
> > > Ack, if we just drop the problematic bits we might still be fine for =
7.1 :)
> >
> > Let's get your cleanup first and then see where we are. I also hate
> > the way I have to report a fake error code, so with that cleanup the
> > patchset should be much nicer.
>
> Ack, yeah it's horrid, + _my fault_ :)

No worries, I can wait.

>
> I can put something together now perhaps that can potentially be queued u=
p for
> 7.2 at 7.1-rc1.

Thanks! That would be appreciated.

>
> Cheers, Lorenzo

