Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3123C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3758218D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eu6pzFAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3758218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r19M5CX4zDqcQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 00:21:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="eu6pzFAK"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r17Q1r3DzDqbt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 00:20:18 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43r17K37FczB09b3;
 Thu, 31 Jan 2019 14:20:13 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=eu6pzFAK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 75wqYWc_OCAD; Thu, 31 Jan 2019 14:20:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43r17K21lhzB09b2;
 Thu, 31 Jan 2019 14:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548940813; bh=GmMo5IBEK2DXMYFK56LLsMM4XCc2b2n8Xsp2cDrgy5c=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=eu6pzFAKNY8LVJ+mu5ZHzx9JtYwGC9i6IQrBR1XmUJYrjLVw4nmx5NIAzmjAjpsnN
 5LBHla63i2yQrISpPqy4YYBoyd2nwiYXus5yKQAN0eBU5JNLsqRijyx6BtmS+VDcQz
 cYTBqgx8YytCbXODwdutlUKCmgzvNiV5kKb1iBcA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 97B248B825;
 Thu, 31 Jan 2019 14:20:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KwjlFfwcHrE2; Thu, 31 Jan 2019 14:20:14 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 38DAD8B78D;
 Thu, 31 Jan 2019 14:20:14 +0100 (CET)
Subject: Re: [PATCH] powerpc: Ensure gcc doesn't move around cache flushing in
 __patch_instruction
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <48284701fe497bb4f5bede5c55bbce9d70309562.camel@kernel.crashing.org>
 <20180517192331.GZ17342@gate.crashing.org>
 <18a52794a30857146396dd6023abf17179db53d0.camel@kernel.crashing.org>
 <20180517230007.GC17342@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3fed77c7-5b0a-10fb-ad64-08e43554ffbd@c-s.fr>
Date: Thu, 31 Jan 2019 14:20:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20180517230007.GC17342@gate.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <michael.neuling@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/05/2018 à 01:00, Segher Boessenkool a écrit :
> On Fri, May 18, 2018 at 08:30:27AM +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2018-05-17 at 14:23 -0500, Segher Boessenkool wrote:
>>> On Thu, May 17, 2018 at 01:06:10PM +1000, Benjamin Herrenschmidt wrote:
>>>> The current asm statement in __patch_instruction() for the cache flushes
>>>> doesn't have a "volatile" statement and no memory clobber. That means
>>>> gcc can potentially move it around (or move the store done by put_user
>>>> past the flush).
>>>
>>> volatile is completely superfluous here, except maybe as documentation:
>>> any asm without outputs is always volatile.
>>
>> I wasn't aware of that. I was drilled early on to always stick volatile
>> in my asm statements if they have any form of side effect :-)
> 
> If an asm without output was not marked automatically as having another
> side effect, every such asm would be immediately deleted ;-)
> 
> Adding volatile as documentation for side effects can be good; it just
> doesn't do much (nothing, in fact) for asms without output as far as
> the compiler is concerned.
> 
>>> (And the memory clobber does not prevent the compiler from moving the
>>> asm around, or duplicating it, etc., and neither does the volatile).
>>
>> It prevents load/stores from moving around doesn't it ? I wanted to
>> make sure the store of the instruction doesn't move in/pass the asm. If
>> you say that's not needed then ignore the patch.
> 
> No, it's fine here, and you want either that or put exactly the memory
> you are touching in a constraint (probably overkill here).  I just
> wanted to say that a "memory" clobber does nothing more than say the
> asm touches some unspecified memory; there is no magic other meaning
> to it.  Your patch is correct, just the "volatile" part isn't needed,
> and the explanation was a bit cargo-culty ;-)
> 

Any plan to get that merged ?

Christophe
