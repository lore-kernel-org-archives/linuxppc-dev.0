Return-Path: <linuxppc-dev+bounces-28697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C860CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 21:09:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwl050cDbz30DY;
	Fri, 02 Oct 2026 07:09:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:32::d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790888949;
	cv=pass; b=Sh1GzAaOQh0oQQmRqDSy6cXL81h0+tCps76eWfxSUihbB9Ea+IkNmY7EfGzDqbs16m8evo+SwOSfqLC39WKvW1uSfqUh0tCwc1WkVAdF/H58xRfGJaqtqmGZhivrbJ1q9FSjuDkKkr16ri7huuuVi5ANVVC+0/XK9PEu+sKTML8APGaAeUgNtJAyZK8YTxOqNbAxRA8DPFDVF1FnW87W1jer7EAJld8OmEgQ4Xx580RRzQS20jfvjWCtildJlnz3p6p7gkVRpjY0IhVpKdOnz/DooqjhgbRneEXpZ347zcuKf6tebpf4pHEU11ULB8EHyGzPgA3Rw8cJV7qpv0kKKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790888949; c=relaxed/relaxed;
	bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2kfGaZiFXMOa9dcERt/yvN4VTL/ec6N34NuhsWyMgFBlFg8CzRTRkNEgXPPAzMO1UVv0MZXUHuSb7k5ZpQwNVIdc8CVZ5Q0BEAzqCIxAZBHmzaPPRx6OGb8CmILmbCH/1XxE7a3QSznYFZ4xlTUlZrxeUneof8ZqRU5S8O17zDcCDb3Pm6+pc2+ZfSxVXOkx565RrZZvfzMuoAyJ5OaPZyp1E0DemWUwwwESuxunnoKwxO8po0OKsohGxC06ZveHVaIxH8JTWw0Z0OYFzItaXnUX8OT9/Z7J/g7PD1CtFFsDH9oMYhmgt1dFKAyMid7by/AMaqs/o1upsT8cqUIkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fTfzI5QU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:32::d; helo=mail-oi2-x0d.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fTfzI5QU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:32::d; helo=mail-oi2-x0d.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-oi2-x0d.google.com (mail-oi2-x0d.google.com [IPv6:2607:f8b0:4864:32::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwl040QsJz308H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 07:09:07 +1000 (AEST)
Received: by mail-oi2-x0d.google.com with SMTP id 5614622812f47-4e9818966c6so4031863b6e.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 14:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888945; cv=none;
        d=google.com; s=arc-20260327;
        b=mB8NPm6BnQZflr9vU9fT3xU7kJka12JT0G82bVbfAogeoOHtdffWu6tFtwBmu8/f5a
         LaitBJiqYbXX8TZVC4tUqbCwT+6e63CmvBQKN0uFMVqZTrlDrApkWrU9CsQeXgDQw2Qb
         rGKw3/I/095MYiRiacurvEi8EfT5oCzKV8MOPTMm18tD61PO/LMAdyW1e0/NHgTp5CQN
         njIe/TttIEku18OO+4OMdKacaT3PIHNGct4wJ2MGTeFa9NoH+X3Nkz3oFe+nQomkmo/u
         WlSJp3XvMvHsL5BG8VwEJqOnwCSKf3ZjHfYSNHuIrhWvYcqpxZ7Auc/x17NVV2y72eg0
         8mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        fh=7/yjYIQDf7zOmNPP9vM+Zwpa0Cvssz4Ow3HCrY3Lqps=;
        b=K2WQKqcS68zKTcfITADff87Jb+eYeviWTg8QZUKaO3n4f1GcH4FaL2krol8pXaZqne
         9bODCTwzOPL+Dnan+yqAE0tcag7RwUiI1OIQam8DISrKOyyC/5EB6EjmOX1yC03O8U6C
         lhrn1BrOxdBtDn2nAlzfBH/CuV2FjJR8xzT/A/zStSct7fxKaY07GNmMldjcyxteZN60
         qw8bXsczGEsnFAGUQnfLokoz6LYOhbsmT/Dg7MzTbY9Q/IvgIvR2i0LRT/NkAE7fEFEJ
         pTP8JTA+gUq5/VkRfXeWrG6+mXrTukXL3+THzYnoECq2geJK1M37S20OC0TlFGhanzoU
         KTbQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790888945; x=1791493745; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        b=fTfzI5QUd754XLMQ+XwuHHLxv74dkf0ThWrEVWKEb7Y8fnyVGCR1qjlOg41op5QT29
         RvRuVaC//sLKoNB6yD8L0WfjJqrIWkoJAyx3hzUwgHjcYHcSmYT3ZflxIOGVmaftoQLS
         SfSUVShlSuJQ7VyexmA2xagp2DYjgBqhxJfT3LFFBKm17vDWoWyXQlH1ntw7qq/MPPqW
         qvs/RyCnhXxTeUqCNfHtokAcJx0ICIHKoCR/dXoIpQS7J/DIqf4MBvA1Zb+/DwAAD3zE
         CMlxSA5qRBCSX3Y05XsPxDuan+gDcXiaLteYf1DekFTKRJiRl0m6KhoUPGwxZ7ncBJd5
         tpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888945; x=1791493745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFokuiRNz9wJ8Ezep4PHoXeKqh3XHPyJk48utuNejfc=;
        b=PE4tWGjTe1qeqjYO7TcirBD1fHEgWs/ue02hIVoz7mrenDXrip38Ar29YhoUtOGvuD
         PS7lkH7RI0J8yn3/Fk34l0w4pZF9a52FQMw9k67eIRjKBst7QEAU2OIyYnL6O7YdFhBk
         yRhuPyf0cIB9+MwqHjLOExjCIdDF6JEh2eBqQLZwLc/e5CiYGVB/Pw2a01tNoT9lAZwC
         Brdi9rWvcJa6Y2/bt28o0Vd9CU7wTOp7v2OoMzgrNEgHE/c15/rJJeUqAdvoIzN040je
         PY21KSgTqAit/9FSTv86rzSr/xFc8NG+Aw83bpth83lOvFFkhuB917p5l8dQ7r7Rtz8i
         yBUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzdT1qySlPLx/bnpxbZB/AuvZWmY/QBSZia8c056li57ynZqPFopJcTni0RMyIGz0nwajfPZPN38rFifw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lqT1Pw/qTLv3ARtB3kpKz9rXodrvMUSTcn2JiYdl5+uSIMgUdt
	P6viIV9gfOq+e2gan4718QfWCcp/FAPSzl7tWPVZCDWSGGMAWpSyeechHY3bhb5uWhZiAP+h7Ib
	zGImQJuX2KsS1ZPCjR2HryKn11TQv0Y8SJlGeALQ3
X-Gm-Gg: AYBFou0tIwmZAZbaEpTElf/G49zarTWjhcLGH9c9DiVsan4D7rTSq1afr8d8OlECC7v
	wybMCUU583zgJBdjY1HlstlXjRS6+SWGLcXOUs2UxdVytAGMY5hNn4urxThHm3oM7E+uoh2ldVx
	ucXXXNojisjprsmFRo2HMUf8cmQfQPqZqX8Z1U9IRwyA/y0f5ULOeqi2IZEKqWSG5yllZmXqSFe
	4psPztv9lk6iEYwmu+WHkdf67p3tFT2zlHsDqSBjJ5TxCiihqJPOozouDdGxvY42onSq8j2L+jm
	pvT67M0xkmz6HN1W9Ix7PO4msO4Iy+FDny7f30WSjPt2Bc3YdqH5IdPOaO172Ss6og8sCtVQxpO
	iVk+tZv9vMkKJFXBb9rYbcisNVm1YKkFMMIoA5PuScwfLPglxNz7dAHz6/UHqn1zVfwhKjO3ybG
	wZMxpJkHQhkXsJEBpy1VUu4sXp2yzGP+ZAyQ==
X-Received: by 2002:a05:6808:178f:b0:4d6:93e2:5bc1 with SMTP id
 5614622812f47-4f52bac82a4mr335961b6e.66.1790888943910; Thu, 01 Oct 2026
 14:09:03 -0700 (PDT)
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
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
In-Reply-To: <20261001202234.3794060-2-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:08:26 -0700
X-Gm-Features: AclHuK9qRTMsBWUaBrJsyydGSs8bKMO-n0iK8nixdC2P8OF7DD2-ohxFc2SMwec
Message-ID: <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:24=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Reject user accesses to guest memory, which are supposed to be done only
> in the context of KVM_RUN or similar operations, if the current address
> space is not the VM's (host userspace) address space.  If KVM writes to
> guest memory after the owning host process has exited, or if the VM is
> being destroyed in the context of a different process, then writing using
> the wrong address space will corrupt a different process' memory.
>
> Reject the access but don't WARN() or KVM_BUG_ON() event though attemptin=
g
> to access guest memory with a mismatched address space is a blatant KVM
> bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
> destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force t=
he
> vCPU out of L2 in order to free the nested VMX assets, and a side effect =
of
> a nested VM-Exit is that it flushes the cached shadow VMCS12 back to gues=
t
> memory:
>
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
>
> Fix the bug broadly even though the "real" bug is that KVM abuses the
> nested VM-Exit flow for non-architectural purposes, as there may be other
> such violations lurking.  For now, punt on fixing individual bugs and
> hardening the common flows, e.g. with WARNs.
>
> Opportunistically provide wrappers in anticipation of adding more checks
> and hardening, i.e. growing the logic beyond checking current->mm.
>
> Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush=
 to memory on VMExit")
> Cc: stable@vger.kernel.org
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@goo=
gle.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks, Sean. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

I wonder if it makes sense to add similar hardening to
kvm_faultin_pfn(). What do you think?

