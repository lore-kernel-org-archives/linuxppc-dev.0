Return-Path: <linuxppc-dev+bounces-18047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB3FD065D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 08:50:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW4Fr1FV4z3cDh;
	Wed, 11 Mar 2026 19:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773219024;
	cv=none; b=DYQk9+ajw9ODKGrObK0yFi7aQ8CJxEa5jIigPj0JeMxQoA0mSI5jm59KhMK2Rwe1xerGvNpt70XbTbrKjY3r1TmCO+qlIYq6scDOkdM1FsM1ofQpil85aCMRI6zBO+nGsWRP2sluG5BL0sxDvGYUJCE44+2kiv93VoDbvXrTAMk2AeMXXtU3URfATouQz0PKDjRadKF8QSYfjzt//v6c5iAtTEsfN6jOmfvC6zXj5+bht+h3fTFVkTe1bJ/wGSXX5ua3FvHKy7EStuE5MjrSmHxSEbgb8XrEFtMo6aRDbPrxYH1TkE384qoIQqi7rIzzxqP1tZuFtFPhUrGPVZy4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773219024; c=relaxed/relaxed;
	bh=Dh2u910Dr9v3m0hVo537X6ofb5vKqJBESKL7gfq66iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKR8nWQvEpirQvdqh9kxVccpJNEF1U6KPDz605qd5jS2r10iWuz/PwW71d6dke3EIUnd8ruLIaLrFaZKm/kWANEZLJit980ekHPyD8sKh3PhnoaXDGzVrgdpXaw31Hi4pdEJqy7hGQA51JLIQFcyAjSz/TE0cm1LWavsttGXBVCG7iPBIOELGDrTbARZbexQQPv61Zz3t4eOeTh6J/PalPqjq+RZGqZppMGp3Q7Qeup0l48avfP/BEHeRExZLQ4VunieXUuYOM7u1HWz2uce88ZggPPLNVN82vFcGOH0/o9pA4idS0XhZgE3KKlDGUj3FTp2iWPYcU+F9utm4G6H2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=o4tcifl1; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LMTIauJ8; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=o4tcifl1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LMTIauJ8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW4Fq0R9gz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 19:50:23 +1100 (AEDT)
Date: Wed, 11 Mar 2026 09:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773219010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh2u910Dr9v3m0hVo537X6ofb5vKqJBESKL7gfq66iU=;
	b=o4tcifl1o8jywgLPdg/s+WX7sDPzz+eCAnhiMj3T66TG/Q1htV1GOGeOOud7SVVEX+GX92
	OVl1a0sAtFbXIhn6q8VAYV3nbRQ8ydhQIs0OB6MXRRv1VFkebNYQxNtC6ZpsNfMUc2HPJe
	my1FYPw0ldYH8kKSZm/D/y2nEimFEJIe4djKU6CH2C6et4c58of1WcZakycG05pAwk+5+R
	vRjsqZMlne+14maN+9VGVI5qg7hbBIk6aqyB10RpJcYkoRJbGh9dKeD1rxtrSKP3zP2jcK
	nzJWn+wPTcYCVcLlRx9uC67R6D4rj8jJI+lZcpjDoC0/26vEYJrmilrpcNilQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773219010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh2u910Dr9v3m0hVo537X6ofb5vKqJBESKL7gfq66iU=;
	b=LMTIauJ88fFcgqN/jXiJPCLOHnYrJyLVhh0TJD/NNsp9hdkMfEbyqHXmdDHdxxwf8KEeF3
	WVtUAKnV6l5hwHDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
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
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <20260311085008.TSnh3YR1@linutronix.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <20260311011218.GA212983@quark>
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
In-Reply-To: <20260311011218.GA212983@quark>

On 2026-03-10 18:12:18 [-0700], Eric Biggers wrote:
> > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> [...]
> 
> > +struct file_entry {
> > +	char *name;
> > +	unsigned int pos;
> > +	unsigned char hash[EVP_MAX_MD_SIZE];
> 
> Considering that the hash algorithm is fixed, EVP_MAX_MD_SIZE can be
> replaced with a tighter local definition:
> 
>     #define MAX_HASH_SIZE 32
> 
> > +static struct file_entry *fh_list;
> > +static size_t num_files;
> > +
> > +struct leaf_hash {
> > +	unsigned char hash[EVP_MAX_MD_SIZE];
> > +};
> > +
> > +struct mtree {
> > +	struct leaf_hash **l;
> > +	unsigned int *entries;
> > +	unsigned int levels;
> > +};
> 
> 'struct leaf_hash' is confusing because it's actually used for the
> hashes of internal nodes, not leaf nodes.

You could still consider the internal nodes as leafs.

> Maybe rename it to 'struct hash' and use it for both the hashes and leaf
> nodes and internal nodes.
> 
> Also, clearer naming would improve readability, e.g.:
> 
>     struct merkle_tree {
>             struct hash **level_hashes;
>             unsigned int level_size;
>             unsigned int num_levels;
>     };

but this could improve it, indeed.

> > +	hash_evp = EVP_get_digestbyname("sha256");
> 
> EVP_sha256()

I would suggest to use EVP_MD_fetch() instead.

> > +	hash_size = EVP_MD_get_size(hash_evp);
> 
> The old name 'EVP_MD_size()' would have wider compatibility.

EVP_MD_fetch() and EVP_MD_get_size() are openssl 3.0.0+ and nothing
below 3.0.0 is considered supported (while 3.0.0 is EOL 07 Sep 2026).

Sebastian

