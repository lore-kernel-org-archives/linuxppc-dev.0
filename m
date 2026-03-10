Return-Path: <linuxppc-dev+bounces-17981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92459EB105F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 21:12:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVmmC06QCz2xS2;
	Wed, 11 Mar 2026 08:12:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773177130;
	cv=none; b=IJM6+xkrVnanlESgyKBclDtQ2cnfGMTjX5J+mtWlyIq0I5UNTGi5oRa/NNC6hwiuIAMvSIGgRtd+eFmQ5PNdWbULSN/KaNTKVmfqIATXmgp2EVOqVdmVL/BcypZ53k6hwhf8GpqVGfYrgILQ84AamSOdYYaiMRwurTZjPpvcThxbMcLtyWQJ6SdbObYcAimzHYCDDuW6Lgs0OAuin6O5ilcxdwnQegDeLAg8fg2U9bWMFxN1rpoMBKS0r5Cs0WFZPLwg7mgo/Ll+KDX7z8Ytx1YH7/IbZJBC5OwKbODH4+m6OLTqkf8PkhcGCZ+EczjPDFWV8tKoSJ8ky/NhDLPqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773177130; c=relaxed/relaxed;
	bh=YsDVJ8dFRdgcxjICkMLHhtu9JvSW9KKHFNiwVpkgqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNInwpnXm96Qz4HyEK89+IDrwSkyyT9kNcGWPw6SfFc9YxAY7CznJAuMlgawNu8wWTzam3A2wv3nYYnzrcOna7u0aYoy/sLYS+FP2ruXHL5W7jqPcTKzGL9kKdsyv8lRt8pzP+NyOJiqEViYAxdcwrAWx0SXVhfo4kup4W+pznaw/1Z2c6uiejdUXLYT4slGdzw+fZfaDzWtQcDOIP7XHM2h+0Z1g/OY7wMFo7KKsz0nfhQpYNjutfUqcuQPfXMLrEegDuya/pc6dWosiTnik+OFz6Atp6EyUoa9M+JRTl8PI4Ur9Fe53eqTqnGhByU21V2c4Vy8MreLNQKiAwSBjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7fKUptr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R7fKUptr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVmmB31Jzz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:12:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D85DF43EB1;
	Tue, 10 Mar 2026 21:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE8FC19423;
	Tue, 10 Mar 2026 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177128;
	bh=I0hRXA8vzphZyPkmaTEi2UnR4I9riSViZx4ZP8KHRbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7fKUptrVOBNk+lqoq2TGcmqzyyjfveB/G4PfGYInXiYCctySVHzOBa/UUoB33G61
	 MmJGLpJ+mo49MHhJD6aD1XApq+fSFdW/dHzoHTjOMiz6fetsczx/N6BP3wKmhjYRuT
	 drpMGbJM9ukEMtNJyyFHtTD1ePlkUiafmvvtZN8JT6pAdwRYXD3+cTaqX/42GtCJ1E
	 MMafX+lc4Ql0IAOp4t5FyN5fUaWaw2pCHhQjKDELAQ8Pik3Iut0hg+Bx85zMaVSQmQ
	 vMGEHIo5jDcg8mMPiODtqCIvJhPlv0kMQVWgJKmRw9pF1k6OP3TUMj8/1LakJ/MrPO
	 UqlCpZx+AHtog==
Date: Tue, 10 Mar 2026 14:12:05 -0700
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
Subject: Re: [PATCH v4 04/17] module: Make mod_verify_sig() static
Message-ID: <20260310211205.GC120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-4-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-4-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:48PM +0100, Thomas Weiﬂschuh wrote:
> It is not used outside of signing.c.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/module/internal.h | 1 -
>  kernel/module/signing.c  | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

