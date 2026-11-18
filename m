Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0wB+4P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV4j65WGvz2xSl;
	Thu, 19 Nov 2026 02:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795014474;
	cv=none; b=itNbyh8YiuNrnOzcK1x37PZNPeue3TuOP0JF9p4X9CwNLG1M0NMjIwwpBtq5jzenQcVbCE1Sf3VV0N/XD6FAQYID1B1GjQ5vHnKKWdNWrmaQ6nTZjHsz2yYXuevrb1FiI5X7gIer6cxXPaPvtKs1u0pdUsgtGgvJe2mm6v60pJ6KnDNEi2vLGjL9qz6x1Hdd3wRxs6OUwvNPC//NbZOcPD8vOeR1POwLPaQhjBKxZ+G+3O0kWlnpRcrnbVs+e+wHY6okcD3hlKWR8FpgFxUCar83/JldPNygQjeQtbzDrR3Ho+aHZHYzE9/AgLeEaVSNKCrjip6Iw0pJuOpbFm7dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795014474; c=relaxed/relaxed;
	bh=WpNvKlvQgWs4nlBDzrAzqY0K1wpz+T9bN3CMOunjYys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk8tzLrYyfCFPM1mDvKIKDoeFWSIVTXV550GkueGg9u5dqjdwekiiYpgZhLuLc9WYTj5q31jLjcvP9fi3ipwCPbMHgUySUXXSnEL3Wz5SC1XycKHGhh7oKqFVjl1WEjjCfrGGW10/pnOZn1utlM7rtvPVuntYPte6ufCK9e2nlmiSxVldKcuRvU31UZhe1fqYVlIs28XvJvthHKa9QllvA+KXBysui4uH7XC3mkaJRVXXzfs8n3lZ6852qBpflJggEP/MhtBq2AKl6oJw2AJ8TQV51lJ2p37ilHJGKoIkcw8YbogD/IVRC61uK3qLd59Vv8pXw8bq8g5BQ6DpFLE7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0wB+4P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0wB+4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jV4j56vLsz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 02:07:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 8E70743DC3;
	Wed, 18 Nov 2026 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C01C41F000C4;
	Wed, 18 Nov 2026 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014471;
	bh=WpNvKlvQgWs4nlBDzrAzqY0K1wpz+T9bN3CMOunjYys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ik0wB+4PWOYL2hmQiNwFTeBBvupZ2nUcJiZ54iyfaa2tU77mnLlpFifyj8n1RAoxc
	 JiFr1whbKGn9jctVHgQHsWlXlRxqGaOAejYgryvppYJ1hYUJPmJajsbl1RZNJZ2urH
	 fAR3taWBeKxDwuMnnlsPRwbWW5GR06M9hA5dv1M1pEA51yEPNLWXKWfBsoGOA85JWU
	 RdSwiNfRnISgDS/zRQ8IFyTjSctGJRDAEhTnp4ENDN8HwGtDmIypnNR9Lro8os8drC
	 gH5m26+2mcTSgygYysYIO2BPjm0gAz6kctoO3OxBWgeB2Wg89nS8C+lhRUQ+5galCW
	 RrUE6ZrvqIprA==
Date: Wed, 18 Nov 2026 17:07:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
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
	Eric Biggers <ebiggers@kernel.org>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av2_QoJHp1gMTFMp@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
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
In-Reply-To: <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 03:57:27PM +0100, Marco Felsch wrote:
> These are basically the trusted-key purpose.

This is it.

If I was adding something like this, I would at least:

1. Discuss the solution that would extend trusted keys to the level
   that makes it crystal clear that this is won't work out too
   well.
2. Then show how the new thing addresses all of this.

If there is any gist this should not require whole a lot of text
dump.

AI assistance should not be really even mentioned the cover letters in
my opinion. It's equal to text editor; or smoke signals. It does not
level down anything i.e., I'm equally dissatified however this was
produced :-) 

Br, Jarkko

