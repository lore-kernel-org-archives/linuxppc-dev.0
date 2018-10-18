Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34912C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 04:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A612B208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 04:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A612B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bGpy5hCszF3SB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 15:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bGmm1pjjzF3Qn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:49:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bGmg4FTzz9ttBQ;
 Thu, 18 Oct 2018 06:49:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id B-rE6LeJOQtD; Thu, 18 Oct 2018 06:49:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bGmg3YMjz9ttBP;
 Thu, 18 Oct 2018 06:49:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B4F58B75E;
 Thu, 18 Oct 2018 06:49:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SmC0HsD_P1HO; Thu, 18 Oct 2018 06:49:39 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E70A98B74C;
 Thu, 18 Oct 2018 06:49:37 +0200 (CEST)
Subject: Re: MPC8321 boot failure
To: David Gounaris <David.Gounaris@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <CY1PR10MB020424967E404E0B1BBE1E82EFFF0@CY1PR10MB0204.namprd10.prod.outlook.com>
 <0cbfec90-0e58-e267-71ae-c5fc8a8e0640@c-s.fr>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d534ec86-840e-11c9-fee6-f758370a9a0e@c-s.fr>
Date: Thu, 18 Oct 2018 06:49:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0cbfec90-0e58-e267-71ae-c5fc8a8e0640@c-s.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Mathias Thore <Mathias.Thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

I can now confirm that the boot failure is due to the absence of commit 
8183d99f4a22 ("powerpc/lib/feature-fixups: use raw_patch_instruction()")

Greg, could you please apply that patch to 4.14 stable ?

Thanks
Christophe

Le 17/10/2018 à 18:36, Christophe LEROY a écrit :
> Hi,
> 
> Yes I discovered the same issue today on MPC8321E, I plan to look at it 
> more closely tomorrow morning (Paris Time).
> 
> I think we are missing commit 8183d99f4a22c2abbc543847a588df3666ef0c0c , 
> I didn't realise it when we applied the serie to 4.14, 
> patch_instruction() is called too early without that patch.
> 
> If you have opportunity to test now, you are welcome, otherwise I'll 
> test it tomorrow.
> 
> Christophe
> 
> Le 17/10/2018 à 17:18, David Gounaris a écrit :
>> Hello, I got into troubles when I upgraded to Linux kernel 4.14.76 on 
>> boards with MPC8321.
>>
>>
>> The symptom that I see is that the boot process gets cyclic, and no 
>> printouts are seen from the Linux kernel. It seems like it resets.
>>
>>
>> When I revert the following commits it works again.
>>
>> af1a8101794dfea897290e057f61086dabfe6c91, powerpc/lib: fix book3s/32 
>> boot failure due to code patching
>> 609fbeddb24c4035d24fc32d82dc08b30ae3dfc0, powerpc: Avoid code patching 
>> freed init sections
>>
>> Any ideas of how to continue?
>>
>> BR / David Gounaris
>>
>>
>>
