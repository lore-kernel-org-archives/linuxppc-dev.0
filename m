Return-Path: <linuxppc-dev+bounces-16666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D4CEB28F8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:18:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6pR51HtFz2xqk;
	Fri, 06 Feb 2026 20:18:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770369489;
	cv=none; b=IHX+dxFo8WDzAwqQa4W0sPVh4vvLxyga8nDc1BbV0ci5xYfny7KgyBSiIx/mWisZHSphu4xRsGg83Z3WeipHAryUscAArdY3imGrwwXP9BcmWWhsazuvFJKqswOXyOq4BfsedlJFPRQOmO2yEkqukTUOMKdCjYATYC/xKSSPyQ3wqoBGkGwZIPGwMtLcw3ijoMzZO5MErRt5eCCOO697LUxjoBJSdriHFt+Ud1d8Qg1buPAmU4ZEGGqdalbWo2lmymfyHFMj08HKE7LlmvPJ4aHn3GT3BHk3J26mtlvZ8PfEvSOXxgo55AgB/cABD71i0+u6oh4aHzLHz+cNrkFSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770369489; c=relaxed/relaxed;
	bh=3F3dLJtVFY4IICp+/0ZLK1SF2Vgnl1mVdbUOWKv46n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw7SMrOiKvaMHe/n93Eu9CLQnHIkcG35yL9ruiEo68CHVo426K25y5m7ufTIqYh69R3lpjyFX5u27mC0mb/1gvnD/IC4sPuOeRBANjFAefAMI6+63fO/PWJ3jrmiZgweiyZw7TKYs+E/C2KoJDgs84aMAlhR6TkdS7MCIfgs6Drpxh6HuHutS4tj2xb3i7lqqdlPynaatQgyUtuFBiqFsjV6FhIFeftR964S1XpdS4WuuReTCPsvQDlLK8aQHnuJHtzyJSnD6QOn83GbfR7pUemCOfrbiX8ReAPOLmIOD7YTZ8Mic9kjuUxvmTWM7J7M3vJ/+UOAYy3Eit3YafFW+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=P8I512GQ; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=P8I512GQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6pR42CFvz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 20:18:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770369482;
	bh=3lh+T18IbYxtb3gtqLTD6cEKkxOYPIXP9FgcFXhcwNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8I512GQdTuSnyyG/lrd0tY92NCxg6hbOdKWE5uC9rEk0Af5xUuBzfxkYiQYnDT74
	 tZLXGVTtusLO1jNFYwYOYKJdJtCfChhFdJR7MQR+p9C9W/0oAljzpiG/Pc1bKJ4KRG
	 +L7bhP0R6enz+BHXvbGpLSUPi81SWL48atg2FHZc=
Date: Fri, 6 Feb 2026 10:18:02 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
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
	Aaron Tomlin <atomlin@atomlin.com>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <08d258a3-1710-4d2f-815d-3d16a3dc928b@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <ffdafd21-fe7a-44a2-86ec-0e0c2ad4238c@kernel.org>
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
In-Reply-To: <ffdafd21-fe7a-44a2-86ec-0e0c2ad4238c@kernel.org>

On 2026-02-06 10:09:12+0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 13/01/2026 à 13:28, Thomas Weißschuh a écrit :
> > Switching the types will make some later changes cleaner.
> > size_t is also the semantically correct type for this field.
> > 
> > As both 'size_t' and 'unsigned int' are always the same size, this
> > should be risk-free.

> Are you sure ?

As mentioned before by David [0], this should have been 'unsigned long'
instead of 'unsigned int'. Which is also what the diff shows.

> Some architectures have size_t as 'unsigned int', some have 'unsigned long',
> some have 'unsigned long long'

(...)

[0] https://lore.kernel.org/lkml/2919071.1770365933@warthog.procyon.org.uk/

