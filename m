Return-Path: <linuxppc-dev+bounces-16689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE6EE20B5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 16:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f708P4bRwz2xqk;
	Sat, 07 Feb 2026 03:36:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770395765;
	cv=none; b=IwiL1Qc+7lZKflDBpUp+hcbTX8eAjH5ItgRQLNWLJqtZAouYAAyNjMElzHnOeqKH3EkSDMBz4y4j3cbbbr/OgA8qrvj7KZsCxfGgA/UMKZKxYjpuMWrhBq+Z3OOENe6oh8FSbrK7n1WMzCGYy59XlPfwiWI1Peo7kaYUYL+CZqLdGTEJU6R422seMVDhdsT1Q9WgWJYAffVYw8EfwFOfCM8ZXIT7CYAjjdkbGxq7aba26Aj4J3E6Ihyfv90sF8TepLLgfdqxhC7e1dWRKQ8BDdDwlYuytVwZry8bi1b1WE/h5WbUFRKwd6pTCEDzTT11TYwc3wxG3PzjyvnttGeetg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770395765; c=relaxed/relaxed;
	bh=KYHe8zfg/8AIpqNRWXh0NAdUyW2bdq8FFHapTrMjpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJsvIaUFExsK7Hf8lrIg09tYtPJx/13oN2OMs85VsQU0+/ERGJuripu90LlbNjcmOIuMugFDElrY0UlEdynqfxxSKlEZ+ApoqI3cxQak5gYW7Ye1bbCTlgvpqCzjqInQetL4bwMMWYn1EMzLSCs+4Tygf+rN7jsFbGY0pZk6U/T93AQp3IbbknDl/Tq4Lh8oT28dbB29V+JpQQOjqWqS8L2UWh/24f9+upSMKU0PjcssPJLSAcIovahztNt/dKwnM8NoC2a8Fvc9Q9Hk4BFaK2eAQ/wp7PvOG7yFG04I43SJVKG0tXa471H1gKB052dkSR2gUgIlvB4VKftX1zU9Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aDsgIDsa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aDsgIDsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f708N0Swvz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 03:36:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5AF51600CB;
	Fri,  6 Feb 2026 16:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E4C116C6;
	Fri,  6 Feb 2026 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395761;
	bh=M4LNx0DUKPh1lCUDhYpFJhkU46B2yI/gi1E3DmfXGKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDsgIDsarGZ6CZYnVZ742HWw/UIsFuqAOaRqB0voEN9pV+AbKPAHl7YijT9amMocs
	 bROAGjI0SCIUSloIS2GzitUKBBOMInPZp0iSXVRUlpOCPjkxr3ZJCh+loUqveSph62
	 pCXqgt9EIwX/ncrkE32V3IGLIQgAAkmt0tfuixgk+93AMSfxxJT2sb2COyD3E4W4T6
	 FTYZgLSWp48OYJZwkHE7sjja+Ja1Do0pdZR9g90V6sL0WQ93lMvx+zSkJYYFndOmSe
	 lb+du3KThhJWnzFsgptfpcwhQt2Yj0UzbtXEVW2AA7eHdq5TPSUjBIRW0XypskauCt
	 KMDwaZElWn/cA==
Date: Fri, 6 Feb 2026 17:28:31 +0100
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
Subject: Re: [PATCH v4 06/17] kbuild: add stamp file for vmlinux BTF data
Message-ID: <aYYWr41jImi3byr8@levanger>
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
 <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
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
In-Reply-To: <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:50PM +0100, Thomas Weiﬂschuh wrote:
> The upcoming module hashes functionality will build the modules in
> between the generation of the BTF data and the final link of vmlinux.
> Having a dependency from the modules on vmlinux would make this
> impossible as it would mean having a cyclic dependency.
> Break this cyclic dependency by introducing a new target.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.modfinal | 4 ++--
>  scripts/link-vmlinux.sh   | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

