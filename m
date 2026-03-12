Return-Path: <linuxppc-dev+bounces-18154-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D1106ACED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:55:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fX0JJ3jGFz3cGK;
	Fri, 13 Mar 2026 07:55:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773348944;
	cv=none; b=O0ExZUh6XlvPL3JBOeWGdCB7zYTL9CJyqNOCFuZ/Xgz1m1BWBirU5HXODayH06r1xCsPYvtCoiWYvFEPYThGjBSvOnLX0ZE6khPXZgjyRhQ8mQ2AyhLmzy9bl95Hi6MnvAzxH82Km0zO4fh2VH7qpCiyGwfwUfbo3hQ2Tyrd4geWcDA7SsekHagj0JrMJWbEvxkSB0W3ikjw+SkN/4Ss6x+z1/UA69RGbfUAnpAQMqG4l87tkhhcb3tWpqavTkOFDrBBdgEPkpcspMvygSMl42uZpR5b5+NernUMwuHfHmQJrSSu6Iv+vwo3rnQuGXehcdZllKi3mSSZ6UsFaeNo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773348944; c=relaxed/relaxed;
	bh=Vxy92FPcqB/cEElO/n2ajzBLyY5Pl47bPcz9N0H3xSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXKYxObLrz2OvLKY5E5q/VRWK/03Jzf1fQrAHeu3CPT6IWdlxB5HD16HESLJaT41md7YyyQCIoORVfm9HHgg2sGOeXUAtJG5/xpyhCqkHyPr0R/HKFY/2PJHfsL3sKOTNfirj9MJfYlFxVqQELu3VoBwhiGWR01PnX+k/80JKBSQ4hA5yczSEa6b24V0nPVwI4D+sY+3/2sLFQjmuWb6YsBP7xA65OPcTHxALgyOIGzj42lsN3cob8b9jpQ+BgGVsi9zP+U/9Xk/N4kguWCi6iO4yUz9YLFCutR/crzqc+MNN0qmguWCCrP842fBU58NJF5Z/LDZbVvz7cWFSPcE2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jPrZEGSB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jPrZEGSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fX0JH3vpLz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 07:55:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BA82761334;
	Thu, 12 Mar 2026 20:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB758C4CEF7;
	Thu, 12 Mar 2026 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348940;
	bh=v7Mp7oQuSeeAnOPIaJpcQ06wzPNoyTHncHKVCUFHvZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPrZEGSBi1TQR0t3km00WpEMYTejgQIVQOjE077ht7cWB1pkJRLriLLy7Jjd5Kerz
	 zF+VvIJYLQbTm0nSWzEM/kqqohL3jJQs/qv6MCXKVMRHXi9DKgZYofma5Hzt2KrtFr
	 LR9+Pe0bGHixbeU3D8vgl8LYkd1EypoBTAR1U/yFO6oI+U84EE2D4fltW4APa3K1+5
	 cze6ejEVN8VlLmzwMZySmLHlYPwt3/KtqDYQ10Ylk1r+aGFvg9mPnJPPWWmdDM5mF1
	 B4m5h+JdU/9liZubVMb3aVD+i3ThdUcK6dvL4WIylaTenx7wGKZs4CmHTvYNCoZU1f
	 VBSPEbfslo2XA==
Date: Thu, 12 Mar 2026 13:55:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
Message-ID: <20260312205533.GC2747807@ax162>
References: <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
 <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>

On Thu, Mar 12, 2026 at 12:07:41PM -0400, Mimi Zohar wrote:
> I pushed out the patch to next-integrity, but am a bit concerned about the
> definition:
> 
> +config HAVE_ARCH_GET_SECUREBOOT
> +       def_bool EFI
> +

What is concerning about the definition with regards to s390?

> Has anyone actually tested this patch on s390, not just compiled it?  If so, I'd
> appreciate a tested-by tag.

It would be good to test (if it is possible to test in QEMU, I am happy
to attempt to do so). As far as I can tell, 31a6a07eefeb placed
arch_get_secureboot() in such a way that the __weak definition would be
used when CONFIG_KEXEC_FILE was disabled, even though ipl_secure_flag
should always be available, which this patch avoids.

Cheers,
Nathan

