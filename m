Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA31C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 15:32:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D6E20880
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 15:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WQwoCl9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D6E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444M720YjPzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 02:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="WQwoCl9C"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444M4c1VCnzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 02:30:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444M4W1rRLz9tyjQ;
 Wed, 20 Feb 2019 16:30:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=WQwoCl9C; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id INhw8yyY2Q8x; Wed, 20 Feb 2019 16:30:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444M4V5wvDz9tyjP;
 Wed, 20 Feb 2019 16:30:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550676634; bh=CbyYZSkhkr0KQuv85U/c83GdsR5h9Eq3NrW7FPUmMd0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WQwoCl9CxovpyjHCPA5MHfFT/wPjTPSF59RLBUAQiw6JIZUn3+K9gX6dVzHdJcJWp
 zPhzrD3T/F1+4RbPA7QLYE7vDSYpjq7qVLCgCZV72OioeUx1+hQtCv+5Y+Mo0f3YxC
 x/0M/RTrPmCMsBXWJ3VmgjJrtbVg048PrRzGhahc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 585928B844;
 Wed, 20 Feb 2019 16:30:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id p5qwV6hQgB5h; Wed, 20 Feb 2019 16:30:36 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 027A08B812;
 Wed, 20 Feb 2019 16:30:36 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <87fttuz0d3.fsf@concordia.ellerman.id.au>
 <8b072209-c845-20f5-8ff1-27ecd67b5c72@c-s.fr>
 <87ftsi7fwi.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8345946b-b224-d8cb-5bb9-3e38d9b0ba67@c-s.fr>
Date: Wed, 20 Feb 2019 16:30:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87ftsi7fwi.fsf@concordia.ellerman.id.au>
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



Le 20/02/2019 à 14:23, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Le 15/01/2019 à 11:22, Michael Ellerman a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>> Le 15/01/2019 à 01:33, Jonathan Neuschäfer a écrit :
>>> ...
>>>>>
>>>>> - patches 7 to 11 fail to build with this error (really a warning, but
>>>>>      arch/powerpc doesn't allow warnings by default):
>>>>>
>>>>> 	  CC      arch/powerpc/mm/ppc_mmu_32.o
>>>>> 	../arch/powerpc/mm/ppc_mmu_32.c:133:13: error: ‘clearibat’ defined but not used [-Werror=unused-function]
>>>>> 	 static void clearibat(int index)
>>>>> 		     ^~~~~~~~~
>>>>> 	../arch/powerpc/mm/ppc_mmu_32.c:115:13: error: ‘setibat’ defined but not used [-Werror=unused-function]
>>>>> 	 static void setibat(int index, unsigned long virt, phys_addr_t phys,
>>>>> 		     ^~~~~~~
>>>>> 	cc1: all warnings being treated as errors
>>>>
>>>> Argh ! I have to squash the patch bringing the new functions with the
>>>> one using them (patch 12). The result is a big messy patch which is more
>>>> difficult to review but that's life.
>>>
>>> You don't *have* to squash them.
>>>
>>> We like to preserve bisectability, but it's not a 100% hard requirement.
>>>
>>> Someone trying to bisect through those patches can always turn off
>>> -Werror with PPC_DISABLE_WERROR. But they probably can just skip them
>>> because they just add new code that's not called yet.
>>
>> Ok thanks for the note.
>>
>>>
>>> So I won't object if you send them as-is.
>>
>> Good to know. Anyway I think I will at least re-order so that the patch
>> using the new functions immediatly follows the one adding the functions.
>   
> Based on that I'm expecting a v3 of this series, right?

Right. Coming soon.

Christophe
