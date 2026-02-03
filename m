Return-Path: <linuxppc-dev+bounces-16549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C052E87822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 12:42:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f536K0DB5z30Sv;
	Tue, 03 Feb 2026 23:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770122553;
	cv=none; b=RuuwlUvbasoUGWxoBDpb5ywbTUNjLfGDkOmwRIyudxs3Jb0SY70cSjn3lx1oH9GiEzKSbhIjyvXkIwWrlNOGu+lxpRK6zj0qYck956flNtDEUQg1q2vXSizOs5rKMYLr4cc4HZ/LLoP0s4n17JdZ0uAhHlg7CgHAaAm0rcufsoP3n0GxDSZzbnZUnyNEgtD9Lg6IuLfd0JZTgKJVSEMJATy5IO5C2FD0i/+IXHsTXSOqdO9cC84Ym/BW0sCLnyYtiSTislWkwd4YARA4TRuL7wyVCYKyRV3ul3G5UchrYW+MpfI12tUCL2rtnMVMNygUgUAYhBfFQyh20iiAYl35gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770122553; c=relaxed/relaxed;
	bh=irb6E8LSn2ChZallYiRh2EYB/H75YZYoYhTa9Bklsy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE35pWx/MtLyDOt7nyRiqT2Yarpv+Gc/orpKLrjE2kc3mutuVyOLFkTVTayqmkO5zqWyV8AIyINxvJin5PkUBbdDQyf++6DUDaU21y7+mLFR35HLxW540Tqh7qt0StWcQjHUwXgDM1TYT0tqxO5i6KLAd6dL4P0+NUH5wd3oyakNXnCqYlHO6AmNuaJQRh+u11l5zd536kK0/7Q2gg/oJygGs+9MSvTnLCSeXsqfL5oEPsXHjF7lcY/rLRlim+xmkWGdrkm9UXJPgo61rgl2gmqge9/j96TAk6RoW4SsWCLTakJP8F842xCUfd8C+OkBP+8FJgorO3X44bIFGog3Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=VaAFHhJc; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=VaAFHhJc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f536H6jGpz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 23:42:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770122547;
	bh=+vKlgAoMgxorO8wzZsSKLOlHjUax16wakp+NL76Z0jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaAFHhJc7RJThp3X+a8KljdNfBU40Qohg4ZbBihrSHkldtnS2mr7PIOYLFNNVh3m4
	 iwPDIMK7zHXuYYbgAnk2nZqfMp/Kc/PcVHebE1k/b71FBy78nAPYLadtFkiaM5Sf6e
	 bpmVJeSOu/HMoajP8WRx2JjXQW/CSQtzckT5P31U=
Date: Tue, 3 Feb 2026 13:42:26 +0100
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
Subject: Re: [PATCH v4 12/17] module: Move signature splitting up
Message-ID: <2d6b4a2e-b65a-4db2-aa92-2ad80d066516@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
 <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
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
In-Reply-To: <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>

On 2026-01-29 15:41:43+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > The signature splitting will also be used by CONFIG_MODULE_HASHES.
> > 
> > Move it up the callchain, so the result can be reused.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > [...]
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c09b25c0166a..d65bc300a78c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
> >  
> >  static int module_integrity_check(struct load_info *info, int flags)
> >  {
> > +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> > +				       MODULE_INIT_IGNORE_VERMAGIC);
> > +	size_t sig_len;
> > +	const u8 *sig;
> >  	int err = 0;
> >  
> > +	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> > +		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> > +				    &sig_len, &sig, "module");
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	if (IS_ENABLED(CONFIG_MODULE_SIG))
> > -		err = module_sig_check(info, flags);
> > +		err = module_sig_check(info, sig, sig_len);
> >  
> >  	if (err)
> >  		return err;
> 
> I suggest moving the IS_ENABLED(CONFIG_MODULE_SIG) block under the
> new IS_ENABLED(CONFIG_MODULE_SIG_POLICY) section. I realize that
> CONFIG_MODULE_SIG implies CONFIG_MODULE_SIG_POLICY, but I believe this
> change makes it more apparent that this it the case. Otherwise, one
> might for example wonder if sig_len in the module_sig_check() call can
> be undefined.
> 
> 	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> 		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> 				    &sig_len, &sig, "module");
> 		if (err)
> 			return err;
> 
> 		if (IS_ENABLED(CONFIG_MODULE_SIG))
> 			err = module_sig_check(info, sig, sig_len);
> 	}

Ack.

