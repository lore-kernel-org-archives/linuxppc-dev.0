Return-Path: <linuxppc-dev+bounces-29433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4EACC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 19:46:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j44bC3FYfz2y2h;
	Wed, 14 Oct 2026 06:46:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791920791;
	cv=none; b=MST81686m9sePmLuKUm4TpiJStwI/wjy2tFTAFPa0zGSJfjlnxDJr2VUqZyPw0bdOoLhLl5imC/puJ2XgXqrHQkjRY8k3xOHL3XfwS86YWx6VF9Wa6EaolAndbLTFAweE87RG0AirayYFbH4diIfx/t6X3osTDvoooBh1lK0WUJjRzjnmG6RqXjVKBT4lPte/iTLmpd4rBgBl9sXUcp9XVjUWI/Hp2CuVSjyEJM4UMXG89kRk04/qv81lk/L01M3KkKnFjc8qczpd1eOsjm0o90rvOzhQU4D6zFdLMrg1poevtuze1GbNxvqn5ifEJmybYbgAEKyMLY2Kq/dIvVrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791920791; c=relaxed/relaxed;
	bh=LeOkNArJ14T449fGvcCB00uvB/PZ25DWOhBo0IuHU3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f84O6dRujGcPn4LEuoSVZFXHh6N8MlMbNUHCGyVvzeK64XuT1LCyCkiN6WDh1ksKc/Xg/tPen0EzCY5AvwjiQyZwjZB+Uqw/3hzYQtg9vl8SUInvXHGkqlGpALHFBSH9aMCsoDw5zle6wupSCjbBAwYFUMgFwXCZpplSyaQFxFpW5uarSlk6pE7ri/xsQsIhB+Wl3vSbyZwZLrEAg7CqoAUKyPlCOOhZETCGFQaulJzLRdV+TjPnFeIT4PwRIXY/ud2Ix4WE6MR9FzL9ZWZbAaNX5SDW48mzYebBCuDBDsD9QtnBAw1OQ124+23yZyd2xdB4yn54O1ldc5/spTjzOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rwIXYfTk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3kyroagykdd4xjfsohlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rwIXYfTk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3kyroagykdd4xjfsohlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com [IPv6:2607:f8b0:4864:20::448])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j44b95RgPz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 06:46:28 +1100 (AEDT)
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-8881a7875e5so2172349b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791920785; x=1792525585; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LeOkNArJ14T449fGvcCB00uvB/PZ25DWOhBo0IuHU3o=;
        b=rwIXYfTk1HCWKiATZVnm0O5HD1plaegteK0x03dhll9TkINuOvo9KS1GqQrySZgNeN
         lEueoLU1oJOawGoCwVKzi4q0Vi7ijJi0RbU8AiBFvrkShQaSZyegLv+hkdFHplmnVB+P
         bA+HdwOdn21Nq9DRmTHlr/yvA4PqSJwQSxTmjczdD7yOlcQ0ir8eUlI1kBu9eWS5aWe4
         uazSezWVi+iQqK0eHP9BweEbXb/5eotmP2YjwqaTK+uYQLQtcMYeTHQUvC5turAdY4k8
         T+nL+YI21T+8yAHkKkr8c/FEU7myfk9RpK/pUyb+hHrlNhlbKLjynzChDWBUAdgQ6Tsk
         N2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791920785; x=1792525585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LeOkNArJ14T449fGvcCB00uvB/PZ25DWOhBo0IuHU3o=;
        b=dIZGKl1Rkcg3DQF64ut0k9TcRaxT3Cw2lda57Yqo4KYhwd/9Y04Qc9PrRSPTAXFdB8
         oaNYzLXYo8iKmJdjH0xNU3DZ6rLmFIcXop4krStXXhct6UZQiBi1wQ8+BfalRcPi8K96
         YWBUp/23SByNe1ONbsJFNy04MkwF7VyiUpL6Hl926xnzoVWGPCG2jp77qWtKpO9GlauT
         uNf1tVPp0uOb8L9o1VpYP97pem/gIE93C5uw/WyiAwGS1hpyq30Q7Wu6VuAPGlXeRWmK
         lS10Wb31n/aiKDVWqPaeEryz8aE3jg6Nb+h7gfTV7LWtJjOFxMumyT+U6Rx7/r0XdTF6
         qunQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1+PE3PyDrXSjL9ckMXZmdpnF8Bu9Z7ssG8udwYXP0DarNZ8SZ4Tjz2Okavjglt4G1N4Tck1fljAWTEms=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK+xaOms+eX0iwhKdWODMkIOk8d8AhlQKMPwAb0NEF+FjgT10y1
	oIT8eGoJaxyQBwaUHLH3L1K2kIMjywVxzJVqOEYSrgNiggbw2Y/y1Iri9w8IoFebv7dp8vVOZq8
	hfFud2A==
X-Received: from pfbdw16.prod.google.com ([2002:a05:6a00:3690:b0:893:3763:ceda])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f2:b0:874:705d:f659
 with SMTP id d2e1a72fcca58-897c6d1e526mr11766098b3a.39.1791920785216; Tue, 13
 Oct 2026 12:46:25 -0700 (PDT)
Date: Tue, 13 Oct 2026 12:46:24 -0700
In-Reply-To: <94cd4203-1be8-4f8d-b015-0c02760e5770@linux.ibm.com>
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
References: <cover.1791280439.git.ritesh.list@gmail.com> <94cd4203-1be8-4f8d-b015-0c02760e5770@linux.ibm.com>
Message-ID: <as6KkH-MnbfDeuAi@google.com>
Subject: Re: [PATCH v7 0/8] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 12, 2026, Madhavan Srinivasan wrote:
> On 10/6/26 3:58 PM, Ritesh Harjani (IBM) wrote:
> > This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> > radix MMU).
> > 
> > This patch series is originally Nick's work. I have mainly only rebased it on
> > the latest upstream tree. Since the rebase required few changes to all the four
> > patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.
> > 
> > Since the last series was posted three years ago [1], I am resetting the version
> > to RFC. This rebase was done as part of a larger effort to improve the selftests
> > infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
> > help on this.
> > 
> Sean/Paolo, hope you take this via your tree.

I've pushed this to kvm-x86/ppc_selftests, and to kvm-x86/next.  It should show
up in tomorrow's build of linux-next.  If all goes well, I'll send "official"
thanks in a few days (I'll be offline for the next ~48 hours), and include
ppc_selftests in my pull requests for 7.4.

