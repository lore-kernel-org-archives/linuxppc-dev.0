Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F5BC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 18:24:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E296A20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 18:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E296A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dhhc6LRhzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 05:24:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dhfn3FsyzDqKt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 05:23:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43dhfh3075z9vCHq;
 Mon, 14 Jan 2019 19:23:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id iZ-ulGqJOV6r; Mon, 14 Jan 2019 19:23:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43dhfh2Vmlz9vCHp;
 Mon, 14 Jan 2019 19:23:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D3C2C8B7CF;
 Mon, 14 Jan 2019 19:23:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VMAGwYmdKohg; Mon, 14 Jan 2019 19:23:08 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D752E8B7AC;
 Mon, 14 Jan 2019 19:23:07 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
Date: Mon, 14 Jan 2019 19:23:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190113210227.GB22334@latitude>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/01/2019 à 22:02, Jonathan Neuschäfer a écrit :
> On Sun, Jan 13, 2019 at 08:43:07PM +0100, Christophe Leroy wrote:
>> Le 13/01/2019 à 19:16, Jonathan Neuschäfer a écrit :
>>> I just tested the whole series on my Wii (I didn't test any intermediate
>>> steps). Without CONFIG_STRICT_KERNEL_RWX, it seems to work fine, but
>>> with it, I get the following error while booting:
>>
>> Argh !
>>
>> Can you please send the System.map file generated at compile time ?
> 
> Here:
>    https://gist.githubusercontent.com/neuschaefer/12ccc87ff8aeff543fad558e8742cd2b/raw/d49d321709cac364779e6893bbd91ff5a80bcb03/System.map
> 
> And here's the config, reduced with 'make savedefconfig':
>    https://gist.githubusercontent.com/neuschaefer/12ccc87ff8aeff543fad558e8742cd2b/raw/d49d321709cac364779e6893bbd91ff5a80bcb03/config
> 
> The exact code I used is here:
>    https://github.com/neuschaefer/linux/tree/ppcbat-test

Thanks

I can't see anything special in your setup, and this failure looks 
rather unexpected because I can't see anything done that early when 
CONFIG_STRICT_KERNEL_RWX is selected.

Does CONFIG_STRICT_KERNEL_RWX works properly without my serie ?

Christophe

> 
> 
> Thanks,
> Jonathan
> 
