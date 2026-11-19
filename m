Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17742606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNbMjuDh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVRBt5ck6z2xlk;
	Thu, 19 Nov 2026 16:01:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795064486;
	cv=none; b=eYF9DHgWK6dqTBNyQrZCs+J3mA1atLfJjoBv64n9zgq5qC+XaZJjmxte0Re5/W6LGL6ksVAmHaAIQswo3DnJdBT2IoAT+BiVO/z0eRFA0CFMmMrO8YbxqyEaWJvbX4NtsliqJQZs+ZeB/KOxGxV1QnK1KA8GjRVs8jFRiVVX2E+Wp/Rp6pk+WNqhzkwe84JhdCellD1Mh7c8Z4dDrLRP4vPm7Lyk6VmwINNqlx1kWnMtyFDRqvsz4BHS+KOiTSK/f1/8rg6qn29faaaFIxp08gTNNZN50vQ+ZRnxggXqmzGjYVFdwcqup5i9EVj6fYPhcichSc4QthvCi35NqwAIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795064486; c=relaxed/relaxed;
	bh=/3gTc3OhQhIgQt6McVDsUOMeCjJgyS505Y5yzx9cgOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb9LgBFekZMlSgluPsjSsdDzOgp1EeWwTllFNl+7rBoepqSlCjGM0NDtYmU/B9yPNDAsU/zK/pHrRziQOYwdio3mw1grq5rlwTAD3fgLhBoVguPcavljUNWegRd6frj/mKmOahJJk+NirfsYzPFbBDee0wV32soIZni8iLGVOX9Q9H71wGAu991DvSocUxntTPZTfRyyiA1iAMJBjkF2qo46XdUgxz/chjfXOkbfXk3x6DBPFUlNgcKy0basDHjSeJ32lwsgV+O9CfylTWnwo8mvWGKN8d8N0njLHwZntqhOsiCAQwoNDUY/zctxBP6hbX3QVjNxPsiHkm4w7TmWuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNbMjuDh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNbMjuDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVRBt0Sw5z2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 16:01:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 9123646747;
	Thu, 19 Nov 2026 05:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E97521F000C5;
	Thu, 19 Nov 2026 05:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795064483;
	bh=/3gTc3OhQhIgQt6McVDsUOMeCjJgyS505Y5yzx9cgOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RNbMjuDhiUDcZyHgp73D5m6ri7m8MwOWTKphR8qId5y/koRUl/2OZN2Idl4zlzkIl
	 dOdKI+XMl7YQs9/bk56L+9i4m6IWT8HLT3iF42eJHckjuMzfvc5rRZrWsHnwuM/ZHQ
	 YGbhJIDGZzqGlYZLisa2Ay9LO2FaNcUaL4BAX85XM1GxxqJsjGK4pFCETfjadu7E1x
	 dAkJnY5r5ucSljqiEj5wXHjD+WfEV9UhBw+ZTLRV3/DfEvMceLdVv/oc1zlA4dj1M5
	 y05y/wrthET2C0OByrOMJGoZFsx2wXuVRkQvWzAqvsik8xOg/dLOF3wagjWs8GbpU2
	 jyibVMmksmzEQ==
Date: Thu, 19 Nov 2026 07:01:20 +0200
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
Message-ID: <av6CoKFTzLN5Ftbq@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
 <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
 <01692969-8e92-4a08-bde9-aad86674504f@gmail.com>
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
In-Reply-To: <01692969-8e92-4a08-bde9-aad86674504f@gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:35:40PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 7:43 PM, Demi Marie Obenour wrote:
> > On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
> >> On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
> >>> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
> >>>> This RFC proposes a key type, "keycrypt", whose material user space can
> >>>> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256
> >>>> and an authenticated AES-256-GCM stream, through a file descriptor that
> >>>> KEYCTL_CRYPT_OPEN returns for one key and one operation.
> >>>
> >>> I haven't looked at the API, but from a cryptographic perspective,
> >>> this encourages very poor practices.  AES-GCM even allows userspace
> >>> to extract the secret authentication key.
> >>>
> >>> AES-256-CBC isn't a suitable mode on its own, unless it's combined
> >>> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
> >>> bound, so it should only be used 2^48 times with a single key unless
> >>> the key is ephemeral.
> >>>
> >>> AES-GCM is not a suitable algorithm either.  If you allow encrypting
> >>> with a key loaded from persistent storage, there is no way for the API
> >>> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
> >>> authentication key and allows forgeries.  Using random nonces isn't
> >>> good enough either: NIST only allows 2^32 encryptions in this case,
> >>> and the API can't enforce that limit.
> >>>
> >>> For long-term keys, all of the following are much safer choices.
> >>> They have 192-bit nonces, which means that one can generate them
> >>> at random for each encryption without any problems.
> >>>
> >>> - XAES-256-GCM
> >>> - XChaCha20-Poly1305
> >>> - AEGIS-256
> >>>
> >>> AES-GCM-SIV is also okay, provided that you are fine with occasionally
> >>> leaking if two plaintexts are equal.  This happens whenever there is
> >>> a nonce collision, so with probability 2^-32 after 2^32 encryptions.
> >>
> >> The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
> >> relationship between the keyrings API and a specific key type.
> >>
> >> At hardware level I did not see any support for TPM, which narrows down
> >> the potential user base.
> >>
> >> The remaining potential user base is further reduced by those that use
> >> trusted keys; leaving out those who need to solve the assumed problem
> >> that only this patch set can presumebly sort out.
> >>
> >> And we don't really know at this point that cut. This is pretty much
> >> the break down of what is wrong here.
> >>
> >> If there is/was a problem to sort out, it should be so constrained that
> >> it should be as quick to describe as stepping over a nail really.
> >>
> >> These are the main topics what I would focus on.
> > 
> > This whole patchset looks like a solution looking for a problem.
> > 
> > The usual solution to something like this is a userspace service
> > like ssh-agent.  Then you can do whatever key management you want.
> > That doesn't protect against root, but if someone can get root you
> > have bigger problems.
> 
> Also, if you need keys stored in hardware for some reason (compliance,
> time-limited exfiltration), you can use a userspace library or
> daemon that abstracts over whatever the hardware-specific API is.

Pro-bab-ly but I'm not a huge fan of generalization ;-) 

But when looking only at HSMs that is at least 99,999% true as they
appear as PKCS#11 providing smart cards with a possible prorietary API.
Other than generic smart card driver they ought not to require any
special kernel support.


> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)

Br, Jarkko



