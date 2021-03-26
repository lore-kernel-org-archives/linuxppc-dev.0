Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 06:19:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372DC61A36
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 06:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372DC61A36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6BdF3hmPz3c0t
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 17:19:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6Bct6P38z2xg4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 17:18:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F6Bcj15yQz9txtr;
 Fri, 26 Mar 2021 07:18:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EPzpYio6x8_7; Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F6Bch6s6pz9txtq;
 Fri, 26 Mar 2021 07:18:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C82E58B864;
 Fri, 26 Mar 2021 07:18:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pXAsruLCGJL2; Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D9C48B834;
 Fri, 26 Mar 2021 07:18:45 +0100 (CET)
Subject: Re: [PATCH v2 6/7] cmdline: Gives architectures opportunity to use
 generically defined boot cmdline manipulation
To: Will Deacon <will@kernel.org>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <2eb6fad3470256fff5c9f33cd876f344abb1628b.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303175747.GD19713@willie-the-truck>
 <8db81511-3f28-4ef1-5e66-188cf7cafad1@csgroup.eu>
 <20210325193216.GC16123@willie-the-truck>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <27de5349-0bc1-74c3-518f-2dcdc1a8cfaf@csgroup.eu>
Date: Fri, 26 Mar 2021 07:18:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210325193216.GC16123@willie-the-truck>
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
Cc: linux-arch@vger.kernel.org, robh@kernel.org,
 daniel@gimpelevich.san-francisco.ca.us, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, danielwa@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/03/2021 à 20:32, Will Deacon a écrit :
> On Thu, Mar 25, 2021 at 12:18:38PM +0100, Christophe Leroy wrote:
>>
>> - For ARM it means to append the bootloader arguments to the CONFIG_CMDLINE
>> - For Powerpc it means to append the CONFIG_CMDLINE to the bootloader arguments
>> - For SH  it means to append the CONFIG_CMDLINE to the bootloader arguments
>> - For EFI it means to append the bootloader arguments to the CONFIG_CMDLINE
>> - For OF it means to append the CONFIG_CMDLINE to the bootloader arguments
>>
>> So what happens on ARM for instance when it selects CONFIG_OF for instance ?
> 
> I think ARM gets different behaviour depending on whether it uses ATAGs or
> FDT.

As far as I can see, ARM uses either ATAGs only or both ATAGs and FDT. ATAGs is forced to 'y' when 
USE_OF is set. Do I miss something ?

> 
>> Or should we consider that EXTEND means APPEND or PREPEND, no matter which ?
>> Because EXTEND is for instance used for:
>>
>> 	config INITRAMFS_FORCE
>> 		bool "Ignore the initramfs passed by the bootloader"
>> 		depends on CMDLINE_EXTEND || CMDLINE_FORCE
> 
> Oh man, I didn't spot that one :(
> 
> I think I would make the generic options explicit: either APPEND or PREPEND.
> Then architectures which choose to define CMDLINE_EXTEND in their Kconfigs
> can select the generic option that matches their behaviour.
> 
> INITRAMFS_FORCE sounds like it should depend on APPEND (assuming that means
> CONFIG_CMDLINE is appended to the bootloader arguments).
> 


Christophe
