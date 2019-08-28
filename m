Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE2C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 15:30:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66982077B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 15:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFysR3J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66982077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JV7g0S4LzDqNf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 01:30:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=jsmart2021@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFysR3J8"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JV4n5XTyzDr2c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 01:28:22 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id m3so1637334pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K1Wo1uryMad+JJHaOOhI3eSiwsKm2WkRf/8nzV4iG5o=;
 b=GFysR3J8M2/ErxWakUhYzi+sSNmBeOJsqfZEFYbxE1KjTRbEdMgPJwDSY2sfWBF4M7
 m554SzdeYG0q9h/3O3YP6S2ney8bZM6NSUhhOs+BcEYtnRmLb27/zrn1sJZtev1TbNe8
 Ai8qsV+khBr3j4Yeyz+kBWE8P0eeENZ+6OFFzS80tsvOSrP0xUaSlO1uH6C13cFJ1009
 cxRzDP706pd2EsdANnd/MK7GNAPYq8p3tpJ8PjWaOCxXwYlQQGvYBgvVjchn42TnWe65
 11Wwhjjeaz6joh+i8Sr2d4JPadlNYYU7M2Bgrc23JlOSFDz4XSx0ovXC/EBXU/ZO9zLX
 +74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K1Wo1uryMad+JJHaOOhI3eSiwsKm2WkRf/8nzV4iG5o=;
 b=SuNc+af5egwjPwO0eX4d2pr87Mr2OuP6MEa8sX+q4zCVEto6g03ifWO+OBiTmwGzKC
 jb1tMl/2CYZX6fgXmxq2Tt6cBYN0WsVUvhSCikTXqrh4wHQcWVgRKSYAtd8l6V6VkBLU
 E7VD3xvCmGW237z/6NGvbuZcM0Qr/6vIkvhZKuMhkV/9IYb8cm4zJA9zROzv5Q9X2gnX
 /6OViXjTpeHsUuirbq7UvyVQ++vmrIy8f9lJl6RSyIRG/g1YUg3u1ybKt4m6BmIMFl9a
 0D3y/i5tY+BdEf89FUB2vJJATtLlGa1G8A3xi6S0OxJnQQfUlisGDTbFcUnCMzwn2Pg1
 a3hw==
X-Gm-Message-State: APjAAAUm7Xb6a6ce+oxg8Q4IEbfC9t6QIunK5p/EAx1PpjmSZdlFDGvL
 JCTuFnxNpjmufn53XySfS/I=
X-Google-Smtp-Source: APXvYqwMulwQmSKyJYZ5XStrF/EheQfqT2YR1ENZMg7+TqRcL/vGToHCYNsXooYGBikFTAvDL3sR0g==
X-Received: by 2002:a17:90a:bc06:: with SMTP id
 w6mr5002407pjr.130.1567005743009; 
 Wed, 28 Aug 2019 08:22:23 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g1sm3330822pgg.27.2019.08.28.08.22.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 08:22:22 -0700 (PDT)
Subject: Re: [linux-next][BUG][driver/scsi/lpfc][10541f] Kernel panics when
 booting next kernel on my Power 9 box
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1566968536.23670.9.camel@abdul>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <601365f6-c753-96f6-5d61-481f54d95440@gmail.com>
Date: Wed, 28 Aug 2019 08:22:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566968536.23670.9.camel@abdul>
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, dick.kennedy@broadcom.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 dougmill <dougmill@linux.vnet.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 manvanth <manvanth@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/27/2019 10:02 PM, Abdul Haleem wrote:
> Greetings,
> 
> linux-next kernel 5.3.0-rc1 failed to boot with kernel Oops on Power 9
> box
> 
> I see a recent changes to lpfc code was from commit
> 10541f03 scsi: lpfc: Update lpfc version to 12.4.0.0
> 
> Recent boot logs:
> 
> [..snip..]

see  https://www.spinics.net/lists/linux-scsi/msg133343.html

It hasn't been tested yet, but appears to be the issue.

-- james
