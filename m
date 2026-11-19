Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8277606A325
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T543qXNW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVK4L4GQkz2xqh;
	Thu, 19 Nov 2026 11:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795047922;
	cv=none; b=NZMYTLNEEVPWmsN2sM+KMAlZ5wN44gEp6RnR5vBlVVcoJmB3bmaQCqQTSW82oxLP1kib0vII9gQWEbF9duanmjXLA2u7rdWclxdPNqzfFgNVU8vYK2gxhtwXf9uMQzhzsEF24ONttmLrIsh3or0r6+n+VWLaobKgk/HGTRXK+9Cw/mfIHG1cInQjNn5k1LOQxp+OFpjCAT80s8yYu7PWIAsPy93jQDdozMastDw7BxI7zvSNiiSGDCQf7buqQz0zskUedei0OELeTacfHiqwodC0bApD+t1jtic6+j6aeBHJvw2SE4ETBXnaPp64fkrf6VUHJ8VxaoXU2N945jBYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795047922; c=relaxed/relaxed;
	bh=rSVsA9fNi7kC5K1IDfWWLOQdUEB3auXl+KZsJESSywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vnq4yPG0d34dBx4wPmpLVXhVeYmhuRyR+2FIdquGCNIaKxS9Oq3NE2dZzkkJlhZ64mcaCuCQIGn7aA2ncluoI8syGrnMzhAn6v1q4Fb7xz3ZUahqBwYWuTsr8p0iY/v6Y2URk9j9AEjc8KUaqYn//dt9VOL4GmR0ELhc7T94zhwHK1DQ/pivmDjSQRUZ7DYOb0Ac/rhqx/kWlEMimNRq4IYk6TgnnL2p5xQ1GmSKv8r9WWyBDoMOHNRICxRIQmk4/IlmY76riXYqX4aqs9D8257ktpc78pe/fjz0YyRr5blWV9IN3e8pbLmuoGHJRcHPElG1KO1e9weHPFK3hzg01A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T543qXNW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=demiobenour@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T543qXNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=demiobenour@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVK4K1Hntz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:20 +1100 (AEDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-8b4cc793704so13665087b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047918; x=1795652718; darn=lists.ozlabs.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rSVsA9fNi7kC5K1IDfWWLOQdUEB3auXl+KZsJESSywY=;
        b=T543qXNW/XqMD33OKHNe/f1zNBKE+sgplo9X6YuvCrTvy6BaO7rfa4zoX3H9v1K1s0
         6JRrgYCHLLAsHbXHw/4SQmn5fRSgAMuJujunF87LMJ0FBb96WnhUJcKS3nosgF04vucc
         Gtb4TsjlrCHM8CXUfSB48u7z/tFuJm4k108Rj6t2zY/oEFK0pTXE8uRwLKEDqJCAR3nZ
         z/qaRKW+tidzXy6epx50bNFSwwjU5Biux7NOkw/o3k9Fp6wsBFX5e4dLQAQYg/+e2qd+
         VFLaUpgBqCIyYuHp78pcKj4GGlP0I0CSRFBqBHwQfnJ96xqvtPRp/NJGR9JY9frlYeH4
         o5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047918; x=1795652718;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSVsA9fNi7kC5K1IDfWWLOQdUEB3auXl+KZsJESSywY=;
        b=D11gEHhD+hBThrsrfMxn0EBeQwou8ozzpUkgropGGWVx8PJPPeSsejXILUuodNfNIE
         a4WAUImwnIgLGZjoR1JIzWSlCosIfSmuoH0ImWgKh1q0+Go/aezOa1JdL9/+HAvHKShN
         g4hz+V/jgY0Dzx1BWIljJbYGKP/X2TeFvxhWd2qrZH5FYvg61Ob8Y0jgjtf9sJVd7XlW
         MDGFTJplRxVrFO1TuzOD5W7Xi9DwLABwq3WnKNBMTteBdiqQENPU9Bf7ivjVIEuW6O1A
         11IDQ6ZfLUr/p//2n8oW+uZYKm7ubKfglabwGA1pE7GlaVBMYoInVoDBRKGR5mNMvhCT
         cfzQ==
X-Forwarded-Encrypted: i=1; AL+hErE6WgqFZtsxuiGsNDBqaxMZUeX6rx635nTyvTMs9pRnjG1gERTXw13/cJoxF1/R6i1x5MdrCbbdS1s+tb0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/47AdyGqki6Wg+xE4NpghUrUBfk0DIS/7Y9D+Ew1pMpid4x8YT
	QBw2GHN/iiZbWCvS+xElJrR4x9+nBpd8BYONAeg6qpQXKS7EjopHa+UQ
X-Gm-Gg: AZFdTZcxeP5onxFkK/rvsnIyciGzSGboqtq6djMGCTzCY31aiUqTCXDHmdCwn4mcqIa
	BXBxo2yH3LqKQPVsSQr5QDOAHKbD9ImeduNFDlfICYn8JjLPdkNrEZnOOLqdQnV8LLBZHK+6OTg
	DpY+K+qOcxNlvZNJ6UG2PX495fOz7HjfdWukeJigqTXEfc15Cgkosh7i/iTOIcUDV9596wEli+I
	JoypuAakixl6+FwpF8HBFmzypiNBkulxKGkM5yOC4XpXlKhbDz1AyFnSJI18659wOYK5tUHilD8
	u7xf7+Z+J4oXoUii7ncicOho62CH+T6P66iEL+086vtvLMvrYw2uhKTtcKgAbGrg2fH/Bzk7MRN
	H8cpPrum6zBz4UQv4boTQ46rVobtQF27VRSSbqrlvvdaAKNsMDJaAmBJKrmvRnDGK/389DtS+YM
	h4BBsUrUuWQUB9UoJpIHGdTqz1+s+bntAos73SZmsKTRqQ4Kl15tdbaobGTIrge9i5skhuCJrXM
	s1N0mKSW27KrbtJe1YgVqY4uH6EkHc4TssGlMykeYwryEwTKTY8CeiTMnCER8ai6hCoPIi6znBg
	qv10PYyzuVdK4cQUbYdLj9ulWyKAeDHHTF8=
X-Received: by 2002:a05:690c:79a:b0:8b4:f2bc:7c39 with SMTP id 00721157ae682-8b4fecfc697mr13290147b3.15.1795047918306;
        Wed, 18 Nov 2026 16:25:18 -0800 (PST)
Received: from [10.138.10.6] ([149.102.242.31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fdf1d0desm25414957b3.1.2026.11.18.16.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:25:17 -0800 (PST)
Message-ID: <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
Date: Wed, 18 Nov 2026 19:25:09 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] KEYS: keycrypt: Add the aes256-gcm-stream
 algorithm
To: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
 <sahil.malhotra@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Richard Weinberger <richard@nod.at>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141257.627441-1-giometti@enneenne.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20261118141257.627441-1-giometti@enneenne.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FHGxV8cRNdUiD6U0H5BD0N5M"
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FHGxV8cRNdUiD6U0H5BD0N5M
Content-Type: multipart/mixed; boundary="------------5YUoLTrRSVm1eElT0Sq1GVMR";
 protected-headers="v1"; hp="clear"
Message-ID: <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
Date: Wed, 18 Nov 2026 19:25:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] KEYS: keycrypt: Add the aes256-gcm-stream
 algorithm
To: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
 <sahil.malhotra@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Richard Weinberger <richard@nod.at>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141257.627441-1-giometti@enneenne.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20261118141257.627441-1-giometti@enneenne.com>

--------------5YUoLTrRSVm1eElT0Sq1GVMR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/18/26 9:12 AM, Rodolfo Giometti wrote:
> This patch is a proposal on its own: nothing before it needs it, so it
> can be discussed, or left out, apart from the rest.
>=20
> aes256-cbc does not authenticate what it decrypts, and a file or a
> transfer longer than one call cannot be sealed with a single AES-GCM
> invocation without buffering all of it, nor decrypted without
> releasing plaintext before its tag is checked.
>=20
> Add aes256-gcm-stream: the STREAM construction (Hoang, Reyhanitabar,
> Rogaway, Vizar) over AES-256-GCM. A message is split into segments
> of up to 64 KiB, each sealed with its own tag under a subkey derived
> with HKDF-SHA256 from the key and a 16-byte salt drawn at
> KEYCTL_CRYPT_OPEN; the nonce carries the segment's position and a
> last-segment flag, and the counter lives in the kernel, so segments
> can be neither reordered nor dropped from the end unnoticed. The
> segments go through a new ioctl, KEYCRYPT_IOC_SEGMENT, and
> KEYCRYPT_IOC_FINAL reports a stream whose last segment never came.
> A tee or hsm backend draws the salt and keeps the counter in its
> secure side; the sw and optee backends implement it.

Please use Cobblestone-128 or Cobblestone-256 instead.
https://c2sp.org/chunked-encryption has the spec, and you can check
against the implementation in pyca/cryptography or (for Cobblestone-128)
the Go package filippo.io/cobblestone.  This assumes your CPU has AES
and GCM instructions; if not, you should see about using one that does
or work with a cryptographer to standardize an alternative that doesn't
need them.

Nonstandard constructions like this one are to be avoided.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------5YUoLTrRSVm1eElT0Sq1GVMR--

--------------FHGxV8cRNdUiD6U0H5BD0N5M
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmr+QeYACgkQszaHOrMp
8lMKphAApmT7NKojxfNUv+4YED5wbkVa7lnarDk0nyp9M3Bt5hNIRlezPRWwnuNQ
c3Fse2TSfDpwTAaL/pZ9bVoUW3FkLcIwnAAIe35/78qpOemxEF5XRd4CQ9OGoQkm
MW429KUVHFxKjlSPCVrMIzW5PwLLvQVO/84lxA3BYJ503yK13kkEC2ja/5bOr2pq
cNzlB0rvirBXLKv2LH9gyIWC3rvLI29QGgGdFocZwnV/EbsWXC+1cNqLGePQ4JW/
X2W4CMomO+RvLWY+tfh/W+5hnUzxfaxn1oyCQbdEa+5KzWc+6oaPK9MU6x94SEhC
qkvoS60vMTP46Q4AQT+zB918F09KoN5Gwb6kWkjYVdfoJhsq1JIToOMT4uWhxwJa
zK5vgEPBWgvLDy5nRHf3l36sS0D8KibzPXtsQfxLrmH88Q8i8VHbMbHeuqQ3hfmi
/7v8eSCrt2NDafwt1mKKM1s3ZhegKN+R8bDXcK9Ys9fQnVMptIcR/tlkBBf6NWes
mdSBLNJSBR6q4Hm+kSz3+j8ah7qhuPVI9FIyKt9Lb60hrI8sHdotye0p5+Ne0iH6
rUKkFHWYEv10C/ku2PdPBgLIc5qfhf/MPSbqH5vAcyc19JIg9xneQVTxoaFK8QD8
aN6GKY3u02GADQHUdEuu26cEaKIBdN1yhWrjlPTIclUizw7Wppg=
=ionq
-----END PGP SIGNATURE-----

--------------FHGxV8cRNdUiD6U0H5BD0N5M--

