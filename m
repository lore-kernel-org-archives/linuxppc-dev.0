Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:14:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4663D2184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="US09r1nE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4663D2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVkv0M8DzDqL4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:14:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVW92x47zDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 00:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="US09r1nE"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44PVW82PWFz8syV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 00:04:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44PVW76yhcz9sPL; Thu, 21 Mar 2019 00:04:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="US09r1nE"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44PVW512kFz9sPb
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Mar 2019 00:04:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PVVy6Dt7z9vBx5;
 Wed, 20 Mar 2019 14:04:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=US09r1nE; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id stYVnmCjJamP; Wed, 20 Mar 2019 14:04:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PVVy4z3kz9vBx4;
 Wed, 20 Mar 2019 14:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553087066; bh=i4j0PmUVMIbCHxfhxqhfBch3ODvon2JeXXkzC3QCfFU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=US09r1nE+zlK+p/rZMx8B4MilpVh53DN4b6rC6TVE6dGYi0CbIllvy4uQlDQs9YKL
 46SugOP7xi427aOKlMg2H1ubeNTi7LpY2zr9dcDbVP91xI86dR5xT3slo+qZqCICEf
 AzseZ4H8I2PKj3C08tw6A8gk3KKmCHIU1yeuc0Lk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 065EE8B929;
 Wed, 20 Mar 2019 14:04:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id EmwkfOm50SXn; Wed, 20 Mar 2019 14:04:27 +0100 (CET)
Received: from PO15451 (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D23048B918;
 Wed, 20 Mar 2019 14:04:27 +0100 (CET)
Subject: Re: [PATCH v5 05/10] powerpc: Add a framework for Kernel Userspace
 Access Protection
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-5-mpe@ellerman.id.au>
 <b1d292b5-5844-34c6-c388-2ad2045e1904@c-s.fr>
 <87r2b1ya8b.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7fad467c-1e63-02c8-636e-7f8ab456f76c@c-s.fr>
Date: Wed, 20 Mar 2019 14:04:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87r2b1ya8b.fsf@concordia.ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 20/03/2019 à 13:57, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 08/03/2019 à 02:16, Michael Ellerman a écrit :
>>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> This patch implements a framework for Kernel Userspace Access
>>> Protection.
>>>
>>> Then subarches will have the possibility to provide their own
>>> implementation by providing setup_kuap() and
>>> allow/prevent_user_access().
>>>
>>> Some platforms will need to know the area accessed and whether it is
>>> accessed from read, write or both. Therefore source, destination and
>>> size and handed over to the two functions.
>>>
>>> mpe: Rename to allow/prevent rather than unlock/lock, and add
>>> read/write wrappers. Drop the 32-bit code for now until we have an
>>> implementation for it. Add kuap to pt_regs for 64-bit as well as
>>> 32-bit. Don't split strings, use pr_crit_ratelimited().
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>> v5: Futex ops need read/write so use allow_user_acccess() there.
>>>       Use #ifdef CONFIG_PPC64 in kup.h to fix build errors.
>>>       Allow subarch to override allow_read/write_from/to_user().
>>
>> Those little helpers that will just call allow_user_access() when
>> distinct read/write handling is not performed looks overkill to me.
>>
>> Can't the subarch do it by itself based on the nullity of from/to ?
>>
>> static inline void allow_user_access(void __user *to, const void __user
>> *from,
>> 				     unsigned long size)
>> {
>> 	if (to & from)
>> 		set_kuap(0);
>> 	else if (to)
>> 		set_kuap(AMR_KUAP_BLOCK_READ);
>> 	else if (from)
>> 		set_kuap(AMR_KUAP_BLOCK_WRITE);
>> }
> 
> You could implement it that way, but it reads better at the call sites
> if we have:
> 
> 	allow_write_to_user(uaddr, sizeof(*uaddr));
> vs:
> 	allow_user_access(uaddr, NULL, sizeof(*uaddr));
> 
> So I'm inclined to keep them. It should all end up inlined and generate
> the same code at the end of the day.
> 

I was not suggesting to completly remove allow_write_to_user(), I fully 
agree that it reads better at the call sites.

I was just thinking that allow_write_to_user() could remain generic and 
call the subarch specific allow_user_access() instead of making multiple 
subarch's allow_write_to_user()

But both solution are OK for me at the end.

Christophe
