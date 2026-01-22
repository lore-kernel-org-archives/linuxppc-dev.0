Return-Path: <linuxppc-dev+bounces-16176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29D4D6CFAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 23:28:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxy1Y49yYz2xlM;
	Fri, 23 Jan 2026 10:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769124529;
	cv=none; b=MaRud+IesKDsEWcIhrPmf4+BZM0wryPBgmDRx2BegtdDLluDw0D1c02da1+feSQrlOpS+jonyGQN0VDlY535q2Vfk1GS7otIQX9HZL5HpTVuMcTvBbbEPqFo3aI7+O7PT/+AjSYoqHcSVpBYi6PUnPkTyKt8KW2kBEHfG1GcgWeFlSsMN9kzWeDBO9GZ/R7r8DYfcFeYwFhFKMSmEnGWXd8q0l9GaTycCQDKs8dQZntDr9QHw0CFHuTlzAa5BGFy3YZfYOFgNYwiguQan1WaBUjbXiGYjyJQeXWSHHahHbQnTyAPENWCIIxrdajjskWmuFEir5PY5qr6ES6GbyI2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769124529; c=relaxed/relaxed;
	bh=kAz0VE0aOXkTcnMsKZPcPLkEBbWRFSQ9zoUsrO3JsFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz/S1xpKRhJPqQP8NfZl2PeuVWybVcv7o2F4J1CCJgWHl00AFEGq9dPVlN9ixOkzU7r5mGe6zrCZl/BFc91YTMWzOB8GgehTSyzXNx5XHyE6kYpOR9GhfNFUZ1Xsm5L500z4Kk4cKyvo6tAM9HdwDYTPukKWJcIfYLgInhkdoLKh3vWBTnfO/2Z+yHKc3Go45bT6PSNNMV+PW8gBAqmbSl12p7nNAZFmIDJyVQqP7Qw/3yh1H0VzCf0aVqF2D0aRzm6PkLBMVNqgLg7s1C4f/XNERp8zIHPgftD9vnhLbRAVjmK6w4MMQu4BS5lLU1v2xTH+UhgVjOiBuCLWIGxCoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=gZQ8voLN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=wvaw=73=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=gZQ8voLN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=wvaw=73=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxy1W0DC0z2xdY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 10:28:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4936A6001A;
	Thu, 22 Jan 2026 23:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21401C116C6;
	Thu, 22 Jan 2026 23:28:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gZQ8voLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1769124520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAz0VE0aOXkTcnMsKZPcPLkEBbWRFSQ9zoUsrO3JsFA=;
	b=gZQ8voLNqP2wWMPrgAFFPQqM3dQtnQELPH8RWkZqlFaRd3tnhApMvte4sd3nU0Ql3XOzkx
	r7O/0h1mHbk5Z3LpYrJJT2rTcscRugiMW5k6hm1nduek7IWmiVHOrg8UD9fwD1yWt9p+cc
	JKaaRYWQ9EN9tFsCeDd2mcNJ+9jcJjQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 325b9127 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 23:28:39 +0000 (UTC)
Date: Fri, 23 Jan 2026 00:28:32 +0100
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
Subject: Re: [PATCH 09/15] random: vDSO: Add explicit includes
Message-ID: <aXKyoETSE7G4PqmE@zx2c4.com>
References: <20260114-vdso-header-cleanups-v1-0-803b80ee97b4@linutronix.de>
 <20260114-vdso-header-cleanups-v1-9-803b80ee97b4@linutronix.de>
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
In-Reply-To: <20260114-vdso-header-cleanups-v1-9-803b80ee97b4@linutronix.de>

On Wed, Jan 14, 2026 at 09:01:41AM +0100, Thomas Weißschuh wrote:
> Various used symbols are only visible through transitive includes.
> These transitive includes are about to go away.
> 
> Explicitly include the necessary headers.

Please lowercase the subject line. Otherwise,

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

