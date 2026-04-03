Return-Path: <linuxppc-dev+bounces-19293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5FBE88D72
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 23:12:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnZHl2Vz2z2yL8;
	Sat, 04 Apr 2026 10:12:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775257939;
	cv=none; b=JRGOQ2fDokYRNoXKszO3HoIwLUOwAntbe5yT0Y6BW0fp1dgpsFki0xoqWzQ2qyDsr7xg0YGzPXPc/6gB3YM8sPQsC0Yhh1aE5QkKp0uIuQSNitei/xb+VP0+9CAL45pJU7lPjcjcjeOt6552QgnaiXfM2HWHlBd/SDevKhA2bnQEyn1mTCdrUixwCFEnN6jKWbwGhGnFrFOFmjRUC0HyB6LhyHbYUa7oTMmkVomDSJCCXoirVh4xTn1td9v2Qze2VyBuWpnA7OBjJ0Hge1pJKH7Sz2JfjIh/0wzWju3WD5Jd2381v6b6dcjN8uGghqlBRALbzH372b9pqx0WMymesg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775257939; c=relaxed/relaxed;
	bh=qdgYiNCpCVITKt4WdfY63SIPUYiDMIfHM1afvBz0ai8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P1DBjQxE7bjOf/3puu/UgRUs1zPwvhPhWIXB//or325+aOjmJi1lYLrM2/YiYHqOkSxwmkeLMWnBRr6ToYCLPN3PdcnV9tO47vq8936N+XredXLl0BTx3zfeyW+VmeSu4HQyoj1ZDfPWm0z/u2NtzABUhzA7Kr7Wg/coWHNu6nm4he4j2glLnhrOrXA+30lGnNkKxJJvOmddM7FtFbmgxgfR4ul+TpKrah5AEJLDBXTOUkuIFLpyMGOReTnCOJhYGgy/P2JpeINcwCsE9Znyf5/uOkb5+vKfoTu0TDYD0NIB9aiuJ6ZbErNiduAw4j97qGVtseevNSuRQEFo8Cbbww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QB6bUhzd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3tknqaqykdhcnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QB6bUhzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3tknqaqykdhcnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnZHk0FYSz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 10:12:17 +1100 (AEDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c76acbe2829so3600797a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775257935; x=1775862735; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdgYiNCpCVITKt4WdfY63SIPUYiDMIfHM1afvBz0ai8=;
        b=QB6bUhzd7qQ8rtAuU4esj+aTzQC+T45dXkD2d5Xi0EtVJ+4WHsxUi553F6BfWfYUWr
         XB2wyWHmTkxEzKgli56tEj6Ax15od7lwKBdoqdn2Qn00aUAq90dq01Udwp/I+DnEjrAB
         3eWkDKKvyU+cYnhDQ4vYh+ZG0YQ3AlJXs+9IKlKjkAWNgqRoz++N7yiiOoRpqdmccTyt
         FuNDXUFqYJr6TMziv7dE94E/lx2KMcd37jmmvTO7mIdSeDERnhe0VUMgspRUC8PLsj3x
         INarPzAGqYkDAT1zC+O6oePiZmVz8nTeRjBhuy/c+ml601khzxKFfJ2DvOvPt5SLvrV4
         o1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257935; x=1775862735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdgYiNCpCVITKt4WdfY63SIPUYiDMIfHM1afvBz0ai8=;
        b=BTxsIOeR54NGOAaHb789v6JOssor5diV6SrtI34VZ0KUUTqTxR5PASL/VEL47VWo+B
         HwOsGIfTDYYq5v/zIjTn/TWuCahBtc5jd6YXqf5h161UtvMApCG7m0OD3i1Al/uUOnNQ
         Njg4tvJsjxILz5ywElE02UkHLjcT5fJtXYdQO5XhwHWfUfGpPs1ScuB92SPlwCECl0KU
         m5nbB1op7jxlQmRLI/M7bMGN5f9DaO///m7JDNyqfUOsZZpCQsDn1I9Vbcuc1de+THDD
         1L7GpCTM6aN3dsuN2Y1kvitFCk9wzNTM6GDxzLn1BDvAqShSdHKa1IU0vkxwgQtZ+onO
         59Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUqWekKs+pvvRxsCXbAYQ91zgU/gtSXsw91vpV64/j48Q8+DEu5+RgVBBaXUyImM17XQKbkKrt6X8YmQgY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdlYLx0e3YBPmTDFqkAiQejj8Wy/GWjwtveq3KTtG2G2fyfuth
	giwBUOcy8CM9eF6Mk8bJDSAWl17H41gxUsVOTFNUMK33/zGJzyoK7jzjIwpi+cLw05v0ZgL+Poj
	4fjpMTQ==
X-Received: from pfmu23.prod.google.com ([2002:aa7:8397:0:b0:829:7ce4:7fcc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac82:b0:82c:daa4:ce2b
 with SMTP id d2e1a72fcca58-82d0dbcfa01mr4616677b3a.49.1775257934902; Fri, 03
 Apr 2026 16:12:14 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:12:13 -0700
In-Reply-To: <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
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
Mime-Version: 1.0
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local> <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
Message-ID: <adBJTXeE6G2vQNKX@google.com>
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
From: Sean Christopherson <seanjc@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 20, 2026, Baolin Wang wrote:
> > > -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> > > -						unsigned long start,
> > > -						unsigned long end,
> > > -						gfn_handler_t handler,
> > > -						bool flush_on_ret)
> > > +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > +					      unsigned long start,
> > > +					      unsigned long end,
> > > +					      gfn_handler_t handler,
> > > +					      bool flush_on_ret)
> > 
> > Can we please fix this terrrible indentation while we're here :)?
> > 
> > static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > 		unsigned long start, unsigned long end, gfn_handler_t handler,
> > 		bool flush_on_ret)
> > 
> > Would be nicer, thanks!

No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
find mm's style much harder to parse).

