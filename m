Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1878C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 09:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E017619BD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 09:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E017619BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9LK23p3nz3c6x
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 20:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9LJg23hmz30Mp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 20:15:45 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F9LJY3T27z9v07B;
 Wed, 31 Mar 2021 11:15:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qd8wwnjoz3M6; Wed, 31 Mar 2021 11:15:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F9LJY24hVz9v079;
 Wed, 31 Mar 2021 11:15:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4857B8B7F4;
 Wed, 31 Mar 2021 11:15:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id r0VLFysz6y72; Wed, 31 Mar 2021 11:15:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C37928B75B;
 Wed, 31 Mar 2021 11:15:41 +0200 (CEST)
Subject: Re: WARNING: CPU: 0 PID: 1 at arch/powerpc/lib/feature-fixups.c:109
 do_feature_fixups+0xb0/0xf0
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <bc1d3a33-2499-994e-860a-b50cf72b9619@molgen.mpg.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4d973f54-e080-057f-6ad1-17396e5afb4c@csgroup.eu>
Date: Wed, 31 Mar 2021 11:15:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <bc1d3a33-2499-994e-860a-b50cf72b9619@molgen.mpg.de>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Paul,

Le 30/03/2021 à 12:37, Paul Menzel a écrit :
> Dear Linux folks,
> 
> 
> On the POWER8 system IBM S822LC, Linux 5.12-rc5+ logs the warning below.
> 
> ```
> [    0.724118] Unable to patch feature section at (____ptrval____) - (____ptrval____) with 
> (____ptrval____) - (____ptrval____)
> [    0.724185] pstore: Registered nvram as persistent store backend
> ```
> 
> Please find the output of `dmesg` attached.
> 
> 

Did you do a 'make clean' before building ?

If not, can you try patch 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/8bb015bc98c51d8ced581415b7e3d157e18da7c9.1617181918.git.christophe.leroy@csgroup.eu/

Thanks
Christophe
