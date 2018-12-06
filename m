Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5433FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:20:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7438720989
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7438720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Rnv0G6CzDr5s
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 18:20:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 439RlY5xfvzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 18:18:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 439RlR1Wczz9vGy0;
 Thu,  6 Dec 2018 08:18:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6HAAqbnUVXwV; Thu,  6 Dec 2018 08:18:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 439RlR0sVSz9vGxx;
 Thu,  6 Dec 2018 08:18:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B5BB8B75F;
 Thu,  6 Dec 2018 08:18:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id STZPDPwlG50x; Thu,  6 Dec 2018 08:18:11 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 73AF28B77E;
 Thu,  6 Dec 2018 08:18:11 +0100 (CET)
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kim Phillips <kim.phillips@freescale.com>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f570563c-1cc7-fecf-2ed2-58164047ec9d@c-s.fr>
Date: Thu, 6 Dec 2018 08:18:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <87sgzchcw8.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/12/2018 à 04:26, Michael Ellerman a écrit :
> Hi Dan,
> 
> Thanks for the patch.
> 
> Dan Carpenter <dan.carpenter@oracle.com> writes:
>> The ipic_info[] array only has 95 elements so I have made the bounds
>> check smaller to prevent a read overflow.  It was Smatch that found
>> this issue:
>>
>>      arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
>>      error: buffer overflow 'ipic_info' 95 <= 127
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I wasn't able to find any callers of this code.  Maybe we removed the
>> last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
>> host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
>> should just remove it.  I'm not really comfortable doing that myself,
>> because I don't know the code well enough and can't build test
>> it properly.
> 
> Hah wow, last usage removed in 2006!
> 
> I don't see any mention of it since then, so I'll remove it. If it
> breaks something we can put it back.
> 
> Can smatch help us find things like this that are defined non-static but
> never used?
> 

I think we have to do that carrefully. Some of those functions might be 
used by out-of-tree boards.

I'm thinking especially at ipic_get_mcp_status() and 
ipic_set_mcp_status(). They are used in my 832x boards's machine check 
handler to know when a machine check is a timeout from the 832x watchdog.

Christophe
