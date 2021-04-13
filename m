Return-Path: <SRS0=AS1h=JK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA55C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 16:34:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD9760720
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD9760720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FKWQp2TKjz3bV1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 02:34:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FKWQQ5QJcz2yy7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2021 02:34:01 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FKWQ85jTzz9tyy6;
 Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0dXyJCLmzTLu; Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FKWQ84QPdz9v20H;
 Tue, 13 Apr 2021 18:33:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED1198B7AC;
 Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hU_iZ0QrHbVB; Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7453D8B75F;
 Tue, 13 Apr 2021 18:33:53 +0200 (CEST)
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when possible
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412215428.GM26583@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
Date: Tue, 13 Apr 2021 18:33:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412215428.GM26583@gate.crashing.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/04/2021 à 23:54, Segher Boessenkool a écrit :
> Hi!
> 
> On Thu, Apr 08, 2021 at 03:33:44PM +0000, Christophe Leroy wrote:
>> For clear bits, on 32 bits 'rlwinm' can be used instead or 'andc' for
>> when all bits to be cleared are consecutive.
> 
> Also on 64-bits, as long as both the top and bottom bits are in the low
> 32-bit half (for 32 bit mode, it can wrap as well).

Yes. But here we are talking about clearing a few bits, all other ones must remain unchanged. An 
rlwinm on PPC64 will always clear the upper part, which is unlikely what we want.

> 
>> For the time being only
>> handle the single bit case, which we detect by checking whether the
>> mask is a power of two.
> 
> You could look at rs6000_is_valid_mask in GCC:
>    <https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/rs6000/rs6000.c;h=48b8efd732b251c059628096314848305deb0c0b;hb=HEAD#l11148>
> used by rs6000_is_valid_and_mask immediately after it.  You probably
> want to allow only rlwinm in your case, and please note this checks if
> something is a valid mask, not the inverse of a valid mask (as you
> want here).

This check looks more complex than what I need. It is used for both rlw... and rld..., and it 
calculates the operants. The only thing I need is to validate the mask.
I found a way: By anding the mask with the complement of itself rotated by left bits to 1, we 
identify the transitions from 0 to 1. If the result is a power of 2, it means there's only one 
transition so the mask is as expected.

So I did that in v2.


> 
> So yes this is pretty involved :-)
> 
> Your patch looks good btw.  But please use "n", not "i", as constraint?

Done.

Christophe
