Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E4C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:46:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C420664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lWPl1PG0zF318
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 01:46:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lWKv6s82zF3Hl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 01:43:31 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id f18-v6so9829882qkm.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 07:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sinQDqvF3So7Cb8pd420WYzTIZ4UJ6tUzd0GOlLZtDE=;
 b=P2/lDI0QWq9+drdX7jveXn86nMwXvr8+O+t5qRCbN3L5UtNj67eCot04L9mIhpL4tg
 39Z8omH92+7meVaVP9CO9MJTfLZFBmGPxeEwahM4nkjqubRKvBm9xDKKqB6DaIr8R2ev
 yw46jdp8L8iEr2fND6LBse+T9yMUvf1lZkLRGoCO4EgtJFNub3hP3l3sq85lP2hh53o3
 Owm/574u/XoyAA6cRRhLnFKnCJeqG6CxMO/CfLePSfkoJ/usgboJa3pd9gVBtlxyhvQt
 hZd7fJr5s9bq54t8zwU3FXiHvQTPerSz7QWONTzDKF+plX+U1V5cx7tC6xjNXGdB/idi
 NmCA==
X-Gm-Message-State: AGRZ1gIb1h+0xajiKS5JH0LdS/ZNS2qs++R0zoxYdxpFosmjA3v8z3Gx
 UjFJBn49WJcL6EbeQQRU7XeLx+K+
X-Google-Smtp-Source: AJdET5c7Q3Ex91oAieBG6V8/QltbD1Lx+qjakfYepXbUYIq8odu9bCAaIyCv0kH7jxmCrkPb2E7D2A==
X-Received: by 2002:a0c:d851:: with SMTP id i17mr2995983qvj.211.1540997009348; 
 Wed, 31 Oct 2018 07:43:29 -0700 (PDT)
Received: from [10.0.0.11] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id p83sm5720829qki.88.2018.10.31.07.43.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 07:43:28 -0700 (PDT)
Subject: Re: [PATCH 3/9] powerpc/mm: Remove extern from function definition
To: LEROY Christophe <christophe.leroy@c-s.fr>, mpe@ellerman.id.au
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
 <1540220060-30162-3-git-send-email-leitao@debian.org>
 <20181023173828.Horde.uVbl4TiimFw-HLaYHTWqNw9@messagerie.si.c-s.fr>
 <3bd3ed6e-3390-a80f-59f8-c1cc0efaa10f@debian.org>
 <20181024171228.Horde.g2r8Qp5NqN_pn0TW6sUFCw6@messagerie.si.c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <8046a74f-6931-8f1a-6e27-57aeb04766c9@debian.org>
Date: Wed, 31 Oct 2018 11:43:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024171228.Horde.g2r8Qp5NqN_pn0TW6sUFCw6@messagerie.si.c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On 10/24/18 12:12 PM, LEROY Christophe wrote:
> Breno Leitao <leitao@debian.org> a écrit :
> 
>> hi Christophe,
>>
>> On 10/23/2018 12:38 PM, LEROY Christophe wrote:
>>> Breno Leitao <leitao@debian.org> a écrit :
>>>>
>>>> This patch removes the keyword from the definition part, while keeps
>>>> it in
>>>> the declaration part.
>>>
>>> I think checkpatch also says that extern should be avoided in
>>> declarations.
>>
>> Thanks for the review. I tried to look at this complain, but I didn't see
>> this behavior on checkpatch.pl from kernel 4.19. I created a commit
>> that adds
>> a new extern prototype and checked the patch. Take a look:
> 
> Use option --strict with checkpatch.pl

Thanks. I fixed this patch and resent a v2 with this fix.

Michael,

If you happen to accept this series, please ignore this patch (3/9) and
use a v2 as its replacement:

https://patchwork.ozlabs.org/patch/991444/
