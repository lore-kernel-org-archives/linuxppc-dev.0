Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF06C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:23:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6F9218AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cWoMsw+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6F9218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q2tJ2q4gzDqSL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:23:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q2rY5V0XzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 21:21:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cWoMsw+u"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Q2rX33Nvz8tC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 21:21:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Q2rX2h2mz9sR2; Thu, 21 Mar 2019 21:21:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="cWoMsw+u"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Q2rW3S8Bz9sCJ
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Mar 2019 21:21:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Q2rR0Drxz9v93k;
 Thu, 21 Mar 2019 11:21:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=cWoMsw+u; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0otqRBEUM4g6; Thu, 21 Mar 2019 11:21:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Q2rQ6B3Sz9v93S;
 Thu, 21 Mar 2019 11:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553163686; bh=qidNJnvo4AbqZReW8wyacg+fpgfNSo+FEpzt1heELPI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cWoMsw+uLxBac+S5ehMedgNzkCKyht/KDnSl0Uj1blBxSVvTerTCJ1EK3buLX5sdf
 8tH/GjKDR+1XfGrB8WCpytbNQlFleGLn9ZB8zKV0wkMzG5vSkzivbIDWuCV4WT1l8z
 NbuF63wysxUryCH2PYH655ccIw1iUOeBT7pDBIoA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 05DA58B955;
 Thu, 21 Mar 2019 11:21:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KnWydq3CpZZT; Thu, 21 Mar 2019 11:21:27 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A3C78B960;
 Thu, 21 Mar 2019 11:21:27 +0100 (CET)
Subject: Re: [PATCH v5 05/10] powerpc: Add a framework for Kernel Userspace
 Access Protection
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-5-mpe@ellerman.id.au>
 <b1d292b5-5844-34c6-c388-2ad2045e1904@c-s.fr>
 <87r2b1ya8b.fsf@concordia.ellerman.id.au>
 <7fad467c-1e63-02c8-636e-7f8ab456f76c@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ea2578f6-9ae3-9482-555e-c8077c22ea89@c-s.fr>
Date: Thu, 21 Mar 2019 11:21:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7fad467c-1e63-02c8-636e-7f8ab456f76c@c-s.fr>
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



Le 20/03/2019 à 14:04, Christophe Leroy a écrit :
> 
> 
> Le 20/03/2019 à 13:57, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Le 08/03/2019 à 02:16, Michael Ellerman a écrit :
>>>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>
>>>> This patch implements a framework for Kernel Userspace Access
>>>> Protection.
>>>>
>>>> Then subarches will have the possibility to provide their own
>>>> implementation by providing setup_kuap() and
>>>> allow/prevent_user_access().
>>>>
>>>> Some platforms will need to know the area accessed and whether it is
>>>> accessed from read, write or both. Therefore source, destination and
>>>> size and handed over to the two functions.
>>>>
>>>> mpe: Rename to allow/prevent rather than unlock/lock, and add
>>>> read/write wrappers. Drop the 32-bit code for now until we have an
>>>> implementation for it. Add kuap to pt_regs for 64-bit as well as
>>>> 32-bit. Don't split strings, use pr_crit_ratelimited().
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>> v5: Futex ops need read/write so use allow_user_acccess() there.
>>>>       Use #ifdef CONFIG_PPC64 in kup.h to fix build errors.
>>>>       Allow subarch to override allow_read/write_from/to_user().
>>>
>>> Those little helpers that will just call allow_user_access() when
>>> distinct read/write handling is not performed looks overkill to me.
>>>
>>> Can't the subarch do it by itself based on the nullity of from/to ?
>>>
>>> static inline void allow_user_access(void __user *to, const void __user
>>> *from,
>>>                      unsigned long size)
>>> {
>>>     if (to & from)
>>>         set_kuap(0);
>>>     else if (to)
>>>         set_kuap(AMR_KUAP_BLOCK_READ);
>>>     else if (from)
>>>         set_kuap(AMR_KUAP_BLOCK_WRITE);
>>> }
>>
>> You could implement it that way, but it reads better at the call sites
>> if we have:
>>
>>     allow_write_to_user(uaddr, sizeof(*uaddr));
>> vs:
>>     allow_user_access(uaddr, NULL, sizeof(*uaddr));
>>
>> So I'm inclined to keep them. It should all end up inlined and generate
>> the same code at the end of the day.
>>
> 
> I was not suggesting to completly remove allow_write_to_user(), I fully 
> agree that it reads better at the call sites.
> 
> I was just thinking that allow_write_to_user() could remain generic and 
> call the subarch specific allow_user_access() instead of making multiple 
> subarch's allow_write_to_user()

Otherwise, could we do something like the following, so that subarches 
may implement it or not ?

#ifndef allow_read_from_user
static inline void allow_read_from_user(const void __user *from, 
unsigned long size)
{
	allow_user_access(NULL, from, size);
}
#endif

#ifndef allow_write_from_user
static inline void allow_write_to_user(void __user *to, unsigned long size)
{
	allow_user_access(to, NULL, size);
}
#endif

Christophe

> 
> But both solution are OK for me at the end.
> 
> Christophe
