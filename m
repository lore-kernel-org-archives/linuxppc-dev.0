Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFAC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:06:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9E620665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4Lo77Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9E620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fftY2QwbzF38B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 04:06:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4Lo77Fa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4Lo77Fa"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ffqW0n7fzDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 04:03:50 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id y144-v6so2579097wmd.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:openpgp:autocrypt:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z4h6H6Qh9c2bIFj3jrZpa8rK4vjzClDzVUlKZIyYLq8=;
 b=J4Lo77FagZtchDCjnhtSS0ZS9uXTsy4SfpI8LRfVOYDZKsgU13I3wOzrRcx1T15Wnq
 d1w3GouB+X4h+CZDpYgiPwO8xZfYWJb7V/Pm6mh06unNCEWyvChc+ufNo4CUuJ1qUsi9
 rIAZqS+afSqz3fMQBdnJ6iafF0S5/3BsjYVY9Hnzt96xESofaUU1wsXxo5oUfIwEakaM
 NsnI2feTH8An+fXKlNVk+JSRaUM6oYMJeKbWbWQzyAVs8M2/PnJt+OLeroTP785DVWcz
 9dZ67PAbjeE+ztSVeshaNhR5PKTAhjqqlP34MgH7Gr7NlyGHimDtNUZAhW8Sg4qHUhgk
 8cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt:cc
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z4h6H6Qh9c2bIFj3jrZpa8rK4vjzClDzVUlKZIyYLq8=;
 b=IlezVWhMUT87kva2noptz1XNnI32zNorORtp9D1Y9b0pcI4nZQk9OuZINY/RVEQo30
 T6La1RqkImvCXGBLiv+2zn+tb/uBVHS8p2oH+VVzJ2O6BcyIZTgOzZhEaR9Js9K3v+Pf
 vv4Qdl2bhdwgUHtW7N42f4dI+QHedOyTYU3wfwPenak+FxGrxV0oWm66o55+to6serYq
 0YkrxaXFm9dK71ap91yUkRzyrBuQ0YYYDFrIp38uniDbwx+0j10VEvmZB5xm9PfAyNNK
 m4cNcQL7DNfB77hyz5amb4bHGGpI38PLAdvDCbTf2ieDGxNW7ntyf7WCT6av2qNPZFM+
 eM3Q==
X-Gm-Message-State: ABuFfoj/nYMBJMDEv0Gc3/G1ecppp7sDngYmdeJu3VMrUvzQMYjRVp4z
 xR3L4IOD9pnooSGBPHwJZDU=
X-Google-Smtp-Source: ACcGV60jngl849fqfrBGeEVyPdKDYDSYKBxV839LmU+W2xuW07AsFaGxBmBn10cqjvi23k/t0bgC/w==
X-Received: by 2002:a7b:c08c:: with SMTP id
 r12-v6mr21867283wmh.108.1540314227631; 
 Tue, 23 Oct 2018 10:03:47 -0700 (PDT)
Received: from [10.67.51.150] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 t194-v6sm3182806wmd.48.2018.10.23.10.03.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Oct 2018 10:03:46 -0700 (PDT)
Subject: Re: ethernet "bus" number in DTS ?
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
Date: Tue, 23 Oct 2018 10:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: andrew@lunn.ch
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/23/18 9:49 AM, Joakim Tjernlund wrote:
> SPI (and others) has a way to define bus number in a aliases:
> 	aliases {
> 		ethernet4 = &enet4;
> 		ethernet0 = &enet0;
> 		ethernet1 = &enet1;
> 		ethernet2 = &enet2;
> 		ethernet3 = &enet3;
> 		spi0 = &spi0
> 	};
> The 0 in the spi0 alias will translate to bus num 0 so one can control the /dev nodes, like /dev/spidev0
> I am looking for the same for ethernet devices:
>  ethernet4 = &enet4;  /* should become eth4 */
>  ethernet0 = &enet0;  /* should become eth0 */
> but I cannot find something like that for eth devices.
> 
> Could such functionality be added?

It could, do we want and need to, no. You have the Ethernet alias in
/sys/class/net/*/device/uevent already that would allow you to perform
that (re)naming in user-space:

# cat /sys/class/net/eth0/device/uevent
DRIVER=bcmgenet
OF_NAME=ethernet
OF_FULLNAME=/rdb/ethernet@f0480000
OF_TYPE=network
OF_COMPATIBLE_0=brcm,genet-v5
OF_COMPATIBLE_N=1
OF_ALIAS_0=eth0			<==================
MODALIAS=of:NethernetTnetworkCbrcm,genet-v5
-- 
Florian
