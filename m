Return-Path: <linuxppc-dev+bounces-28783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D719CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 22:19:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxNVL48r0z2y8r;
	Sat, 03 Oct 2026 08:19:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790979546;
	cv=none; b=PotkLczSnJ8OriUkU6hjQAMCm1u59Y8vyJq4zq45AHop36AuLzJC23AMdIEVDF2seqqlAGRyR5m+0UYF+PCNzyIh++Zscf8ux0hqeJ6/lnc5i2C+8pwcR/Uk3dEVrUlpI8nfyVRpX/yKPJSMSv4wLQrbH7eLNkI40DXHEgpP5g1OB0Nw2T+03hyujUSVSc9T5GqkAKKdlPHFr5HJsiFW0do4QobMNO6DuccOG68amGgTZOWK4f2GG8m4teQKWqP0umca9VRBPvYbaXauHleHlv+0CHoY/BHj+i3Q3ZFuUz4n3O28UfAAgdx/j+tzRqJGRewADWY2fns8lIj8tKkGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790979546; c=relaxed/relaxed;
	bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QxiM+gnOnqa6N6oZU1bS3hQDJSoZ2XvLIX67Vj0lqTmvjpTS93o7H57kxbgGorCk8CwUcSIn+waJiTdQ4cA334EgSEwjA24jKTrK8paRXk8pqYxbm6XMrId6vY41mkrBy6gQEgUw5Zxa27ZHtheZbwZJ7pVmrueQKnCEyuK6TWS//qkC7mvdIgjXJNPs7yIzhjK2qR82hjm92aZtbOzsbxEW1yC1YO/2O1/gcfUhkTNaHgoSqT0q4fbUF2bgovANPpRy8RhCkv8L5wBF6wrhakkDlN55wWwXgm0X+UV23jZ3zFxwI/kHoHBkkdA/2E8zUeV4YhpDCTA25GVSsyMbTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdit2Bm3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=31s3aagykdi4aws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fdit2Bm3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=31s3aagykdi4aws51uy66y3w.u64305cf77u-vwd30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxNVJ6bmlz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 08:19:03 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so49972a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979542; x=1791584342; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
        b=fdit2Bm3voGMBArwxJ4+kUjFKx6DSZBA/KVxlekn5RedZKHOcUrqFTMEpbRpMEoL3v
         tieMWWA7L745Xpapcjr9eMuYFLb0EHFxx/riU7ea4vCd0sQRIGGCvsufzylOY0CXdvcF
         e1w0VSCh0NA1UB8KJ2lfv2WK5uU6xdmbXDqc/ET2poZ5f6unZH66ZSuLQLjQ0k8Y6FiT
         InqrJWuPmjGM1fF4zRRJfakJU9LiA9mFoqzh3wIY0VsKHfRnlXCLzFtmi+P5c1no+sQE
         AnnhRzeb5iYuxHa/0ZMRxovm4XYT2J1h5FmR+dVioG5EaqlA5Ya/dLMVSXFmdf2cQzip
         HGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979542; x=1791584342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
        b=VBAlqXsA3MaVFyp827sACDd+7ayJ+YvxK0nQpluLp17quxF/eDTUxEpAXsrao3zf1Y
         ZVJXEDHYJKFxPQpDlB/CfC6IksGwPJb6PIoY9ZhcHl0eDJA6supM4imdok1KPcvRo5R3
         d6iGOT+SxgmuZziRPro1q+k8Mtkhg4llRl3SycqBzf+lBzf83pEUspo9zJk5wj53IK4R
         oUBUAhdP25MPpdoVl7XFSEsGfV4MjR8poa+0FhPIC9jMGkYlfjVjkRAhshFLoExcFiIo
         oDg4lDvQDZqp31SiulqjMY0tqWjGbCqCNO8Zzk8t/juPzf6Cld7hhsnUzdKjG3YQqXka
         mxsA==
X-Forwarded-Encrypted: i=1; AKwUvByg1C3nEbUO0yoIl9DmUnU/VFB1Bsj6O8ysE/RYot4mzoLLKzr4isx0/7WLC/rJ2SH74soERoBkAJQqY6I=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKQUYRrU8f0pIcKl73AI6BniiI29zTqAHH5ZEbFFSL8Izx7D2uM
	1jLIoxl7BfxhS/CkFH+Wglq6a1hp2KOLv7QqLBPSGP3zclAh9x60vsFSShb6xnBpIeXLHZF/GHJ
	NZzzRAQ==
X-Received: from pjtn8.prod.google.com ([2002:a17:90a:c688:b0:3a0:dee2:7813])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b48:b0:3a4:71b7:eb63
 with SMTP id 98e67ed59e1d1-3a6ceab25dbmr1825054a91.10.1790979541549; Fri, 02
 Oct 2026 15:19:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:19:00 -0700
In-Reply-To: <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
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
References: <cover.1790101179.git.ritesh.list@gmail.com> <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAt1NhGFs5HNbvl@google.com>
Subject: Re: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
> limits that number to 4 when we know that we are running in constraint
> host environment. The number 4 is just a safe minimum when
> kvm_arch_vm_create_may_enomem() can be true.

Please actually explain *why* this is necessary, and where the magic '4' comes.
I assume there's some system-wide resource at play?

