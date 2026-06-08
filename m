Return-Path: <linuxppc-dev+bounces-22280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663AECD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ0DC6Gxcz2ytj;
	Tue, 09 Jun 2026 03:59:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780941563;
	cv=none; b=Nmfij2hgCAOxjk//neOGOUELFusc/4RD4LOQiJndrIXEhlqkdFv/F4S0o/fEMVTkwW1CF95+6KZjx2zQlcU1g+9RRQabZ/qvS4pTSuOFnAo/8K+r3mJiqRuALLvTBtZNfLaw6UMiNCTdjzYE5S1yANRQ0ENs+Mh0jE8atijoOqyA28HAdugT7soAy4rG6LfEgndUAm1CSEbeEa5FT+KKP5OQGeST+HitIvJuNDvSkDGS0R9LCWnHxVnUjRHkKFz+CxCHadOgqctAbOexbfcEXbx8ekCssWssKnwSfmfZa7KrxNawraCfHVGBsATCDG/3WnttA4/KoNfeEfY1nDoGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780941563; c=relaxed/relaxed;
	bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joznY629SwS6LqnjDEJpuIslp56z/RKNLytxwpKYZOxubWsraaS3m7J5e8pKJfgRGL1zPKxqCPFP6in8oA5cTOvc6qMVlfqylDdyPJ1zFEVVv32ZlFpesZR9a5Cn6dDkGmmYQOC5+SzaFcYrEcvR1W5G+jj4b+zFDga4B+jrJWZvR0gm+OLyocYnQbcKUjKc4fWIxfYrxuOFI/Aasdqm3lE60AE0fNknaY6yO6/9ZeO6Ro3e7kmSgy9HiLhBJK3jpoOVvRWKTYFbmZHgbjdU++2GRxlUethgIoagv6eQQEz7J2jnme/N1Dd2Zra001VxNoWvum8bO6oIMxPbB8+NdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuRaIeDC; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUY6YrOQ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuRaIeDC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUY6YrOQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ0DB5CMMz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 03:59:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780941557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
	b=iuRaIeDCE6C2vg4OsQ/bxn0KOdr2IzkYEe4lTXR3vnMaxqefdNwRc53O/JR2JXj2Quj8Cw
	9E8lWcKT3oh2fgrMjvCGD5XJMAhu204ruIUM4fiOPjnOFyY6G9ui2j1ewzpwGWmv4jnLU6
	1k8zC92Nkdo5DgJvJDn0RDjQtiWk6DI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780941558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
	b=AUY6YrOQ9plNq/CYRGbRoQJRYkCPVvA2/akADym9mecp+aeKLvwtw+Ry3h4rDKYS7BG1XC
	tsnSApEkjhrVZVzJmiGTO1BTgX0Osrwb2R978KntObSeKnp8n7TcRFLqrVGDPIXfCoNLPR
	d8kZC+Qz5T/fIpSBvXkCxGcqwqxMgx4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-hUnla6JNP_aZ8AJ9QFJuSA-1; Mon, 08 Jun 2026 13:59:16 -0400
X-MC-Unique: hUnla6JNP_aZ8AJ9QFJuSA-1
X-Mimecast-MFC-AGG-ID: hUnla6JNP_aZ8AJ9QFJuSA_1780941555
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46011aa5000so1978223f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 10:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941555; x=1781546355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8d2xpklGhwQZIXzXL6uTt/rbyfEnaEp9dTHG5HoHQ0=;
        b=iN5HNymONxZuqYmD6m0KpQobgA9jUxrXJFfctzqaQ67JXV4ZOuChcpzQN2BSZOHNwN
         nYOBSQsXIJl4+DLvbByWDhefe+KrG3Vx8nNzAltWL3PIs9g8QpgP+VUzHardiKXOBWjE
         UEsKi7qR4dbSthR96VS65zHO6+AR4s1S6tIOKLa6iXzpoa9C1ybmSC+0C3TT/Jw+5ocq
         T5YhmdkFSDq/rZgOrulhRpM+zE/oiVJKj3vLrON1ZutnNWP3feZu6Jgg5INKmMJ/26EC
         tczbip2/MwZa4F6hRZk7BLFrUFAQrhAOVy51RLFVo7z8C5z+TIWYBqz3m9XtbinxVgZ6
         Q2lw==
X-Forwarded-Encrypted: i=1; AFNElJ8NqTyKXq7aYKxdN0dg62WCz4+3I4H9aKZ9CL4s0xmoy31dp4SHYbfUMNilMNznhKxaEn3k6Piz70t5dWE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxkus05fC58bJq/XAGfPZ9qTUSz0Jt3kZYWQi5vQN83+vLsw0fl
	75Y2o9Yj/ytLG0ElueaJSWTeQExkvOkPfnsadv8HX8q6SqwLY+G2rW/t6BQGsH7aGUKnm0zJpQz
	1NabbuWvndWJRxvvgV2AhTOQP9KiEYO0RX+VqiIjTtfjodBLCsffakJmi7jzEKfzdarUzsuf/1C
	rZveC0pLkxBmYb8KPtM1o7byW7O6TMaG6k/hPB8JGefQ==
X-Gm-Gg: Acq92OGkGX5Gz5LFuATj2t52fWSCbV2up+FDJ44Kg1xaPXlWHYcM30IuX7nSgjSe/uN
	br9KDmwvibDqr0GfbaJOjkj2wHN0yPxbH/24OLLsDYDjPzqNS8JwtzItdQ4uxPF1L/F3Rge+Opw
	9Mq4TyHCCVNDUzyPxM8/U/B+GlU1ALHhfELsGiJOjpg2RjhabBr+WUdmmdL1Rqt3iFyH7BAEeot
	ac57yUlD63K4y3IpHgP9vz3zTA7ErIarpE0sm6Wvc7dxP5tWQbWp151X3MROUhK3vHfw24AQ9I6
	6FZQaNVA9R+6JthD
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id 5b1f17b1804b1-490c25b5f6cmr285228315e9.13.1780941555113;
        Mon, 08 Jun 2026 10:59:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id
 5b1f17b1804b1-490c25b5f6cmr285227865e9.13.1780941554714; Mon, 08 Jun 2026
 10:59:14 -0700 (PDT)
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
References: <20260608144252.351443-1-joro@8bytes.org> <20260608144252.351443-36-joro@8bytes.org>
 <e7eb0dba-790a-4644-9895-5c9a7420d7fe@redhat.com> <aib8n5lO6HKbLC4Y@8bytes.org>
In-Reply-To: <aib8n5lO6HKbLC4Y@8bytes.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jun 2026 19:58:43 +0200
X-Gm-Features: AVVi8CcaSI98hh9wFoB_n6cKHV5EHNPF6kPS5m5gs3YdhiTjEhtRfK4vGBfAwzg
Message-ID: <CABgObfbUsDeStnZF-7oyR-W-Bvd4qTMoeUwGizgn10UTdKtZ2A@mail.gmail.com>
Subject: Re: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com, 
	michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de, 
	James.Bottomley@hansenpartnership.com, Melody Wang <huibo.wang@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, x86@kernel.org, 
	coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YFoEvSh45ExSAdWLWvXwvgod2JGGypPk8UseMotIaL0_1780941555
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:52=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.or=
g> wrote:
> On Mon, Jun 08, 2026 at 06:47:54PM +0200, Paolo Bonzini wrote:
> > On 6/8/26 16:42, J=C3=B6rg R=C3=B6del wrote:
> > > The algorithm is to always run the lowest runnable plane. Plane
> > > switches are done by stopping the current plane and setting another
> > > runnable.
> >
> > This was left arbitrary in my version because for example Hyper-V VTLs =
use
> > highest-runnable instead.  It also made pure userspace scheduling possi=
ble,
> > though that may not be very important in the grand scheme of things.
>
> IIRC what Hyper-V does is always the run the highest-privileged runnable =
level,
> no?  Maybe in their numbering level 0 has the least privileges?

Yes, exactly.

> Anyway, I am happy to make changes here, also based on input from the VSM=
 side.

Related to this, let me know if you want me to pick up again the
common part, especially with Sashiko being hard at work on it.

> > Did you drop it because it didn't work, or just for simplicity?
>
> The user-space scheduling worked, my 6.17 planes implementation used it. =
But
> there are some problems with it going forward, because TDX Partitioning (=
and
> likely ARM CCA Planes as well) do not allow arbitrary switches forced by =
the
> hypervisor. All they allow is a forced switch to the highest privileged p=
lane,
> the SVSM on SNP will force the same constraints by making lower-privilege=
 VMSAs
> not-runnable when it executes.

The idea of the userspace scheduling was that you're not forced to use
it - the kernel can always choose to override it if it's using an
accelerated implementation of planes (and of plane switching). But it
also leaves some leeway to different accelerated implementations, each
of which can pick their own algorithm.

Conceptually I'd rather keep the possibility of userspace scheduling.
But maybe it doesn't add much.

Paolo

> So exposing an interface for user-space to chose which plane to run does =
seem
> to gain some weird, platform dependent semantics going forward. TDX and C=
CA
> also require in-kernel switching as they can switch planes without a VMEX=
IT, so
> I decided to have it from the start.
>
>
> -Joerg
>


