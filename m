Return-Path: <linuxppc-dev+bounces-23002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF2CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 07:50:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmnsh3YD2z2yYd;
	Fri, 26 Jun 2026 17:50:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782460248;
	cv=none; b=bfa4nmn1FEyktEZise7O4ctaJASaHe8wwZqlQuZOFzj+pLXIOJz7xbiWZSxupp+uhu/33ClTDFlYqC1J1tpcKgpgV/LFqhwh/m+XHmgnQfLIzItQ6sZsEphKNm4bkwd0EvvUrD8JdeqWZ++Ktby44f2mm+p8asBntLym2y5DTxVYv2UUa39A+j2jrl4Od++k6lx+6eiI8Dba9SesSfpTldvjwuGHYHfEmEHVQKUh49PUvMhXq1ieBGGcduY7cKipSiutsE1pnxn+TWMAGardBLtimn99dGSvUvvLvvupUMTU/MbCAj93mt+LdIsTbHrgd54CfKdF265rjHscQuNCew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782460248; c=relaxed/relaxed;
	bh=fSf/Ohl+0RKuKbg0UOro7LvUAnl/SbQmtX/a2h/zMMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+EW+S0k/mOCFVHmAvr6dIR/tnz8ZfYTK4eIwLWPhLmspuo9jYGIpjJ7l0WsoxrcWN02AQ2VR4hbNt8V5RB92BUTTA+Rkp1JXz7BzbkdwCfNB4o2qs0lsq/Y06jtWm1aGqO8y8Il85Kq/vbJ8PqoJRIHmKeUfCFMmbZbYGsbWv3HPko0TxS+A2UwzJ6WWHcwwA9NMiaakqrV+Yf5/FjPM4FkkCbJnxy5Vxr1EC1NNO8ek0GQ9byS8qkcPHnKNtZQMZrRZTxX+kpWtYKXzkkLmSEtxCukBDSsnjtNtH0pexrhEbZ+QSaE/P2g6bMSPgHyjuAnf8kxL2CriZvl7LOnjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnWvHBBw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnWvHBBw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmnsg2Sbfz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 17:50:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DF2534194F;
	Fri, 26 Jun 2026 07:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E271F00A3A;
	Fri, 26 Jun 2026 07:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782460244;
	bh=fSf/Ohl+0RKuKbg0UOro7LvUAnl/SbQmtX/a2h/zMMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GnWvHBBwhWSLJ1VYhYGaPyWeqsj7UKJdGxIuvFNKuDd9YQmoH4BkUE/xo4lsfqFLf
	 nfia+DDGak56/3LPf3nzajgQbjkDekIu6i/np0o7Ul/wTPy02JNYMs57jIh01fezQh
	 y5muJe/CAMy/5MBi1bzqXB3zXDmHnlynGenHCdjaFPkAcP+ZTHv4xXF2lenYPDOWP5
	 oV1EjO1Wo+uC9GJzD747lEq1qEW6AvBY/1d9LKsFqgmxO7I1xurCzI7h+gIz4SQAhO
	 ipexjDFYgdNs8gKq4C30pkwEl+cuAt1Ut8tvwWulmrs1TcH2NZhFmUAepzG+9iHkA5
	 R837+JILwUuqw==
Date: Fri, 26 Jun 2026 00:50:44 -0700
From: Kees Cook <kees@kernel.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com,
	mark.rutland@arm.com, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <202606260050.681FAA94E@keescook>
References: <20260624171520.772408-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624171520.772408-1-mkchauras@gmail.com>

On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> (Function not implemented) instead of the expected EPERM (Operation
> not permitted).

Was this noticed by the seccomp_bpf kselftest? (If not, I'd love a
regression test added for this case...)

-Kees

-- 
Kees Cook

