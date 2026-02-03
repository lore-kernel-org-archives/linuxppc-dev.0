Return-Path: <linuxppc-dev+bounces-16552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD794E87824
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 12:59:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f53TR2Dwvz30Sv;
	Tue, 03 Feb 2026 23:59:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770123547;
	cv=none; b=RhuavIeJyCVhJ+nbeXuuZDC2ZXSW6zhCdaqSQDY6sdWwLXN16r5pFAWNUd0Sk/g+dE5+vJrABLdMr+q9V79GKQ0rXqy11HPwkM4GgbEKo61q72eSpe1V3KpWdEUNZDyMGD1VIRg6m0h/rntIfFxfTPux2wmBcxHA3neBhY3/aKgR9TxUh+PCnGXmwPSB2h6CdmUXn6yjAxgJg+m8Jrhprk6Zxt1lGJv/mPYPwxfowyUisr5mscxP+qE2HQ1ZU4YxWxD2Gd/IxH8X0cfU3MWQkuxUtIzuuOGjTOpFkYDkWe7HkQzHuSnEkWHnY6/wkiXd1Xf0rm6T80Z5HR2eVCrjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770123547; c=relaxed/relaxed;
	bh=f7WbDf6ppBGZw1zGUTqtisKIQ3OECv7udSRxwXjOPuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nuk501/8NLLwcqzbpjHFP0K/whetOIZt/5fjr2RHLVaMvVwcBq8g3mXYeTVrhEyTW7/kaPFkHnBhiAFkyHtnl3HHHShPV+sXRdVopyCTILvAUBS/r2vVMYI//3buibp3P8/F5MjDLMgJZpbgGiUc5nkbY/8ZMr3CbIhEgCSLmAMy0Dk1jDPR2F1bi/XB1O5d9QcAiSvU6gOv1E+nRz4I7oyE8WJHs69vhXGGnnzpKTvarbO2/SGbhdTaM8ELXzOECKXU4jYEq6PvnmFRk5GaCH2iOL+6sGr/CLS4AIZdTGHOtYVtWkFitDNsyZroOVL77ckRJK/9d5nU/8K2J0yiqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SPdtsnUd; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SPdtsnUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f53TQ2bJPz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 23:59:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770123542;
	bh=6LS/kA+onmwNe8A7Ynby1iar5OwBoPJ8XKnL5twRNZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPdtsnUdSSGeLAvpGs66Yc7fwhPORRh9r7ctAvysXw3f//3u70CJ0gLtNJWuXJQC9
	 7MAnhu/JI34H1H6OHyalZvy4k5hxQXNQ1m/yLoFxdGWEao2ummshchk8d8wnhmjVOu
	 e+aM1OBp2myV2ypeuFFm6aPHmRqcdO/MCSevgV0o=
Date: Tue, 3 Feb 2026 13:59:02 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <633ddd60-edbf-4072-932e-2d67d2173edd@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>
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
In-Reply-To: <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>

On 2026-02-03 13:19:20+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> > 
> > The goal is to reach bit-for-bit reproducibility. Excluding certain
> > parts of the build output from the reproducibility analysis would be
> > error-prone and force each downstream consumer to introduce new tooling.
> > 
> > Introduce a new mechanism to ensure only well-known modules are loaded
> > by embedding a merkle tree root of all modules built as part of the full
> > kernel build into vmlinux.
> > 
> > Non-builtin modules can be validated as before through signatures.
> > 
> > Normally the .ko module files depend on a fully built vmlinux to be
> > available for modpost validation and BTF generation. With
> > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > to build a merkle tree. This introduces a dependency cycle which is
> > impossible to satisfy. Work around this by building the modules during
> > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > but before the final module hashes are
> > 
> > The PKCS7 format which is used for regular module signatures can not
> > represent Merkle proofs, so a new kind of module signature is
> > introduced. As this signature type is only ever used for builtin
> > modules, no compatibility issues can arise.
> 
> Nit: The description uses the term "builtin modules" in a misleading
> way. Typically, "builtin modules" refers to modules that are linked
> directly into vmlinux. However, this text uses the term to refer to
> loadable modules that are built together with the main kernel image,
> which is something different.

Agreed. I'll go through everything again, to consistently use "in-tree".

(...)

> > +
> > +	while (fgets(line, PATH_MAX, in)) {
> > +		struct file_entry *entry;
> > +
> > +		fh_list = xreallocarray(fh_list, num_files + 1, sizeof(*fh_list));
> 
> It might be useful to not reallocate this array for each file, although
> I don't immediately see that it contributes any significant time to the
> runtime.

The libc implementation should optimize this internally to not actually
grow one elemet at a time. I'd like to keep this as-is.

(...)

Ack to everything else.

