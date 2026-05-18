Return-Path: <linuxppc-dev+bounces-21134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D06ACD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 21:15:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK9Yc6X2jz2xpn;
	Tue, 19 May 2026 07:15:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779138900;
	cv=none; b=lROzu9cGtYrxOO2pyzX+ywQfwncObO0GYsiHKoswn8U5iseSHtfxa3M/7y+dsDirclAxuFuN93EIGvXbIdpeG+uWWG9kx6XZBiE4An2TVFWOIm/mPrxDOx9/bGp58HWStMSUDoL3Z0X3d+L4Qg2kcA4AMVjMlZKOQTrAWoh3IQV0XUIYR1AqkIXclnLTPdVRQ6RdTh50a3jNMyZMjEBKMd3q24XREYwjouoSBgukgx3AB8O6J4dOlXPSQ2pjc36oF33OqkVMSM4+NKEPTYPNJqNWNoDHLkYnqtVGi6mO4Q4I9MdCqryxydGvqj2kvoAPGSVN05gihTu4XGyCzwUC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779138900; c=relaxed/relaxed;
	bh=rs2uqTkIc7aAMCm9u6DZxVd5AsfHqGkk6OElJunpKgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoYNSRMJVYTDphV0MB64Kn+i4D7jRR6huVDYvnrdxKA20ZSQEU8tynYUwtB3+6+Ogt025r4wcQSZz52K8eVhTVO2aLoNEqOEZiGJ87COg55MlVogmevp0bVZwOhgFDKJIqQM/mFDegm1zObDpvapVzJ7OlYqwCgD4ZJKk3pBcMQart6WkMw0UnXdfb25abnPBJqJled898wXsKgXzg/NIT1niQuFPDcPT61V1E50xxOZEhUYXJgG4vzYz27NKhWyMroNQFRpy/MO2+4W7AtylC7XivBAaYmm75s17BLkicRlTZkzlFIcuPj0/cycvqVl4fRWQnrEE0vXacEwKmRlxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LKnQHg2E; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LKnQHg2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK9Yc1RGfz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:15:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E29844483
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 21:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E692C2BCFF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 21:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779138898;
	bh=rs2uqTkIc7aAMCm9u6DZxVd5AsfHqGkk6OElJunpKgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LKnQHg2EuuoiFeAFnxbyqE2fDmZVEFfJR4ym+5yVJgFpQm71jto6sLdg5WZBmxtnG
	 feASvKZV1Hz5s2U3CIOgVNjCbMO2KjX0U8n0MqD5oIETyTM4cq2dp1kF8q1re74vLb
	 j2vE2OH/h90vuhLO9gHN2qcX8iyk6Gj1VD31+RAQ6EyTWZ4iOjRfdPPOVrvYcxkaZB
	 XBfLDuqUgKG5MGYNKIrR4nHOZTbtTfEwI8Yhu+ZJ5BbOAt8fRt2kA+h5FZmAtjQcpZ
	 rnFDFHuQ6kgr2W3lu3RNNXviIak6dJ8MP1UOPZWyzYJ4m9mWzT3WG+SsY25Gg+DtTb
	 3+Mm4p2TcK06g==
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso574348241.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 14:14:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9jrfyAumevPV+piZuBSNqPS3rTLmWJRx5ZOTNPAPUbNq+27d1HdHidP7NniYs2GfkV18gQBXOzrSopSbw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyW8agw4D2sfh/AXieZsqsR0AKmQsizTKCVH+UjcCnHLTUYBE61
	uSeRa7qFQvfRvzAbvuhiF9XAo65mnbyLsV+udYY/BuShNaSY85mJ58V+Zqq0T5d3rHkbDUwIU1v
	ynmLuZCwSKFV0rI9krM3gn9L+tZZyvbM=
X-Received: by 2002:a67:e70a:0:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-63a3ee862bemr7850443137.19.1779138897435; Mon, 18 May 2026
 14:14:57 -0700 (PDT)
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
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
In-Reply-To: <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 05:14:45 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
X-Gm-Features: AVHnY4KjG65G1ecWJLmAXfyGgeXMxqs_Hs937nQXWNlaevhV7YwGMAI3sK3pWtE
Message-ID: <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, May 18, 2026 at 4:26=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Mon, May 18, 2026 at 5:47=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
[...]
> >
> > I think we either need to fix `fork()`, or keep the current
> > behavior of dropping the VMA lock before performing I/O.
>
> I see. So, this problem arises from the fact that we are changing the
> pagefaults requiring I/O operation to hold VMA lock...
> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> any VMA modification. On the surface, that looks ok to me but I might
> be missing some corner cases. If nobody sees any obvious issues, I
> think it's worth a try.
>

Thanks. Besides the creation of processes via fork(), I
am also beginning to worry about the death of processes.

One thing that came to my mind this morning
is that when lowmemorykiller decides to kill an app, we
want the memory to be released as quickly as possible so
the new app or user scenario can get memory sooner.

In that case, if the app being killed is performing I/O
while holding the VMA lock, the unmapping procedure
could end up being blocked as well.

If we release the VMA lock as we currently do, we allow
process exit to proceed.

I haven't thought it through very clearly yet, and I
may be wrong. I'd like to do more investigation. I hope
the apps being killed stay very still, but who knows=E2=80=94we
have so many applications in the market.

Meanwhile, if you have any comments regarding the death
of processes, they would be very welcome.

Best Regards
Barry

