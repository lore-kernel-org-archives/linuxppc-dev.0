Return-Path: <linuxppc-dev+bounces-23704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21594C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 13:40:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvj6J5PtLz2xdb;
	Tue, 07 Jul 2026 23:40:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783431640;
	cv=none; b=C/ujw3fy7A7V7E6Sd4XIcKJ15YYquEhqog6UQVCW4Kd8CdsRtSop14b1NA5J56oNbiYuE8SQoatg26BeCkWXHdXvPZR6+axvEGx+wLOHAwXcHHFS76/gYigl/i6w8VmCvS/Eq2VVdsnlHlPWLCZLrYhuqVtEtRvEYnYQcQll6hEFzfWQkK5zRhDGg64IcV5mhfxLrL7s1RwVJFOcmE+pCjA3r6837kOLB8a10IRUFVl2MCSKJsuv1J/60pxPUJx8uKucaCjra3BxjEy7ejwsSOl+Dtyz33JRX/UZJOfHEddVIA3YuN4gyTcCnm/UPHf83XT14MYBDyWUpuMokee1og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783431640; c=relaxed/relaxed;
	bh=bmqUt+g9FyWmU6ipf2GuV7nDUiq2yVCFHD4qz2spAaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4/HNtnTPJh/98ib5UGTXX9i4hhdq2GaalcDyE8wgOMnttVJMG0hxUcke3pCIOdSc4m3WRa10Bjk2VE4+9oyBBaN5pwwMF5n20+O8C3s6qbbmVXDz/FbdBoyEBnNqdS25zolh7w8Cn8eGjDJz44WeizADrIa5Q6bUGzCTs0I55n+T0fduJUNnAYcwJIvIiKe96kv81f6CU6yrAxH6PDNt3Fy2KG9YfNdiWTI4pmAn/ei98lY6kNrb2Lk8nUGwfaSG0itcmfHEQCsCW8imAfePs/AC9IBwg9/y4IK7IeeN+lJXT6iM1yWWdzEQ2+r+SitnWsRiJn6ra9Qa9hkLAnyGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rt1U2lb9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rt1U2lb9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvj6H3kQcz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 23:40:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C57C43F63;
	Tue,  7 Jul 2026 13:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034A91F000E9;
	Tue,  7 Jul 2026 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431635;
	bh=bmqUt+g9FyWmU6ipf2GuV7nDUiq2yVCFHD4qz2spAaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rt1U2lb9H02UccHpTsgdX7JQcUo66j+coktV1nVn/mBIWyNGO3PhZsxunbAcW83Ka
	 54kp8+S5mjCXn5HtTbFjhDCYTzAdkkwPBpUFbX0whVqiC8ziFubhi2qlHdvdByzzms
	 4nk7JcTLdxAPhNaMIaOAMEP7QNAVNRRGmeyfScH9xe6waEQmbq1NpGJX8K/HDsBUo1
	 jZp37rBWM92UU7LoN9B13cTA39ZGzZ/6ZDrqSbEYvuEk2nbD/lABU1ulNRDnib41Nn
	 I/8pmobomED2Vl4XQIHtRfuJ7Fmt57A8Nf7iLZmzqpRpxKxZGyTtorI+eccftmIKR9
	 GazRqD5MT+VKQ==
Date: Tue, 7 Jul 2026 16:40:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve()
 return value checks in early boot
Message-ID: <ak0BycosiHcaZLqg@kernel.org>
References: <20260706163753.193875-1-ekffu200098@gmail.com>
 <akyZ5DhIV_Grn1Kc@kernel.org>
 <CABFDxME7ig1SQDB39TUeUXoAOA2jSRhg6h-bm0kUHrHzGYeE-A@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFDxME7ig1SQDB39TUeUXoAOA2jSRhg6h-bm0kUHrHzGYeE-A@mail.gmail.com>

On Tue, Jul 07, 2026 at 10:24:09PM +0900, Sang-Heon Jeon wrote:
> Hi Mike,
> 
> On Tue, Jul 7, 2026 at 3:17 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Sang-Heon,
> >
> > On Tue, Jul 07, 2026 at 01:37:48AM +0900, Sang-Heon Jeon wrote:
> > > memblock_reserve() can only return an error after memblock_allow_resize()
> > > has been called. Before that it either succeeds or panics, never returning
> > > an error.
> > >
> > > Before memblock_allow_resize() is called, the return value checks of
> > > memblock_reserve() are unreachable and can be removed.
> >
> > I'd rather keep these checks.
> >
> > Removing them relies on internal details of memblock_reserve() implementation
> > and the existing event sequence. If the code would move around relying on
> > panic in memblock_reserve() may not be correct.
> >
> > And the few bytes and cycles the change saves do not worth the churn.
> 
> Makes sense to me.
> 
> But most early boot callers of memblock_reserve() don't check the
> return value, so I thought we already rely on its internal behavior
> anyway. So the few remaining checks just looked a bit inconsistent to
> me.

In reality it's very unlikely for memblock_reserve() to fail, especially
after resize is allowed. 
And if it does fail, the system would trip on a memory error, usually
sooner than later.

> Would you still prefer to keep these checks? If so, I'm fine with
> dropping this patch series. It's not a big deal :)

Let's keep the checks as they are now.
 
> Best Regards,
> Sang-Heon Jeon

-- 
Sincerely yours,
Mike.

