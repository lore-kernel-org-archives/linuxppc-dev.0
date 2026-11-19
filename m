Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D2606A333
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSxT9huh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVKky0Y9Gz2xMt;
	Thu, 19 Nov 2026 11:55:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795049722;
	cv=none; b=YNj/qaEQqfQl7u6XClDczwpToQ2QuetCgbmb1NnEeNhfavUlGejImoYQjzDcT5I2gISlDVmqisZfzG+hcWkU6DS7lbW0yoJvB2T/F3p+KEJyoGf2fNuZWbmmddYfc036n/KbrieGllQDJxywM+O7DGSE2/RLXnk7jYw0ADI8Mk59W7rAts4sPUc7azs/HXYlcHew2yKZF3gWXAalSS3eYTrZobFMtbEMVr8CSI0aYQIf5k9vW882Ets6ThVJnwP2hQqkPPBky8PkflA3LgvykIt2XOMRvj6Re91HpyIRoXBAg3wc9APO7fzXACdbnyBmOuu2TRY0RtrG/KWA/GxGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795049722; c=relaxed/relaxed;
	bh=25HxFNVSbdwyEfeQT/v/hb2lKg9U17dcPsjF33ZXCwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0xYGXfGCdIBvwz6Kl59NJKsiIK39ao/UVRzmLXLeIRkPLYlv7qYBmFEGM7Dyw3pJQgXP/0FblGieS8yCTKcqizsz7lNvTgzA05sbyR+tEfjw3fLXVa2mZp/4Zp6IS002xeVcH86BNSkfOlEXQ1kIkKjYoKNv8G9sUwK+aNlZKXbQkbIfebPh9Q2LrILMG1Zx/JfCa/nLWhSApEeBmiHYG/iwvmYxGFPXL4E/CnJyKPjLqb2pbRuV6er1aDz0vgwnOsiKuIXsNAATkgoalfr7tg2f+H4dyfxUzAL+dhvVcB/OCMrh+fda6CDrr1465QydQwPXgclG1j9KXGvtcF5HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSxT9huh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSxT9huh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVKkw6cyGz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:55:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 48042642B3;
	Thu, 19 Nov 2026 00:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6BD871F000C6;
	Thu, 19 Nov 2026 00:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795049718;
	bh=25HxFNVSbdwyEfeQT/v/hb2lKg9U17dcPsjF33ZXCwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSxT9huhMwIVOvdxA1oFUsA4Z3PU2/6QKN1JtOI9ZSJErZpgzNWfQOcPlKak7TIE4
	 tm+0xSyBkBRfpn8XMWTzqp6KgUlDMmSl0HEHE90q5hwkySZIy9ns74+aW5YDlu9QwV
	 vwcxJUfaAxhlXZj0yYWSuZ8ZbfS2AK6rkE6AUIW0ogLTDSl9WRU2XQN9k6nL4Fy8mv
	 C4L9LtEdTSU97TB4VEGpS/gI+hAGPUHp3DtgSFei2y7DITtIFMXh2ymqvxfleCFenG
	 HZgKoVAwIiKWIq+u3tkkkmJxz6F1QUKEAxNhZ+GdXSpvRLONSfa7LYlJ4B0KvBgLyc
	 SaJhYffuT9SzQ==
Date: Thu, 19 Nov 2026 02:55:14 +0200
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
Subject: Re: [RFC PATCH 9/9] KEYS: keycrypt: Add the aes256-gcm-stream
 algorithm
Message-ID: <av5I8lhExyKvf9w_@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141257.627441-1-giometti@enneenne.com>
 <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
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
In-Reply-To: <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 07:25:09PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 9:12 AM, Rodolfo Giometti wrote:
> > This patch is a proposal on its own: nothing before it needs it, so it
> > can be discussed, or left out, apart from the rest.

If there is no one who needs this, this is literally throwing a dice
with Claude.

> > 
> > aes256-cbc does not authenticate what it decrypts, and a file or a
> > transfer longer than one call cannot be sealed with a single AES-GCM
> > invocation without buffering all of it, nor decrypted without
> > releasing plaintext before its tag is checked.
> > 
> > Add aes256-gcm-stream: the STREAM construction (Hoang, Reyhanitabar,
> > Rogaway, Vizar) over AES-256-GCM. A message is split into segments
> > of up to 64 KiB, each sealed with its own tag under a subkey derived
> > with HKDF-SHA256 from the key and a 16-byte salt drawn at
> > KEYCTL_CRYPT_OPEN; the nonce carries the segment's position and a
> > last-segment flag, and the counter lives in the kernel, so segments
> > can be neither reordered nor dropped from the end unnoticed. The
> > segments go through a new ioctl, KEYCRYPT_IOC_SEGMENT, and
> > KEYCRYPT_IOC_FINAL reports a stream whose last segment never came.
> > A tee or hsm backend draws the salt and keeps the counter in its
> > secure side; the sw and optee backends implement it.
> 
> Please use Cobblestone-128 or Cobblestone-256 instead.
> https://c2sp.org/chunked-encryption has the spec, and you can check
> against the implementation in pyca/cryptography or (for Cobblestone-128)
> the Go package filippo.io/cobblestone.  This assumes your CPU has AES
> and GCM instructions; if not, you should see about using one that does
> or work with a cryptographer to standardize an alternative that doesn't
> need them.
> 
> Nonstandard constructions like this one are to be avoided.

The wider problem in crypto without a use case there is nothing
to protect.

> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)


Br, Jarkko

