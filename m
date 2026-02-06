Return-Path: <linuxppc-dev+bounces-16663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B3EB28F1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:56:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6nxY5mTxz30BR;
	Fri, 06 Feb 2026 19:56:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770368161;
	cv=none; b=F8TUkRJJf8VrenlQHeFvAwW2yy02ryqNqTycEiueqRBFdz5s2u7ChAgIO7WeD6HByhzD6BCQ0wPlhbM6NHCV/6Ij0I3rN2cWIWhzldtAJEWasGB2ccY0pHL2NRYOVXShpYU48RYGmSsBD7jY+8/OLFDClv+1IwaDbZUJUBqquC5JsKx1CNpex+zDFVbXaDrajGGkzXeC2MZowQxy/nIzGEfkYq5QX3InI1wNfMipS4YuClkt4MdJlzNWsT91dGqt7ahdOnQR5N5QZSXd4Lg/rDWt4sapWLa0PD9l52cYcf3BZw/nlahzvGtUylay3LeD0kWs1nlJoIjv5UeXg5eM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770368161; c=relaxed/relaxed;
	bh=jelIi3hGsj+4c04iErzkYD9GT0Uen4BiJWApuWXcVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMIQCBSyud/ofQCM7N/2MnEGlRhYm69MxyiqhTX4QARDOb/O7ZcmmIsWt79BSiWHHXPo0f9t7AHWKvFvJnVOVWOvksb9EI97uilNJtKyGSDBNbPL9tvNo6cYERSMj5xOV5z7K7STQwlG+Llz7tbkVkC1TJPDN02w2l+xZxbuHARVrfaaw0xDhp6JeNyqGf5hv3hvjkNiLNaJXxD3I9UBUFTw0M9NUsWOTMPKVZWZONeYzSS+263dddHaiFmazZ5YfP3seDVUS7JLxUOP/ZfMhF69eBsvwavCuv5BVfG3kolmvHybrJQ70LX8LU00ardshp7ubWmjVm7va939KU2LbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CU+cP+w0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CU+cP+w0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6nxY07WYz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:56:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 700C940A47;
	Fri,  6 Feb 2026 08:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB60C116C6;
	Fri,  6 Feb 2026 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368159;
	bh=TUSlCOhrAtGm3RFLHWsHhAz5xYWCAH3aTOWbzoQrEko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU+cP+w07aDAn1kC18HiM/LUIeZUCnNuHh0PfQQjZjmj3J0A4fhIhk05I3vcnbasd
	 rNcR+4z2piSJJtZzQRuZKltlh8lIbnQDc7tx+z9+Pj8QKcCl3Y/gKJpBnusjZdTBvW
	 7QUz3JlqWwj040I5c4Nyw23/DajuxfO/OQltgGyNxuUWczbwHSMYQGS3vSw+BHPIqm
	 nm2McVRUpJg5wNG2K/L9kZx0wix2DyCr04JIcSh0FtTKv9YYnTDOAYOHxfUNaYnb32
	 O3K3fvUKrO75FiWXaYvRFpf++ADHPckHazTjaBAIpUzhBH3CkXh8NkSnmWvBZYJZ+/
	 ebMCmVyMQHjgA==
Date: Fri, 6 Feb 2026 09:55:50 +0100
From: Nicolas Schier <nsc@kernel.org>
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
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <aYWsllH6SIl4Yik4@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
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
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <aYWmkEzjvo9RrzI9@levanger>
 <8fd4914d-5cff-4030-822c-98c8e76d0e60@t-8ch.de>
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
In-Reply-To: <8fd4914d-5cff-4030-822c-98c8e76d0e60@t-8ch.de>

On Fri, Feb 06, 2026 at 09:38:07AM +0100, Thomas Weißschuh wrote:
> On 2026-02-06 09:30:08+0100, Nicolas Schier wrote:
> > On Tue, Jan 13, 2026 at 01:28:49PM +0100, Thomas Weißschuh wrote:
> > > Switching the types will make some later changes cleaner.
> > > size_t is also the semantically correct type for this field.
> > > 
> > > As both 'size_t' and 'unsigned int' are always the same size, this
> > > should be risk-free.
> > 
> > include/uapi/asm-generic/posix_types.h states:
> > | * Most 32 bit architectures use "unsigned int" size_t,
> > | * and all 64 bit architectures use "unsigned long" size_t.
> > 
> > Is that statement wrong?  Or did I mix up the context?
> 
> That statement is correct. But as both 'unsigned int' and 'unsigned
> long' are 32-bit wide on 32-bit Linux platforms they are compatible.
> 
> 
> Thomas

sure, thanks!

Acked-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas

