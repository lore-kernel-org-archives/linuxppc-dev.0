Return-Path: <linuxppc-dev+bounces-18058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6211125806
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 13:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWBCv2Gx5z3cC9;
	Thu, 12 Mar 2026 00:19:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773235147;
	cv=none; b=eeOq1IyMrjNAl+PlzM/EnuZTAOeEyeuj3uD2Hlukcb6vr5Fep19VN1jL9NhNUCzdL3OKRC8l1gKdLiudwGcScpLby9wIeAfgWaihvfVotBeOadF/7aAiaDXWshVKAlW61uZ1spUF7Boyq1g1+e2ImBsoeXXWkvj1PobTkhEgoq6fY2LwfJXrYzMcdLsc5bhBYf4C6ECC8InjdJ/oPUDsqKQfFm1klvKr+EHILwRMOIh9Vnw1VQ3eVVSdda4pcIft8/4SwfdkbD5BEqf3YSfN/9m1drJQ2X0vaS+jtGWDYsRDq4d1QWUL1SrO0/jFyk3+dbvazUOw3bflKyvrI3+nGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773235147; c=relaxed/relaxed;
	bh=+SMjKaB3sSi5nScBoqEvttRN0u+goKS17vQ/BC5xWIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJen9nCMwLqZaOUmdgfv8oIfxjqxtxmVkDNydYFgG549jrXl843z0hj7Z+poLLH5ppE2pmyI4yS/yRq5rruFNhSzwNrmBMcIxO8f9Cd6mLXtvFC6B6dnVAe4SPIHCxTuRTqtgNeF93nXje5Q6hfRrxzRWRRLk86EZ7S3ebDoSd6Y6ubp6UKzzmm1SwRlwKyUc/lYSzuJxVgGiNhHsbTLcAa2UQOQzhsA5oKKJS1XS+afUi/7x2gkx3umvBKWwAYJYuu18mWrKkPCV2lee5bFMUIer3kuOxXvBm5rP8gb4GTcv9utknhGoNcZb5PfoFUWXPGw1oC8OCrBfCGwwfmMkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=HQsb0mto; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=HQsb0mto;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWBCt0Vs1z3cBW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 00:19:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773235142;
	bh=yORSnb4FKH66tX09G1qK8g0oY/Uo2rIpyvZkEjNDm84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQsb0mtoTbwEGco/L3lRbJ0WTajceIyEQmoKsZbs3ijP9DIl6uMUH7DyCJEKEf4Nm
	 owAHusHX0qnegQ4fOa4IysSRsA4AurPsIoJqlTnoeOwj3DxmUIvbEJueidEPMQxkvz
	 Uowp8NlWKsfgXCHMDcyu0Ko9Yx9jg/4i7nHbYH8o=
Date: Wed, 11 Mar 2026 14:19:02 +0100
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
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <5726fc65-7d24-4353-b341-81b785f2575c@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <20260311011218.GA212983@quark>
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
In-Reply-To: <20260311011218.GA212983@quark>

On 2026-03-10 18:12:18-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> I think this actually undersells the feature.

(...)

> So I think this is how module authentication should have been done
> originally, and I'm glad to see this is finally being fixed.

Thanks, that is nice to hear.

> > +struct module_hashes_proof {
> > +	__be32 pos;
> > +	u8 hash_sigs[][MODULE_HASHES_HASH_SIZE];
> > +} __packed;
> 
> Is the choice of big endian for consistency with struct
> module_signature?  Little endian is the usual choice in new code.

Yes, it's for consistency. But I am fine with either way. Given that
this is essentially an internal ABI, we could always change it later.

> > diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> > index a45ce3b24403..3b510651830d 100644
> > --- a/include/linux/module_signature.h
> > +++ b/include/linux/module_signature.h
> > @@ -18,6 +18,7 @@ enum pkey_id_type {
> >  	PKEY_ID_PGP,		/* OpenPGP generated key ID */
> >  	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
> >  	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
> > +	PKEY_ID_MERKLE,		/* Merkle proof for modules */
> 
> I recommend making the hash algorithm explicit:
> 
>         PKEY_ID_MERKLE_SHA256,	/* SHA-256 merkle proof for modules */
> 
> While I wouldn't encourage the addition of another hash algorithm
> (specifying one good algorithm for now is absolutely the right choice),
> if someone ever does need to add another one, we'd want them to be
> guided to simply introduce a new value of this enum rather than hack it
> in some other way.

The idea here was that this will only ever be used for module built as
part of the kernel build. So the actual implementation could change freely
without affecting anything.

But I don't have hard feelings about it.

> > +static void hash_entry(const void *left, const void *right, void *out)
> 
> Byte arrays should use u8 instead of void

Ack.

> > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> [...]
> 
> > +struct file_entry {
> > +	char *name;
> > +	unsigned int pos;
> > +	unsigned char hash[EVP_MAX_MD_SIZE];
> 
> Considering that the hash algorithm is fixed, EVP_MAX_MD_SIZE can be
> replaced with a tighter local definition:

Ack.

>     #define MAX_HASH_SIZE 32

IMO it shouldn't even mention 'MAX', as there is only one hash
algorithm.

(...)

> > +{
> > +	fprintf(stderr,
> > +		"Usage: scripts/modules-merkle-tree <root definition>\n");
> > +	exit(2);
> 
> This should show both parameters, <root hash> <new suffix>

Ack.

> But they probably should be flipped to put the output second.

Ack.

> Though, is <new suffix> needed at all?  It looks like it doesn't
> actually affect the output.

It will be required for compatibility with INSTALL_MOD_STRIP,
two patches later. I'll move this code into the later patch.

> > +	hash_evp = EVP_get_digestbyname("sha256");
> 
> EVP_sha256()

(...)

Ack to all other remarks.


Thomas

