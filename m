Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C2DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 08:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7EF2145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7EF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430G8M3q3jzF3FJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:34:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 430G6K1V9YzF3PM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 19:32:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 430G676V56z9txvZ;
 Wed, 21 Nov 2018 09:32:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IAHMGtRtbQbW; Wed, 21 Nov 2018 09:32:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 430G675zNyz9txvW;
 Wed, 21 Nov 2018 09:32:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C54488B7FF;
 Wed, 21 Nov 2018 09:32:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QfZI9f9-l_5r; Wed, 21 Nov 2018 09:32:35 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7573E8B75F;
 Wed, 21 Nov 2018 09:32:35 +0100 (CET)
Subject: Re: [RFC PATCH v1 5/6] powerpc/mm: Add a framework for Kernel
 Userspace Access Protection
To: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
 <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
 <d5aa6ff391c0438371cae507e0b82a96eec4e979.camel@russell.cc>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f579dd05-975c-5e3f-1dd2-0702f1cf3fea@c-s.fr>
Date: Wed, 21 Nov 2018 09:32:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d5aa6ff391c0438371cae507e0b82a96eec4e979.camel@russell.cc>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/11/2018 à 03:26, Russell Currey a écrit :
> On Wed, 2018-11-07 at 16:56 +0000, Christophe Leroy wrote:
>> This patch implements a framework for Kernel Userspace Access
>> Protection.
>>
>> Then subarches will have to possibility to provide their own
>> implementation
>> by providing setup_kuap(), and lock/unlock_user_rd/wr_access
>>
>> We separate read and write accesses because some subarches like
>> book3s32 might only support write access protection.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Separating read and writes does have a performance impact, I'm doing
> some benchmarking to find out exactly how much - but at least for radix
> it means we have to do a RMW instead of just a write.  It does add some
> amount of security, though.
> 
> The other issue I have is that you're just locking everything here
> (like I was), and not doing anything different for just reads or
> writes.  In theory, wouldn't someone assume that they could (for
> example) unlock reads, lock writes, then attempt to read?  At which
> point the read would fail, because the lock actually locks both.
> 
> I would think we either need to bundle read/write locking/unlocking
> together, or only implement this on platforms that can do one at a
> time, unless there's a cleaner way to handle this.  Glancing at the
> values you use for 8xx, this doesn't seem possible there, and it's a
> definite performance hit for radix.
> 
> At the same time, as you say, it would suck for book3s32 that can only
> do writes, but maybe just doing both at the same time and if
> implemented for that platform it could just have a warning that it only
> applies to writes on init?

Well, I see your points. My idea was not to separate read and write
on platform that can lock both. I think it is no problem to also 
unlocking writes when we are doing a read, so on platforms that can do 
both I think both should do the same..

The idea was to avoid spending time unlocking writes for doing a read on 
platforms on which reads are not locked. And for platforms able to 
independently unlock/lock reads and writes, if only unlocking reads can 
improve performance it can be interesting as well.

For book3s/32, locking/unlocking will be done through Kp/Ks bits in 
segment registers, the function won't be trivial as it may involve more 
than one segment at a time. So I just wanted to avoid spending time 
doing that for reads as reads won't be protected. And may also be the 
case on older book3s/64, may not it ?
On Book3s/32, the page protection bits are as follows:

   Key	0	1
PP
00	RW	NA
01	RW	RO
10	RW	RW
11	RO	RO

So the idea is to encode user RW with PP01 (instead of PP10 today) and 
user RO with PP11 (as done today), giving Key0 to user and Key1 to 
kernel (today both user and kernel have Key1). Then when kernel needs to 
write, we change Ks to Key0 in segment register for the involved segments.

I'm not sure there is any risk that someone nests unlocks/locks for 
reads and unlocks/locks for writes, because the unlocks/locks are done 
in very limited places.

Christophe


> 
> Curious for people's thoughts on this.
> 
> - Russell
> 
