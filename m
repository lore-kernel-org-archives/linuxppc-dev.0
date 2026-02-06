Return-Path: <linuxppc-dev+bounces-16656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45870EB28EC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:34:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6nSX5yY8z2xqk;
	Fri, 06 Feb 2026 19:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770366860;
	cv=none; b=Nevh09mrsBabLRI3mpqe38aJ8SRlv+qAsq29YADcoUraIOR6B5qZKGPibxIVfSrmRcpjaixXrhkP3ZlJIpX2J2TPFPXqq/LKQEqZkqkb2iMO7r/b86D7dSj+TKcIh89DhbCGxaBMyb+Sk7WaVt6efETVQCCXL4TukqMFGbGGZPZWIvcMrTWG8SPl66Hi1XuRn6DxhwuebxYMFtLGYKO0VaXJ2ShRvYbKiIalhx+MneA2y3KflaaezpRNZB6aZXz3UjgRWWXIqpk2caVPVRrXT5auzfHd9xWbq3+ETqEteaYEP734mlk2vS9veQSicFZbcS2a0hrBjBTb2GzyTNjXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770366860; c=relaxed/relaxed;
	bh=sDjPgx7kg4Rf6xcwAWH+MWf35L0rC+sR1a8ifeSDnBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgizhTDC4fDyMzbyuzusGT98HJKQqjk/buoKMnUiPL326Aot+/QvfT3mrxIgsEh6CvmxSozCDTbRBF/gf9Duwwt43dCX/LWFvjvCAodgYnZmRHfjGJbwSVSdv7FYz4oRV99391vhyBCAThiAsq/Qdwfdf1nra4DVnqjdYOD/JvJgcIctrhd+hyDobKrqZ0ITA6LC5k2lXRqsyno+DcEw2JjdvKo/Bco3fj8ZZXbssEWNNqoYD4cay0eNQf0dbiGX1GDtIxhvo73mhOkPjPqe6jX1S+h5SYuJ1a4PTdobmB5WVjFY/pA8pmYRNq0vBDbvcH8fVJ2iOlRHQNAlsyw3/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=EgAqSTaj; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=EgAqSTaj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6nSV6mHpz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:34:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770366852;
	bh=N6gVERObGhB15T0VBTmv5xARCwqXVSRXY8MFd6Z+hoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgAqSTajdYeJFKCk0ywbXmuECt0fZYvujzSTRvhETEtx3/f+KtVBNsuJfW6iUHO95
	 xDBk/bqTf7KMMjXf17G01CViU2TjvoF5hm7V0YQt4BUyrOOW+RHBazyoxvvFbIQVcl
	 KTCxEkR1IahrhDbJw5ftdTKxtSQZZkdA6ovkvFgk=
Date: Fri, 6 Feb 2026 09:34:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: David Howells <dhowells@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <1c30b3bc-8dba-4627-8a3e-db9fdbbce6ee@t-8ch.de>
References: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <2919071.1770365933@warthog.procyon.org.uk>
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
In-Reply-To: <2919071.1770365933@warthog.procyon.org.uk>

On 2026-02-06 08:18:53+0000, David Howells wrote:
> Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> > As both 'size_t' and 'unsigned int' are always the same size, this
> > should be risk-free.
> 
> Did you mean 'unsigned long'?

Indeed, I'll fix it for the next revision.


Thomas

