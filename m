Return-Path: <linuxppc-dev+bounces-16527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A25E7DF0F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:47:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4bFw5Ddsz30BR;
	Tue, 03 Feb 2026 05:47:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770058052;
	cv=none; b=ciXKSZbR/ZZ/yxfaY+6+bGDgneV7ABBPbOT3knN7KmK2mxnuInLNtwgRwVaQMwFG2sG7PN5ERUg4ckGiUJUvi9xQL3HW1ogtKXwqulff2H8uaU35vV9vR05aQiQVKHT3bbmiWKOkaD3C7AHsJMLZrYCTy3bsjnsUOk1RcjAwcDK+zRNB5Dj8oVllVMG+gxgi/jyH5Izq8HvaWDRdogOAfb1ZswVj4LT5teqOKmxbnYSV081K5FjAQVqSOGgZ28cD/xVMLLjRxKjgcHsE0Y3uQEwox3ucZJNSzb8I4PB5h0ObqGUQdbBsk/kf2JS78BQUUXEr5nV80fGsH3VqgIoTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770058052; c=relaxed/relaxed;
	bh=Zp4groAgVFf8Z6FsyW78hGxMRu8WsOlzg3z3ubBRZRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz2xjI3TMKqoPrvQhipY8bv02haIQeB99dMOz8VN0Gbl/QsHhOuImrNgVUnyeOS1w5RX0vvMXXpllYr0hOwDfRrGE6Kz87T04RWeKqJw4Lay9KuZ4yOdlgB3qBjYo/aYBqhUPU4MwO5T7Zy3ySYQn9APnJqNJeSu1kMmFouUFX0BHQfRck7n5QMYVTr/ZqJ3JTriw4+7ogJM9Tqsh+CfjPVW9rit96HtynOkVMwaLKCzWjkgDKwL4s35mfV2rRmVaUb8G32t4/Z+NJljmZVum5TnlnHuSE5Bw91XK8iFpBC+jZ+xlQEHyObH7EeBmr8Cqaz3IbjHLx934cq9wHzECA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aCKhW3mX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aCKhW3mX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4bFv4CHYz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 05:47:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8915860010;
	Mon,  2 Feb 2026 18:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E1C116C6;
	Mon,  2 Feb 2026 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058049;
	bh=b1c9hVroKYW8OCGypKuuUgArjCJp8gAKeo9XoSbuZKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCKhW3mXh4GMY6S3gJZHpkUL/e079wkvIz4StZSSFnNiJpENS1vb009Nnw6/Gv1Ho
	 O7IqLvlFBUcPPaHmemphyl8g5x/Xu1vGyLhXz2xHPJYq43Akq6PHjLNgr+KJ5RZ3OB
	 jYfmikmo7u6XcZF1Y+aEaBpajLhG1o0HZca91/uZ12/t/3iGvhD3gTGbGV0Xpk4bzT
	 7PvlHHVPEAx2QjM9YwOHrva2imznODhL/DXbiUI1JtwPimcHJQbP4HucTvqJN5r3am
	 r+PSyekjnt8ryUK0OML++wPPKLWeKExnZA83OKQWgOm51T9t9rlSEUc/Xm3GptqwJC
	 CajFQV8Axm+mw==
Date: Mon, 2 Feb 2026 10:47:25 -0800
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
Message-ID: <20260202184725.GC2036@quark>
References: <20260202183055.GB2036@quark>
 <20260201201218.GA15755@quark>
 <20260131073636.65494-1-mcaju95@gmail.com>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2316630.1769965788@warthog.procyon.org.uk>
 <2339369.1770024079@warthog.procyon.org.uk>
 <2513499.1770057531@warthog.procyon.org.uk>
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
In-Reply-To: <2513499.1770057531@warthog.procyon.org.uk>

On Mon, Feb 02, 2026 at 06:38:51PM +0000, David Howells wrote:
> > Could you give more details on this use case and why it needs
> > signatures, as opposed to e.g. loading an additional Merkle tree root
> > into the kernel to add to the set of allowed modules?
> 
> Because we don't want to, for example, include all the nvidia drivers in our
> kernel SRPM.

That doesn't answer my question.  Are you trying to say these modules
need to be built later *and* signed using the original signing key?

- Eric

