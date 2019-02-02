Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2371EC282D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 17:30:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BBC20869
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LLNUzOb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BBC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hartkopp.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sLbb2Y3XzDqHg
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 04:30:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=socketcan@hartkopp.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=hartkopp.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.b="LLNUzOb+";
 dkim-atps=neutral
X-Greylist: delayed 589 seconds by postgrey-1.36 at bilbo;
 Sun, 03 Feb 2019 04:28:07 AEDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sLXR6R8ZzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 04:28:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549128484;
 s=strato-dkim-0002; d=hartkopp.net;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=rehcv0vygKeLFmcL2i9Y89DgKx6ZIYyYldtPdL8iBYk=;
 b=LLNUzOb+6M9zQj1Pp+ZM387zhPf6ZYHSJIPwdKLN8GK7od6R6619RPW903sxORmpg9
 PICvyDTNiqrbhx39VlNuGLbr8xYy5ddd4TtqTLsOTJT/CPK5Sv0aGUFK0Zzof+r4IA+D
 qOuDH139u3Zu5GL2+TEWwzgFu+uR3Ql407BXALSe5TRb1mcd/qCeRgYGj+0iVmDVdU12
 rP2X4W3m7Ou6xLJoq77pD9mAdYycGQmPxZXkovzfLcECX5AP+HE7NKoA5x0xBW+TCBce
 8QYKIOuNSojX6d5pMaZ1a0zsjDiBkwP02L/PWmCObAPRi1DzBrxP3IKCLQG6dY2q9ceE
 iI/Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T3lT8iOWw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200] by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
 with ESMTPSA id j01e49v12HFkpna
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sat, 2 Feb 2019 18:15:46 +0100 (CET)
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
To: Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net,
 linux-kernel@vger.kernel.org
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
Date: Sat, 2 Feb 2019 18:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202153454.7121-13-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de,
 y2038@lists.linaro.org, netdev@vger.kernel.org, deller@gmx.de,
 linux-mips@vger.kernel.org, ralf@linux-mips.org, cluster-devel@redhat.com,
 ccaulfie@redhat.com, paulus@samba.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rth@twiddle.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

On 02.02.19 16:34, Deepa Dinamani wrote:
> Add new socket timeout options that are y2038 safe.
(..)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 9826d1db71d0..0d0fddb7e738 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -119,19 +119,25 @@
>   #define SO_TIMESTAMPNS_NEW      64
>   #define SO_TIMESTAMPING_NEW     65
>   
> -#if !defined(__KERNEL__)
> +#define SO_RCVTIMEO_NEW         66
> +#define SO_SNDTIMEO_NEW         67
>   
> -#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> -#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
> +#if !defined(__KERNEL__)
>   
>   #if __BITS_PER_LONG == 64
>   #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
>   #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
>   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> +
> +#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
> +#define SO_SNDTIMEO		SO_SNDTIMEO_OLD

Maybe I'm a bit late in this discussion as you are already in v5 ...

I can see patches making the transition in different steps where it 
might be helpful to name them *_OLD and *_NEW to understand the patches.

But in the end the naming stays in the kernel for a very long time and I 
remember myself (in early years) to name things 'new', 'new2', 'new3'.

In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and 
SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Especially as it tells you what is 'inside', the naming of these new 
introduced constants should be replaced with *32 and *64 names.

The documentation and the other comments still fit perfectly then.

Regards,
Oliver

