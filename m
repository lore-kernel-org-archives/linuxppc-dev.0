Return-Path: <linuxppc-dev+bounces-20372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D3CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 17:44:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6dhy46f1z2xnZ;
	Sat, 02 May 2026 03:44:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777657490;
	cv=none; b=nNpBCc2uFOKvT4/EVA16/E4HItN3pY3bmE2Rbdfl8xIZXHjhy/MNppoybycQiVDUtewxx/34jDvccbi/g43Ca7r9hVi6i6tmx2Wj7MrqA4cLUMGZNY4mPz2n8K9cHxar40jSVZTAWwafd/KEBdIIg+tHp/pUvCtgcZPqN/bVKa2eKwpN+nAoGIMovYGeL/T1Tw/64OHJIgVFF5UFPU9tmsZhuqeaCYZau5D/nxTgH3ITKposO5n3fSOgj6zTQncWDoDbetMLRiOXIedOVVTPT6bQYqp7Ig85G0S5xJtBuvkWSaiS5DFlr02Ah9XPC6W9gyDYHM/ePcrHMKRgoWextQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777657490; c=relaxed/relaxed;
	bh=9YAd4wJdBuwvuhq3A/51ZtTu6jgeC0RYN/Swb2V6zYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxIAKU0EANGJHuWrWimIYFOFZ/eq16eMIW1Q37jOnM6Xn9ifKsRvF1YbObCPRqeQlTL1XR4YIkT/PPKAUKSeHCB2Wmfzpkczs/J8jeZiuuThZ1/ss6jjZaUhiShFcBxi6rOdS7Q2KsbLh73FstxFX2Yy9oGSlBSHjRRmZM8mPlaCXYMBFca4TUwv2ZAl6Ln3HBSHLrUda1oSpwrx2SQbrE62/1DiTfMGaYXozmX4i2I1s4W7Flelzsobu30xADc2v71tFN2BEPCxb/jgKu1lbQA0RU917WjlptPv/aNwsANd92IStRc/QNR55hi+tYhqvCAQ8iDXckb55xTsnHG5Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cokKUJ4c; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cokKUJ4c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6dhx3N6gz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 03:44:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 569D244374
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 17:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E965C2BCF7
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657487;
	bh=Hl2YiWTcbo74Gxc6IpUU70j+aHuYqyHn+c9GqocmPS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cokKUJ4cVjTc6Fh+umuWaKXjfGu696YYSrhlsdu275noHQdipmmX0gkSiihTIc2Sl
	 fpYV1mlggK7Yc6cXYI+XurdET3PGISSUYmW2rPT5S58wxIfAaO5cGneYrdxbKBfIlB
	 XZEkY0bHXwj5IHxfWfRQxZg9bVbm6Czf+haANPTe/D+0YAlQo7B5g+S/t38bZMqyZA
	 Hvwafr5cJ0ewDjxPrc13qWWQ0oTeI8rTw7+kBgHhpYucb3owFD/0kIrKesBp3DFJve
	 SXoo+/ZlI3WZftzrouDPSabfXV4IkYxfnkLGV13yzz1iWbpLIbSY4Ytn/c7yT/Hw0B
	 9r576Ai8d9MRA==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a151012558so23995426d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 10:44:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8QXMDZ4r0Jd1GWl6BLPSrW/6XG6OzR4wnVnNT35/k7c7b2Xqn0TPDq7a6kLjDeU2Rqbe+RDR6UMDXuxSw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmghyRksBY19CcfUMXSPDjfHyq4+EOg09JXnyB5/gf4RoE+eEs
	c/xr0fNiFHnRhBv2TSEYCUvIfBsJfZ/IneFXvZB+27FOh69LiNBL8MzzPmHSwdbBRrYczTVI5lZ
	yCjaLKc7jFQ2+C2qY0itw7PcweJ+0kxE=
X-Received: by 2002:a05:6214:260a:b0:8ab:4ab9:bb50 with SMTP id
 6a1803df08f44-8b668638bfamr8385726d6.37.1777657486245; Fri, 01 May 2026
 10:44:46 -0700 (PDT)
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
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com> <afS_L-5XeWIldTXA@casper.infradead.org>
In-Reply-To: <afS_L-5XeWIldTXA@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 01:44:34 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
X-Gm-Features: AVHnY4L9r5jHmXxuaat24ga_fMfUkn2-2M0MEFhZDB6ITf6AdiWvpvcS2QZoKTw
Message-ID: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > 1. There is no deterministic latency for I/O completion. It depends on
> > both the hardware and the software stack (bio/request queues and the
> > block scheduler). Sometimes the latency is short; at other times it can
> > be quite long. In such cases, a high-priority thread performing operati=
ons
> > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wai=
t
> > for an unpredictable amount of time.
>
> But does that actually happen?  I find it hard to believe that thread A
> unmaps a VMA while thread B is in the middle of taking a page fault in
> that same VMA.  mprotect() and madvise() are more likely to happen, but
> it still seems really unlikely to me.

It doesn=E2=80=99t have to involve unmapping or applying mprotect to
the entire VMA=E2=80=94just a portion of it is sufficient.

BTW, the chain can propagate: a page fault occurs, B wants to write this
VMA, and C (a higher-priority task) wants to write another VMA. D may need
to iterate VMAs under mmap_lock, so B can end up blocking both C and D.

