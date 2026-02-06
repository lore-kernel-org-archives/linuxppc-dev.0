Return-Path: <linuxppc-dev+bounces-16655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF64DEB28EC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:30:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6nNJ3kNQz2xqk;
	Fri, 06 Feb 2026 19:30:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770366640;
	cv=none; b=hApBzWu2mNyS5KhV6+/QevBi4H4D/zkUdU8CGH+Up+N700plX8ztTTtpqg9Cg4wZ1UPc8sTscZ2Q1OwUBAQQPM542NCRoQLDqYDnOmoMpKuGuvNqtZS0qc+FFYeeNLp2IVHKKpME5owCncT3e8ziw9J8maef1JNESAfIm1/Uxd9ToP20Zjz4KUEtMkf17UBj41rQqTWzm7j3M2M5DBCxpUdzMhCDGq10JqTyFDz29BnbvnEPMRcmWfZaEctNNGZvBjhzsrwnA6ieNikpX7HFYqu+xu56tTENRhJjDvMvm2wzM6RUQqQfML4othXhirgNK0I9tlHV32cnkvhepZ9B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770366640; c=relaxed/relaxed;
	bh=sdOTZioJuz3aMR6h3cXIsj2GPleXC8Oph453vxjWLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnOAVjV//2rgSB7CZJeeciHVT3r56kuNn8YxrLdkt04nhWQXNbtVnj29Qf3GDOgn1HwTmvTA4KBI/nhtLsGK6eNnYXslu+ei7wtTasZMhHg3tRVlMfWHRqX52b6oOUjatfJM6TPJChMxJwDnkKdMuxnCC4l3lbGnwGte8s77rl1JUzNnz+/+8Shtp9dobduqSNXiVBnFoW2XfpBkeRbigijw//n4k50sNsatMlXtM05qovErzdKzFvb+g0dfGwIMuUSOftgccTBPRX+VlmZ81tMtyNdM0eqetiXK6tFQU4kUCGha+Ww+kA6MNXlS6GjHEA6fzJpEVIDNT+udFGcd8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KbZxmDrr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KbZxmDrr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6nNH3qFCz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:30:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E9B1D42AC9;
	Fri,  6 Feb 2026 08:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487F2C116C6;
	Fri,  6 Feb 2026 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770366636;
	bh=CyWrZOJATVNS9+Rj5D0Boe5KDdvWmaNR5FdjGU15MAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbZxmDrrcakJ1Zbg86za3Nn9bxpJJasJZ16hyHVIpnfS1mGRcJ3jNdVJC+Jj19++i
	 PnqWZFYx52twIezwwpk0X6QS6xzo4JcNBncQACzeVxjyHXngXPgP3tIbbteQ/24IT9
	 hiiwZu6Dywo+w3kpTYZNBhw5+WZLY5UX7R/ohVMYzH1KHFl62weRoMxRPY3pR5QjVO
	 d5VSXMwhPOYk1nZJeUxwaJDqXNznFEJjahtBzWO4YYlcyvgUVDHJmKKgafFuD0pdIN
	 vbno5/RvKlSCcd79Gf4Z2Kqme2oRkRu8CzIQ5fv1QDygN6tvY3nONmqGvGHrUztUps
	 EmR0AXYyecAlg==
Date: Fri, 6 Feb 2026 09:30:08 +0100
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
Message-ID: <aYWmkEzjvo9RrzI9@levanger>
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
In-Reply-To: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
X-TUID: cnlOAPnJljc+

On Tue, Jan 13, 2026 at 01:28:49PM +0100, Thomas Weißschuh wrote:
> Switching the types will make some later changes cleaner.
> size_t is also the semantically correct type for this field.
> 
> As both 'size_t' and 'unsigned int' are always the same size, this
> should be risk-free.

include/uapi/asm-generic/posix_types.h states:
| * Most 32 bit architectures use "unsigned int" size_t,
| * and all 64 bit architectures use "unsigned long" size_t.

Is that statement wrong?  Or did I mix up the context?


Kind regards,
Nicolas

