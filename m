Return-Path: <linuxppc-dev+bounces-16341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF08D35671
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 04:58:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f195f3YMpz2xT6;
	Wed, 28 Jan 2026 15:58:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769576310;
	cv=none; b=ZAb7/RAYe1nqls3AQoa4Jd3X/L6aHuFR8yyJ9bZCPSzS2IDT2vZc4aTFh2QcqeQnRgF3IYrQtpzO2QZDHlnQGiW0X40pbN/lt9U47NMHJIzRrtX+E0nkPmhTkbhNpP4emnd+Y7zVMHtyClAFy7/o0dFpmNmXpWk4dolZ9YneLl5ikK4k8r1foRxlx7sLha/OXnLvyCyGjCgrxxqBeA1kCxpl5F1bf6sCJOA22ThnvNJjuIxaphdu9bUDaLrtMxNQ0OZUfnLI8LlZ/NYhSsk7iUqYj28JRajj6wqroTo0XU3nY/O5zdO9IOIio1grSKIvN1Rat7a+rOiLpabrK11lYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769576310; c=relaxed/relaxed;
	bh=daXjtGTfmlVfqWEsV/tKRDwuwZG19vc4O33UsaVuyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKKZ0Z9+LtHXvoYz5fPYeqncr5mQT1V58iGtjVtl9OJY0anyxWregPD9eDZbh6r/UHTbERpCbJ26qEVib2Sg0k+iPlSFfKwLgrikLxJTz6kdbi3OGTIlsLbUsVXSvWou9da3Orhrsyw5sHxFEHLg9sDFlMCUfFX+pC4wFKrQfhp0TLQpAhmPwoiFdrx2VClLWp2UcWKtBRZ3ir9RpMgaGVVNGQsdEx3py6HC15rgBgcpujHv9LmGRffJrJdW2Vq2U+psmVJ5efNaJ/DLhAzJITyJVzT1glsaSlBgTVpxpZCZdqvFBmkcph2fcW6b+ND5HipnF9/l0sw03CJruax+CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=PKJoiaAI; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=PKJoiaAI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f195Z4T2rz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 15:58:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=daXjtGTfmlVfqWEsV/tKRDwuwZG19vc4O33UsaVuyC4=; b=PKJoiaAIeJUIezjpIUvwLfhLOU
	ljSMzyiy8niSruUOPj8Yhae/1tEMXXOfdDkBPWvk228fa+x3gT5ziOetsoIlPS6qPOcomc49/VYEg
	TXRw9lJUhkDbPABnmZAwnrgsKAmLUH7AQ4AnGZOBwiLlkTJITaGg5cRexxsqxsIPyy0pfvevgI10V
	EkVCPliHzrpbNBjpdQZtf8BtLMu9Kcsy7J4hQT6WtNuW7LYoAAzyuI/C3HY4Xp5Pm7lL1/zj5aQ3N
	KpLYJej9U/8afrfofjKQFQuivnbtyPIWzjnE64luVJY6SlrAo9HkNbF8Ew4ypXGp7RUjQj7TvDxC5
	7aSVGjaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vkxek-00000007aLd-3OJ0;
	Wed, 28 Jan 2026 04:59:54 +0000
Date: Wed, 28 Jan 2026 04:59:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260128045954.GS3183987@ZenIV>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
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
In-Reply-To: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 27, 2026 at 06:02:25PM -0800, Samuel Wu wrote:

> Thanks for the suggestion. I tried a few different setups, and now I'm
> fairly confident e5bf5ee26663 ("functionfs: fix the open/removal
> races") is the culprit. I did have to revert 6ca67378d0e7 ("convert
> functionfs") and c7747fafaba0 ("functionfs: switch to
> simple_remove_by_name()") to successfully build, but reverting only
> those two in isolation did not fix the issue.

Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
demonstrate that behaviour?

