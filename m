Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rm9KOyeh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVKTh4Fbsz2xkr;
	Thu, 19 Nov 2026 11:43:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795049032;
	cv=none; b=OMQK9VZBPLDE+gOBrSrLU6ZyyjjIxiCO9b1KQF9juz90021dJwZTw33ZF1sYpBOZX+x4QsNU0Ajs9vN4hjFs7lWH35Tw2Age93+7guus2RdOjTU3X1Bxiy66H3l6gEYvyZb5TCbNG+5WEIARUE7KlT7gPxC7GfYqC1ZTEGZ4iiohrWBgI2d/ZLkg0L5ZFMy2YAGufjR2L77A2NLpKAyJntVyNfQOh7LBIr13zBuK5blOd3UD5KJP779KAr9Ag0fwxaPSF2VhbFP/EQfLUqy0hLrG73qeeyFjhRsMxo3CMzxVI70jdxhEwrMD1P1cKyJ5fBGS+W5T0mG49f80HojJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795049032; c=relaxed/relaxed;
	bh=fgA8o0FbMXPNXu1ndyU//XOwV/J+NqWrJ7q89CkWjTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AN/1tY4+VwTNz6fVB+MOoIScnCKlov4l0NcXQzjRlSVkz76FNlK3OK5V7BWf0qptXNk/wphU6NFQC58YrmI9EMMKi1o4PponbqV7I1ajmZPA9O58wQk72JpvIQO0V3Q6ghUv/3i7cXgNoIHZZI/8KFOFU9vgLPsOvR2V1XL3PMVvWmLdP2Et6bkohu9ehRjX8YZd2oMhSYcfWE3k7jAB8fttkYuxIEOOVMCGJpTvChuS3fU5X125c41VRQgobdAKXpscERavI7nr3cdb5qCHUtWwmwDcQxtJf4drCiU4wKi8XseaT7R0DdubxFf7G/w8Tvyb3bMzk5SzmD2Gq36MMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rm9KOyeh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=demiobenour@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rm9KOyeh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=demiobenour@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVKTf6W99z2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:43:49 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-67db0791748so1936904d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049026; x=1795653826; darn=lists.ozlabs.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fgA8o0FbMXPNXu1ndyU//XOwV/J+NqWrJ7q89CkWjTg=;
        b=Rm9KOyehqfSs7t9iA39XJZlPYwETv5urth8mMbHborquh4+XkUW+4gNmsq3ahH6Y1Y
         vqY+sjTHxu8sRyn0iAU3l8o/4BDcenKPYTSWiW9jEO8nL4jVDVCOuPHZbrDATJOlPkru
         0P3y0vso0hR6/4bPcQINZKdCs3SY3EGz1uvy6ueDrpJMslj+XL9/u7nCoHeqv1uSjI4R
         6UJi+TwIDyR3QJN6w9qUz0xmN1HagsJuc4zRoCBUbCK6+Pgh6AS2+3Pwq4ar8hnINafG
         ai+Hfo/ENv9d0alJgXxscX8jkmfVwkf4VIf6mD3n8N3dAW0jgUITg5ef5HLZVcXrNMw7
         KEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049026; x=1795653826;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgA8o0FbMXPNXu1ndyU//XOwV/J+NqWrJ7q89CkWjTg=;
        b=bd9OfxayaSkzRtQvZkF6gMBxQnfQdDlyijAh+YpKPkBbpavvsTSzLX1z2dhjH6mcYP
         m7H1Yio83iNfYe91FijlvHYHABhVacac1rjP/C/LbDn7nRfaWv/16oaX/DtxqA409sQI
         ugrsnLGHYlE4X/tTKBT5w7FbzePT3bjwJYYADWPYGDbmzqeYfH+J6H+Ovvynwqw7/4DV
         2DnEzvDLfjtiHSVRrmedsyAPg+WAyry7vUAlZ5gElQ88fJTMVGQG3OkF9JikwPL7nUD7
         JxCNDbtU5+6UddGnOP/2o+qpcg/IrKCWx6da6f+LR10ejDOvPLcyPgOxpb1MdMqZBW/B
         ZB0Q==
X-Forwarded-Encrypted: i=1; AL+hErG+lMJB0m8eO7LrMH703htGpq7+DP6g5JCanMcMlz22PCEc86v+JyJQFbIaN8nLQtnJMA20w0wiTs2LFnc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+SdnWZuGcOST4wPA/tE86NQtsS7fvV5HkMWGbGKJ0JEZ53OdCt
	jgRQaKHAKdJ1ky/cBuYjVsecRfJQeCxBd74R7+49cpqVppt443+DyM1o
X-Gm-Gg: AZFdTZdDtomVzEiDcqvmii0o4X9SaaUMTsEoqdnsjxvJ2JCu+0idKVG3mwLbwfq9+Fm
	cmIjxc7LAnyLVdL9nokNtOF4zthXX6eb/2tbuZ6r0XQvpn8wKgJ7Cw1ggJl1MTydJpKibrsIm1y
	sfuCsQgoAveZ8f3fODcBkop32hVdvSNsFcL2T4CLg6Tqq/BOotazg5vSMms20zz6s54WzU4H5TB
	y00Ms9+sOZGNvbbu5UDbMZJUD4mI93eCw5xp6uTMSXb27ukZ4H6VfmP5vqpJFinZsGWo9ciVTON
	ZY4SwvFNl8RfvB42xI0hmufYJX2jcvE5ajfCQWvwvxPGVeanuAPTDhTbx8+WYDHi63jUjRbi5Ia
	+MSRN/NWralp2OvWY33kJO7ZCV1Jhp6KX9aKHDoph7UnRrMxBUdhtdakcrnD/TYwo2Cl0xf01uB
	okMgPFlnNE/Xz3qJPBsl5eYOHXP8l90jBHK2Bp/lEMEwKHaeMmsTwKE0k7rWN2bfOt66NbK8WYG
	/q3gC2APOED1B9isD7YFGiL31c+L4qCXEjrYWwFfkbGTnthS7k/aHxHfX4abK1j1nM+75trZlzD
	Gf6qZC/zEI/Zj79pCwC5xvGlUZHIuKU8sV0=
X-Received: by 2002:a53:d018:0:b0:67d:affd:e015 with SMTP id 956f58d0204a3-67dd3f19e9dmr1827544d50.37.1795049026165;
        Wed, 18 Nov 2026 16:43:46 -0800 (PST)
Received: from [10.138.10.6] ([149.102.242.31])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd58a1478sm2511941d50.14.2026.11.18.16.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:43:45 -0800 (PST)
Message-ID: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
Date: Wed, 18 Nov 2026 19:43:37 -0500
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
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
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
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0bx6vSKCAV0Mo03JVw607zhR"
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0bx6vSKCAV0Mo03JVw607zhR
Content-Type: multipart/mixed; boundary="------------B160UtrZAU3kNrK8qGCCzylk";
 protected-headers="v1"; hp="clear"
Message-ID: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
Date: Wed, 18 Nov 2026 19:43:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
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
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>

--------------B160UtrZAU3kNrK8qGCCzylk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
>> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
>>> This RFC proposes a key type, "keycrypt", whose material user space c=
an
>>> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256=

>>> and an authenticated AES-256-GCM stream, through a file descriptor th=
at
>>> KEYCTL_CRYPT_OPEN returns for one key and one operation.
>>
>> I haven't looked at the API, but from a cryptographic perspective,
>> this encourages very poor practices.  AES-GCM even allows userspace
>> to extract the secret authentication key.
>>
>> AES-256-CBC isn't a suitable mode on its own, unless it's combined
>> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
>> bound, so it should only be used 2^48 times with a single key unless
>> the key is ephemeral.
>>
>> AES-GCM is not a suitable algorithm either.  If you allow encrypting
>> with a key loaded from persistent storage, there is no way for the API=

>> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
>> authentication key and allows forgeries.  Using random nonces isn't
>> good enough either: NIST only allows 2^32 encryptions in this case,
>> and the API can't enforce that limit.
>>
>> For long-term keys, all of the following are much safer choices.
>> They have 192-bit nonces, which means that one can generate them
>> at random for each encryption without any problems.
>>
>> - XAES-256-GCM
>> - XChaCha20-Poly1305
>> - AEGIS-256
>>
>> AES-GCM-SIV is also okay, provided that you are fine with occasionally=

>> leaking if two plaintexts are equal.  This happens whenever there is
>> a nonce collision, so with probability 2^-32 after 2^32 encryptions.
>=20
> The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circula=
r
> relationship between the keyrings API and a specific key type.
>=20
> At hardware level I did not see any support for TPM, which narrows down=

> the potential user base.
>=20
> The remaining potential user base is further reduced by those that use
> trusted keys; leaving out those who need to solve the assumed problem
> that only this patch set can presumebly sort out.
>=20
> And we don't really know at this point that cut. This is pretty much
> the break down of what is wrong here.
>=20
> If there is/was a problem to sort out, it should be so constrained that=

> it should be as quick to describe as stepping over a nail really.
>=20
> These are the main topics what I would focus on.

This whole patchset looks like a solution looking for a problem.

The usual solution to something like this is a userspace service
like ssh-agent.  Then you can do whatever key management you want.
That doesn't protect against root, but if someone can get root you
have bigger problems.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------B160UtrZAU3kNrK8qGCCzylk--

--------------0bx6vSKCAV0Mo03JVw607zhR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmr+RjoACgkQszaHOrMp
8lO5Iw/9HOFK9h3BHZwDlgyA+MXIYfSw1WE0cw6OUocFfslcMGtaJ8QUnc8FK7ej
JwNHAFrOQiY0Om8URIO+73PT7KKU3jUc0xHs4ZEbrZ+pUdwOaPSu8AIhc7QHrAbw
sqPqYIKJsbaoiuFGaZWZA/rBxBofCyx1kPZfLBVTtk6UochaiB5wNg7uPZsET7o+
qmrujw2kIGRuMREUtnBM2784dfVECk6kT4ukrFfKu6CYD+fANTEaVGFfasiOATFv
th2IpXIn9teh3KnD7bESgkgmKNo/3Ve0ltsrCnWa2JrwSrvacDjqtxIGQGZqAIe/
Ydt2QmrbrYfpOzACofLLmC3hEs3KL2fEFpfC2CfSYdABc71dYQZf4YsVtVXYwvVD
h6+AOlMBdAuD7HGnjyYRoLz+0ootP0+XmSYadYQbMBJX+T+6+Yc4Dk8fOMV5fp1o
GmaCI2gz3kd46+jOE7+NNUDb180/eth0DZo9A0/q1sbe6rLe5/mIWXdZ42tvvEzy
uysEfhp/DLGc1rkHiGTZeOEv5O74eGRqfK2ZpkRIXOitHt0k9W5xAIe4Wy1tsTfV
S1BrrJD+YEAZJP/3cRbbZvb3bV10NujrW1gJVMoP+vQt/AncJ1IIgkmL/WzK6tUo
QWTfj6w6ZSnX1UjV4yv0Svpyjy0CM53r4p/gZZow8N+5a4I/k3g=
=kuCZ
-----END PGP SIGNATURE-----

--------------0bx6vSKCAV0Mo03JVw607zhR--

