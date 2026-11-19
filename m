Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F831606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQv06nro
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVKsh07Q2z2y0B;
	Thu, 19 Nov 2026 12:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795050071;
	cv=none; b=EHtzWbpWfdcRhyklTic+BfItyd7BdSBL0Nmf9Q3F+5/TSVXskEucTKKhHtUqzAZ4LqTMddOoa714BB9DOh9cZg0jbtv6VnIm/gG2j9ouhWggbOabB6JOYHHvmXufOUmhPV+Tywm98iuNt42jsemty1kcAWrqpgmxDDFuRu1/KZByHL4341YB0NS+e4Za1C0XDayHaKrrH4OxplLuGP8HVkH0Ze5zlkRXoYbgtWG5YOzioBJs68Rxou3U+OlxER4icQJrF4wVWyoD2y0F+77x6q+Ub9FeVmSaeC3efOcnVVO8G8i3CdOoryqIqHE17Z67d0lMAxDB/uHQAHXg7sToOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795050071; c=relaxed/relaxed;
	bh=49NXjUTbzL4+xbJpcXKoJd4omTTJA3SheYrgPCgGq84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn3uUWx7QoWwMpUoiH82owulzkyZEx3e2vHM/kNuJ5E90HvMoJHf6+lZ4TM8xEWvY+rfhI+55OI7qsCQzxHvABDWyicuoxiDTY1Pmbq2vbsMzjd/Rlqo65YJnO3495UzLwOnsZTPJ9+J1RYeLKSKuaA5bRPDj9xD39h8/cQzoBnHcgnPYFgGGH7VL+tl1AUiuBvsWygZQS26qCGmxbaz91/w+HKKH1WaBHztL25wKph4/V4K9vHXyn2AhoLTtwKvxbp9zq6WSgh0I5i7izvEDVPN7iOGxRr9iU/4vxpUjfu1wgtUiPBl3sZbvI28kCg7iUqrZ/5/5OvpueQAhlL+LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQv06nro; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQv06nro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVKsg0vP5z2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 12:01:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id E578843726;
	Thu, 19 Nov 2026 01:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3E62E1F000C4;
	Thu, 19 Nov 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795050068;
	bh=49NXjUTbzL4+xbJpcXKoJd4omTTJA3SheYrgPCgGq84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQv06nrofbIqNARVVWh9JrAgHaEyRWKOud9QvOcchO4KY4ScIzXSqs80rNJ/ht3b1
	 Tsu7VMYrIh/2Fi+hRTl7qSSsKz4S7jM8ebpPVfo17lwtEFZMdAvwfZsxatV/ZsWAUp
	 PJgwsXqU+KqK3LvIcvOGucx9P9jANzCFHIamLnf4sC5rVp+bvnrP0sCUChwGa++Hwx
	 a7awEoAOqry4Xom2vSVycaB2NRS9vG06yCTtwmMYjMTvqtDoBc6hHSkU5Dk5pOb1Ih
	 GIaqltmVlM6m491tKp84gsZmgrtTNr8xvyupIzrYmeeJ//m5Bn5hJKwuAsDqwP+LxE
	 +hNKrozwFIXmA==
Date: Thu, 19 Nov 2026 03:01:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Richard Weinberger <richard@nod.at>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av5KUakRYdiaondn@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
 <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 07:43:37PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
> > On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
> >> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
> >>> This RFC proposes a key type, "keycrypt", whose material user space can
> >>> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256
> >>> and an authenticated AES-256-GCM stream, through a file descriptor that
> >>> KEYCTL_CRYPT_OPEN returns for one key and one operation.
> >>
> >> I haven't looked at the API, but from a cryptographic perspective,
> >> this encourages very poor practices.  AES-GCM even allows userspace
> >> to extract the secret authentication key.
> >>
> >> AES-256-CBC isn't a suitable mode on its own, unless it's combined
> >> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
> >> bound, so it should only be used 2^48 times with a single key unless
> >> the key is ephemeral.
> >>
> >> AES-GCM is not a suitable algorithm either.  If you allow encrypting
> >> with a key loaded from persistent storage, there is no way for the API
> >> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
> >> authentication key and allows forgeries.  Using random nonces isn't
> >> good enough either: NIST only allows 2^32 encryptions in this case,
> >> and the API can't enforce that limit.
> >>
> >> For long-term keys, all of the following are much safer choices.
> >> They have 192-bit nonces, which means that one can generate them
> >> at random for each encryption without any problems.
> >>
> >> - XAES-256-GCM
> >> - XChaCha20-Poly1305
> >> - AEGIS-256
> >>
> >> AES-GCM-SIV is also okay, provided that you are fine with occasionally
> >> leaking if two plaintexts are equal.  This happens whenever there is
> >> a nonce collision, so with probability 2^-32 after 2^32 encryptions.
> > 
> > The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
> > relationship between the keyrings API and a specific key type.
> > 
> > At hardware level I did not see any support for TPM, which narrows down
> > the potential user base.
> > 
> > The remaining potential user base is further reduced by those that use
> > trusted keys; leaving out those who need to solve the assumed problem
> > that only this patch set can presumebly sort out.
> > 
> > And we don't really know at this point that cut. This is pretty much
> > the break down of what is wrong here.
> > 
> > If there is/was a problem to sort out, it should be so constrained that
> > it should be as quick to describe as stepping over a nail really.
> > 
> > These are the main topics what I would focus on.
> 
> This whole patchset looks like a solution looking for a problem.
> 
> The usual solution to something like this is a userspace service
> like ssh-agent.  Then you can do whatever key management you want.
> That doesn't protect against root, but if someone can get root you
> have bigger problems.

This is true. Even if the code was like it is BUT it had a clear
motivation, I would likely suggest to the author how to resolve the
problem more properly.

I.e. bar is not too high in initial code quality but it is steep
from the get go in the "utility value".

> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)


Br, Jarkko

