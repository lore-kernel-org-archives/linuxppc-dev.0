Return-Path: <linuxppc-dev+bounces-18639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C6F483D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffhyF538sz2yhG;
	Tue, 24 Mar 2026 05:48:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::830" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774291701;
	cv=pass; b=QJSjeWeb3O0dRZW9NN2QKkpQPwR5e4ZJWk67vo/j4XstzEQ4urXB5hW472OHVKLjS278K/CN22LR28/atVCz5ptwU8RTklXGbCTyyrvcXhBSjl/nYPGDyUwCToSb/V5OSk4RzEKU9Qh+ZrlFIv8HJiXPloazA9+VzzLE9WIBesfwQdVry6ErC25TUhX4yzi1hqyDu7/V4cVFh4LJ8PJjYLTLwhRl8G+MYt9UMvhzCWDC8mXKrDEsQsjlXUKkZhE9Pd1wpS1oCwUFdvAe4aaeiwDD1afSS6BBciFjV2fOBdrUCjoqBviD2uU6ZKOOTeKjq8akGU7nqv0dlrYWcx4dVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774291701; c=relaxed/relaxed;
	bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEolUMoEh+RstlJTWqRuBusP8TtlPhFaZFUABqYNZ5AA72jXyLK4YoEx0TL4pvC0OVMUXNo1EePdwVMJWBwvyU4B5tUaXbCFcIPPh+C4wet3L9rXF/+cCF9AZGJFKUHcCCw1LQXc6rDqcUv7Ed3ixtbM+H2+WoiIY/3ZefL4Q/wiTHNDpW68T8uob3EojXBDd64cD1I3vcqd8KcblLWYxaowPREiYzAuMroydtGN4kkbfTdBucDU7Kbb32RnTL1WYyiS+vQpVE6MgVL1zSrfPrbW1Xtegf1x9VogCz36g8en2aUwPgFLTqMHp1A//Elqlgabg2cQ3vBSPg6jnYNdWA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gjwzH7/q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gjwzH7/q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffhyD6Tyhz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 05:48:20 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50b6c45781aso145201cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 11:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291698; cv=none;
        d=google.com; s=arc-20240605;
        b=I3mfmlWEOlotcvYbqIepjJoqIQNJzwKi6QR/QAc59qwNb3uHhrRGqlka1dlQAzFZdL
         7Pue0uvY1liLupOQaiJrCOKYzYM4XZ37YySZY52FK2F49rk3F5SSEitRErFVByNDX++P
         luwCr5jHYbzrLEVt1v1CxNQIir/npVUVjO2TBXZp3zDM/YgibatKxLPkIsRft110+ftj
         ODDSAexpiZQnjeuEc7j8jMj41mvNJZruysqYvSUWWWXYbRvIZs2V2xiQ8UFZdRPzorWF
         K+kIb125mjqL8IPkBn999aU8aJq3EMWqR65TgjiOTzetRMVzcjRPL7enoVIyiQxcJBQA
         IxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        fh=rUQUBX0bTY2y/L8SEXGPhOFoU+4IKe1l08C5Q7JYe+M=;
        b=MV+9hjxsgWpc3jKZNmY6AgRnPptsbnOMwClB9UAj9xeAGYDZVynStBEcQkxOQFcUku
         2DUmJ02gLMFmmSXoPceTkaSzlsZnsffCariJv14U53zE9DhCh+iHWlY9i7FdMeLhtxa2
         m1AAiMMgZUQ5tN3psONVDDxb+UdylqZxDyj6a1NbuJaqnqFphRkRH1qxZqAQiCxFuPKH
         xWY00rWqaT/zHuTnW2Kq2XvDEJWhBrF1Igl6icfBH8rxU9jzpS4vQ7uFOGB6d5vwDg4U
         Am8WHFUtIyGQ7sPwFqL/ulrifgbhVqM6gO9VUyNHeQM0LJ+DnW8ylvg6zfecUUMBAMeN
         gj4A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291698; x=1774896498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=gjwzH7/qQOh/lJjW+mJ4uSJOXPXIsIZ2lC3NcPzJfWmENr1MEV1gNNslk6h4Z/DC0w
         zQ1ZTzBW7Y/gDIPSCJ5SnLCuJh8L902+53KnQa4SXzi7aQlODwWvWxdSENeh2WTIbtPS
         E2pt3xkkptEU1pBK+5edHL3APgQ+vCFG5kG4eLCNCPTYjG8SKNnTdG7A6XABV4LwlBBm
         pB6sFd+h7c98GqvRHBXeW/1GRLyEJY3npjLtiHRJGD9YF4OrOUdO8zOwH7V/dHijj/c1
         IT71+BhEniAb/X6rMaJHJx7whFhJssjmw1Q/64704+FQR69dF8KQHQcwalXg4nd2qQef
         S64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291698; x=1774896498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=cZMFunRo2DMEf0CoBDb2mNjiOpItXoLLY6+w32jJfT7gIIy1LseimUpOs5KtoyCd4M
         p6kpdQK8eVbGzBQpXt/heMok0uD1qAMD6djGnx40RQNZgyHUQQ1EdN1SBs2A9rM2FMlW
         FvPkcFJMo7tLukIPHOyc8QQoZt+PM0ipDC9sS8sGXLLfHkJ8fyjRAZTNVlwjbPYqFcMN
         mEw9Ih+7I7EzGM6uC5UZYGQB1tI97RXqdkPdcO7hQI1AmV4Y4xwqRHQ8sr4K1tTyP19B
         Y8q5p5v85ahNMRlg6oI8ejgBuVPnI0h0vKHI1Gpm4xgsXBqklI7YWpq4uv4RiNtCzrDo
         aN0w==
X-Forwarded-Encrypted: i=1; AJvYcCXGhxVGPM8rgjaAutAjpHIjjGIQfIwH5kHFE6Ng1KQ63nifAzupBursIecEArXodbwWMYXdF9mNlGXOtnE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdIEOa/AzYuaXsG2E2zH2osou29vCQhKfMe6m9ZKo77P0rJqFF
	4H/rguK0lywCzWfXNM+q3yqsTMsmCNNhJ5398I9A9xmF0FnKDDpGzr1j85O60vyqKqtK1ZVZe4Q
	NSmOS8b6PCIBpG5++VmbbVH9T4UGjzL7QDvhAr2nQ
X-Gm-Gg: ATEYQzyqbo6OHRksYMQO47uqecihKO2wKdnKXf2ScumoWeNnZyww8E6v8dtksSXdx+6
	Zu+tW1lDaYCzVMhsjs+Sdonf7PHaMnXsUaBi3+a084IA+/L8T+sgNgJoifGXlSx2kH7jrBXNRbK
	GgKYOpz7EllmEZBpwydVw271pA4rabI2DS4+thc4Ns094LwjMtVGitWTgg0WhFQG6K4QVX2TX3s
	hpl3kS6eVOySFCm0iWGEnOyyXv6e6zC3QRcgE8ViFpJ5nrk2oVLUrHq5sj3KYExZMjzy3YfA3T8
	YsssbKm0s0KjSRnd
X-Received: by 2002:a05:622a:1f85:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50b6fd357cbmr1787911cf.9.1774291697776; Mon, 23 Mar 2026
 11:48:17 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-4-surenb@google.com>
 <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
In-Reply-To: <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 11:48:05 -0700
X-Gm-Features: AQROBzAcISvCKuZDTq5gxGva_UwU6WnzRjvi5ru0PTUHh42qSaWhag7QAbSow20
Message-ID: <CAJuCfpFDv1JC-wXR2d_KyrisnJTXxZbPSCY6Bpo4vLxj+FNw5Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
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

On Mon, Mar 23, 2026 at 10:53=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:07PM -0700, Suren Baghdasaryan wrote:
> > If kvm_s390_handle_pv() call fails its error code gets recorded but
> > execution proceeds as if the call was successful. If the next call to
> > copy_to_user() fails then the original error is overwritten.
>
> Is that really a big deal though, as you're returning an error in either =
case?
>
> > The follow-up patch adds fatal signal checks during VMA walk, which
> > makes it possible for kvm_s390_handle_pv() to return EINTR error.
> > Without this fix any error including EINTR can be overwritten and
> > original error will be lost.
> >
> > Change error handling for kvm_s390_handle_pv() to alter normal flow
> > once failure happens. This is consistent with how kvm_arch_vm_ioctl
> > handles errors for other ioctl commands.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 3eb60aa932ec..ddad08c0926f 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned=
 int ioctl, unsigned long arg)
> >               }
> >               /* must be called without kvm->lock */
> >               r =3D kvm_s390_handle_pv(kvm, &args);
> > +             if (r)
> > +                     break;
> >               if (copy_to_user(argp, &args, sizeof(args))) {
>
> Yeah as per Sashiko we probably need to copy_to_user() still.
>
> But in that case, do we even need a change at all? I'm not sure it really
> matters which error code terminates things does it?

I agree. I plan to drop this patch from the series (see my former
reply) unless someone tells me otherwise.

>
> >                       r =3D -EFAULT;
> >                       break;
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo

