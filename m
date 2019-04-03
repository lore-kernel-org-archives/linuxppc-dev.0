Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8F2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:07:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C6D206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YE+VTJQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C6D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YvFp1HDmzDqDX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:07:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="YE+VTJQ5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YvD02LdszDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 16:05:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44YvCw1yCxz9v16N;
 Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YE+VTJQ5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id M4wI-XQ8K6LR; Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44YvCw0lXCz9v10J;
 Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554267932; bh=UYB4t7W+MEomOIELIAMAtRYtB+TapIPe+5KAY88OVkA=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=YE+VTJQ5WOXbsMRO/MeYHEWH3NrrhQaa4MxJ9eEAsDr4mQXP16CXkaIZbZOFXfUjB
 rg7CSIFf7OPoMCLSMnccLsULCxseIwETX8U9drkr6+QQ63cIpAsO0iGpAmDLv8KjQ9
 icM0G7XjwlkiY91Uo4HsJJAInpxFGBaUuMEBe0g4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D77568B77E;
 Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2VfhUlfrPTTB; Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 718CA8B754;
 Wed,  3 Apr 2019 07:05:32 +0200 (CEST)
Subject: Re: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
References: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <79a9370a-7c4b-80be-adab-6dcf3b0fa6f2@c-s.fr>
Date: Wed, 3 Apr 2019 07:05:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 03/04/2019 à 05:52, Christian Zigotzky a écrit :
> Please test VLC with the RC3 of kernel 5.1.
> 
> The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. Another user has already confirmed that [1]. This isn’t an April Fool‘s. ;-)

Could you bisect to identify the guilty commit ?

Thanks
Christophe

> 
> Thanks
> 
> [1] http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4256&start=20#p47561
> 
