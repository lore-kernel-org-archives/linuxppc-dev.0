Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB2EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7F420657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YAPZ7hYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7F420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gLkG6R1VzDqpq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="YAPZ7hYs"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gLgZ07J6zDqjN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 21:59:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43gLgS1XXHz9v2C2;
 Thu, 17 Jan 2019 11:59:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YAPZ7hYs; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 46iSN4xSOAEa; Thu, 17 Jan 2019 11:59:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43gLgR74jzz9v2By;
 Thu, 17 Jan 2019 11:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547722772; bh=j1qBj5EFQPkYjhifaDgiu5IwIYflUbomCpdiIJbHl/U=;
 h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
 b=YAPZ7hYsHmTktDoksvOoxa2yyn51SEVR72WkZZ38CaF1XeW5ZhNiY7OaiolfkllOJ
 ucbVpENyb82HZnuOu18Rbu2naXfZi5E1CA8lpbl5x5p4HT9YP9tNy61TC2rV8lcqTu
 D1MhpnINTPGbPCPv30HRLc4UIOPF07KBQs9ZC9iQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AAAB8B858;
 Thu, 17 Jan 2019 11:59:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id srtPCZbvyH-Y; Thu, 17 Jan 2019 11:59:33 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C8918B75B;
 Thu, 17 Jan 2019 11:59:32 +0100 (CET)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RESENDING PATCH] powerpc/wii: properly disable use of BATs when
 requested.
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <7e6748349978f4f177b6a1f3f1c773da98ae3b59.1547570012.git.christophe.leroy@c-s.fr>
 <20190117010509.GH22334@latitude>
Message-ID: <19fd4dd4-ece2-d508-1ed5-5a9ed2aa84fe@c-s.fr>
Date: Thu, 17 Jan 2019 11:29:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117010509.GH22334@latitude>
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/01/2019 à 02:05, Jonathan Neuschäfer a écrit :
> Hi again,
> 
> On Tue, Jan 15, 2019 at 04:43:20PM +0000, Christophe Leroy wrote:
>> 'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
>> deny the use of BATS for mapping memory.
>>
>> This patch makes sure that the specific wii RAM mapping function
>> takes it into account as well.
>>
>> Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
> [...]
>>   	/* MEM2 64MB@0x10000000 */
>>   	delta = wii_hole_start + wii_hole_size;
>> +	if (__map_without_bats)
>> +		return delta;
>> +
> 
> Nothing is visibly broken without this patch, even with
> CONFIG_DEBUG_PAGEALLOC (tested on top of v5.0-rc2), but the patch still
> looks correct.

Obviously, CONFIG_DEBUG_PAGEALLOC cannot work without this patch.
The purpose of CONFIG_DEBUG_PAGEALLOC is to unmap unused parts of memory 
so that any access to them will pagefault.

As this function inconditionnaly sets a BAT for the second block of RAM, 
any access to free area in the upper block will be granted without a fault.

I think you can test it by doing a kmalloc() then a kfree(), then try to 
read in that area (hopefully kmalloc() allocates memory from the top so 
it should go in the upper block). Maybe there is an LKDTM test for that.

> 
> I'd prefer the 'if' block to be before the whole delta/size calculation,
> to make the code slightly more readable because the delta and size
> calculations stay in one visual block. It doesn't need to happen after
> delta is calculated.

Euh ... the function has to return 'delta', so if I put the if block 
before the calculation of delta, it means we have to calculate delta twice:

	if (__map_without_bats)
		return wii_hole_start + wii_hole_size;

	delta = wii_hole_start + wii_hole_size;

My eyes don't really like it, so if we want to keep delta and size 
calculation together, the 'if' will go after calculation of size.

In anycase, this change is only really for fixing stable releases 
because this function will go away with my other serie.

Christophe

> 
> tentatively,
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> 
> Thanks,
> Jonathan
> 
