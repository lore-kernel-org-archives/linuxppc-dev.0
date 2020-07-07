Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A83EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 13:39:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30D420658
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 13:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30D420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1Nnh0bwrzDqpy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 23:39:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1Njz1lGFzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 23:35:48 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4B1Njq1JYkz9tyDq;
 Tue,  7 Jul 2020 15:35:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hCWgdyVLIS1v; Tue,  7 Jul 2020 15:35:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4B1Njq0G6Sz9tyDp;
 Tue,  7 Jul 2020 15:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D994F8B7E3;
 Tue,  7 Jul 2020 15:35:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WKBcZEmXlIcl; Tue,  7 Jul 2020 15:35:44 +0200 (CEST)
Received: from [10.25.210.22] (po15451.idsi0.si.c-s.fr [10.25.210.22])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB8578B7D7;
 Tue,  7 Jul 2020 15:35:44 +0200 (CEST)
Subject: Re: kernel since 5.6 do not boot anymore on Apple PowerBook
To: Giuseppe Sacco <giuseppe@sguazz.it>, linuxppc-dev@lists.ozlabs.org
References: <89e412a76350b28f791bb8a2b6f9647a034f6fc8.camel@sguazz.it>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <04544f16-fb20-54b9-e56e-47d45af03b6c@csgroup.eu>
Date: Tue, 7 Jul 2020 15:35:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <89e412a76350b28f791bb8a2b6f9647a034f6fc8.camel@sguazz.it>
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

Hi,

Le 07/07/2020 à 14:58, Giuseppe Sacco a écrit :
> Hello,
> I am testing linux on a quite old hardware, an Apple PowerBook G4
> "Titanium IV". I used to run Debian on this machine, so I upgraded the
> old operating system to the latest software and found that new kernels
> do not boot.
> I rebuilt natively (on the powerbook) a few kernels and found that
> 5.4.50 still works fine, while 5.6.19 and 5.7.7 stop after printing:
> 
> pmac32_cpufreq: registering PowerMac CPU frequency driver
> pmac32_cpufreq: Low: 667 MHz, High: 867 Mhz, Boot: 667 MHz
> 
> no more output is printed. I waited 5 minutes and then powered off the
> machine using the power button. Rebooting with old kernel works.
> 
> So, I am looking for help. How may I better investigate the problem?
> How may I crossbuild the kernel on a faster machine (amd64) in order to
> try git-bisect without waiting ages?
> 

To crossbuild, use cross tools at 
https://mirrors.edge.kernel.org/pub/tools/crosstool/

Can you tell which defconfig you use or provide your .config

Christophe
