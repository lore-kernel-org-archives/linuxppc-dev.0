Return-Path: <linuxppc-dev+bounces-16550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB22E87821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 12:44:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f538B6zChz30Sv;
	Tue, 03 Feb 2026 23:44:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770122650;
	cv=none; b=KksZfJ8NdhFgmmy4ayqLX/6oTCMGYP4xKLwV9uFVvllu0E3PhBek9Pl2J+12q3glscuSi4230Q12CfWakF9J9PGTlay+orZjjCSIu1c0dS1zlE5gQilLRyqXCjLrISHJLEEae7bD0KdWPQlz0kF5Vo49P014QEJqLH5my4hwkQsE5MLv8+KvDH5BMz06scFBkwSIrAv3/9OXccYyku6oWkUY3byWW1k8UJ6vteI81rARjsSqlqBfzoz4+JXsRQ/AC5J0JWfEUALEX7qp/nulsJPYavPysmCkziXJp5HOuwNlrwQtvkkOM0vhK0Nw6cpvm65OO7VIolSzVIOJUbzBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770122650; c=relaxed/relaxed;
	bh=RA+12AgdHQ2c0mALL3E63gSEBxQMJO52jgNasY+io6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqcaLNDFCJOGzJdEBWoyxlh7crdkh6PmyHcvI/BCTNvL6yuv+WN+CXfE8LbqQaeneBr933dkxAQKWlJas/vcmvRY8NqAgxB067jkDE1QU0qeYB8GoOGGI2SekLDQ4FJphH+eifNwA+BaDC3kGEKIX1NdgJdYT5GzywK5pX9oIPYKSmV9tsPk85AP2yYkxDAtRhFqNJhXST8GRn+NF0/RitmwVJWSSLJclE0RB/Okm6xkgWJSk7VgtBljC7x4gWy6BHH3ZaNReiVtmLYOQXTw8tWVZYv2BG5DV/L4M7Vdl2YoH+rTwtwqC4Ee9kqATS+9A3v7FV1Nd4SIZjpIK8AwzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SMXk7Zio; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SMXk7Zio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f538B1sMYz309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 23:44:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770122645;
	bh=4xMbDkPtYFnbhn8oi8ogQM7HDBoaOGhwFfB7e0t3td4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMXk7Ziop93PtXgUUPvFJrwX+tZphLJn717cY967EJ+dn5c3ytK5Jd3akdSlt7smz
	 LjQYDD5nu7+lEc/AI7bKfPM9nyLwM7tXiMSSwvKs2nPopR1BLCJ2Cgd771dfO3qck8
	 4K58p7AUrndd8U19BhXdA2hDQ2k+wJyqNngf+7xI=
Date: Tue, 3 Feb 2026 13:44:05 +0100
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
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
Message-ID: <8d399298-88a6-4c89-a0ed-fed0268b6493@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
 <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
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
In-Reply-To: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>

On 2026-01-29 15:44:31+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> > This needs to be handled by callers differently than PKCS7 signatures.
> > 
> > Report the signature type to the caller and let them verify it.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > [...]
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d65bc300a78c..2a28a0ece809 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
> >  {
> >  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> >  				       MODULE_INIT_IGNORE_VERMAGIC);
> > +	enum pkey_id_type sig_type;
> >  	size_t sig_len;
> >  	const u8 *sig;
> >  	int err = 0;
> >  
> >  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> >  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> > -				    &sig_len, &sig, "module");
> > +				    &sig_type, &sig_len, &sig, "module");
> >  		if (err)
> >  			return err;
> >  	}
> >  
> > -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> > +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
> >  		err = module_sig_check(info, sig, sig_len);
> > +	} else {
> > +		pr_err("module: not signed with expected PKCS#7 message\n");
> > +		err = -ENOPKG;
> > +	}
> 
> The new else branch means that if the user chooses not to configure any
> module integrity policy, they will no longer be able to load any
> modules. I think this entire if-else part should be moved under the
> IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
> patch #12.

Ack.

