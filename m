Return-Path: <linuxppc-dev+bounces-28699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A9CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 21:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwlCD3nXyz30DY;
	Fri, 02 Oct 2026 07:18:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790889528;
	cv=none; b=dQySwECGXjUojxQhgIuyS4zYHOwu/61y3hdjsSyh+Y6cJcPr+tYDU0kWqbsmOh+6rXwkvnsy/eefM47YVypX9HwGuJb9IEoJodm2ZnU+mdshIFaCoaG5QQdBvPGLzvo8Fi5/EuxlPo7QyvwpyICZTgrl6ojeNghVW6y9MnSylD7Csoqzpiy7RJHeqm5pcP6MBUyAEEK9sRjr8zV9k/Yj+7J629gUmtk7iINxQmLKKAZCJc5OuVdPZi3QhsRk0KSgD94JeaIaLwpr18jC+mkW/uJfmydzW/nLiSkRPxKY+G04xOGo0vLiatoeUUib+vI4A/6L5dPddRHjoPVAVqYrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790889528; c=relaxed/relaxed;
	bh=4UWY4lqIbXW0hgSoFKxOQDY3goBYarydfObAA0sKuMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kp/s6iGRjZ+UDefMhN/cmFKWtKveR246R1DfJ5OShzpein03fczXBf/T4z4CVdQPByI4WfOqWi+WjwFSS8iVH7m/n67VhYRfR2Q1Wd6fHO2w7avWdKOzUvSdmB/OLTyw3Cq5obKy4Hh+jANlm6+NbS7HcCBM7zWag4lgHXMjERHCMguoxu9QPgFMSTSes5vxi8aC0C6yyyKRusnWbEIagOT5/MmStmATi9AUWx16/MT5r68/sn69PubvIFuUJNhNH0CiuTayJSs45+zMHq2ozeeSMVxwMqIRKPD4lOQKVaO8LnJ5AgXZ4XlIaiD7B324Pg1EPr33Mq6t5gBnIOzkFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PWdRAPRI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3nm6-agykdckxjfsohlttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PWdRAPRI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3nm6-agykdckxjfsohlttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwlCC3Yfvz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 07:18:46 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso4699899a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790889525; x=1791494325; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4UWY4lqIbXW0hgSoFKxOQDY3goBYarydfObAA0sKuMg=;
        b=PWdRAPRIXcvFTgFHVgVOJD6qksbeNYON9ME8N5fstSuORXnT1uR7O94E3Ea773BKxf
         jZUQIy8KwKr8G3jqOHgo6lLqoVqbD9ubAViLcVDLt6KD+6HMpsO2OInxNfRhG+qerAEY
         oCHYkvquMmZvBYTJv2K6AcoWSfb2tIGkA6DLsl4tdY5OjgW5M8F7yTSwu/AVMFjIb6KU
         uOgOzYI0OY1s581v1fpGtOJjD+jrTssYD9THehAKd0QGt13sUk9QOHdKmIPrxqqxjKVc
         lXNS7ZsrhLZuSeqxV4ppiGMqWtqFZZy97lENyBFJcMF6jnlq/ZrzQdEJif45ktytMbOg
         WwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889525; x=1791494325;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UWY4lqIbXW0hgSoFKxOQDY3goBYarydfObAA0sKuMg=;
        b=MLakeYi5PZmqi1Sm22K0qGokYIdVOXW1tfCoPaat3nyLnPLV4XP2ZuhL+PaN84mc79
         axZ+kseNs2e6zwT6J7XHjB2dHp1NG45ZsXUpBDs03nBbptwaEGxF89XzmbRXiZ2c4yg6
         WZmnjdbEKKNamHS5Dy3FmEgGblRxy3eyk61eW5gH0fdeGmHQcB7NZxjCv102Gz7wJT97
         xS+AnommQ1CSvzoQFNi1u3ZvX8hmqcSjDWr05n2+7c8O1OQ1M7oa4xCcQcOJDMTtHh9n
         QjVwYIacTD/QzqK7BLsjO9A9IaP/tx4j0MNksS8thcEWezycK1MlAAIwLyKGpIYb68SS
         bfyw==
X-Forwarded-Encrypted: i=1; AKwUvBxVQIM1Ymi0ke9T4OkQOilUopyCSeKJWsd3Pdis8y1JTFwYAA83RvM8vJjZf1GOwBdv1MJT405EUX7Xgkw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nypkaN4RiKhHL+isyAM0y33b11MSE53erEn6ZsxHgG42geGtho
	D/PGiniL0/Bl3banXSe/xNGZElv9I3b39ZG979RIYH3u8byQVP1c8lOnLMq1ZBopZPGelG5Bh75
	kBqkgaQ==
X-Received: from pga7.prod.google.com ([2002:a05:6a02:4f87:b0:cc7:ac0b:f49d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:3dd:659e:5db2
 with SMTP id adf61e73a8af0-3e0bce8431cmr525636637.16.1790889524390; Thu, 01
 Oct 2026 14:18:44 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:18:43 -0700
In-Reply-To: <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
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
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
 <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
Message-ID: <ar7OMwkZ9bc0tbzC@google.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026, James Houghton wrote:
> On Thu, Oct 1, 2026 at 1:24=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Reject user accesses to guest memory, which are supposed to be done onl=
y
> > in the context of KVM_RUN or similar operations, if the current address
> > space is not the VM's (host userspace) address space.  If KVM writes to
> > guest memory after the owning host process has exited, or if the VM is
> > being destroyed in the context of a different process, then writing usi=
ng
> > the wrong address space will corrupt a different process' memory.
> >
> > Reject the access but don't WARN() or KVM_BUG_ON() event though attempt=
ing
> > to access guest memory with a mismatched address space is a blatant KVM
> > bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
> > destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force=
 the
> > vCPU out of L2 in order to free the nested VMX assets, and a side effec=
t of
> > a nested VM-Exit is that it flushes the cached shadow VMCS12 back to gu=
est
> > memory:
> >
> >   vmx_vcpu_free()
> >   |-> nested_vmx_free_vcpu()
> >       |-> vmx_leave_nested()
> >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> >               |-> nested_flush_cached_shadow_vmcs12()
> >                   |-> kvm_write_guest_cached()
> >                       |-> __copy_to_user(ghc->hva, ...)
> >
> > Fix the bug broadly even though the "real" bug is that KVM abuses the
> > nested VM-Exit flow for non-architectural purposes, as there may be oth=
er
> > such violations lurking.  For now, punt on fixing individual bugs and
> > hardening the common flows, e.g. with WARNs.
> >
> > Opportunistically provide wrappers in anticipation of adding more check=
s
> > and hardening, i.e. growing the logic beyond checking current->mm.
> >
> > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flu=
sh to memory on VMExit")
> > Cc: stable@vger.kernel.org
> > Reported-by: Jim Mattson <jmattson@google.com>
> > Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@g=
oogle.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> Thanks, Sean. Feel free to add:
>=20
> Reviewed-by: James Houghton <jthoughton@google.com>
>=20
> I wonder if it makes sense to add similar hardening to kvm_faultin_pfn().
> What do you think?

I'm not opposed to explicitly hardening kvm_faultin_pfn(), but I don't thin=
k it
would add much value in practice.  Far more arch code uses __kvm_faultin_pf=
n()
directly, and that doesn't have a @vcpu or @vm pointer to do the check.  We=
 could
obviously "fix" that, but nuking the memslots (patches 3-5) will prevent al=
l but
the most ridiculous bugs.  Getting anywhere near __kvm_faultin_pfn() with t=
he
wrong mm would either mean KVM is doing something amazingly stupid during V=
M
teardown, or I guess maybe the scheduler or preempt notifiers went off the =
rails?

