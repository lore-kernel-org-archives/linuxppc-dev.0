Return-Path: <SRS0=1bSx=7A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F84FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 17:17:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD272207ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 17:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD272207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Qm0V5QZzzDqf4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 03:17:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QlyK4H5rzDqSK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2020 03:15:13 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49Qlxv4bBHz9txL0;
 Mon, 18 May 2020 19:14:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OShXfZPyI8I8; Mon, 18 May 2020 19:14:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49Qlxv3QWvz9txKy;
 Mon, 18 May 2020 19:14:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AB8EA8B7A7;
 Mon, 18 May 2020 19:15:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qGBdn49tVpu5; Mon, 18 May 2020 19:15:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 686248B76A;
 Mon, 18 May 2020 19:15:06 +0200 (CEST)
Subject: Re: [Regression 5.7-rc1] Random hangs on 32-bit PowerPC (PowerBook6,7)
To: Rui Salvaterra <rsalvaterra@gmail.com>
References: <CALjTZvZ69v3Z=8MY28F+p8v8_Z5e+7NrH0PAJ7TGD9kh6Ab7bw@mail.gmail.com>
 <3729805f-2638-6f0e-55fa-bd7d5c173899@csgroup.eu>
 <CALjTZvZ0gjZOpx7GuJ4ccawqpyOjr4N_C7UCQQHrrFR1Ojrh4g@mail.gmail.com>
 <d4f02b20-8b3e-fd88-6857-c2e4dc7786da@csgroup.eu>
 <CALjTZvZ1NyVOhX+qJZSqO_8shn9yD76DBBg0t9UeFUyzom=PBw@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c00ed41c-e13e-6bd6-4084-501ca14adb4c@csgroup.eu>
Date: Mon, 18 May 2020 19:15:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvZ1NyVOhX+qJZSqO_8shn9yD76DBBg0t9UeFUyzom=PBw@mail.gmail.com>
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
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/05/2020 à 17:19, Rui Salvaterra a écrit :
> Hi again, Christophe,
> 
> On Mon, 18 May 2020 at 15:03, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> Can you try reverting 697ece78f8f749aeea40f2711389901f0974017a ? It may
>> have broken swap.
> 
> Yeah, that was a good call. :) Linux 5.7-rc1 with the revert on top
> survives the beating. I'll be happy to test a definitive patch!
> 

Yeah I discovered recently that the way swap is implemented on powerpc 
expects RW and other important bits not be one of the 3 least 
significant bits (see __pte_to_swp_entry() )

I guess the easiest for the time being is to revert the commit with a 
proper explanation of the issue, then one day we'll modify the way 
powerpc manages swap.

Christophe
