Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:55:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A71B20881
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="N19zEt1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxvw5xQwzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:55:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="N19zEt1E"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qxst6DJVzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:53:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qxsp1W3Tz9ty6k;
 Thu, 31 Jan 2019 11:53:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=N19zEt1E; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jNsrFHxAsgTy; Thu, 31 Jan 2019 11:53:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qxsp0MFMz9ty6h;
 Thu, 31 Jan 2019 11:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548931998; bh=Ge2Ke7mi5a5ZWlCUxOOSAiFD+a6A85PCuNvYEukSmrg=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=N19zEt1EwMW+rLZfIkd1hbXLGEGmbrdZ4qB1pBdsNidFXvP8OMjTTEJaPkHN/Thjl
 /dp3/gvdgXoTF6vwRVACz+DYVoTCJPsr5NxHrlT/Ip00Uqk7uVMk/GA/6ZEMl4XEUK
 82giiFzWR976qKrVAY5ZFsdV4wX/oijhm8pC32gY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E22308B818;
 Thu, 31 Jan 2019 11:53:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id j2t2dylNX2S2; Thu, 31 Jan 2019 11:53:18 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EAD5D8B78D;
 Thu, 31 Jan 2019 11:53:17 +0100 (CET)
Subject: Re: Does SMP work at all on 40x ?
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, 
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <5c170dab-4f0b-8be2-e99a-9afd0fa02394@c-s.fr>
 <871s4uqskb.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b0a16b8f-308a-e59a-f3d9-7f7360835e86@c-s.fr>
Date: Thu, 31 Jan 2019 11:53:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <871s4uqskb.fsf@concordia.ellerman.id.au>
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



Le 30/01/2019 à 12:43, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> In transfer_to_handler() (entry_32.S), we have:
>>
>> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>> ...
>> #ifdef CONFIG_SMP
>> 	CURRENT_THREAD_INFO(r9, r1)
>> 	lwz	r9,TI_CPU(r9)
>> 	slwi	r9,r9,3
>> 	add	r11,r11,r9
>> #endif
>> #endif
>>
>> When running this piece of code, MMU translation is off. But r9 contains
>> the virtual addr of current_thread_info, so unless I miss something,
>> this cannot work on the 40x, can it ?
>>
>> On CONFIG_BOOKE it works because phys addr = virt addr
> 
> AFAIK 40x can't be SMP:
> 
>    config SMP
>    	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE || PPC_47x
> 
> 
> But this stuff is all before my time.
> 
> The commit that added the SMP block was clearly only meant for BookE:
> 
>    4eaddb4d7ec3 ("[POWERPC] Make Book-E debug handling SMP safe")

Ok, then no need to worry about it. It will implicitely get fixed with 
the THREAD_INFO_IN_TASK_STRUCT series.

Christophe
