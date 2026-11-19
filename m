Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C9606A330
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+plfSKN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVKLT0TJDz2xkr;
	Thu, 19 Nov 2026 11:37:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795048656;
	cv=none; b=ffse5hs2Dr3NaTZY0gyWkCN6Mxcz3srFKMPLGNl/o2Cgbz7ka4vyLLhF25d8d8p91h2/nII5UMPZ0hAbPAZigaTza8b+clT+qCqlJEBA/OQhstr2xcdXrK2+9KRzS2EiP84onHZt+SgJ+3vJ9Y9B2pr47a4AQIPkXeWR4LuT0tNtROL5yGJTCdFv8yRS6YaSVTSyiZ0Q1EwEPr6XXFrTondZSxZr0bIqIVJ+V26UOLicqC0E32cM2Gh3otwj907pHqkfkkf25tkkG/IQNNKEt/4CcoKE+DeHqh8D03Kv/I4F+dJLTvcSyLn1NOl4iVR7SgsXSkmOOLSvqSVHNRk5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795048656; c=relaxed/relaxed;
	bh=oAmABwcXXotQ3MKjKlI/9ynn2ibq7W7A2AvNHWEPewY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBrHv5jj0V5zkez3ui1C/VjG7QEQX92Pc3UZOq4B8jO4s6YNv+cqWGwV53kqmuVa/JI5bglRjuVPNZpneim9fljEq4+nMF243tts0WoqnECTNDASjvzrLUPN6jZ1tPWQ250QAdNQW8YZau95N1pniyCa7xRBq6189CwqJZn8VbThHkNKpTBDUrQEy2Xs827YPotKoOhAd2KtztcYzw3Owo701udaDBws/BYU//WXQQrhk8f3lji3kC3VX/Yb2MNgad6bi8JcfmknIB72c4LHCfCzbjjqm8m9ENiE9dXBrHmaPQFobo59NAHWCURcFI4OkRqI0o+ljku1wihnvblEGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+plfSKN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+plfSKN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVKLS0gtTz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:37:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id AE056644A0;
	Thu, 19 Nov 2026 00:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DBFE31F000C7;
	Thu, 19 Nov 2026 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048653;
	bh=oAmABwcXXotQ3MKjKlI/9ynn2ibq7W7A2AvNHWEPewY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h+plfSKN+NLklqzjVemtZ32v59otj6WZ+i5ZX7AJNaHRwkty60vwf5CANYwQxXadx
	 9grKaSXHcL88gyAjvmXj7Dxj3igtLg6VRA9BkS2Xz+sbkPiCJQ65NyUYXBfOPbFLaf
	 XdoVCRs1sK9pCYlYYliMAoWSNOquomqnVLl3/oQYKhVOXjNB/2YkLR+ZmUSK7vARM2
	 NrnppZL015i7TMfc06dS3AIYzWHi0I0F9oDGYTm5PYv5MbnqgOyCcmXq05dDZE4G/8
	 9EcXCPKRRhyeREJcSq+0h5D+bY7R62ppVpH/JRlvhOiY5Ob80r79UOhLIEBJXASLY8
	 Zf17RFO2AFGOw==
Date: Thu, 19 Nov 2026 02:37:29 +0200
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
Message-ID: <av5EyVHnNzT27dyK@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
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
In-Reply-To: <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
> > This RFC proposes a key type, "keycrypt", whose material user space can
> > use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256
> > and an authenticated AES-256-GCM stream, through a file descriptor that
> > KEYCTL_CRYPT_OPEN returns for one key and one operation.
> 
> I haven't looked at the API, but from a cryptographic perspective,
> this encourages very poor practices.  AES-GCM even allows userspace
> to extract the secret authentication key.
> 
> AES-256-CBC isn't a suitable mode on its own, unless it's combined
> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
> bound, so it should only be used 2^48 times with a single key unless
> the key is ephemeral.
> 
> AES-GCM is not a suitable algorithm either.  If you allow encrypting
> with a key loaded from persistent storage, there is no way for the API
> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
> authentication key and allows forgeries.  Using random nonces isn't
> good enough either: NIST only allows 2^32 encryptions in this case,
> and the API can't enforce that limit.
> 
> For long-term keys, all of the following are much safer choices.
> They have 192-bit nonces, which means that one can generate them
> at random for each encryption without any problems.
> 
> - XAES-256-GCM
> - XChaCha20-Poly1305
> - AEGIS-256
> 
> AES-GCM-SIV is also okay, provided that you are fine with occasionally
> leaking if two plaintexts are equal.  This happens whenever there is
> a nonce collision, so with probability 2^-32 after 2^32 encryptions.

The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
relationship between the keyrings API and a specific key type.

At hardware level I did not see any support for TPM, which narrows down
the potential user base.

The remaining potential user base is further reduced by those that use
trusted keys; leaving out those who need to solve the assumed problem
that only this patch set can presumebly sort out.

And we don't really know at this point that cut. This is pretty much
the break down of what is wrong here.

If there is/was a problem to sort out, it should be so constrained that
it should be as quick to describe as stepping over a nail really.

These are the main topics what I would focus on.

> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)

Br, Jarkko

