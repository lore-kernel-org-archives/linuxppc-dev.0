Return-Path: <linuxppc-dev+bounces-25094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1B9C55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 11:25:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9n1K3zrlz2yYd;
	Thu, 30 Jul 2026 21:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785410709;
	cv=none; b=Kvm65SolqmF0B3qIDziSBdcRlJRg77bxlPlwP457VLMFEVaIHNdgTF+ryTj5wRXjPC0UIoVrq67Vo9dTJ3+FEPODuFW1Y3O2U9I7YWNvbz1H6KWP0W9ZK8XcgN+HcURvnv4RXcDlMQDn7/zp65svfJgVuTZyHdSeB/Cjsrm9JeYr4p5noCS50Q1DyBLfNBJDOv1FDc8ZlxGsTsYVONzlRPCit6lXzQ2NPuH/ChQwbhfHajTke8mka4LCv6Z3QiPy+Pj26FUhqoQ8VRjgxSGCNFsXVw2Ouy9XO2j2SjtYVBnnid5BSxpspyRs2Ln3IWlQ9xf7JiCL6tSd61pwjlT6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785410709; c=relaxed/relaxed;
	bh=CzD6ujUwwh6aLrlrrvmIz/3MadpLBE20PTGj3wkxdZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Agey4fiPb6hH8+bPfdacc82yIq2XmMbbHTaGAtcp+Yem7cFZAeFrCZ8R1+KGuDpFAQ9wY3iB7XGjHM3aaZigb1Q4UpugbWrjxhcej9pks5i+FGTEcTdbUgEUFVsIT25XV+Z8YNXiWHrOCB8LKnv6aOZWInAFv2CNRNqR0HaFIFP5CO1cMmlAucDdHp9hqFZcnx32IZOCnRq0ktEpxJzxjre8V0MMRvWzo0Ca9PX0w4ykpuDxzi8aVbsZTFBPehH9+jJVy/wcTfSM7g5YfOCiL7f14TAV/6oGE2sI6idN5RYA/1nmVfk2XbiXZ1w+xuT1ma1FDvV0/Fp2Q86CJEs2vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fH+WV9ns; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UxhEUB8y; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fH+WV9ns;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UxhEUB8y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhladky@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9n1J188Lz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 21:25:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785410700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzD6ujUwwh6aLrlrrvmIz/3MadpLBE20PTGj3wkxdZo=;
	b=fH+WV9ns6WeKmhURe1ch+S6kdEivXjalZ8HwUaNKq/SHjRL2yqXLwgaDDmHXW5Qpj3XpiY
	TPF89sru0S0CG2Pxa1gYUgRv4HwFxy/o7n0hmA2bBqQOJgCer4RXpvL/3PlBErCliA5Kta
	mq+j1UOwXAoi4M9/IYzWDfFXi59l9uE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785410701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzD6ujUwwh6aLrlrrvmIz/3MadpLBE20PTGj3wkxdZo=;
	b=UxhEUB8yWsa86cTTuvbZhv94Wm2KXLNRv6jtyXHF2kRJOIsW8XjjzZbymjTy1qNMZMpZtk
	uu4OGSzN8dIf9PjPzytNasGfInZsJMjbROsnIveLg1GUM4WFTkZyJOOGJbSxeskMELtaT1
	Qku1RGbm8uBMGNp5fWB5pz9Ufk1KB0I=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-FZ4wOW1YPVG6Ol88mE6uXQ-1; Thu, 30 Jul 2026 07:24:59 -0400
X-MC-Unique: FZ4wOW1YPVG6Ol88mE6uXQ-1
X-Mimecast-MFC-AGG-ID: FZ4wOW1YPVG6Ol88mE6uXQ_1785410699
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bbd3241499so1583589e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410699; x=1786015499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzD6ujUwwh6aLrlrrvmIz/3MadpLBE20PTGj3wkxdZo=;
        b=JITRMpxwVnETC9lTOde9hhL2cDvCpAgGdE+BMtdt8lXnNDRnn43OXYYMu5uJg6W6vO
         /ARuxq1InA/pLlGun4XGxEdPxR4r8j1q/BR7JWj1ByPMDZEpcpde9vJ4xSpxO0J6B4PC
         vM8igVNuYW6OplyWkZpHwG4EUqgDOH4EiQml/qxxiZPa8oLfAlwMiaISIYsO1BzkJLox
         aF/Q9C26YsQdjISilRbqf48JzFIaBdIQS8MiVIgKG25qTE5aQlGqr1/6pOfqRl8wUYTE
         /mhNqC4VgqQTQ2Wvd/GXbiVn6noiWNZddHx4zltgKMH2+RdOYJ0vAUv6KSGoWVL+zjwh
         m/jg==
X-Forwarded-Encrypted: i=1; AHgh+RriCiQ7uyyqsZhf4uqOv/4v8wr/GYdb8NyZK8S47quGqw+1Im8Apd8jtQUCIMFgSgjh/oqsUFFsSXpBpxU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqK5byk5SvXdtOoWmVN+ouF9He6WwoZyxe5oEv393c0JxLwEtr
	xE1GI6EA/+zUC1Su6p7ZWQKrrtQtPYDPG9SY8PLTbcClcEYDpF2i1kkGeO+Fygbvb1hXPiVJ0Jb
	5pq9cBmpB8RvLqFY1x94da7DlcswDPqKkdLoev8uWQG7t4x9jfcEJudTKmnr9LVQYcGTl0TH0VP
	7gBtduIFF0qJ4wJeKQUO4Dcvf+HB5t5HBaLn6+okQFKg==
X-Gm-Gg: AR+sD13wukstmfshljl+h6TaTutkrAJ+kYIvfJhNgYFZvWLQd+iZSqfnJCxgWEi5gdy
	Vivv7QecQupKbHuuoRanXvHodGz5vWQPFtIaMEx9lJNmHCEhc1vazez1FtdT4CCIjdql8h1mdfI
	H+7wXJ6jqULHNQ8Ba7Pm7wd7mEX45+15XofEqxOjQ6XXgOcfgIanDgQRxS
X-Received: by 2002:a05:6122:378b:b0:5bd:fb78:5461 with SMTP id 71dfb90a1353d-5c365d7d405mr723867e0c.0.1785410698624;
        Thu, 30 Jul 2026 04:24:58 -0700 (PDT)
X-Received: by 2002:a05:6122:378b:b0:5bd:fb78:5461 with SMTP id
 71dfb90a1353d-5c365d7d405mr723859e0c.0.1785410698195; Thu, 30 Jul 2026
 04:24:58 -0700 (PDT)
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
References: <20260427122742.210074-1-mkchauras@gmail.com> <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Jirka Hladky <jhladky@redhat.com>
Date: Thu, 30 Jul 2026 13:24:46 +0200
X-Gm-Features: AUfX_mwt-qWKfPCEIV9LLRivv2noKYkMyzP6nL-9XRVh8e89AjTuXNRPBqxQHdM
Message-ID: <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, 
	ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, 
	ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com, 
	segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com, 
	pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org, 
	kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pycngU63iGvFrq2NyI00cv2SdRTL1M0pgn1dj0x2WDY_1785410699
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 11:36=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 11:41:07AM +0200, Jirka Hladky wrote:
> > Hi Mukesh, Shrikanth, Madhavan,
> >
> > I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
> > syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
> > narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
> > bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").
> >
> > The regression manifests specifically when SELinux is enabled. Regressi=
on
> > disappears with selinux=3D0. With SELinux disabled, 7.2 is actually
> > slightly *faster* than 7.1.
> >
> > Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
> > Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB
> >
> > Results (bogo-ops/sec, higher is better):
> >
> > Kernel   Enforcing   Permissive   Disabled    SELinux tax
> > ------   ---------   ----------   --------    -----------
> > 7.1      69,107      70,248       93,566      -26.1%
> > 7.2-rc4  56,247      59,075       99,240      -43.3%
> > Delta    -18.6%      -15.9%       +6.1%
> >
> > Key observations:
> > - SELinux permissive ~ enforcing on both kernels (overhead is in the
> >   code path, not policy evaluation)
> > - SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
> >   path itself is not slower for the base syscall
> > - The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
> > - No changes to security/selinux/avc.c between v7.1 and v7.2-rc4
> >
> > The kill() hot path (sys_kill -> check_kill_permission -> security_task=
_kill
> > -> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC loo=
kup
> > in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, each
> > pair requires lwsync/isync barriers. I suspect the generic entry path
> > changes something in how context tracking, tracing, or RCU interacts
> > with the syscall fast path that amplifies the per-call RCU cost.
> >
> > Note: this is on top of a separate ~36% regression from 6.12->7.1 cause=
d
> > by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
> > (commit 6ad7751537e8), which I reported separately on the v4 thread.
> >
> > Thank you
> > Jirka
> [...]
> Hey Jirka,
>
> Thanks for reporting this.
> I'll take a look.
>
> Thanks,
> Mukesh
>

Thank you, Mukesh! I'm happy to run additional tests on the POWER10 machine
if you have patches to try or specific experiments you'd like me to do.

Jirka


