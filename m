Return-Path: <linuxppc-dev+bounces-18057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E92B1062896
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:59:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW9nf0WZtz3cC9;
	Wed, 11 Mar 2026 23:59:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773233990;
	cv=none; b=AkB3OoSsc/gffGkGVjNBwix3Y6UIDaw9NdJQSVWwkyJfy4N2z20zoajkmi3r7l59Zrbe9MxU9MRsjX2CG4wbQk3hBMd6+4lPJelc3s0RM4dIn+KORiRGsJDMTK7lcE0hCL8V8CuqewEDlg7iWgvQuFPR55QCCi4lLGgnkKQ3OLGM6QnVRO4gI9xMF8Wvn+gMcP4O2k2ITde+matKBmViUzx3kfziPCuoW9taoCVGm2UBLJO7V/wNF5afqr/YJWWX2HxDaRwqLTEoX4MvLLZpdQdT/k56K/CiXiT5U3wPMw2eZidvqJIOI9JICJMbF+VUKsvfP2GueFOBVyJhV1NE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773233990; c=relaxed/relaxed;
	bh=bC0kY/4Na/XlNuC6qk5L4uZyWLWZIZvZpwIjsprH2kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ceo5PFrCSsfbd4pCek8kQv2iRlDedoSoSk6jGgOTNA5c0MOoPJMSbZGIB5Tz6R/pDGIB2GrqdC0UETXwgI7f4kvQ6SAbUzWtJRtkzzK+WbaB3pRwOJVMaQSMvavT3rkvCsRnKg/2EGTvGLjTOWnlgwQQ5XlAn03ythkuDKpbQQ0RL5DFqH2GKXMI8aXf8yXk+OoSc9JDVwAIdmCpK83kXoXeiH65sl5uupBivCel8cVsw3/PYrtOWz14SPeDaVKTh/iYHhcm6LadnaU1yp3in2Uwn2HcrDBfwvzZuThrPPwQtm6P0vc8CvSyRe2Z2shiNILDW9daWuKjFiVsSXeacQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=CEiZ87VU; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=CEiZ87VU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW9nd3DMkz3cBW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 23:59:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773233984;
	bh=6iMI2XFYcGmArDxHVD1cNM01BLfDHO/WY4pBP+fXMLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEiZ87VUhKkkjxvvSxzMolbjRXZkdgJY0Rzic3nGaTRS6rUPbCgJmnQ+/+MVDz77B
	 T0VB914Hs6kRIOMVG/+6qkbqwiEQ6Ju+JDASONipQYTCXd3FloBmK2xVggCqy7Xgzr
	 wkmrvsN0vaq/eTWXkiLVV77iXHXn2bYLd9icP6MQ=
Date: Wed, 11 Mar 2026 13:59:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH v4 09/17] module: Make module loading policy usable
 without MODULE_SIG
Message-ID: <2f702140-32cf-40aa-80fb-3650145a2adf@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-9-0b932db9b56b@weissschuh.net>
 <20260310220146.GE120274@quark>
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
In-Reply-To: <20260310220146.GE120274@quark>

On 2026-03-10 15:01:46-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:53PM +0100, Thomas Weißschuh wrote:
> > The loading policy functionality will also be used by the hash-based
> > module validation. Split it out from CONFIG_MODULE_SIG so it is usable
> > by both.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  include/linux/module.h  |  8 ++++----
> >  kernel/module/Kconfig   |  5 ++++-
> >  kernel/module/main.c    | 26 +++++++++++++++++++++++++-
> >  kernel/module/signing.c | 21 ---------------------
> >  4 files changed, 33 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index f288ca5cd95b..f9601cba47cd 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -444,7 +444,7 @@ struct module {
> >  	const u32 *gpl_crcs;
> >  	bool using_gplonly_symbols;
> >  
> > -#ifdef CONFIG_MODULE_SIG
> > +#ifdef CONFIG_MODULE_SIG_POLICY
> >  	/* Signature was verified. */
> >  	bool sig_ok;
> >  #endif
> [...]
> > +config MODULE_SIG_POLICY
> > +	def_bool MODULE_SIG
> 
> Maybe MODULE_AUTH_POLICY?  Hash-based module authentication does not use
> signatures.
> 
> This issue appears elsewhere in the code too.  There are lots of places
> that still refer to module signatures or "sigs", when really module
> authentication is meant.
> 
> I'm not sure how far you want to go with the renaming, but it's
> something to think about.  It's confusing to use the term "signature" to
> mean something that is not a signature.

Ack. "authentication" is much better, I'll use that.


Thomas

