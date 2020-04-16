Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81973C2BB55
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 04:13:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494B220767
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 04:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B220767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492m6v1KK5zDqkp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=59.111.176.18; helo=m17618.mail.qiye.163.com;
 envelope-from=wenhu.wang@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492m512fsTzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 14:11:43 +1000 (AEST)
Received: from ubuntu.localdomain (unknown [58.251.74.226])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 5B1A54E17F0;
 Thu, 16 Apr 2020 12:11:32 +0800 (CST)
From: Wang Wenhu <wenhu.wang@vivo.com>
To: oss@buserror.net, Wang Wenhu <wenhu.wang@vivo.com>,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2,
 1/5] powerpc: 85xx: make FSL_85XX_CACHE_SRAM configurable
Date: Wed, 15 Apr 2020 21:11:13 -0700
Message-Id: <20200416041113.112735-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <36961f9d8c533d8b576043a2c6fc4859accfd9f1.camel@buserror.net>
References: <36961f9d8c533d8b576043a2c6fc4859accfd9f1.camel@buserror.net>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVJTkhLS0tJTkJIQkJPSllXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6NSo6LTg2PAg9MEIrTD0V
 NRAaFE9VSlVKTkNMS0pLSUJPTE9PVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
 Q1VJTkpVTE9VSUlNWVdZCAFZQUlNSEI3Bg++
X-HM-Tid: 0a71812f4ba89376kuws5b1a54e17f0
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
Cc: kernel@vivo.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Scott Wood <oss@buserror.net>

>> +	bool "32-bit kernel"
>
>Why make that user selectable ?
>
>Either a kernel is 64-bit or it is 32-bit. So having PPC64 user 
>selectable is all we need.
>
>And what is the link between this change and the description in the log ?
>
>>   	default y if !PPC64
>>   	select KASAN_VMALLOC if KASAN && MODULES
>>   
>> @@ -15,6 +15,7 @@ config PPC_BOOK3S_32
>>   	bool
>>   
>>   menu "Processor support"
>> +
>
>Why adding this space ?
>
>>   choice
>>   	prompt "Processor Type"
>>   	depends on PPC32
>> @@ -211,9 +212,9 @@ config PPC_BOOK3E
>>   	depends on PPC_BOOK3E_64
>>   
>>   config E500
>> +	bool "e500 Support"
>>   	select FSL_EMB_PERFMON
>>   	select PPC_FSL_BOOK3E
>> -	bool
>
>Why make this user-selectable ? This is already selected by the 
>processors requiring it, ie 8500, e5500 and e6500.
>
>Is there any other case where we need E500 ?
>
>And again, what's the link between this change and the description in 
>the log ?
>
>
>>   
>>   config PPC_E500MC
>>   	bool "e500mc Support"
>> 
>
>Christophe

Hi, Scott, Christophe!

I find that I did not get the point well of the defferences between
configurability and selectability(maybe words I created) of Kconfig items.

You are right that FSL_85XX_CACHE_SRAM should only be selected by a caller
but never enable it seperately.

Same answer for the comments from Christophe. I will drop this patch in v3.

Thanks,
Wenhu
