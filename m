Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F76C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 14:59:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B201F2064A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 14:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jMN7jmvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201F2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZmMJ5y8fzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 01:59:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="jMN7jmvl"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZmKZ0BH3zDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 01:58:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZmKN5brxz9tyYc;
 Thu,  4 Apr 2019 16:58:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=jMN7jmvl; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id oCj9zuRFZiQv; Thu,  4 Apr 2019 16:58:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZmKN4WBpz9tyYl;
 Thu,  4 Apr 2019 16:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554389896; bh=cMfZOVmqzpmPRuKNX9ovRJrfpu2XRoXYeTIcOnWt5x4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jMN7jmvl7vZduX0UglFcfQp3Piav6rY4MwOCc4KrGsPZL2zX9Lyqkm1EKnu0sotzf
 7FZRaPkQRsv5VY90Cnk56ODcpTNE7wOY4bzkkl2ZrYHrIctrwdj/e8EUtLt7NWDVR7
 1xVPmCgWHXiFJba0UcdEi0al4VKWi35iUtt7AlSU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D1278B917;
 Thu,  4 Apr 2019 16:58:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nY2xWqsVm5Vu; Thu,  4 Apr 2019 16:58:18 +0200 (CEST)
Received: from PO15451 (unknown [192.168.204.43])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 68E4B8B92A;
 Thu,  4 Apr 2019 16:58:17 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/vmlinux.lds: Drop binutils < 2.18 workarounds
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>
References: <20190329064453.12761-1-joel@jms.id.au>
 <20190329095318.GJ3969@gate.crashing.org>
 <CACPK8Xes6+j+bjCbqwBLJpvP-Hi_WzbtEwfUSzJjeAW9jwFRKA@mail.gmail.com>
 <20190404145333.GC8599@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <de3aa487-4de9-a7d6-3280-c7be2460f0ec@c-s.fr>
Date: Thu, 4 Apr 2019 16:58:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404145333.GC8599@gate.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/04/2019 à 16:53, Segher Boessenkool a écrit :
> Hi Joel,
> 
> On Thu, Apr 04, 2019 at 12:17:40PM +0000, Joel Stanley wrote:
>> On Fri, 29 Mar 2019 at 09:53, Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>>> On Fri, Mar 29, 2019 at 05:14:53PM +1030, Joel Stanley wrote:
>>>> -     NOTES :kernel :notes
>>>> +     NOTES
>>>
>>> I think this still need to be
>>>
>>>          NOTES :kernel
>>>
>>> or the linker will complain.  Did you try to build ppc64_defconfig?
>>
>> Yeah, I did build (and boot, in qemu) the ppc64_defconfig. I tried
>> leaving in/removing the :kernel annotation in a bunch of places and as
>> long as I had it in the first spot, the kernel linked.
>>
>> Shall I respin with this added?
> 
> Yes please, if only so we are testing the exact same thing :-)
> 
> There may be a binutils version difference here.
> 
>>> (And I do not know if there are any tools that expect the notes in a phdr,
>>> or even specifically the second phdr).
> 
> ^^^ This question remains?

A few days ago while I was investigating 
https://github.com/linuxppc/issues/issues/208 , I had the feeling that 
QEMU expects some sort of NOTES section.

I didn't investigate further though.

Christophe
