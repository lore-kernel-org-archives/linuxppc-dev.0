Return-Path: <linuxppc-dev+bounces-19292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5883E88D72
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 23:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnZ336mHSz2yYJ;
	Sat, 04 Apr 2026 10:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=136.143.169.19 arc.chain=zohomail.eu
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775224334;
	cv=pass; b=oMlBK5C1m4Ia2aU9DrWo+N85SthFXAGfKA1q/4QLnyRD5ZBYj8TgTbNKeUSTpOeLmrrHr2BDrQKl52beE41pYLglxiR7q4CQ7DZ4PRNjDtWE9+toZQln/Goms2e0bMcftDJxX4uXx+PVDYNhBY3UHZuEkQf9Wrq0gqaDJC3zvWVa/euskOw1DQWthehBmd3oHXJGG01limbYzLnTFnP/c9ByGzUmia9s8YJ/5JprMZ/X5fPw8eBtK61vXSiXsGLeKMCAt5J+zoHB50vfB0h9gBzmmS6Nrc3AT/7F5JqzyI8xTxhEtu0obie8ENdZNdJ9PoIxlgWD9uVfYQZjOFCwVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775224334; c=relaxed/relaxed;
	bh=InLCCKin5kc31jhHqJ2/xj58R/AdCjuyS3cbeNCAucg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMGuGUt633gxmpH4ACnjQRgTbrViHtquX/wYWTs3jQvFXmZy0W3dajOtFviLByDamW+C2oPLoZciXvUjcY6zVYJjDYo++k5EqA6Z6D7C+NQK/eHAjCyYnsRh6xyj9Dov3+K1BhFOPAcDi6J1PyVsI+IqDPOleLXHd3vp5ToD4ZYw3kzZXVIGhhJeEyR+L7I1DPaVpJpNtlSD65kq0W/ogdaj3Amr+Qa5ONZ0/gIaU2y3EABQFcgyaz3u2P8PyexcpaQO8r6shJANItr6PNCldPpuaXPUk+5kc+kHJiu1NficzknommM/ltK4FRvnmMMydSmLwYVJ5R1i6cUiCTsYyg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org; spf=pass (client-ip=136.143.169.19; helo=sender-op-o19.zoho.eu; envelope-from=jes@trained-monkey.org; receiver=lists.ozlabs.org) smtp.mailfrom=trained-monkey.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=trained-monkey.org (client-ip=136.143.169.19; helo=sender-op-o19.zoho.eu; envelope-from=jes@trained-monkey.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 909 seconds by postgrey-1.37 at boromir; Sat, 04 Apr 2026 00:52:13 AEDT
Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnKsT05g0z2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 00:52:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775223288; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XsFx4p5VgwLYs8/vuiRIhFYYY7BZEtsdweYoyutsI5s268xHDZNE+1aosDKf5tOhWsVRislQ2rdBSUSa3fCzPaXhQ7Jdtd14qGY8D0s0mK+KI8/ZOgGLtIlFsNetysymzkEm9B+sJUcbGoymfigIjm3FIkkIgaoeHQH/4ENLOjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1775223288; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=InLCCKin5kc31jhHqJ2/xj58R/AdCjuyS3cbeNCAucg=; 
	b=lR3dFmcub3ObCAdL18l5iaak8Gdiovaq3Tlv5KCFP7EBHANgryMrZkVOEJB8fSUW5MlwFmvffcCYzAUr4kG8Ob5saqKe5ZMxR7XXQMzbCi79zRQMOFW+87zJDova5JdrpCtyj2UlIF+m1T9nJVioaY+neqHcxDVDkzKGLqW3R6o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	spf=pass  smtp.mailfrom=jes@trained-monkey.org;
	dmarc=pass header.from=<jes@trained-monkey.org>
Received: by mx.zoho.eu with SMTPS id 1775223284898804.3284909269775;
	Fri, 3 Apr 2026 15:34:44 +0200 (CEST)
Message-ID: <ec7e71f6-7e95-4f22-8b80-d0925d5bd9c8@trained-monkey.org>
Date: Fri, 3 Apr 2026 09:34:38 -0400
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
Subject: Re: [PATCH net-next] eth: remove the driver for acenic / tigon1&2
To: Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, bhelgaas@google.com,
 dakr@kernel.org, kwilczynski@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 ebiggers@google.com, ardb@kernel.org, tiwai@suse.de, tytso@mit.edu,
 enelsonmoore@gmail.com, martin.petersen@oracle.com, jirislaby@kernel.org,
 geert@linux-m68k.org, herbert@gondor.apana.org.au, vineethr@linux.ibm.com,
 lirongqing@baidu.com, kshk@linux.ibm.com, vadim.fedorenko@linux.dev,
 dong100@mucse.com, wangruikang@iscas.ac.cn, hkallweit1@gmail.com,
 kees@kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20260402183029.1236713-1-kuba@kernel.org>
 <2026040357-flick-coil-0c5d@gregkh>
Content-Language: en-US
From: Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <2026040357-flick-coil-0c5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/3/26 4:48 AM, Greg KH wrote:
> On Thu, Apr 02, 2026 at 11:30:29AM -0700, Jakub Kicinski wrote:
>> The entire git history for this driver looks like tree-wide
>> and automated cleanups. There's even more coming now with
>> AI, so let's try to delete it instead.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Jes Sorensen <jes@trained-monkey.org>


