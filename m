Return-Path: <linuxppc-dev+bounces-28951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C37CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzW6c44cGz30V2;
	Tue, 06 Oct 2026 20:24:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791278664;
	cv=none; b=eydiS2Au7zs7Pu5mMNK/j4hI3Fo1sl0TtIBOOHQxf5Pr2KmEa8Dz+1V/mJLzfDUrkOToMyLia6rJgOCCbmGkebDMgXKWQjlycWshjdiQ6E9qDbdTBksmX+gKNaJLQKRT8AYCgdTygqQb+Yr9gp5Gc7H801kloqIkAefFTAlt0/fLxbzQrJabEPVv4neKsGwFm7IjEwdjLbrI6yvKTYbdJ1i2nHlAqGB9JSNiJhMGz+OZg/7kh+Dxx+WinJrekjNyAwWW+MY5zhnK+oPYKYcQEIaTSNO34Lyu1xH3IvcUFv7iHHjFSe7cou9bbW9K5AaepYBDEEL/rwwVtvflpzBUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791278664; c=relaxed/relaxed;
	bh=ohmud8dlW/23qmDZSut2G/bzXusBDFIZZACFjcnqkos=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QyqUfWy7uazXMbm8iwHf3DXEhE1tmnW/G1WzxdlTcYqUC6V08vaVDPsWzFxt7JfUKODImGJbWqw1zVAXddLXAZdHtmkOqBjGuo+zSmPE8C56QQc5zVZLuLZNTtTCM+DxTS8xuIN2cF4+AVFPk3mcf0Id8SE36PMoCHrGTPExh83LWOV1FTWmXkZJYItPVesxdqZykw7gfU4xZBesxaufAf65+op1GhqvUE03Xo+Om6ekFAvdm8Id8wT9DQoA5Yl8CVrHQUdYrMetUACu/rF6oJLbTl8GSlfTtOTfcwqGOE3uoqPXh0lB4/JPomnGl3IZ+GjKxZ11Qa5irCZLh/ZOvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tHPWISO+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tHPWISO+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzW6b0rxsz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 20:24:21 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1447164eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791278660; x=1791883460; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ohmud8dlW/23qmDZSut2G/bzXusBDFIZZACFjcnqkos=;
        b=tHPWISO+aW/27FuYa2IGBkHGZpkPN22feUDCUW+xP/ZOt83cM62Z6tghMr9BprQ3XH
         mHh6mINQBwXuo50upHn8SfE4F+vzKZCuGNZaWxD0ZwItjgVVwJz6mo2YuBkqRW9rIIK1
         oldWXxYnfVJ04OHUUTHTztgXG2Ds9z466Eo6ZW2bWgyMma7nJWA4oKKtpjvOWGgBk6AI
         t9t2T3RN7/iPLZNprIj6o6jhVnca8D2z0M961qg2rJfAYb6wLVM+7zJtH3tmfcO9jbAE
         Uqfq4YYbuyDrEt8QuR2ygnVawWWd4nLPRPQcx5MElhpT0SnqzCPsCb5waNbUr2JckPp5
         M1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278660; x=1791883460;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohmud8dlW/23qmDZSut2G/bzXusBDFIZZACFjcnqkos=;
        b=GFuO+IJhTulKkPFKQYtsSuVpLdMAfgKRFtwBDsuYSYc82qKMckQvxfUCdbhVJgMKq7
         eeZjmuyBamUPdBcB8KnS53CH4rC2RodPqWoxZ+2XMuawkTACxgWzrWY8ualjTYFTpRGU
         axXTkM/HNkN9TLaBHqZ2g7M7021Gp3JKx3/KV/8AcTCijTqiuLk7UlMuFzpRUrXmxXR3
         7671y+cz5SCsLqOXKKQ6NJqCVMnYcYcHtqhMSoqvUhFpVjMZhhv7Vk4EBstu5qjceMnp
         hujc7s40ds1WoYstTxiTcVjC63r0u32hmi9gUP9hYKUURSGBgPmQv9ewj/COuEfM9DTs
         VYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwX5mCVKeLXagsqcUQ7BekeUguXPUNxQADorY+XT2lkJDS9Qud0qKu8pZJWfhCEK6CoYnK3Yl/wgiDAZrc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k7gjTnB0FAb2ER74atyz1m6QNJ+LI+MMiZwQgnfagsipTzingY
	e365qg/6OtC0UpNwF2YE+An1fd2dQmtiM12rVUJaqZQblZEWfcc+9+T2
X-Gm-Gg: AYBFou0nWIJw0dnmIvCUXNEd1627qyCXhrmz6LQ8SE/EmWLjs0jhkSP3ytQN8mpn6x9
	IGUcoRda5OxQ7Xk4xnG3uUxXyDkQxJtCCpG7IBKWbDjaY//HXQ9fZUjs064IoRX/ptMGY9PBQiG
	JlCQ6rfhedIJchpwtBf7VSUnenmuvMOo13vPcZ0yjwKNzuhXONZVUeKCvRJlyU0cJ5znwGZWLs/
	EUjj1DHC5YplkEm/u1CAW++8ZAZwBRKg2Z6FfVfSIZXXxoPRN9cZUyvp8A7iuQ7f9g6alnafXkt
	FNu3J4akmpDnLNFK9aDq1LYnA2ME7gwyjFSumpbKAvC6qAruq48N16yRQ3uUETknsWJuC1NKfZi
	tH0JW2nNiu7RupixKov9rR1J7FDt+aY2dcid9/nDxkxfAzMHjxFzlpApb+HRTN20tIbZHXaXkeE
	oh6GnuKd5eAfGyQlHmBu94XqaiEBpIgTbG6wf0wUigOPkXlhny19J1gTNNKxSI5ESlsfvP+H6x5
	n8wJCUJ3sNnpW99Gk8GjzEFYn4WMOrmq19LyzOR4mqy9bstZocNDw==
X-Received: by 2002:a05:7300:51e9:b0:351:52ec:60ee with SMTP id 5a478bee46e88-35152ec672fmr48303eec.28.1791278659872;
        Tue, 06 Oct 2026 02:24:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f73fcsm6424655eec.10.2026.10.06.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:24:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asM-1-ptu1b_URqR@google.com>
Date: Tue, 06 Oct 2026 08:13:01 +0530
Message-ID: <ece3k0qy.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com> <asMN_TAX-1_J3jiP@google.com> <fqykkc3j.ritesh.list@gmail.com> <asM-1-ptu1b_URqR@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Oct 05, 2026, Ritesh Harjani wrote:
>  > I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
>> > over open coding TEST_GEN_PROGS_COMMON.
>> 
>> Sure, so will add this check for kvm_create_max_vcpus()
>> 
>> #ifdef __powerpc64__
>>        TEST_REQUIRE(!is_pseries_lpar());
>> #endif 
>
> Or maybe to avoid too many ifdefs, something like:
>
>   static inline kvm_is_ppc_pseries_lpar(void)
>   {
>           /*
>            * Comment about how this setup has unique limitations and isn't
>            * compatible with tests that create many VMs and/or vCPUs.
>            */
>   #ifdef __powerpc64___
>           return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
>   #else
>           return false;
>   #endif
>   }
>
> Probably redundant naming to some extent, but having "ppc" in there would make it
> super obvious it's a PPC-only check.
>  

Sure. So I will get this definition added into kvm_util.h header file.


>> Actually I was thinking we may as well use the same check for now for
>> skipping hardware_disable_test on pseries. Because there also we suffer
>> from the same resource limitation. Let me know if that sounds ok to you
>> or do you want us to skip kvm_create_max_vcpus() only for now, since it
>> is part of TEST_GEN_PROGS_COMMON?
>> 
>> > LoongArch open coded its full test list
>> > for some reason, and in less than a year it has started missing out on new common
>> > tests.
>> >
>> >> (& maybe few others like vm_types_test) from that in v6.
>> >
>> > What's wrong with VM types test?  That one really should Just Work on all
>> > architectures.  It doesn't run on LoongArch, but I assume that's
>> > oversight?
>> 
>> So the test doesn't fail (it gets skipped). However this cap
>> "KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
>> open code all common tests, hence I thought I may as well not add this
>> in the first place.
>
> /facepalm
>
> I completely forgot KVM_CAP_VM_TYPES is x86-only.  FWIW, I'd still say use
> TEST_GEN_PROGS_COMMON if possible.
>
>> BTW, based on this discussion, I think I will re-arrange the patches in
>> the following order and send a v7. (The Makefile.kvm changes will only
>> get added after the main patch which adds powerpc support).
>> 
>> cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
>> 2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
>> f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
>> e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested
>
> Doesn't this one need to come first?  Or is this different than pseries LPAR?
>

That is correct. The patches are in the reverse order taken from the
output of: git log --oneline ...


>> 178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
>> 22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc
>
> This should come before "add support for powerpc", and should have a shortlog

That is correct. The patches are in the reverse order taken from the
output of: git log --oneline ...

> more like "Skip max vCPU IDs test on PPC with <whatever is a good description of the SMT cap>"
>

Sure, I will change this to something like:

  KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
  
  kvm_create_max_vcpus creates vCPUs from 0..MAX_VCPUS-1, then again
  with ids at the top of KVM_CAP_MAX_VCPU_ID.
  
  On PowerPC the vCPU id is not a flat index: it encodes SMT thread plus
  core. So on powerpc maximum permitted vCPU ID depends on the VM's SMT
  mode and the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple
  non-SMT VM's limit.
  
  So, skip that second loop when KVM_CAP_PPC_SMT is non-zero. The cap is
  0 on other arches, so they still run it. The 0..MAX_VCPUS pass is
  unchanged.

>> 11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
>> 63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
>> 
>> 
>> Please let me know if this sounds ok?
>
> Ya, works for me!

Thanks! Will send v7 shortly with the discussed changes.

-ritesh

