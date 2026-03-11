Return-Path: <linuxppc-dev+bounces-18080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB4103E2E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 21:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWNmc3Q3Sz2xTh;
	Thu, 12 Mar 2026 08:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773263680;
	cv=none; b=kjAw6BHXt9ONto9VJVqU8NbHEz+X+pShmuBXfsGKzSTxlV4Zz+T9FmtUMhofxCCk2l+UraRwGUSBrR7fzw6r2hi+Yk8UY7z4o0C/2nCJuSEG5NZiu3wIAwO1qhDniwXc7ftqsJbLDeSJEAqIO/UQk4531Yx9IIh7NlGraSPgbcQTchfjt2/yBKzDcdwGE3dIz4jR1hfvwJHkytCpcbbRYRtXBSKjCgkZRjAjExSqurfLxRyANNTfi4bInrHCE4NccOLww0UPLM+HJWTdmHbgAUTYwwmt4kJnKuFTWMdNMMSiDJgl0FIVnox+OAVyRgv+zgEkxMeuy0LAFwzz+sz5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773263680; c=relaxed/relaxed;
	bh=6olQe5Znja+kHj66m/qnC2ILJgRuydjqp+R7FkQCPAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7ndrcE3hJqvdNmQztxuSrHz+AQ0eQtNsiHmIVHIc9spECa8Kt7dpbGAPoQ3cbsKvQ0fujWY2yzPzpsM25z48ObD3nA5YQCEOShddvw5Nomvc7XMeswwrj9N8DpTvkEKlMF+O7Cg0irve8NhbpRxbRN1jLtu2VhPVzMhCw6IYAxUhP5Brw6Kj3ZGVRX7yv1r07URA8+EGeHCQaseD94cnv4dRRH/VPpklC7I0Rln575wZm87Sc6uMfpTBW5Gaei62ToD28hCGrjNYK2ZEiQMixS69l+JBeijogdMrYs7Iudj6MxtIJ+WTlfjR/4+i0Zp5UfpAIFkdw4kaotqXUI4cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nB1ceOIT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nB1ceOIT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWNmb5Kncz2xSD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 08:14:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AFC940BB4;
	Wed, 11 Mar 2026 21:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB722C4CEF7;
	Wed, 11 Mar 2026 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773263677;
	bh=4AK1rqDz6/A4qjK/w9x6JibTYdqI2D5USa9Uljlor+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nB1ceOIToPCiG2Ga6fYFvAKYgRMq4rBLUcUJz61ILzyuOdXns1FvKE63ZPdgZQHZl
	 Sb4nNTfsbw0QQI5n6wXKZka0cIrk//AuTKoo0ISRoDGLOBcwr8YHsLLIUfXs3ewVur
	 Y//Sw9zR3uoc7l0O5LZdS/vroMKyuP4eog+uvpPQG9u86rx9FDtkb5kBULGBJiQpKA
	 ykMX0LdNVLH7xwVNGKzNvHSeT8rR69Tat3JUo29pWbE2YUJJsafK9N2xB5JCRpAIUo
	 okDFx5h1iJaRVeUidyBXYGIr+WO3tVsGNN7BB1kj1hqBJl5sHNlsdHbQV7Px/yDwRA
	 t4r5txKCfn75g==
Date: Wed, 11 Mar 2026 21:14:34 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311211434.GA4173404@google.com>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <20260311011218.GA212983@quark>
 <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>
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
In-Reply-To: <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>

On Wed, Mar 11, 2026 at 02:19:02PM +0100, Thomas Weißschuh wrote:
> > > diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> > > index a45ce3b24403..3b510651830d 100644
> > > --- a/include/linux/module_signature.h
> > > +++ b/include/linux/module_signature.h
> > > @@ -18,6 +18,7 @@ enum pkey_id_type {
> > >  	PKEY_ID_PGP,		/* OpenPGP generated key ID */
> > >  	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
> > >  	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
> > > +	PKEY_ID_MERKLE,		/* Merkle proof for modules */
> > 
> > I recommend making the hash algorithm explicit:
> > 
> >         PKEY_ID_MERKLE_SHA256,	/* SHA-256 merkle proof for modules */
> > 
> > While I wouldn't encourage the addition of another hash algorithm
> > (specifying one good algorithm for now is absolutely the right choice),
> > if someone ever does need to add another one, we'd want them to be
> > guided to simply introduce a new value of this enum rather than hack it
> > in some other way.
> 
> The idea here was that this will only ever be used for module built as
> part of the kernel build. So the actual implementation could change freely
> without affecting anything.
> 
> But I don't have hard feelings about it.

Ah, okay.  That's even better then: if someone adds another algorithm it
would simply be a kconfig option.

It seems 'struct module_signature' itself is intended to be a stable
ABI, though.  So I think there's an opportunity for confusion here.  It
might be worth leaving a note somewhere that the format of the
PKEY_ID_MERKLE portion of the struct does not need to be kept stable and
can freely change in each kernel build.

- Eric

