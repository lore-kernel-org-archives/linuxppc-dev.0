Return-Path: <linuxppc-dev+bounces-28907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB1CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:08:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hypq112drz2yjw;
	Mon, 05 Oct 2026 17:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::445"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791180509;
	cv=none; b=nOJggWDYGS3/c+vxKPu0E+hx1qJJSaVek9wQAZSXp1aoBGXG9F3bdC79QPfqIQGEkYop8Ye0luKC1vFx51/8OJmqNw2F8thJay3cAg0lPl5U0CXQCr/aOhjO+6jLHNIp3IX/54kGr6L/hggsDCSU2eFt+3yNpZBN55VbyWuNE+6mofKPCIj7/zYwVMWT48upsrw7B+8S0LblTpJbScdNVAZHU1DZHIThch9ymih/4lTacS9eewSYVQmtwksFMb4zdhzXN9bc96bwRE8TjC4D6wjC/nPYchodBvSQkWJESHaCx3a9yl1PK+HlrTwPWheZgzQ5siXnRXIrkc16tFQUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791180509; c=relaxed/relaxed;
	bh=IITz2XbwrAyv27W8DNZJyeO2sE+zaKLd0NzyMXZbO5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYI/DzvtmY3RYk3aeXmLt/UYXpJr8rOXMGYr7s+r05z32woYN1oT6kpqAMsGhztxHTNr6hQ9SLcwYAUXJK7ltWC3WbFiuJFIueWQZ49LMcQmAQfLOtSY9OEvXQ7r12XJs3zrdvzjmG1BA4VWTVkHrC4pq3QyBku6ztL5SsjTI4OX+ONC5WfG5e5aIZ4DSOT92hiUigjMhX7koQkoJu7L6eh/+gA96orQc78i3DBKHmwH1aTfmKWE2DLiUAiQVpiGhddsuYYiP/r6JB4lOaiPTM8u4ka5DhXn4rbgijjscPLXUpWkKSTu9M805SlkZC0difjZWSRdaqxfFV8jdw6qmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S8HNolEO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=32d7dagykdl8xjfsohlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=S8HNolEO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=32d7dagykdl8xjfsohlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyppz3lfyz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:08:26 +1100 (AEDT)
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-88b9d8c9e55so1186857b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 23:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791180504; x=1791785304; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IITz2XbwrAyv27W8DNZJyeO2sE+zaKLd0NzyMXZbO5I=;
        b=S8HNolEOObFvVR3wFINM2hi++yH6exrfKooEkVf/tLFJwRAC5kHy8MS7egPoWS4lVt
         4GgS1Wjilzu52q9u3MSfS2IV2M6nEqfW3WHTbE18ueCtqXR7HSCoeKnRjXPYEcZsqyJl
         9ikOmrja72DrSRKyHvlW7Yp5ljuOx+8Ltq0ySiy0ejuJGB+6lYsMnX0t4cVTB1IVx2A0
         mpFeLirX+lt6AB4oCY1XdPxb6A7rVXzy7WcXnZfVRpuFnSL4kLrBVCLPZ+wq+eqBoP30
         KPLObqCoEcItrqnYglW6CgAv+XqEMLjxhH9WrA5H9kPS84mgFVPvNt+5d+c7bEpHFJe/
         t3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791180504; x=1791785304;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IITz2XbwrAyv27W8DNZJyeO2sE+zaKLd0NzyMXZbO5I=;
        b=aP7Rrp2PE6vySxnVY7/1tMyA6wImhGOw/UTFDVmtunTJ+lC/x9BQI68G+s7TU0dU3D
         MbtxNMeW1AUH+FV8LC/SXv9F2m2lUcxYaezBhzGUF2d7bVwTKAXE8+iHU3lgVD7nZ9nF
         B6KJ6h9vtzdaOC9QCU3MOonWuPyOgYgmEUsqkHQqYL9aCb06RWlaNZtiJBKcOoO+WygQ
         JpKA+Tq8pL8PqJ8HcgFRLiSFUUKOPYbYBtRyuouFWP2dlHcbtau0Jy52ig/EXf8AsTrX
         JxdmbsYXGnSC2GYemxhoo1s4pxCwDHt5CvraIW87c5mitz3sbLINpj2i9zJRwJh3/XPT
         NisA==
X-Forwarded-Encrypted: i=1; AKwUvBz3QDRXPcfBsdNm4VIusZbHbxRmlLO42s0110Kmai36/67XJDZNG9GCMefBEVvWIfC58X65MBtXSlq9vaM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++menkVUlzxz/RHI+I3zm1EEfA9fTxkMZg97M1X4SuUIYrFcrZbh
	z/FHQa1LOCPkPXXgnA2/quPBzQLvBqhM9lwgCDRfgsYH4BVXI8HbEElnBJM4/D+avhrAQbJOPR4
	Nz4RRfQ==
X-Received: from pfbga7.prod.google.com ([2002:a05:6a00:6207:b0:87f:22a2:2139])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da4:b0:884:e190:1b94
 with SMTP id d2e1a72fcca58-887fe2e5855mr8812734b3a.34.1791180504209; Sun, 04
 Oct 2026 23:08:24 -0700 (PDT)
Date: Sun, 4 Oct 2026 23:08:23 -0700
In-Reply-To: <fqykkc3j.ritesh.list@gmail.com>
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
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com>
 <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com>
 <asMN_TAX-1_J3jiP@google.com> <fqykkc3j.ritesh.list@gmail.com>
Message-ID: <asM-1-ptu1b_URqR@google.com>
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 05, 2026, Ritesh Harjani wrote:
 > I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
> > over open coding TEST_GEN_PROGS_COMMON.
> 
> Sure, so will add this check for kvm_create_max_vcpus()
> 
> #ifdef __powerpc64__
>        TEST_REQUIRE(!is_pseries_lpar());
> #endif 

Or maybe to avoid too many ifdefs, something like:

  static inline kvm_is_ppc_pseries_lpar(void)
  {
          /*
           * Comment about how this setup has unique limitations and isn't
           * compatible with tests that create many VMs and/or vCPUs.
           */
  #ifdef __powerpc64___
          return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
  #else
          return false;
  #endif
  }

Probably redundant naming to some extent, but having "ppc" in there would make it
super obvious it's a PPC-only check.
 
> Actually I was thinking we may as well use the same check for now for
> skipping hardware_disable_test on pseries. Because there also we suffer
> from the same resource limitation. Let me know if that sounds ok to you
> or do you want us to skip kvm_create_max_vcpus() only for now, since it
> is part of TEST_GEN_PROGS_COMMON?
> 
> > LoongArch open coded its full test list
> > for some reason, and in less than a year it has started missing out on new common
> > tests.
> >
> >> (& maybe few others like vm_types_test) from that in v6.
> >
> > What's wrong with VM types test?  That one really should Just Work on all
> > architectures.  It doesn't run on LoongArch, but I assume that's
> > oversight?
> 
> So the test doesn't fail (it gets skipped). However this cap
> "KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
> open code all common tests, hence I thought I may as well not add this
> in the first place.

/facepalm

I completely forgot KVM_CAP_VM_TYPES is x86-only.  FWIW, I'd still say use
TEST_GEN_PROGS_COMMON if possible.

> BTW, based on this discussion, I think I will re-arrange the patches in
> the following order and send a v7. (The Makefile.kvm changes will only
> get added after the main patch which adds powerpc support).
> 
> cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
> 2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
> f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
> e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested

Doesn't this one need to come first?  Or is this different than pseries LPAR?

> 178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
> 22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc

This should come before "add support for powerpc", and should have a shortlog
more like "Skip max vCPU IDs test on PPC with <whatever is a good description of the SMT cap>"

> 11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
> 63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
> 
> 
> Please let me know if this sounds ok?

Ya, works for me!

