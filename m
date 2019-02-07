Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA7C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:09:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231602075C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 06:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hqjAnojz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231602075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w7Dq6ljVzDqQS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 17:09:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w7C820mBzDq9W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:07:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hqjAnojz"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w7C80n4Bz8tCk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 17:07:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w7C80GMzz9sMM; Thu,  7 Feb 2019 17:07:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hqjAnojz"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w7C52c7Qz9s4V
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 17:07:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43w7By4FMcz9vBn2;
 Thu,  7 Feb 2019 07:07:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=hqjAnojz; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id BulpXCiefyPi; Thu,  7 Feb 2019 07:07:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43w7By3Bllz9vBmp;
 Thu,  7 Feb 2019 07:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549519658; bh=i/19kWA//HoS1EeatGNpm+SLsGe7AzyNyHOyqGwRz3M=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=hqjAnojzemInBuYVm1iQbZm0uO1T396ewWqMVdnZZlK9AcZ5Szqqy/VdyYpBY0OIu
 JE/mgz5/HiVzPrcIBPCI5JAI16ju3GxbdF6Mc+JcWsI6oTZXjBIGVRenaBLOi9IaQX
 GB4vATRS2/R4TK4CGDat55CHId4REDDZzcJO4+bI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 44A1D8B886;
 Thu,  7 Feb 2019 07:07:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id virwbSgmeLyd; Thu,  7 Feb 2019 07:07:39 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 02F8B8B754;
 Thu,  7 Feb 2019 07:07:38 +0100 (CET)
Subject: Re: [PATCH v16 16/21] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-17-mpe@ellerman.id.au>
 <1549515139.mlgyosrnpx.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d99b0e4e-2015-46fc-fbc8-5b99cd9d80d6@c-s.fr>
Date: Thu, 7 Feb 2019 07:07:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549515139.mlgyosrnpx.astroid@bobo.none>
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



Le 07/02/2019 à 05:53, Nicholas Piggin a écrit :
> Michael Ellerman's on February 5, 2019 9:32 pm:
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> This patch activates CONFIG_THREAD_INFO_IN_TASK which
>> moves the thread_info into task_struct.
>>
>> Moving thread_info into task_struct has the following advantages:
>>    - It protects thread_info from corruption in the case of stack
>>      overflows.
>>    - Its address is harder to determine if stack addresses are leaked,
>>      making a number of attacks more difficult.
>>
>> This has the following consequences:
>>    - thread_info is now located at the beginning of task_struct.
>>    - The 'cpu' field is now in task_struct, and only exists when
>>      CONFIG_SMP is active.
>>    - thread_info doesn't have anymore the 'task' field.
>>
>> This patch:
>>    - Removes all recopy of thread_info struct when the stack changes.
>>    - Changes the CURRENT_THREAD_INFO() macro to point to current.
>>    - Selects CONFIG_THREAD_INFO_IN_TASK.
>>    - Modifies raw_smp_processor_id() to get ->cpu from current without
>>      including linux/sched.h to avoid circular inclusion and without
>>      including asm/asm-offsets.h to avoid symbol names duplication
>>      between ASM constants and C constants.
> 
> Come to think of it, can this patch be split out entirely and moved
> earlier as a 32-bit patch? 64-bit does not require that change or the
> additional build step AFAIKS?

Euh ... we may do that but the change in smp.h cannot go as is until 
thread_info is moved into current. So it would mean only having the 
Makefile change and the GENERATING_ASM_OFFSETS define in asm-offsets.c, 
and eventually an intermediate version of raw_smp_processor_id() in 
smp.h, that would have to get modified in the activation patch anyway.

So I'm not sure this is really worth it.

Christophe
