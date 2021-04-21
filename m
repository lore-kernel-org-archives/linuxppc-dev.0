Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D422C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 06:13:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF8F613DE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 06:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF8F613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQ9GD4Yfbz30J0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 16:13:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQ9Fs4bSXz2xZm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 16:12:48 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FQ9Fm5p1Yz9txtZ;
 Wed, 21 Apr 2021 08:12:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uoidS_nNDIN5; Wed, 21 Apr 2021 08:12:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FQ9Fm52lxz9txtY;
 Wed, 21 Apr 2021 08:12:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C05E8B815;
 Wed, 21 Apr 2021 08:12:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id B5fpCyXSl8YB; Wed, 21 Apr 2021 08:12:45 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 03E478B814;
 Wed, 21 Apr 2021 08:12:44 +0200 (CEST)
Subject: Re: powerpc{32,64} randconfigs
To: Randy Dunlap <rdunlap@infradead.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <45afab41-cc5f-dffa-712a-d5fb1a9d0a23@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <11333059-50b4-35e6-4101-d21e28ffec7d@csgroup.eu>
Date: Wed, 21 Apr 2021 08:12:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <45afab41-cc5f-dffa-712a-d5fb1a9d0a23@infradead.org>
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
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/04/2021 à 01:31, Randy Dunlap a écrit :
> --- linux-next-20210420.orig/arch/powerpc/platforms/Kconfig.cputype
> +++ linux-next-20210420/arch/powerpc/platforms/Kconfig.cputype
> @@ -1,11 +1,12 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config PPC32
>   	bool
> -	default y if !PPC64
> +	default y if !PPC64 || "$(ARCH)" = "ppc32"

I don't think you need that change. If the ARCH is neither 'powerpc' not 'ppc64' CONFIG_PPC64 isn't 
set so CONFIG_PPC32 is set.


>   	select KASAN_VMALLOC if KASAN && MODULES
>   
>   config PPC64
> -	bool "64-bit kernel"
> +	bool "64-bit kernel" if "$(ARCH)" = "powerpc"
> +	default y if "$(ARCH)" = "ppc64"
>   	select ZLIB_DEFLATE
>   	help
>   	  This option selects whether a 32-bit or a 64-bit kernel
