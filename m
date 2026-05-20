Return-Path: <linuxppc-dev+bounces-21257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE83CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 21:40:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLQ1f6Mvtz2yDs;
	Thu, 21 May 2026 07:40:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779313206;
	cv=pass; b=RtFbeMkSDoD9khdC4ecXMAy5Bcvrr5GtGNmNe7ELR42IeMVpGtlruQ1x99EgEhbZaroDe9yL5YVdyBfxLAlvgu1WjFUgoK/2EGbooM9SDCYld3WX9lILA28yLFf4MAU7RKWHgk/pLl4KPG032fDcs+sY/wZsdZZ4T/de1WecgPVegxjuE46Kpz0r5ExlfDXfuRSj+uzTCVvX9sJQH6vMPV3B7mK2kCI7WaUdLc9sY+SldQwPaJ+zbG/HM0ljDM4/+8jws4WTLhhi0xdVrxVsXXGcuglm0cmmGqx1Z303tj9dL8dAkM0H6Svt0VeOtcQce7wRlfHZ+aPm6GJU9ZZSlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779313206; c=relaxed/relaxed;
	bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGQA5HwDCeSRoV9jyVAOkQT5Hg6kW5o1IJiduY05qm/5bShx8fjrUb17S2CamLVqT2Apc3ivsnrcTSRORF3agydVoYJGKnmwyfwOrg8QBYi0P2DeyyG7QR2rEd2iaYNr2+JeUCH4HWayc8LVwfWJ0G6aSeC6EqWt3v7ZiVdvX7G94tpLwYXa5jKoKb27F53QQwyXpMklF9D4CJUu1zasaCR01fDcQMvX4RZCenxJ4174OZtcko28JB7zwLUkRaqCzEDiHjizUuB2MgzfeYCq9MoygUrqv58ndY3jowgX4GgsUCQa5VmwPKu0bn+oL033/UucOR0LWuMfaeoR9jl9MQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lGEA3DWV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lGEA3DWV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLQ1c54VCz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 07:40:04 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b9358bc9c50so813166866b.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 14:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779313201; cv=none;
        d=google.com; s=arc-20240605;
        b=apooVOMwosDjq3iYRCQXXWaweGMiy/cFOXKPmAsdYCORuhV4TXPTMsHgI4cwvcsyGB
         o+Vocnu9oIBoDYZyWs4mwBVapKgWlrKZJmJG9xx0cKXJYtxjNDafWib188BZ8uROs2Ic
         S7shsjYvLh6h7xBuZsEqrPveLoutCSyc+ZpwpWcsN7k8asnh/fEx5qURJ0U7UXGI2b2t
         8SV1lMSsHnhbreoDYdXhxB3fzb1vG5KrblKafiinov5ICQzLJuApcqVvWheR0D6/D+8A
         e3g9WDeqyqVXHpeyDTw9MoSPYPGHcGf3mCrFJBsvarZumX7W/7BIto/KPLeAbl6H2X5O
         JGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        fh=5XBtcKEMUpLvSOq79n7E/JfXuf5r/F/cuT4gv/55U+U=;
        b=HvlP258ubqeEo1wjKg557Qa7cVQkzbVBv/FN7HKQQvXk2dFON6DNFceBW+tmrRnVbi
         tB5IGNWynkAEBEIwmfIn+vMNjoxahuz6Y4PzT4l0DUxcZWU0d4ytZsxFBEBK8/NCNWgI
         aPfWdNbvXhHgJAQbsatGcjB3VM/B2F8/g8n6gvUF3TF3S1oWkMvbuMY5J8vWI7DJfTQ4
         TxSOBGVtgbtrXt2RfT5aKPE136OX3W0QTrpPHhWOot09Ja9Ks+0kUVcR6Er/Ldm4/a64
         zocymhH9dZYftKxxc30t/DbpkTMAV0tf8NQVPIjWMvakKPRZo3oM+tiMUCvIXmY+6Xv4
         K3lw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313201; x=1779918001; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        b=lGEA3DWVclz0dHAahh775416wjaJhAANJ7q9Wyc1i9vshBKKJJw6SuIZwc49HEdW1w
         U9rvQ8fhC7krLz3kXSI5Ko+FDomAWjNLrH4Et94SvCPSlsUkhUTgWl5aH2RichZF+p1E
         sZgr1ztM9UXeo2CZ71jW+RLARkhUZPJJpPvGAGPT3W5CsSmndubmUC16kW15UFJqpn7+
         BjqnSl6XyJxj0HFbeumpBtG9KLNtsiW47Co7BHX7c667qMV59taVjOGj1w9uNXqljUrn
         FqFL8M/BqOjFeg3AsIRqzdWM1iIUek2+ayHqvgr20iLASNuU5zvumz6ALDuU+ne4tnQx
         gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313201; x=1779918001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmdK4vbjUWnyTBEm67qsNClqg8Ylwzn73Ycp8tLb8QQ=;
        b=kUfL3LG4jqQn1ZgUCYO3yv+cG1ukBUrGrWYkCCwnLwcWq+xW6bTPO+7Me9YE1XWDtn
         QVOsq2jZlsFPo2oP81H6aHDlezLKC37wKINxqGPZO4KUzJGGHWHVBSmtuq9UE2jpNLZL
         +rg4SIv8PK3BhwOd/CzJP922gfot4AN4BhJDzeQG86fDfrRpfS6D3OeQ3EU+BU/35are
         boJPI/NmlON7a/eRK0KzpEjsgsWp1bPY9lz5sTNFTgxLl1TQBcMEls13AF/w5cL9Zxzw
         oANk9YJOuEkXqtygwrzD+LSuWQ3bHj3nFiUvsr5LXVW09Cc9iAF5irXE3DySqz9HHpyU
         9AMg==
X-Forwarded-Encrypted: i=1; AFNElJ+IHNP/YBZQDS5QTGmp0TTRcO7IroLueiFxhtDitmYq8gZ+hoKpe01kBZDFuv0moMi5MmTKtBRz5tHgwUg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGPKeaj8HDpIAaAm2Jcr8h5eu03wz3lv6clXBxtZz/85qMXdDg
	P7INn6W3m26ug9bWAwu7NSOe3BXTTfYjLCgWGwZ4tHdTMkCpBk8NTuuE0WjUboEs8VijvAL0tNp
	r7h8X5ToLjMkunNKJ0i1KehEvIFDBKus=
X-Gm-Gg: Acq92OGcCMy3fdOeFsRVfSG5Ds6btIy/YCEg1BCTt/w29dHVaTPipTrWtqIfR6f+kE+
	HtZnLVdQWcB5kX4IWbD/jBon5/0DKfdvRnHpi98W1z3WFHZt9kH36uzWLKlpxGd6TX8tk11rDx6
	1NYdiq+QblWPI0ZXjI5m/rKFj9K0OyAdxxWXxgOhdqqVYD2jW1kabpS4rRfsGPlbqDz4Kbwbtj1
	mTCms0cSQKlhsLsWe6zY1+Kc9xUGiog1hty/ppXDZH274GASZTdDQNm+OeNkIpq1ap3slhsIvYv
	iyQoKc8vjlREew==
X-Received: by 2002:a17:907:e14b:10b0:bd5:151d:2d31 with SMTP id
 a640c23a62f3a-bd51781106dmr1121316766b.13.1779313200765; Wed, 20 May 2026
 14:40:00 -0700 (PDT)
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
 <agxbq1TxJdniMQT3@lucifer> <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
In-Reply-To: <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 20 May 2026 14:39:49 -0700
X-Gm-Features: AVHnY4IxXAq80R4nUJKOoKG85hi3I-EgpsftnPlc019PI3pxbjgBD4oSC5VrWsM
Message-ID: <CAHbLzkq3S7NDYe4LXjurKNQU+40-wtqrD_PT18YcyHbAcNxiRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 14:53, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> >>>
> >>> I think we either need to fix `fork()`, or keep the current
> >>> behavior of dropping the VMA lock before performing I/O.
> >>
> >> I see. So, this problem arises from the fact that we are changing the
> >> pagefaults requiring I/O operation to hold VMA lock...
> >> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> >> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> >> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> >> any VMA modification. On the surface, that looks ok to me but I might
> >> be missing some corner cases. If nobody sees any obvious issues, I
> >> think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
> >
> > I wonder if you've confused the fault path and fork here, as I think Ba=
rry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork b=
ehaviour
> > so it's different from the entire history of the kernel (or - presumabl=
y - at
> > least recent history :)
> I don't want fork() to become different in that regard.
>
> There is already a slight difference with vs. without per-VMA locks, beca=
use
> there is a window in-between us taking the write mmap_lock and all the pe=
r-VMA
> locks. I raised that previously [1] and assumed that it is probably fine.
>
> I also raised in the past why I think we must not allow concurrent page f=
aults,
> at least as soon as anonymous memory is involved [2].

Thanks for sharing the context, it is quite helpful to understand the
race conditions. Because Lorenzo also raised the concern about page
fault race, I will reply to all the concerns regarding page fault race
together in this thread.

IIUC, there is already some sort of race with per vma lock. Before per
vma lock, mmap_lock did lock everything. So page fault happened either
before fork or after fork. But page fault can happen on other VMAs
which have not been lock'ed yet during fork with per vma lock. For
example, we have 3 VMAs, we lock the first VMA, but page fault still
can happen on the other 2 VMAs during fork if they already have
anon_vma. This is the status quo now, but it seems not harmful.

The bad race shared by David is caused by racing with copy page. So it
seems like it will be fine as long as we serialize copy page against
page fault if I don't miss anything. Since we decide whether to copy
page or not by checking vma->anon_vma, so it seems fine to not take
vma lock if vma->anon_vma is NULL. This will not introduce more race
either because setting up a new  anon_vma in page fault or madvise
requires taking mmap_lock according to the earlier discussions.

Thanks,
Yang

>
> ... and I raised that this is pretty much slower by design right now: "We=
ll, the
> design decision that CONFIG_PER_VMA_LOCK made for now to make page faults=
 fast
> and to make blocking any page faults from happening to  be slower ..." [3=
]
>
> [1] https://lore.kernel.org/all/970295ab-e85d-7af3-76e6-df53a5c52f8b@redh=
at.com/
> [2] https://lore.kernel.org/all/7e3f35cc-59b9-bf12-b8b1-4ed78223844a@redh=
at.com/
> [3] https://lore.kernel.org/all/2efa2c89-3765-721d-2c3c-00590054aa5b@redh=
at.com/
>
> --
> Cheers,
>
> David
>

