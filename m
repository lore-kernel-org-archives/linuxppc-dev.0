Return-Path: <linuxppc-dev+bounces-22423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2680CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 16:19:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb9vy3WG3z30FP;
	Thu, 11 Jun 2026 02:19:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781108366;
	cv=none; b=WNXbJKsSoxjpI5PFgtaLYRrdA30+jiXKDgZ5rVqEjFZXaM+QGitjjsNmDcg72/Qx8tNcMaQ9yHWa7g47MSgso8I5rO9e8ax7AfW3sPZWTEigmbkwI3UjCY9aJjb56LLAHUqIguUuvJj3s1EOMh0kwpUNXhgifJoS7hLEX+O0MoWFr3Uc6FEmQ6AVl3kw0Ympyf24OOWvq0dx2/zZo5v3VIYzQcFtFePhY49Ho88bD/VczZ9sApUDwQoELY4lxMcnIV24oc32fe080Z4KD7y2G0WI5ghfujojXCIxXhfV7KAEi3vDPFzZPsV/L96zH3CoVo7bQE3zwyr1BXHck0n61A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781108366; c=relaxed/relaxed;
	bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GM+VE8C7MYs26UeEZiIf/rVO70lW6ojCEkv61gsYWi26SJXqos78lr1gqDLHAoycVkYiGW9T/GvuYYrEWxyn0k3w5G7dN0Dp324SrfUdDAh3JbYduzvSX+khz8OZhML3y+C8rTD0q9IcgL+3ODNrsbndMnNhiWK0xtL3p+FbiJBBgXWMPxzcizDeN/RanjYOtd97AgFzCOpri79bwsEmVodqA4tjSKc3+n1TdmDphGOnrxPi9kkkb7GTmbGmj+HXuZ0MkrERgyziubEuhIl7dRvRlD7FyF3Oe01N1vQA5e5zKyAffeT6V1kll1umANDbL9lddK3POLypkH9aNJtOFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gkyzwRYd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3i44pagykdkyykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gkyzwRYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3i44pagykdkyykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb9vx5C16z2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:19:25 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c85a298cd62so4603735a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108364; x=1781713164; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
        b=gkyzwRYd5XlFpIyaw/RBnBxFp3NHMQnL+k0pKO1r9jDacuQ+h2N3RkBoJUU3D5VCgZ
         okRly/FvtyTxBONcONbngnuMlFLeBgkSwcpmWOi2pJQSJuzr4zL0xJTPzIGkND1l84f6
         3AWcPL4RD4dtUdFBm8HxKlqg+PBHeTMt8oPVHYOR/D6ejusZShHt/CPNdSBSEm3U1ZJx
         oZkb0bbqeMTCQNSJb+bLafvzp0W9zVSiOvQMxEKbpDPBs1GEvloYWoKBBYZSDzCXU/hc
         IZWxQlX4NRXAFtuJsG4r46reBS+NzwYg/ethjg9+0cGIXZyfrbckzNucfDWl19i5BwLw
         0aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108364; x=1781713164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
        b=QTNjXt913lImgt12D1go3sivnDNbvkoI1PDzqNBJaFlNllwGU9Y0ta6XCPLPxA8L1M
         qK+dc94ybfr3Gzfvk8z74EtnySJNSUm/yGUyatTsAB16G7nsJdOhk3vZDvBpWD2c/5GN
         WSXeM4e6A8jfl2ASzK8PpCRHiNcIvxP/gTNmvjRIbwe1OL16hjis58h+Qc59qR9+7fzl
         HH6keZq0mWIENnMMxO6QNlprZXPJBA0uS7hZ65WSKCQUSeHy44UUjt+YpxqnKB2ZIh0R
         aGfbPQqYfAOKuVbzSCZwoN0mFX6o828mHMdblXEhctwaKAwEh1kmRCvY5sxCR2nyIA7I
         6Bkw==
X-Forwarded-Encrypted: i=1; AFNElJ8QjMeJgbabD+mO1vSi+n8ogSTa2SO8+afa8xcJTfM1O0GNyZ5lpAVfrafU3oCBRI/afq8Yy9152ScUZkI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxV+Mm5S2vS0ZPAwoA8vTVUOPPrI3sDmEd1JiFqhkox+bBdEt3j
	OnZb6Piid+BcltZWNZRvHpwkijXIzw2otEQtKKKe8wn+WAda2qRgtqiCtk8EOPUNt9ICPrdyupA
	oZx0qFg==
X-Received: from pgbdp7.prod.google.com ([2002:a05:6a02:f07:b0:c82:354b:8e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1f8c:b0:3b2:86e8:a817
 with SMTP id adf61e73a8af0-3b4ccf7f0d7mr31791362637.31.1781108363531; Wed, 10
 Jun 2026 09:19:23 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:19:22 -0700
In-Reply-To: <o6hieeub.ritesh.list@gmail.com>
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
References: <cover.1781093720.git.ritesh.list@gmail.com> <aildxtZhqEFYygp2@google.com>
 <o6hieeub.ritesh.list@gmail.com>
Message-ID: <aimOihmFdNIK9TIc@google.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani wrote:
> One other question - Should this go via powerpc tree or via kvm tree?

Definitely the KVM tree.

