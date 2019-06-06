Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0596CC04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 04:12:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3127E205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 04:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="SNQqjDKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3127E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KC185k90zDqhK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 14:12:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=anastas.io
 (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.b="SNQqjDKe"; 
 dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KBzh2kp1zDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 14:11:12 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 3ADDE7F8A8;
 Wed,  5 Jun 2019 23:11:08 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1559794268; bh=IXEj4ZIqHL7cUKfHaxZHU4/XbireQ0xukVB05oE0jc4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SNQqjDKeTOnlp9Lqu1pCLwlJ/k7tz5v5u4zA9NGKwQf3a4R14yeDZZTxeQZggARCr
 3OyaNmhdYSup1cAWrL3VePF8jsSY118hO0fXAkOkXXN+TJ9k7ipAgvBKdZY9xW7Doz
 OdczR5FcEMZ78kPSY0Cu4LT/kS1Oh6pCqdmpPctdUshzsCC12Ms88Hl+yKgKdKhRgw
 LYM8COPRVLsxB55tdefddklDNAwHci2uFWadOZyWstbx0Ac6mosLE2fYlaaue2X013
 SuMJ4o2dVvyiobbQgKFPN8oNhF5U+W9wEORnP/BXJeJmcF8I4o4vYgFNPwFoYA5jjP
 mj9GjIUA7lUtA==
Subject: Re: [PATCH kernel v3 0/3] powerpc/ioda2: Yet another attempt to allow
 DMA masks between 32 and 59
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <20190530070355.121802-1-aik@ozlabs.ru>
From: Shawn Anastasio <shawn@anastas.io>
Message-ID: <deb34b5f-9472-2156-e58d-8dbcb0a38979@anastas.io>
Date: Wed, 5 Jun 2019 23:11:06 -0500
MIME-Version: 1.0
In-Reply-To: <20190530070355.121802-1-aik@ozlabs.ru>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/30/19 2:03 AM, Alexey Kardashevskiy wrote:
> This is an attempt to allow DMA masks between 32..59 which are not large
> enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
> on the max order, up to 40 is usually available.
> 
> 
> This is based on v5.2-rc2.
> 
> Please comment. Thanks.

I have tested this patch set with an AMD GPU that's limited to <64bit
DMA (I believe it's 40 or 42 bit). It successfully allows the card to
operate without falling back to 32-bit DMA mode as it does without
the patches.

Relevant kernel log message:
```
[    0.311211] pci 0033:01     : [PE# 00] Enabling 64-bit DMA bypass
```

Tested-by: Shawn Anastasio <shawn@anastas.io>
