Return-Path: <linuxppc-dev+bounces-25170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD8C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHV93592z2yhv;
	Fri, 31 Jul 2026 17:18:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785482305;
	cv=none; b=EQs45Yh3ad9KvgDyNouucpoxpzNgPhpFcTXlVZRLsJDCrUS9p8j89iAavDuSdPs08ZfT1t81EeZ5IJ+kGjgp8IWB7QpNYch764GM0InN9DRUqGiyCW/Zs00NWSUGqlElypFMUXB4qQHDyGimAsugphBW73ossBeblAFbcIRbPybPNCFKbtjkwbCeVrpT2Som+a81NwJE3Ghaye5x9DtfRqJ4vtCAqsh/12d4Mlabv4gp2n0/XjAZnrafl9keyiMT5Nx+pRlRu+oe2Jj+yBDRq8+ns976OJvEyCMvNK8w8j9Z58mwBDQe9uasVPeKhtZ4Uak/Hx9QWOj6WdckF679Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785482305; c=relaxed/relaxed;
	bh=7EO7IWtL8xlMWLECD7zNK5hmYyf4uWmZWcRBG4l9dwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUiIvD4wkrUb1QJB7pbWmlP9t0ATQYOd1No1cjvmnKnEgaGNW12GZzgyGQHgk+K4bifs4fVIrVR/kbC6A0KhiqEBxnMjjeOBgAEX4ov78855Ml9PTPRA1gTHAoIivo2fd7FUUhUgmpJBRP/WfqZ31YpnflTRJHD5Px2cLElHk+cK2yiKEZ3ZG70LzfeuYsBOjO7rhO/Wpal68qJHBddLopjrTHclh5CMTpfkU6CyPhJd33VqGZtPbUzc660XeZjcaPK7fQEgr3q9/xjfELV0qJ1Ynx5aa66GBHnK3URiCWLjjXcDrlkB4Lqh2pXLbLNEJoelUDfd5f3ndWuTysxZjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsK9lqNl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSyUMkqu; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsK9lqNl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSyUMkqu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHV8141gz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:18:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785482297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EO7IWtL8xlMWLECD7zNK5hmYyf4uWmZWcRBG4l9dwg=;
	b=ZsK9lqNlu6BoQx4HxT2KA01Ss4H+kn15Pq6jTvraMLYwFp4bLFdPASpO6eRlgbf+qXylNm
	W7wxezbBiuoi++zZGtdy2gwzONaKC2JRb3pLOMZ04pD3jJ7VqJ8YyR+BKkWh6wVzRvaC9P
	T6I8+KUxsEo+vaV2aHspMWSvj9Mf0Nc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785482298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EO7IWtL8xlMWLECD7zNK5hmYyf4uWmZWcRBG4l9dwg=;
	b=XSyUMkqu3wQ1Zof5F8am61QsG/MVyIauphhMN3lEjzMjS4xsctDy83iPTpT3KhAiJuZ5/2
	I9Auly9peTAopE9MFD7Kx21duAmKLVS+hrqB9xfhi5DNloRl1M6VLdnOYMMd6d9zwx35Y/
	zRlzdm5g+pw+/zL9tQgldvCGh/ULopU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-JEOpO0KjPRGaVYte39kpZg-1; Fri, 31 Jul 2026 03:18:15 -0400
X-MC-Unique: JEOpO0KjPRGaVYte39kpZg-1
X-Mimecast-MFC-AGG-ID: JEOpO0KjPRGaVYte39kpZg_1785482295
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5bfd2dcf7fdso196041e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785482295; x=1786087095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EO7IWtL8xlMWLECD7zNK5hmYyf4uWmZWcRBG4l9dwg=;
        b=iQyTmR0PJnSvw/13FZClCyO+dz3omZUsmNeD+zks5bwBWninbZeRW0nx7+sePdoQmE
         nA/S+nnPOay1Mz5ymYe6gU1CEAHMadxkRwCJLhx0rhTndxewPuBWeIjhMK2uHD1Knn7D
         si9SPnVg4mSmg9ydaY1GBdWAIOwDgdBE0DE/HyvYM71ymfKj+7dfRTm11vbXWfQW81s+
         LGxGZIwHWX9IijMt4QMYkpyiL4KjAJceBF9qemT5875bumb2StwiL0CCNJVUGaX+qyNL
         2yFDqI1PgM3M9ozEmoAJlfCLSRzjXqzfGn3f1D44FgsaHqFHUpHlQrDntyxd2EThnQUa
         K2Mg==
X-Forwarded-Encrypted: i=1; AHgh+RrwUyFMdAyXWKMjmPrBVlVl/8LltVV5MMZHRzSqm2eSQWzWYTvzAc8Nv64K0yCcKELy1UrZHrbmAR9RSj8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy6hl8eHg2WhfDHZbxYXXdLoPFVNFwoxI5H0z0CU82rIRLrLwe+
	JfWUlprDiCUMrni9bJTfSsAnyKK/NJ7KSQpE95Jn3wfeMAHomJvHWNuV/7jd/FEm2iFq6Wp2MXR
	DpKoRpKi6gagFbsIaQjmchU3NDxIordootpoBOeN2RxW1gKC9W0aM/E37RS6bA4TnKTZfZOqVCs
	/OYCdn57nErbUEYRw6XcOhmD+rxwiPBvCRHcFTHVQ7MQ==
X-Gm-Gg: AR+sD10IJwR4/vgMLMwQ7ELdBy/DPlg/uOCD5kcFA/B+5iKfq8/bLPhYwXi+jwlkGFf
	4Ubi5dDaS0eICMebCZk9aFd98yNbt1JENQfw/2ZiP0I8rH/o3I3WlQvoSfBhK4FJbGN6HvV+EyY
	Yxw0gJJbZKSic1i3VvMEgkptlVpEUM2eVkhTEdhd98HH2+AF9Xhy+qBoKG
X-Received: by 2002:a05:6122:660b:b0:5bd:86ac:a847 with SMTP id 71dfb90a1353d-5c37e2061acmr233557e0c.6.1785482294700;
        Fri, 31 Jul 2026 00:18:14 -0700 (PDT)
X-Received: by 2002:a05:6122:660b:b0:5bd:86ac:a847 with SMTP id
 71dfb90a1353d-5c37e2061acmr233547e0c.6.1785482294237; Fri, 31 Jul 2026
 00:18:14 -0700 (PDT)
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
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com> <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com> <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com> <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com> <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop> <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com> <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
In-Reply-To: <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
From: Jirka Hladky <jhladky@redhat.com>
Date: Fri, 31 Jul 2026 09:18:02 +0200
X-Gm-Features: AUfX_mzzfqdtb8bDStI4cE7iXbASDfojU9P9CI7RdohfIpT2TKyRXrB4Z8TQLPQ
Message-ID: <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, paulmck@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4tDO_EuBmGrXqpoc5geJV2XhgUoMlkHS-vFbXsLW6WM_1785482295
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:03=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 30/07/2026 =C3=A0 19:10, Shrikanth Hegde a =C3=A9crit :
> > Hi Jirka, Paul,
> >
> >
> > +cc will
> >
> > On 7/30/26 8:38 PM, Jirka Hladky wrote:
> >> On Thu, Jul 30, 2026 at 4:53=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org>
> >> wrote:
> >>> But is this really a fundamental RISC cost?  For example, does arm64
> >>> see the same performance issues?
> >>
> >> We tested arm64 (Ampere Altra Max) with the same controlled
> >> experiment -- two 6.18 kernels, both voluntary, differing only in
> >> PREEMPT_DYNAMIC:
> >>
> >> Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
> >> -------  ---------------   -----------------   -----
> >> ppc64le  off               108,836
> >> ppc64le  on                 68,197             -37.3%
> >> aarch64  off                 5,538
> >> aarch64  on                  5,082              -8.2%
> >>
> >> arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
> >> much less severely.
> >
> > Ouch!. But that's good to know.
>
> Might be a stupid question, but what is your .config ?
> Are you sure it doesn't contain CONFIG_DEBUG_PREEMPT ?

I have double-checked that and it's not set:
# CONFIG_DEBUG_PREEMPT is not set

Thanks
Jirka


