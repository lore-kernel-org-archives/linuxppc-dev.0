Return-Path: <linuxppc-dev+bounces-28784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD9CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 22:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxNj16KQWz2y1W;
	Sat, 03 Oct 2026 08:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790980101;
	cv=none; b=P6z0ySPq3BN7wRn8KcAJiS0E2fjwR/ksCM6pEoLUeyv7STFrrVvskC1cI/RX1JLYocFwQiEVwXupnubfURqMZnJIVL7jrX3bxrAh3AZYbfodC6oio8uA7UOKNnVkTgxDwEznQn+R/d/Aa+uws8sJSOMkKJRTTsxKJS6RSpcoNq1mYuXNALd18cD2egq1OkpqYukKGz0JCHqZDnYueqpZv+EnUGS7JSbLZzkXe9tX8nJKfpEOC/b76HYZHubIDgEnhYd6aEwI4pJJB0pohgfVxsN/PxWOw8qk3eJnsi08G0CMVfhwBfwzyJO9H7l8HyNDmxzMn7gTIf/cxyp98UfcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790980101; c=relaxed/relaxed;
	bh=6cEXwvHyHYypv1TjIMTLjauYp2kWmUbEs4O5rr+p48c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dCKwVVJaad3GxtvCGkg+Y0MWHi1xr+SnuV4syJ6x9AbMw1rIxnjrnKZjCr+NRF/owFMk6AC0MpnhnIw5WWxLEEEFcfm7NynFlBAEDhWvdYnwmcE57FjnEb3BN6XJ7HKlo9V115UFiclPSRir+SQlgoyw4qaiFgjNStMbuJFEyS21DMC59tAIH7Sv14j2uPJ7DnrSuYp2tuaT12hNWzt/bP61RqROjzk3PSUWqzDls0m0Pp0jp0DyMjzfmunyR14g5A4EKssPLCU+rMqzg74F8qt0K1mHeZjtbr2aauDRnd2GYg9xFfDDjl+Hso3wMkqKVBGNWlX3wm1pjqHAfEtkuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Yro6gQ10; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3addaagykdl0vhdqmfjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Yro6gQ10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3addaagykdl0vhdqmfjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxNj00r2Cz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 08:28:19 +1000 (AEST)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-39512608fb1so57057a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790980097; x=1791584897; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cEXwvHyHYypv1TjIMTLjauYp2kWmUbEs4O5rr+p48c=;
        b=Yro6gQ10gYDO67ChuddOqIv77Mg+gbthaD/FF3Oz8lyzRZViukZqRet4w9HeFDmKng
         fhNy7+TNqmBl4CueAu4dvh3g3J5Qmqy6bdmpwWLMdpDoQUnChSJHGlPvXCfyKF68pnAr
         Fch2dMYmP6OTc8y53TzNVNZbBxv7xuY8YRd3yOqOCz5Lq2hsqsPsLQliVMFJuG5hPQTA
         Q1rMWZ/gV4fEeRmjC0AUxtGscgu1V5sBpdmHRimlk9K/0PJCxng6rR0IjKKrKu/2yaM7
         LZ6xjf6W7oH1DQEuQBEk9lBnFbVPFU8X6lo3zvnAXoqbWceda2AUYqYIjgPKezeW2XFt
         +4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790980097; x=1791584897;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cEXwvHyHYypv1TjIMTLjauYp2kWmUbEs4O5rr+p48c=;
        b=gSGlZowgQcivw7Bn6uX8Gh/zOY+nuOYU2rur0fF0XIiROQb9/pi/H/uNdiGg3NXKuX
         VIG2UpmAOdbx3jjcuGOcO0zjTTRNpUbDP+9nuwcoXqBX74+0GWb9YU2RQ3bbz5b2FzJb
         U8bGHCxbufQdb3/evqp0d4BDysHGZEaqRAs09lMWGPcWymh4W6nHR9/NPEK2dlcj5p0G
         TcWXEcTgWYyoOc07vDxzWxS6su8yVnyhNe7EbXhy4AZKA48ukoctfa5k30F6BPwPT6Fr
         hLfxnP6vCwloI+6PV4EwkYBtVo6AZlZAUAkP99srwD6BlNf7PBzAU8Jt8Jl9GwxNnBqa
         9h+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzN7NvvORWTSThzNG2TcZgGhzg/tKAUsOMmh31SGWPZ+K7FuO86Frjg8wXni5SdgdEzmKekEUeYuL6VpLk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKpk1zaVlgpb0WJiDNv8mMQf5fJfMicqiMsSYijT5NWyRdHmZqM
	6SIv6JWOon7xu2x+KW4sPJKBkx/SjYhChcvH8KIiOsTLOunAPkcmmvoJSon5aQqFfvzX2M3BeOV
	KXx72xg==
X-Received: from pjbfr22.prod.google.com ([2002:a17:90a:e2d6:b0:3a0:b207:df5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8c:b0:3a4:7730:33dd
 with SMTP id 98e67ed59e1d1-3a78776199bmr395614a91.58.1790980096162; Fri, 02
 Oct 2026 15:28:16 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:28:15 -0700
In-Reply-To: <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
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
References: <cover.1790101179.git.ritesh.list@gmail.com> <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAv__Gozv6r3QWt@google.com>
Subject: Re: [PATCH v5 9/9] KVM: selftests: Move memslot_perf_test off the
 256M ELF load address
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
> KVM selftests are built with -fno-PIE/-no-pie so the binary uses fixed
> load addresses.
> On powerpc64, GNU ld default links at 0x10000000 (256M) which is also
> the MEM_GPA, so the identity map trips with the error:
>   PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f
> 
> Put the test slots at 512M instead which is past the ELF.
> e.g. failure w/o this fix:
> 
> ./memslot_perf_test -s 514

This, and any other adjustments/fixes to get common test functional on PPC needs
to land *before* the tests are enabled.

