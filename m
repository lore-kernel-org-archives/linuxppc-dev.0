Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33788C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AFF20863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ocd2h4Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AFF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SSZy4zZSzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 19:48:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ocd2h4Iu"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SSYH4XKVzDq9C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 19:46:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44SSY76SqDz9v0Yh;
 Mon, 25 Mar 2019 09:46:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ocd2h4Iu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NYLuaqNDWwwx; Mon, 25 Mar 2019 09:46:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44SSY75Mnpz9v0Yj;
 Mon, 25 Mar 2019 09:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553503595; bh=Tn2iFshbMVV8+/NjtTvedum7vG9Ug59TrF8UYE3kO8g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ocd2h4IuwReE7/obA0Zd2hZLc80s/BwG1adgd7fX/E/HotSaqXXw0VrdO3qD/nkDT
 vk++JokWfnj13ugwTvLERalwLxu3vzjHRKWvwmHy7Oxw7EdFEqNQDl0sjG4irUwO7G
 GeMLxMq+dkyB5YamS4/gIYIcT202mogfHHa6WfNs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 52F678B74F;
 Mon, 25 Mar 2019 09:46:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 93AfAA_Ar67L; Mon, 25 Mar 2019 09:46:40 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 26B1F8B89B;
 Mon, 25 Mar 2019 09:46:40 +0100 (CET)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1c1f7eae-0c49-dcb2-f27b-96a83d811df7@c-s.fr>
Date: Mon, 25 Mar 2019 09:46:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/03/2019 à 01:49, Larry Finger a écrit :
> A build of kernel 5.1.0-rc2 resulted in a failure to boot on my 
> PowerBook G4 Aluminum. The bootstrap loads the initial kernel and issues 
> the appropriate start, but the machine hangs at that point.
> 
> The problem does not depend on the choice of PPC32 processor type. This 
> machine has a 7447A according to /proc/cpuinfo.
> 
> The problem was bisected to the following:
> 
> commit 0df977eafc792a5365a7f81d8d5920132e03afad
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Thu Feb 21 10:37:54 2019 +0000
> 
>      powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while 
> in RTAS
> 
>      When calling RTAS, the stack pointer is stored in SPRN_SPRG2
>      in order to be able to restore it in case of machine check in RTAS.
> 
>      As machine check is not a perfomance critical path, this patch
>      frees SPRN_SPRG2 by using a field in thread struct instead.
> 
>      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> I reverted this patch and found that the system began execution, and 
> then failed, likely due to the reassignment of SPRN_SPRG2.
> 
> I had found this problem with 5.1.0-rc1, but -rc2 was out by the time I 
> finished the bisection. Unfortunately, none of the changes in -rc2 fixed 
> the problem.

I think I identified the issue, see 
https://patchwork.ozlabs.org/patch/1063962/

It is now booting properly under QEMU with your .config

Could you please test it on your target ?

Thanks
Christophe

> 
> Attached is the .config that I used.
> 
> Thanks,
> 
> Larry
