Return-Path: <linuxppc-dev+bounces-16500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5D2E65298
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:12:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f41BK411zz2yGx;
	Mon, 02 Feb 2026 07:12:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769976745;
	cv=none; b=WVajBA94BDOxD/+lf2vMJ+q23W41YlGxbs9wf9/D9whhhvTqw0nALUJr+qHg6+v0znR5K2KL0x1BdDcnUc3sX1MhGcUvV32XtmMkPnpCk+ggmqN5cob7gL7oqt57ewDAEKN4ytC6q8bz51jFq52B1HksynhPSuu5tccZi6La0A8U8mhl4QKIwrXPnV2agLYxDCHAMSJYCqanik8oey8RaFxFs+AKDZAqju4tuVdSSGSaHFSwIoZHDUqF8v7joK0AwzvsMiDWV9dmXHFo+EZhtsoS/BVaFhxyvxvLczbixwtzpXcyNWgWztUHXjIYl/Q4a2wYb5y96awJGC1DG5STqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769976745; c=relaxed/relaxed;
	bh=n7UE7HJmKRFcTX7LjokAA9IEGfkzkEmFjPR0EbMgHfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SltdYpJKOmb4+X530aYbG5SzHb6NXLBShw4H7Wbt74MbJES/VDkYwt6thq8b3NpOpBK8O3VhvkHFNdi1sFd+1hVm4ugZZuZZ1G6NY9TTS61ukr/KIV47wvoPB8TshAL5Ai29Pm6A0jejaBRCltJezyO4EfGNFhgFFM1gD593HCi7OAEhohGk5nI4yt6l8ZHBYbvrtZGp5Ax4HemCmrFzfFrgPtTNx+kl/GT/7NzAfLNHprhQYzX7jopGrT+/03E4+GNq+b1YqhBzudgQvyv3ohHh60CQhoWTva3ffNABXGfXTtW6L3EKcA2FoCHVSgjuyY1HqFW8ULO+xWyjLuuibA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fIdRv4hA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fIdRv4hA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f41BJ1XPdz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2026 07:12:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 801A64385A;
	Sun,  1 Feb 2026 20:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C67C4CEF7;
	Sun,  1 Feb 2026 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769976741;
	bh=P4abRiJNT2o7A1KauWPFd1QUCJK6AwkuNkuWQv1rej0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIdRv4hA/DqSiqBclAtFK4XfUk/ksYnebA0yhghX5vLyndIRXaysGZ5MMbgL4vwkI
	 8QvBVSpULQqoJhdyvj1t+Bug4HEuYNCYZpbs71huOoJbBE+HauLZ7LOEuhZ05cJQV/
	 94Y42B9l4Ik8l7KwDFKgbh0MP9IX/WqJ6i2FNecab++SmyJy3Bh3nn+Acqzrq+Njoe
	 CsZ/nV1JY55rWf1JPQfvoOd6i0Xj135qyfTL+vl7JOttvuSTevqqFRtknPLvL8LLVJ
	 cQaAEOaE5VWFnmDFi97q9n93wpKJXVcB/h7Fay/vhGI+7dszWX9t1U+EoJG9mhwgBV
	 dAMVUoFltx0rw==
Date: Sun, 1 Feb 2026 12:12:18 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
	linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
	atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
	christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
	da.gomez@kernel.org, da.gomez@samsung.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	f.gruenbichler@proxmox.com, jmorris@namei.org, kpcyrd@archlinux.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
	mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
	nathan@kernel.org, naveen@kernel.org,
	nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
	npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
	petr.pavlu@suse.com, roberto.sassu@huawei.com,
	samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
	zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Message-ID: <20260201201218.GA15755@quark>
References: <20260131073636.65494-1-mcaju95@gmail.com>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2316630.1769965788@warthog.procyon.org.uk>
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
In-Reply-To: <2316630.1769965788@warthog.procyon.org.uk>

On Sun, Feb 01, 2026 at 05:09:48PM +0000, David Howells wrote:
> Mihai-Drosi Câju <mcaju95@gmail.com> wrote:
> 
> > > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> There is another issue too: If you have a static private key that you use to
> sign modules (and probably other things), someone will likely give you a GPL
> request to get it.
> 
> One advantage of using a transient key every build and deleting it after is
> that no one has the key.
> 
> One other thing to remember: security is *meant* to get in the way.  That's
> the whole point of it.
> 
> However, IANAL.
> 
> David

It sounds like hash-based module authentication is just better, then.
If the full set of authentic modules is known at kernel build time, then
signatures are unnecessary to verify their authenticity: a list of
hashes built into the kernel image is perfectly sufficient.

(This patchset actually gets a little fancy and makes it a Merkle tree
root.  But it could be simplified to just a list of hashes.)

With that being the case, why is there still effort being put into
adding more features to module signing?  I would think efforts should be
focused on hash-based module authentication, i.e. this patchset.

- Eric

