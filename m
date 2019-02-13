Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E0C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 15:28:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BCA222C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 15:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VDNF+ik6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BCA222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4403Mk4kPMzDqR3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 02:28:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4403Kz2vX5zDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 02:27:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VDNF+ik6"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4403Kz1sYlz8swG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 02:27:19 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4403Kz0Ysnz9s7T; Thu, 14 Feb 2019 02:27:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VDNF+ik6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4403Kx5rhwz9s4Z
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2019 02:27:16 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4403Kq5ZSdz9vJfY;
 Wed, 13 Feb 2019 16:27:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VDNF+ik6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RppkDiXhHE9X; Wed, 13 Feb 2019 16:27:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4403Kq4WnYz9vJfX;
 Wed, 13 Feb 2019 16:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550071631; bh=qZ6fKozz8zLmuKip3ekmkokj1or111UW+7UMRqGnrCM=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=VDNF+ik6LokX4OZo3KSIL9yJvL+rwsULuBXJtChiILmOG7JcYik0IHweC8+8XB5+x
 SHkf2yht12mLTWHhSIhD3kBbj9eQNn4t3zFvdnWahLFHrnFczskC04ygskNBM2csft
 5fUjAzZ9aJhtRsSaRoip+kkCvub6dcuef6TTCoQg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A4A48B875;
 Wed, 13 Feb 2019 16:27:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0Asfl-icMSru; Wed, 13 Feb 2019 16:27:13 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B39E8B756;
 Wed, 13 Feb 2019 16:27:13 +0100 (CET)
Subject: Re: Kernel panic when loading the IDE controller driver
To: sgosavi1 <Sachin.Gosavi@emerson.com>, linuxppc-dev@ozlabs.org,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
Date: Wed, 13 Feb 2019 16:27:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550062386389-0.post@n7.nabble.com>
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



Le 13/02/2019 à 13:53, sgosavi1 a écrit :
>> Why using 4.15.13 which is obsolete instead of using one of the Long
>> Term Support versions which are still maintained, like 4.14 or 4.19 ?
>> (see the complete list at https://www.kernel.org/category/releases.html)
> 
> Well, when I started this task 4.15.13 was probably the latest stable
> release and hence we decided to port this version. In the older kernel, we
> have the m8260_setup.c source file for our board where the function
> "io_block_mapping" was used to configure the non-standard IO port address
> starting at 0xe0000000 location. This address was passed as the base address
> followed by control address and IRQ number to the ide-core.ko module. In the
> new kernel we do not have an option to send these addresses and IRQ numbers
> as arguments to the driver. Instead the ide-generic.c source file in the new
> kernel uses the standard IO port values and IRQ values. I modified the code
> in the above file to used the addresses and IRQ number we used in the past.
> Also, added code in the "MMU_init" function call available under
> arch/PowerPC/init_32.c to setup the IO port address range by adding the
> "io_block_mapping" call and the required IO port address range.
> 
> Is there anything else that needs to be added or how can we configure the
> desired IO address range in the new kernel?
> 

Maybe look around 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9a0e77f28b50128df0c9e26ae489e44e29a7270a

Also look at ide_platform.c. I imagine there must be some way to set it 
up in your device tree.

Maybe Bartlomiej Zolnierkiewicz can help ?

Christophe
