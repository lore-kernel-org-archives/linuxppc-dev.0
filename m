Return-Path: <linuxppc-dev+bounces-10324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C6C83F1A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jul 2025 17:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bkGrZ4y1Hz30Qk;
	Sat, 19 Jul 2025 03:25:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752859502;
	cv=none; b=LmpeZwPn1QfUiqwFJDvPFdVHDjVJCSxAQ9g2ppJzfcta8I9sWabK/Yc1IkP/+AQtCKJigO3+zslJaDsiy5hZffuzCGjy8afChFLCQqZyR9dJpHXlwXcTeS88YAVYul/N/gDRw6fsDCeWLs7c0YpQR0EpnAozw5judbByqXlPhHY1Vs4t3mbjw/RV9cCqY/g+4TlJEuy08bAMuUY5wfgXVf2IZhMRs6E6rBe/IRlsyM+FgI3wq3Q1IHMXyRauvylMavNJ8xmOzhsrI3T4Y5EXuiohohxbEEDBbed2+80O4cKeoFv/NB3kiZe29YxBQkvDNX+JAYHLeTOdx1yxXScZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752859502; c=relaxed/relaxed;
	bh=PQvsb01xzlGHM7LKVKP1tOCkGZRrJOceq7UoklVtaK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbZPme2oGTzBwYDgXpKskajKD8V70sfMHc2P4hfkdir2TOkgS+OMq+f7KrO9oss8mGOqZGCsSgWaQWg+Th5dX3ku2MKxWwfB1pX1wclk9pVshVBroShQCN05nhF6+kaNSgOyw6dSIY6eFA/7SQFgL5JPevPAvp0R0478w0ELK7ffNNXpAkJyRbfKkMonNtXDYAEZ2lGgRlQ2e12qE49H602XkBWLokz3l5dDY4VbJJV7J9fFU2auWl3fTU4k7fY7UdIsJhdMNSy1zwW3Tq0s3RFEwca9cohqZWCv12EqoLfmwjlU3cya9wHWcSx9VajEdMbIUflN9esNoyeWVS/oOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TqXalVmJ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TqXalVmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bkGrY684Kz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2025 03:25:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0133F5C694F;
	Fri, 18 Jul 2025 17:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4F1C4CEEB;
	Fri, 18 Jul 2025 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752859499;
	bh=oVO5M0xi9nHuF2wLV5lZIwV9zZTHFOJINcZiTfuxVMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqXalVmJ44i3C1Q1lZX+O1wEI6wKjOoYPZ1t3bA8aoZ2FUaaVn3QiCetoUYw7m9z2
	 RnNt7q1ghLvXnreglbMakN+S+6i6Vo+Md/+RfrIEBGMIB3L0YjMvj7rjIHAumcK1R9
	 9caF4FditaprdNNusCfs1NjwrfpNJnd/1ABK79IzRnS/ijirZpAaAnWMd1bbUUmOY/
	 InjU+kV49p8Rn7kLevtJg+PcO8UqEbXm0VB38B+flHprmY7HaLtWIboKpi5+0S7CSL
	 I9eCKxE6pjSGWTgkub5pwV3502DeVWGGS78Y7zaHCRhdOWlOVrZz84wsLygXKNFy48
	 ldVY1/Ozd/Ctg==
Date: Fri, 18 Jul 2025 10:24:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/26] SHA-1 library functions
Message-ID: <20250718172457.GB8845@quark>
References: <20250712232329.818226-1-ebiggers@kernel.org>
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
In-Reply-To: <20250712232329.818226-1-ebiggers@kernel.org>

On Sat, Jul 12, 2025 at 04:22:51PM -0700, Eric Biggers wrote:
> For 6.17, I'd like to take patches 1-15 at the most.  Patches 16-26
> would be for later, and I'll probably resend them individually later for
> subsystem maintainers to take.

FYI, patches 1-15 have been in linux-next (via libcrypto-next) since
earlier this week, with no issues reported.  So I will include those in
6.17.  I'll resend patches 16-26 later for 6.18.

- Eric

