Return-Path: <linuxppc-dev+bounces-18833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8332510A88FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhXHm1Rx8z2yS4;
	Fri, 27 Mar 2026 05:24:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774549492;
	cv=pass; b=Tklvg3ZT1csCXM6l/ffpIIm0aGYxIG/26fklOmnPW9qfdbsHTG4uM5ZJTL5XUZBELQVHMcGdIb8kH7BPDDKMxoBUC3UyeYAFP+XU3WFIzfWMOxNsRmsHUUj28wXvUaljUosxrqdJsdJyBww9KGGu8ci3vyybdEtay7adSf5G/53r6Tz9bO+7xbR35FpWuR9GHY3GoQB80/HC2HYDSpiEnueQoOkNgQffjDdsymyuFvPVJsWbITPBhlUaoAKPRCZbM1ueWVigex/lLaUS4jInVVLFqPh3RR7RURIS6bMJoTBLPp+/1wAUdAtLC4HZf85QR+wcuTwoJUU82N76CAi/Bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774549492; c=relaxed/relaxed;
	bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giD6oiN6bi0BoCZuyVvt8IHquGAxRsCY61MdU/JvUNeNyAJAFTmoPK21OQQPAxbOTyUha7eja+EpjNlmrkK7kTqgsrRpFceZ3hjHDq/cgXJCbEVUm/4d+7GhiG4CfFXoKDOJe4RVP9sw6bwUBQvL1cBuNcRjFyFjh2sCRfoLqLv2c/T2UqpAwaif/dHBFfsuNpv6Z+qGEml3f9nFdz6Y92U39IGkjN+iV5nvj+T2sj3Z25X5RHqfFy8kSYdtir65oNlNdSRR8ED7/PJ6OIoL8UHlfbjQmOUDDZYvYEX5XB/0F0iLB1WxXyS4NKPUZmuSbk5qZ4IzYUZQo8SM/6VoaQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kJ5svZOb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kJ5svZOb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhXHk3J0Jz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 05:24:50 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-50b6c45781aso88311cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 11:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549487; cv=none;
        d=google.com; s=arc-20240605;
        b=b0mvluGAe3CLADr3jVWNJynjrVFUD1OltJ1oRbYjJwGYO2XYHxUD8ZPOSKikKyunMq
         LGRefLQbZ3caH33ONzWznl3uiUO2ZakbVPHJzH1A17p0tJx6NbcxULTSAcTn+2yNEj+m
         I+tHo3gfBTTkMbBkOEkWKKkBsnD51wMJARShGk9SQbz9+HARjo98AA+kaKZhi9YaRw+X
         ZM4MDxJDFvbGbCKF9+tzuqpShyxtJuBZgTsxa77u57cwppJdqDWngbQmR/wvpo1nzj71
         JZXZp5eU7fK90Ms/PiAbLTXJQYp+8LUDOfiqag8DhaqL6DZVQPdEWALShgboHqEWEiSh
         RuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        fh=iWAfPxlM6Sb6rMuqhDWSgu+SRPrx221ayrGdFI+NE3c=;
        b=dsEktA3jUP1/4gAls/8lEAf7FY3u1n084h/RltsyP5z1FhT8wjJ6MROlL5EkQD5fdE
         T0DStcFMTXKJfBPNhCdZd20OBipbJAJWbPP3G0gwFIDi/GeaPX9vYiI1hAtDBxMZQ2x7
         3FnvfpxSps08fRTEuXHErYRDupB8oGhPS/kQHbZYNw6VA0FseGFZABOyeipoN2WBshD5
         EXUyE8QmhzuOuukJY2D4naD6nCrRVFhpIc3i3lSERcvCCPzPc/HHcBACm7qAyCHniqWr
         Dxunh0euZow/APzePG8OnX+t35ch88oHtM7pC6XJFluS8G6k774I8l+TiwM6lgKPrfxp
         KcAA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774549487; x=1775154287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=kJ5svZObQMQqVtUrECN9Qw129oQqz9iM8WKOaTEIgnUTT3InZrwYi52EfBX9uhqRtU
         zp/VvkPzQP+saUGvNMHMdf5FOxOqNCkemoL2hUkZIBK4KEAO6pOahazmAHxHYLSMCaEq
         eS7lkEhFeOAbUxhqlDjCud/E0F5LuNMZ3xekxi6R86MUceYnUREGfLDDAJc27pu/stjA
         fSfiGi1ZLCuAM86MpPLf9O7+ITawcZTBqW3eSQcEM5rXi1RcRx9fHTlv08wU5nTpeoDW
         Vka9FDeqstlTI5mo2YJLdQYgps4cgrmP1peDwLrSR4sTfsZ7j24SmnZUz6Zpw3AcrNyW
         iMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549487; x=1775154287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQhGn+VUrLV0McNgTLWhQuOTcrsY+On/+03qmLT1CZw=;
        b=gyuqZXHGD2YRwja55K3KEhkEXXIw3Ler+DFLg/fkPac1qpS8MzUeTuhra4fxXKynW9
         7ueEv92q8Ahyj5e+6vOrVxLccjMrUJyRfisIq3sKBVbpaxMxeluWn65gAyCnuEbH97Ku
         64L8Pidgawot3bNNw3+rbuozOgnntIaZ2tYoclPsGWML9xlYNRhqZJx/MIVOwPx69GFM
         5rG9nrLMcUdDjH4EbgfuJ/GCZlQZq2Mg0uYfVkZOgE+GkGoNIhyD/qC7XM1lntIx9t6l
         mSjQ7Xi80UfeIMN8ZS9DMTOi3Axncjl46i7nHn4u6GHsb20DiKmqDv3wPJleO2ifLJVV
         l9QA==
X-Forwarded-Encrypted: i=1; AJvYcCXikXZwtwWZhRmHNOLUk36cfneq1iVzPb5VEEK/2ErJ7dTtrusdE1+bdhpY2zMQSulUBjmkVjaSYz3T17U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxqIAefeewNgaRAAeZoE197K8nj68RlYPMoBLvthi/Y8FqiHvOX
	mzNo75xL87jbRwfdj+z4qzuk/AQVbhCez4iq+G+RYecXmaoCciYpOWQybUqlYn7Etllxp74VIgv
	CyordN5meJ8eP5uWpljPoyIWr7YaqFQXW/CNxnREO
X-Gm-Gg: ATEYQzwf5b3J5mW3OSrFSDyQuqdIedHP18OD4y4k3FJzua/sqsNE43AnyHhbmTvB3u5
	w+AXhFpaZpRmHfAAMmWqOzUBTfKAaTDPzuOx11YBar1TwfiJtZf8s3wJx20yO3wrguRavL6gxKb
	bsgq46LjLdZPttjCWiw3zoukwVLdkjsqz85Xi9WuwFj8pauwQ8cfl1YM5nM4EC+t7ZTOpaKklEM
	hSRr/6w47sdKyLZMounuweITT2UcLB3Ogkbjt3E47G8pVdZ6RkI8k2Av1LSeHKghDJ/hVp3z7LG
	EafUZOhn490iKfviauoKGQZFXcd/g+//Dg==
X-Received: by 2002:a05:622a:93:b0:50b:71e4:878c with SMTP id
 d75a77b69052e-50ba1e41c39mr1037271cf.15.1774549486349; Thu, 26 Mar 2026
 11:24:46 -0700 (PDT)
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
References: <20260326080836.695207-1-surenb@google.com> <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
In-Reply-To: <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Mar 2026 11:24:35 -0700
X-Gm-Features: AQROBzDeN__PRe-Y7mIO9LZxPL3s1KNrdWWWOsbo7He0DKFlde5Dab9lnrvUpiU
Message-ID: <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
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

On Thu, Mar 26, 2026 at 2:18=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> -cc old email
>
> (Gentle reminder to please send all new stuff to ljs@kernel.org - at some
> point I'm going to set a rule to ignore kernel mail sent to the old addre=
ss
> so, if you need a response you should send to the new :)

Ack, sorry about that and thanks for all the reviews, Lorenzo!

I noticed Sashiko's concerns at [1] and a number of them are false
positives but I see at least one new claim which might be legit. I'll
check if it holds water.

[1] https://sashiko.dev/#/patchset/20260326080836.695207-1-surenb%40google.=
com

>
>
> On Thu, Mar 26, 2026 at 01:08:30AM -0700, Suren Baghdasaryan wrote:
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patchset:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> > and operates on a remote mm. Incomplete operations here would result
> > in an inconsistent cgroup state.
> >
> > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
> >
> > Changes since v4 [1]:
> > - added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the c=
ode
> > stayed the same)
> > - split patch 2 into 3 parts, per Lorenzo Stoakes
> > - converted vma_start_write() in mseal_apply(), per Sashiko
> > - changed vma_start_write_killable() error handling in
> > set_mempolicy_home_node(), per Lorenzo Stoakes
> > - added comment why mm->locked_vm is fine even when we exit early,
> > per Sashiko
> > - moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
> > and Lorenzo Stoakes
> > - set give_up_on_oom on error in vma_merge_existing_range() to propagat=
e
> > the error, per Lorenzo Stoakes
> > - moved validate_mm() out of the error path in expand_upwards(),
> > per Lorenzo Stoakes
> > - dropped the patch changing S390 error handling, per Sashiko and
> > Lorenzo Stoakes
> > - reworked error handling in clear_refs_write(), per Lorenzo Stoakes
> > - uninlined process_vma_walk_lock() while changing its return type,
> > per Lorenzo Stoakes
> >
> > [1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.c=
om/
> >
> > Suren Baghdasaryan (6):
> >   mm/vma: cleanup error handling path in vma_expand()
> >   mm: use vma_start_write_killable() in mm syscalls
> >   mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
> >   mm/vma: use vma_start_write_killable() in vma operations
> >   mm: use vma_start_write_killable() in process_vma_walk_lock()
> >   KVM: PPC: use vma_start_write_killable() in
> >     kvmppc_memslot_page_merge()
> >
> >  arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
> >  fs/proc/task_mmu.c                 |  12 +--
> >  mm/khugepaged.c                    |   5 +-
> >  mm/madvise.c                       |   4 +-
> >  mm/memory.c                        |   2 +
> >  mm/mempolicy.c                     |  12 ++-
> >  mm/mlock.c                         |  28 ++++--
> >  mm/mprotect.c                      |   5 +-
> >  mm/mremap.c                        |   8 +-
> >  mm/mseal.c                         |   5 +-
> >  mm/pagewalk.c                      |  22 +++--
> >  mm/vma.c                           | 146 +++++++++++++++++++++--------
> >  mm/vma_exec.c                      |   6 +-
> >  13 files changed, 190 insertions(+), 70 deletions(-)
> >
> >
> > base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >

