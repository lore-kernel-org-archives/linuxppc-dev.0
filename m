Return-Path: <linuxppc-dev+bounces-17984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21207FD88C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 22:06:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVnyd1VyYz2xZK;
	Wed, 11 Mar 2026 09:06:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773180377;
	cv=none; b=Lf+vPYc2dIIGlGCvEdVZd+p8DxZtVUrV9p9mHCYWAANlAwUMExDxNWXbNu7lkCvPMgFi8L0ogBQPlNzgJ7L/P1z/Kb8Yz05Ij9qSrxOtMQIOcK8RyBdBAI1ScQi5lk8wD1/TyxTk1j70m/NymahsQBd7eB7ZlPQsCj+wZubmCMb+3u0bYFwqHhG0y0cp3s69ibRCINPOdIVn2TJAZeHKIUFOzMGt+7YI/oBXHlVB7EdAy6zHCNAJbKflblSG7sYqfeuQrQ20ZZsFmeLmp/MnrTqqBz/nxP4U6Rhy4KUrERuib3IyooC9XAh3QMQ8dvvA8qLrODN7Sp8IjJM2XtRCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773180377; c=relaxed/relaxed;
	bh=d5zUlKZcI58cDAmfLQJhGLb2FQvK8CqI8lxmoJER0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etk6TQRJa5VF7Kz4xmvdBwyylhQhEM5MVy38DNyCilUrrjYy/Hs9a44LtapuPqmzC9ussIxbgSFSY3pDP+UvGWgXF5zHJ16zm0NeTzL91GwlWfwT5GyXI0guulczVSddR6xaldLbDi1NAVep2HkU2h6nbIUh9HiIJbEZhNu68FeZk2lR4v8t3JLSKQ1sro3MEcCqO/BnhHpYYDmtJIlU7XAd2cjXgiK70gbvhLcBYzQfm1kJwIVM+RaurzT0ad7WfLfwv5A1ac7vRflCxO1N4jHTDuvB9DMgg+pQvluMUB9rhWIeXceB897lfKf9ZTI5M2RbM78RCntDJTiAo7eAQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=niMNHIJg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=niMNHIJg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVnyc49bgz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 09:06:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 622E660054;
	Tue, 10 Mar 2026 22:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FEEC19423;
	Tue, 10 Mar 2026 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773180374;
	bh=Z2giByPPRkEFQ5qLqYmDyLPdv5AowAZxy5PkqD3GqNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niMNHIJgC+Fz1U3WEaHZP1AZ6A6ndoOiIOXNnbFOQJsdOYzSy3crlWDdkLKjeR5b2
	 XvH4lmIKveB2sp9jzY5WkaDtkmeDQejcg4IoTi7DNKUO4WaucUDLPOcBnVCGS1QaHH
	 ICRtc+Db7OW7Hf/vBq/22p+5js/WsiX+rFyr51i3UUtyH2VXaO0tDFHxTHghJbweVK
	 i+CrRjzWn8CB8fcmxJoA7FgucAgGM6YYIdwLcXufx7WeQLdm6py7P49e5bjDU/9vu1
	 /yJPj/0yLUiv46KoZXKcBlDm0/zuidupWpweJ0iRXBwOexeMyAnrcoUyEaC0VC8aoU
	 LxihD60Qr2aPA==
Date: Tue, 10 Mar 2026 15:06:11 -0700
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
Subject: Re: [PATCH v4 10/17] module: Move integrity checks into dedicated
 function
Message-ID: <20260310220611.GF120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-10-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-10-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:54PM +0100, Thomas Weißschuh wrote:
> +static int module_integrity_check(struct load_info *info, int flags)
> +{
> +	int err = 0;
> +
> +	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +		err = module_sig_check(info, flags);
> +
> +	return err;
> +}

Maybe module_authenticity_check()?  The purpose is authenticity, not
merely integrity.

- Eric

