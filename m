Return-Path: <linuxppc-dev+bounces-16496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03B1E65298
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Feb 2026 16:22:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f3w526WNXz2xqL;
	Mon, 02 Feb 2026 03:22:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769962950;
	cv=none; b=FyMo+MyWQ4HIBZLMuXng5AO4kVgWM4cvY+msWemxkbidzHOYnPQgKCShUTQXU+tTlzxVJ5tYEuVgQ9D0VH4gASKJRvQ0/X8kKPOUpns+/2f9NCjyC6+3LbHk1u6BkhEHpbL00eFAH0fetZEItYmLRaprsbTblXcdF1YaWzTfxxI6PdP2b2aTo1xwmerfkImzgpne95j2Ed6fAvTXwGGa1wR5sge8dnR/x5eIBSLsxHxUcu+LFsQCHAHs81u18yaBmg7FT60CyQ0AGgZXS/tcTMx9h3C2UarV0LxWCXfwgN/MsH6S8990c9UQ5pgOIfyOiZ6Owk9hgR8IDitv5hT9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769962950; c=relaxed/relaxed;
	bh=Ekq1Oa0kOuIGGpmbH0KxUoKo4PNldrHeMX6YIdXEy9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSBauda4RdDABsfwAKqTKM9zKoh3y+jTFlGjr1miJfko9qfprBLh5hBHXdgddbNJ8iYP1jNr4rvFjHhFAH4ENNk/RZIWH154RnDw7I3fvDoBtty2gO9gRh95uinT62ngKB2y74DbzaoZysFFB01bGZAUX+EmykZuLXkdBwwueoN3NcgAEVi7+qbNE6GSYE1t4pq9u1bHqs9G6LutdOyjSMTx15sL35BoojIdsyLCOlnmVAZmqNZgbj/FZGd2g9FzF7bVgWHeJpVV5MlpkxwcAgqxOHyhUwkmPXS5Cqm6ZLx+DvW3UfHxTQ+LHtyAd1UZ1OXWQwnEgDLqI2zcg1skA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=bEfjssX6; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=bEfjssX6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f3w504l2Jz2xgX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2026 03:22:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1769962934;
	bh=xlStmTRMhWVPt3fGtyXwEEDK5QLc9ZLigiHpsUvTOrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEfjssX6nVvGGJYCjRv1Hgum2HvUXJPGA7CgYPlDg4pNFEnfuqh6BJNVd4xzoEnb/
	 ZMmAJGEOHpCghTNwc5ybR5xqiScFWUgOJvwITdq0n0q7Kv6pPqNjU99FoLxmpQ1ILY
	 /UCNvFIurX5sZ1rKb2ccqszu5PRz2lLOVB+DzJaQ=
Date: Sun, 1 Feb 2026 17:22:12 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mihai-Drosi =?utf-8?B?Q8OianU=?= <mcaju95@gmail.com>
Cc: arnd@arndb.de, arnout@bzzt.net, atomlin@atomlin.com, 
	bigeasy@linutronix.de, chleroy@kernel.org, christian@heusel.eu, corbet@lwn.net, 
	coxu@redhat.com, da.gomez@kernel.org, da.gomez@samsung.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, f.gruenbichler@proxmox.com, 
	jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	maddy@linux.ibm.com, mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au, 
	nathan@kernel.org, naveen@kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr, 
	nicolas.schier@linux.dev, npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com, 
	petr.pavlu@suse.com, roberto.sassu@huawei.com, samitolvanen@google.com, 
	serge@hallyn.com, xiujianfeng@huawei.com, zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Message-ID: <1ff0f085-fe89-48b4-bae3-559777a56a0d@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260131073636.65494-1-mcaju95@gmail.com>
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
In-Reply-To: <20260131073636.65494-1-mcaju95@gmail.com>

Hi Mihai-Drosi,

thanks for taking an interest into these patches!

On 2026-01-31 09:36:36+0200, Mihai-Drosi Câju wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> I think there is a middle ground where the module signing key is generated
> using a key derivation function that has as an input a deterministic value
> on the build host, such as /etc/machine-id . The problem with this approach
> is that only hosts knowing the value will be able to reproduce the build.

The goal is to make the distro kernel packages rebuildable by the
general public. Any involvement of secret values will break this goal.

> Maybe this is a solution to NixOS secret management? Introduce minimal
> impurity as a cryptographic seed and derive the rest of the secrets using
> something like Argon2(seed, key_uuid).

I am not familiar with NixOS and its secret management.
This patchset serves a wider audience.

> There might be another approach to code integrity rather than step-by-step
> reproducibility. One may exploit the very cryptographic primitives that make
> reproducibility hard to ensure that reproducibility is most  likely valid.
> 
> For example, the module signing issue, the build host publishes four artifacts:
> * The source-code
> * The compiled and signed binary
> * The build environment
> * Its public key
> 
> Now, we don't need to sign with the private key to know that building the source
> code using the specific build environment and signing the result with the private
> key will result in the claimed binary. We can just compile and verify with the
> public key.

This could work if the goal is only to verify the reproducibility of a
single, signed-en-bloc artifact. But we also need to handle vmlinux which
contains the corresponding public key. It would need different handling.
We can add some special logic to strip that public key before
comparision. But then vmlinux might be compressed or wrapped in some
other format. Another whole collection of special logic.

(...)


Thomas

