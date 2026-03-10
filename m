Return-Path: <linuxppc-dev+bounces-17979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071B3FD4F34
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 21:11:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVml6156Nz2xS2;
	Wed, 11 Mar 2026 08:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773177074;
	cv=none; b=Jx5qCRopb4qHS1PLeauXm1E9+op4MIO6A9uhI9CldsnNHY2qPnSCRuVbiV78/3CdzVvtQAUk2HAQOEYrdBvKF2oQYN1e7gL4JrU9KRvP5te7Gpnz8lAnyizMAEU+GGmyM8yXQNVAFFu07EjQFezBz2EV7AL69OWY8miwSeyrCckt9PfdCFoPl38OAi8oN9eFN/Djhs+iA50KxPisk8F6rnjvNgfLU0GW6w5eY2Tc9Xol6cMhFOYfZF6qmTzh8Um/7dzYNaQ1QxdpFOL7HUHZdEQerUAOFtGZO6ZCVdxUx921RLhBbPprfRxuuFSi+eL67SNuzB+zpTC9hMjU67My+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773177074; c=relaxed/relaxed;
	bh=WEKVAfhHTxG2gBcCoFejyDidq95HG9ecWnahHjYaJNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpoJuOcSBaongp13syb80hNGln2BJUP3bx91L6cNtpqFc5BIVpWT9QP/vXmNIMd/iPhvDyCTfQr09vEXeRdtFjF0xQwxMQ4AVAmuO905zQIHVsWVaTxAJJHyTyibj1SHKrrUOUQ/QZFN4RhhO2dour5NdK7z3wC4QvsyQNRPMgbapLIDT/OYng9nxtRcFnbcbvMGkDBLN8gOZBKukgPzrm5GM1xZaro0YzrduhVoWnf9oNZzg2oTcc/ZeQsENYJSw/baZjpqXo29UrPy1TI1nJzneLrVWeQwfLrCBSM6xCLjb+9tI8KYS/nTp3Lsv3gQ7PRoBxU4no4XuinsIwE3wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dFYD1ByL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dFYD1ByL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVml51xfRz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:11:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EEC860054;
	Tue, 10 Mar 2026 21:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E792DC19423;
	Tue, 10 Mar 2026 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177069;
	bh=yyzdGp+0sPRPTiABz81aZRloIPxSgjyHr2YQUr/A+N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFYD1ByLLsnPqMH8HvpxcPSYDZmiTMH9uIgAC5+zFHLZxBhpolkrX+vcWCFVr8dmj
	 29js3lSD3EP6jNZyT+AW/TyMOyiweLB8zLOj+u1rKJO+Yk5G4k4INqFDRribqkQwYG
	 PU5Sqe0GLid9VxVNNxx6J7CXuJfFQ3+3PM3bfGXpngtw1jEkAz3zyt3foM96dA+4PA
	 gNPBVPESP3sZ2w5NQjwiuGdGIuRenZrAmo8N1lZ2ElCPuIwn9/4e2+Fy9uJ3qTwYGb
	 FUBKESjL6+R7Ljy++ot4ShKUaVNg5AnAT+CWS1XDngm6viJftDOM2Y43c8qq4sW242
	 w6uDBPIYTGkYQ==
Date: Tue, 10 Mar 2026 14:11:06 -0700
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
Subject: Re: [PATCH v4 02/17] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
Message-ID: <20260310211106.GA120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:46PM +0100, Thomas Weiﬂschuh wrote:
> When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
> as an empty stub, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the check avoids some later churn.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  arch/powerpc/kernel/ima_arch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

