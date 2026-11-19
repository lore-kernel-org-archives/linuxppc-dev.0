Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F37606A338
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkO9ZyBD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVgtb3ssSz2xL1;
	Fri, 20 Nov 2026 01:33:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795098791;
	cv=none; b=gAseY27U3qORhCJ7htX90JlBViHsw1gJkxg2qVqoy/Tx2FWI9Y6WXlwAhe4sw8ZjsTktHcIDQAD9BRSNaCAv3A8+yDe5U4Cffq5ysl+ZSUAG+qsc63Z0TFRxTQjLpo1KV+p4FCEWwhPwdsQn+1+MgR3xOfHYA81CuhozHe3SUqD7aUCnmEifFgj4eBIMiG+zPMDMIWgAIvfduhTdnaH2RBvNeSrbbU4VNKDsZliVB9ODnUlMFPm3WI2DpZ7ZzkBz85dZiNE7I89cLP9k16TQhYBBCN2v8bLXlsTk6nSWrAdOzIHU0dEB6JvMqvCP9AFmOaz0M7gKGwWYnFID35cw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795098791; c=relaxed/relaxed;
	bh=lv3NYu11pHprgRUUKX5nzbXJ9PYh0wkr94sy1z7rgm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQOHX/Stq/JCd6ymA788OOKwwh7bb8GFLNtUtGn447bxImH5kxEmAsInb5zrZDNMuBP9nOEabBij9ErOreY4wJBSjTAnKPOsd6VXkyk/flNS/vUyDabFsauLWnRQ9NO+FXaQr5GZ5PadBxX3NzKhq8/sx86sLWAHsLB+jy42v1zPRCkbO+mT4r1dStat75FIjC60PiFB1IG2/V1JA9us4K8gpa2HJFbZXvgx0ysD3Rm9SCc8Pr3LGt1qnuiPtn09+LZgNSLauE4IFEtru3hRCY3CDcLfm1JbFhI1df3ur5sYAM8WtMWm+vihYfUsrLPvL34KlD8qkePzBZv0QyMmng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkO9ZyBD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkO9ZyBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVgtZ1YFJz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 01:33:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 0AF3260A6D;
	Thu, 19 Nov 2026 14:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3738E1F000CA;
	Thu, 19 Nov 2026 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098786;
	bh=lv3NYu11pHprgRUUKX5nzbXJ9PYh0wkr94sy1z7rgm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DkO9ZyBD2TgaZMRcs8EgWiOCyNyqCS5GVpH0PIaxsiAxioBTNKOP1wNtv66D5cYUo
	 SVbW8UDU1ecj5E3RCQAhHUNANk3OefmNfhyVcaUvR0Gz4clykNB0Ug9GoG1Ptr8ZuJ
	 ONnfC20iTyqzzJ2bUJn6Pg6qw6zmZqZ3ZatVKnDFWAqwRPzMWGYReKxU4oRi50tS1Q
	 1qTF54aQpt4AAtXTH2qm2wUUGVJhq8ji6yCXpiUz4OvXBnHZfzrVs9GnUElmUD670e
	 vrz7s2wx6vlq7TxR3Li0W0SBs0mp7rRKPrBjNuC5IHgS3SdNuJjawMEJSGy/3xT0BT
	 6PR8vQwsFHWZw==
Date: Thu, 19 Nov 2026 16:33:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rodolfo Giometti <giometti@enneenne.com>
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
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av8In0Xyd5iI9N7K@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
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
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:37:33AM +0200, Jarkko Sakkinen wrote:
> The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
> relationship between the keyrings API and a specific key type.
> 
> At hardware level I did not see any support for TPM, which narrows down
> the potential user base.
> 
> The remaining potential user base is further reduced by those that use
> trusted keys; leaving out those who need to solve the assumed problem
> that only this patch set can presumebly sort out.
> 
> And we don't really know at this point that cut. This is pretty much
> the break down of what is wrong here.
> 
> If there is/was a problem to sort out, it should be so constrained that
> it should be as quick to describe as stepping over a nail really.
> 
> These are the main topics what I would focus on.

I'm not disregarding that there might be something; and neither
disregarding e.g., the use of Claude. Throwing a dice can apply as well
human made code as for me code is just code. Perhaps using Claude,
people just tend to have just a itchier trigger finger :-)

The place where *in my personal opinion*  anyone who uses agents would
be better to do manual work is the commit message. It enforces to use
cognitive abilities even more so than writing code, if you with
absolutely no self-deception, read it all through and write with your
own words what the heck it does.

Usually when hitting the wall doing that leads into better code
because of the healthy reality check. I'm not a medical doctor but
I believe at least that thinking more stuff like this is also great
for long-term health and cognitive abilities.

AI is for mental health as a car is for physical health; for better or
worse.

Code quality is also over-rated although best effort should be done
but that's all. If you get it, then it is done. It's harder than it
sounds without self-deception part.

And yeah, we don't have projected problems. I.e. "no users" is always
NAK. You have to step on the nail at first.

Just need to clear my thoughts on overall the topic :-) This is I guess
where I stand now. Hope you find these helpful.

Br, Jarkko

