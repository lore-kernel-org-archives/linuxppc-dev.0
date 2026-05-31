Return-Path: <linuxppc-dev+bounces-21763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AB4CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 10:16:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gStKD5gn9z2xld;
	Sun, 31 May 2026 20:16:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.77.101.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780222560;
	cv=none; b=idoYOaahexKRABjcXO9mYKG1Gy0olI6wyVetjl/zG+ifumc4V3V3ZNE+5jzfz63+MQ9YIAitZ2Ahu9xJRTkWK+RKqV9BtKLTBSQihcZKXfsqL99wsvBja8BLPe6XudbgEZv680fXJP/BQOsfWyimfdXJl9UBEbRQ/r0OjWrE3zcC9XDjFyD+VmzwiA/z/IeuaT8UCCOPBZIjEtiTxW3bT6F6Lxzj0MEDCp2E1aw9qpWfwEDK0svyIB1F/EocwjevlzxuLPah2kveI35bPVxFHYmUUqv6gDLgEODXf2iTLAyct39hA+o279DRkjbb9ge6o+1oPT0dntXXSiH3ikiMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780222560; c=relaxed/relaxed;
	bh=2SQfCs0HoCf9vhy43ML8A/6cWeTnQI9VwH6KrCBIL2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CECn7N0H3gNe5aSygL/+pQCKZ1z/7mXIn2O4H7yDmictuYioCgUMV1Phkc4zg95mmBGqdLx9npX9qmiJamhY36kxZYeAEMJEi4JBC8OlgQ6fjmUntyuoPgF2E9DiVKDE5CK2PHvE7IRP7wH9pFXfT7haJjfaR5U7fmXHrezVfd+G+X9gJNaDz5iSgizV5Avmu8FR1XhmUja+Ekgc6XOjv9rlZuq3svGtHH29F1Ky+/20IPPF29TntDweTTD21Wmdzxe5qNZEMPu76K2Ro4qdhzwv3rH1jTGoG3urhw5g7TxRLJOAAqEeZh5iSFUNaC70Nzdlzh1ZUEBEqCI5bPN3tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=wp.pl; dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=20241105 header.b=BqcqyyO7; dkim-atps=neutral; spf=pass (client-ip=212.77.101.10; helo=mx3.wp.pl; envelope-from=olek2@wp.pl; receiver=lists.ozlabs.org) smtp.mailfrom=wp.pl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=20241105 header.b=BqcqyyO7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wp.pl (client-ip=212.77.101.10; helo=mx3.wp.pl; envelope-from=olek2@wp.pl; receiver=lists.ozlabs.org)
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gStK94VwJz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 20:15:55 +1000 (AEST)
Received: (wp-smtpd smtp.wp.pl 13222 invoked from network); 31 May 2026 12:15:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1780222550; bh=2SQfCs0HoCf9vhy43ML8A/6cWeTnQI9VwH6KrCBIL2Y=;
          h=Subject:To:Cc:From;
          b=BqcqyyO72zHQfNAxITei2Q9ZqGAZZV5fA8933DKK1TQwzgx0QkjevfzORptFdOsR5
           ur3j9/QkwPykJhWPJNspTVenLHeMbI0LvrT+5lKc1LxQxmegZAxaYRWrrJ4H6H6u8/
           y7+i92zw5l1gIa0mEjYmz5F89FT98AcLK+fLju7OeeAHZWDYfeWqwhTmm5IQkJEEtd
           sfwwAl9CO3OEwNWRoHP2nGHzXLpyLH6ZjdtL85hqSJ/RNgLoTUTg1skVmNDrN8xtIA
           GKuR0YMjZfdeR7Km1Zx6DKzz4pdH2RxYF706tGxGD9m0vADhRTiQDEu9VWzLN6TT7s
           jWup+ojD6k7Yg==
Received: from 83.24.39.212.ipv4.supernova.orange.pl (HELO [192.168.3.203]) (olek2@wp.pl@[83.24.39.212])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ebiggers@kernel.org>; 31 May 2026 12:15:50 +0200
Message-ID: <465adf3a-2c27-43d0-afdb-68ae12b89d10@wp.pl>
Date: Sun, 31 May 2026 12:15:49 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl> <20260530192630.GB6807@quark>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260530192630.GB6807@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: a6e63facd6f870f2252be64801227204
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [ker3]                               

Hi Eric,

On 30/05/2026 21:26, Eric Biggers wrote:
> On Sat, May 30, 2026 at 05:05:19PM +0200, Aleksander Jan Bajkowski wrote:
>> Hi Eric,
>>
>> On 30/05/2026 00:04, Eric Biggers wrote:
>>> Remove crypto4xx_rng, as it is insecure and unused:
>>>
>>> - It has only a 64-bit security strength, which is highly inadequate.
>>>     This can be seen by the fact that crypto4xx_hw_init() seeds it with
>>>     only 64 bits of entropy, and the fact that the original commit
>>>     mentions that it implements ANSI X9.17 Annex C.
>> In addition to a seed, the PRNG also uses ring oscillators as sources of
>> entropy. The entropy should be higher than 64b. This is the Rambus EIP-73d
>> IP core. The same IP core is built into eip93 (EIP-73a), eip97 (EIP-73d),
>> and eip197 (EIP-73d). You can find the documentation online. The complete
>> "container" is actually Rambus EIP-94, and one of its parts is EIP-73d.
> Just because it may have another source of entropy doesn't mean its
> security strength is higher than 64 bits.
>
> I cannot find any documentation other than
> https://datasheet.octopart.com/PPC460EX-SUB800T-AMCC-datasheet-11553412.pdf
> which says "ANSI X9.17 Annex C compliant using a DES algorithm".
>
> DES actually has a 56-bit key, so maybe I was over-generous.
>
> And according to https://cacr.uwaterloo.ca/hac/about/chap5.pdf ANSI
> X9.17 has only a 64-bit state anyway.  So even if we assume the
> datasheet is incorrect and the algorithm is actually 3DES which has a
> longer key, the state is likely still 64-bit.
According to the datasheet, there is no second source of entropy. The PRNG
has three built-in LFSRs. Each of them can be initialized independently. The
first LFSR is used to generate input data. The second and third are used to
generate keys for DES encryption. The output of the first LFSR is encrypted
using 3DES with two 64-bit keys. Between individual DES operations, data is
XORed with the seed. It sounds like a fairly secure design if properly 
reseeded.
There is also a newer design (EIP73a) based on the same algorithm. The
only difference is the replacing of 3DES with AES using a 2TDEA scheme.
The DES-based variant is more widely used, even in new SoCs.
>
> So it isn't looking good.  And since it's an undocumented proprietary
> design it shouldn't be given the benefit of the doubt either.
>
As I mentioned earlier, this IP core is quite well documented[1] (page 198).
Half of all SOHO routers have the EIP-73d built in. The algorithm is also
described in TRM for some of these SoCs :)

List od SoCs with EIP-73d:
AMCC PPC405EX/PPC460EX,
Intel/Maxlinear GRX350, URX850,
Marvell Armada 37x0, 7k, 8k,
Mediatek MT7623/MT7981/MT7986/MT7987/MT7988,
Qualcomm IPQ975x.

[1] 
https://www.scribd.com/document/734250956/Safexcel-Ip-94-Plb-Sas-v1-5?_gl=1*dng4pf*_up*MQ..*_ga*OTQ4NjkzMTAxLjE3ODAyMjA4ODI.*_ga_Z4ZC50DED6*czE3ODAyMjA4ODEkbzEkZzEkdDE3ODAyMjA4ODEkajYwJGwwJGgw*_ga_8KZ8BV0P5W*czE3ODAyMjA4ODEkbzEkZzEkdDE3ODAyMjA4ODEkajYwJGwwJGgw

Best regards,
Aleksander


