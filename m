Return-Path: <linuxppc-dev+bounces-17980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C2AEB105F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 21:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVmlh5yJHz2xS2;
	Wed, 11 Mar 2026 08:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773177104;
	cv=none; b=Q4WrOuCNjdKMn9hTJl/FzYvlK8Fe443uBk20D6/kact0O4jLLu4F46S08xJKVmBfMf/IUMAmBevt/EOz3YcboNF/Gk7ahBALrWN5lSfAXZa7OzIrTPyWG5/wrapcyKPj2ufMEmB9vwkw8wlWnO79YqMpX1petqsNdpQ8kvpoPO050FQo4fr49eO2f9Ghw/C7Pbb1Syadl0UxRVVfrFtPBaR2HIp91+3hqgt+ib+z2gWieR0KcQZOWbbI0lmQLa9P98I6GTYFuuPisYRciEefOkWeZ7xgysJU3L+5IHeAdjXR3puOKE8ATuwNRkrwaT9sPbiVvmgX+CuhsmiV9BeGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773177104; c=relaxed/relaxed;
	bh=owuYDc7AG+Kh4xNCH4PKrwnWjZ273VjWga84Lv/t2Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knqznvB8zgHWr64FCIBu7xWFBr6p2xQ50fgqBriMq13VUSBATY/1bNYv5tRxEvhSF8rIeszqq4wbxwT9ugZasWBjSBU7DpMvhkaJLnb5wqUrAzvCfzntzK8fZDRZ23/g8jn7qwbMOpWAoQ03sQ+CENuI/0KsYnoLMO1ITafMqr13Kj8Is6NOSLf9eRfGeO2Ive6LiLJ7shq0FTIqgqhIkedPBoF9y/GSw5Me468QG9cMBgPI5jzxJh6bBsCt1bx8Sel15h+CckgPie0utAaIgSfXZeqdTWmWmSEPQHaaqFvbioyvhLs9Yn/4T6gNMWzvdKLb4IcoCy/L/aPE0kQkyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VH0SHwW2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VH0SHwW2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVmlh1dkrz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 08:11:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 598544099A;
	Tue, 10 Mar 2026 21:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD220C19423;
	Tue, 10 Mar 2026 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177102;
	bh=u9D4qSIhsqbHAEaJC+KfjGBC0/+qWnDd2jVHhVc12Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH0SHwW2EakhuoAOlXnHVG/DOFMds3YD5l8iS+OsAyWWfAno1uHNcQOkOsZg89/vB
	 sz5gNWAqBUEneU4LKkjUrzRVARqs1112fvzBRDiOMYdvrEyNWjGXJ6Bvwdq/acoFSA
	 U6+LmcJGgJFC49mosiJc7sTvP3V+uiVO16/Txt+eHELFQICkwZm983kOdwv6Q1QWkP
	 y1OsGkdoUhwWPrrrb49qHzB2wtjJR3fPEyAnzxNnHFX3G+dAbwuLypQ1jQusvNgUwh
	 hDA7v1J8dkw8hcBMyAzbwpeQZyNRNVBZWNOw+MGNxQJA/oBWuskHTU40OJv/9zXKlJ
	 g19Oq0oWIxXSg==
Date: Tue, 10 Mar 2026 14:11:39 -0700
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
Subject: Re: [PATCH v4 03/17] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Message-ID: <20260310211139.GB120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-3-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-3-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:47PM +0100, Thomas Weiﬂschuh wrote:
> When configuration settings are disabled the guarded functions are
> defined as empty stubs, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the checks avoids some later churn.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  security/integrity/ima/ima_efi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

