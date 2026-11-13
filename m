Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF4606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R+pkqZv7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQz9c5wybz2xQD;
	Sat, 14 Nov 2026 00:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794577700;
	cv=none; b=LlksQJc7Hge8GW8/4Sy+xOuRUHFk3iTLwpMqUNDc+JwVb+tGY5fD1QH6qfD5XMyabGOSFrusIg/Juh6yj3WaSO2ch82kfdb7G5NpayWf+nlZGoPX863tYWrpgUmJ29XoVy5+9m59v+IAye7FJG2mLbothVMg5FgFMmZa36kWhut2WkWGyIDSJvJ07xPbJd0KrYN4g4WNrLhnYzRNge5ImsNsQHQEMhHK9fpubmpkbA617pWK4M2tGWkMOBtejjoctbdzDl6fY9YlgVfDF61s9zmZ0dx3fBtTK+j5NG4uREp6MiBCurQJvwyFcThlQk52b0DGQW2kzbw2+tf4zcogMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794577700; c=relaxed/relaxed;
	bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBF6WC7p8v4IORUP0XcdwnbcBMvK98Ibp88ZEKeKK1GIJcgqWld23+93s1wB4kfKTYjf1VxSEF7Xd14kuvRJd/PWcWoG2Bmb/1OQfAowCB+4RtV2QCvP94Q+BymslczHZ5rC30q2EyLr2GHhKzpXWcd3zSkaEyPl7daMN+gNx6mBz0rTeuW82vHYXTa+QOEu9S0NceopDE5B77M4QWl6/D0wHg+3CmEYeiAq9UqT0mUoffZBU16z+SgMUa2nIjpu3x0G/yEe9+vI/yLdLKPemETW2pLrPmpsqxNFM2JWgbK3LvFetuneVaF4lkmsnBjUcMyRzk5VC1ou3wdz18zMsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R+pkqZv7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3irx3agykdiy2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R+pkqZv7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3irx3agykdiy2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQz9c1Br3z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 00:48:20 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2ea446ea8c9so15379085ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577698; x=1795182498; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
        b=R+pkqZv73+eC85Zzq/FRrc8CHOcir5LtVSawUHfbt9u37wcYZXIUTPazZQtDp0RC0f
         n0MpmhE7nbZHML0s+f2Fvs7u31BF/cEc0Tzpp0sR1himLdYXLEzowCj/mhfri65wGzGl
         O7TzB/2K5BEVq1SWlcWmMyHinl6xyLrGfgufDFh0mRQTY7V+BDCkfXnPlqLslnH3DUj7
         wrS7zBorHlfh1poOSF8idMbH6fX+Z/h8mdkjmwDqQE2Dabthbg82X3ogw9VJkTf6Q2w2
         kWuKsQLsqYxQ7MhI3yWR0/g6WdVeT5V7aUzW6VpbAuwl3JyOzoICw2+7OUr6mXTWiTYw
         QVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577698; x=1795182498;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
        b=Bf5iKB638NnSYwrde4msZ0t2wElkJe6Edu1vxBgTSkfgVTfJU8xPvYvr1qOiCPMjty
         aDfDBrZ8no7Q6wV0IDK6ptv/S649K7Jg7jTwpRAhWYjHpV/Ng1HDjMFii1oMjyNPCN7M
         g/dSlC7R89R+Nq8QW90qpDyxQkVc6+VhMn1Hop4ScNRzcbSbn3A3Kee2YP/e/dNvamIe
         ZXxDl5IOAAFRRdi+BT8YzD7S1DJ0FYV6wZ5XFJUkjckdul7ptDCk0EKbmjOnkPQ0A94S
         hE25WTgEYVoKAnP39EEjrbEVnCPVqJOXz5h19s5MzeS5uDsR96DFN9qCLo/kgbEOcQ+Q
         ECLA==
X-Forwarded-Encrypted: i=1; AL+hErHE0tMACBQvhhrWQa+feFkliJ/R5KsR8c46WetZLtJnPeIjJIgmoHkyGgw1dGJXvesimx4mxe/XRpYlVjs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8YXp33UJs42ZkQbaibGhdLM3uisHQEgSUvDLngQ+MI+7Uzx7tl
	VUxhEnWcdgdxl5n1tCQS49U+e6G+DqVoXV6+0CI1yHv6xMXim8fTps1wHc9GaYxtMRluMGfU7CJ
	+2SpcQg==
X-Received: from pjbfz9.prod.google.com ([2002:a17:90b:249:b0:3a8:8d0:61eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a45:b0:3ac:7406:b49
 with SMTP id 98e67ed59e1d1-3b1b0b5c202mr1376156a91.15.1794577697434; Fri, 13
 Nov 2026 05:48:17 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:22 -0800
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441847158.83355.13758439775824427618.b4-ty@b4>
Subject: Re: [PATCH v4 00/23] KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 14:20:48 -0700, Sean Christopherson wrote:
> Stupid SMM.  Patches 1-3 need to go to 7.4, everything else can and should wait.
> 
> Fix a class of bugs (limited to nested VMX, as far as we know) where KVM can
> corrupt an unrelated process' memory if KVM (attempts to) write to guest memory
> during VM destruction.  Because current->mm usually isn't kvm->mm when a VM is
> dying, e.g. because the associated kvm->mm process has already exited, writing
> to what KVM thinks is guest memory will corrupt the current address space if
> the associated userspace address happens to be writable in the victim.
> 
> [...]

Applied patch 1-3 to kvm-x86 fixes.  I'll probably create a dedicated topic
branch for the rest based on a later -rc.

[01/23] KVM: Reject user accesses to guest memory if current->mm != kvm->mm
        https://github.com/kvm-x86/linux/commit/2520694e6048
[02/23] KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
        https://github.com/kvm-x86/linux/commit/99872af7b904
[03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
        https://github.com/kvm-x86/linux/commit/93862ef1afdd

--
https://github.com/kvm-x86/linux/tree/next

