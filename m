Return-Path: <linuxppc-dev+bounces-16177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05486D6CFAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 23:29:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxy2C4dDtz2xlM;
	Fri, 23 Jan 2026 10:29:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769124563;
	cv=none; b=me/1cKxCRAJo4k24h/DgXbp0wtOibD8Qut31EEPs4zsvJ68KKGRcW0auVfdEv7GE2C2yNRd9v4XWWxJGIhkD8msmNlSVY3l+pGxv+4eITKbaPqCz0vl7brWiaBERqrpucQz6gHqIi7af/e4zPFbVDDm/8cJZcFdj46fgx0sQEicby6iWVzu+wieXebGOeoaOx5hV7Q1SUjvF1wecqRJHbV//GM86DqLDoUgPtXkalVSUFcfELzhN58PIT/q44V9ylC8J656rD+bQ6CHC5KFD3j4e03IlGM50vxoY9D3UwobO7l/2G2io9xOxX+gz7O1YCxaCVT9NEvaGOFsHqgHp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769124563; c=relaxed/relaxed;
	bh=kf/+wm9T8K+0mpA0ud88MFs+EQUKYAWohz0EXddAFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5EKlZDu2oqgy/OR94g1SyU5NINneNUgzQRlVLKDs9anPaQwTcy4kWRRNI0Ac+vUfo1vmWXOK/SDHo6rP74c7mlVlS2WCXAYfHo2LkzgCPP5k92OIPEwRen08VYhIfhbpaJ/k6wPKpx3FyPwo6GK12mF0zHQF9qqXUsG4kNOYO9LUGZ62+uSmyDs8wQH7uN82isMV1IGzZVFfgsPiqQtG1wPbdsQbpuG9SdD+4EAZa/7m5agLMqnQCkfPcLe5hqhOesLxRVLsYwALMSqVJZrep/PD4r5cREcnWPkdyBNKm+LMn3QDWdqy3qDeGWXrRXKVwitiLImrlNVKhJYYuSpjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=AR0pJ+JM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=wvaw=73=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=AR0pJ+JM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=wvaw=73=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxy2C06shz2xdY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 10:29:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D3B3760146;
	Thu, 22 Jan 2026 23:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B31C116C6;
	Thu, 22 Jan 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AR0pJ+JM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1769124557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf/+wm9T8K+0mpA0ud88MFs+EQUKYAWohz0EXddAFIo=;
	b=AR0pJ+JMGvnU92uFTU2T54v518VZAvj/JhSPeH2ruQ2iUnWODCMzwcyklRasNyjc5Nirfc
	hjplmDuzJ7dqi5gWcnTH9DnHPuorX8VguNrcy3/iL6SFHksUcHvzRrHBIlaMQhqWQWghLd
	CzN32ZUihqTaUd1w5/EzDixALWTTABY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3fea361c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 23:29:17 +0000 (UTC)
Date: Fri, 23 Jan 2026 00:29:10 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org
Subject: Re: [PATCH 15/15] random: vDSO: remove ifdeffery
Message-ID: <aXKyxviscQhQlGig@zx2c4.com>
References: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
 <20260114-vdso-header-cleanups-v1-15-803b80ee97b4@linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114-vdso-header-cleanups-v1-15-803b80ee97b4@linutronix.de>

On Wed, Jan 14, 2026 at 09:01:47AM +0100, Thomas Weißschuh wrote:
> Recent cleanups of the vDSO headers allow the unconditional inclusion of
> vdso/datapage.h and the declarations it provides. This also means that
> the declaration of vdso_k_rng_data is always visible and its usage does
> not need to be guarded by ifdefs anymore. Instead use IS_ENABLED().
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

