Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE558C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:48:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5711222B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="n0/28kBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5711222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zySt1vTqzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 22:47:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zyQv1v6RzDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="n0/28kBi"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43zyQt6yytz8swq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:46:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43zyQt5hPXz9s7h; Wed, 13 Feb 2019 22:46:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="n0/28kBi"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43zyQr1f9Gz9s7T
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 22:46:11 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43zyQc4yXczB09ZY;
 Wed, 13 Feb 2019 12:46:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=n0/28kBi; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id aClfrLFwixxs; Wed, 13 Feb 2019 12:46:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43zyQc3nSzzB09ZV;
 Wed, 13 Feb 2019 12:46:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550058360; bh=8h5VmglpRg2efJmt/ZAzkY/wFly753sTbUWzfUoTB4c=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=n0/28kBiOSAPLPJfaCbeoYuQqQ8dtn0t8lpaWc3iENb/kDV/RP8PhKd9OCz4yaRKp
 HFeXWaKpTp7py0hU2c37JXGArSSdTRyem1eFD8fsWWWM/Yg3v5ypNijdwM4s83Fyy7
 H0Y3uXjIp40LLXirptooPGRGCA52pywm3EPnE0kA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B15208B858;
 Wed, 13 Feb 2019 12:46:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MRGZYh0XMXvb; Wed, 13 Feb 2019 12:46:01 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 904068B756;
 Wed, 13 Feb 2019 12:46:01 +0100 (CET)
Subject: Re: Kernel panic when loading the IDE controller driver
To: sgosavi1 <Sachin.Gosavi@emerson.com>, linuxppc-dev@ozlabs.org
References: <1550055691105-0.post@n7.nabble.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
Date: Wed, 13 Feb 2019 12:46:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550055691105-0.post@n7.nabble.com>
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

Hi,

Le 13/02/2019 à 12:01, sgosavi1 a écrit :
> Hi All,
> 
> I have been working on porting Linux-4.15.13 kernel on our existing MPC8270
> processor board. For this exercise, I have used pq2fads as a reference
> board, its associated device tree and used cuImage for building the kernel.

What it the last linux version known to work properly ?

Christophe


> I am facing an issue with the generic IDE flash controller driver in the new
> kernel source where it fails to detect the Flash controller connected to 2GB
> NAND flash available on the board. We have used non-standard IO port
> addresses for this driver in the older kernel and I have added the required
> code in the new kernel to setup the set of addresses that we need as IO
> ports. Also, modified the code in the drivers/ide/ source to use the
> non-standard IO port address. However, during boot up while inserting the
> module I continue to get the below errors.
> 
> [    4.116587] ide: forcing hda as a disk (3543/255/63)
> [    4.184190] Probing IDE interface ide0...
> [    4.226330] Machine check in kernel mode.
> [    4.233809] Caused by (from SRR1=49030):
> [    4.233826] Transfer error ack signal
> [    4.249263] IN from bad port e000000e at 004123ef
> 
> I understand that this is an addressing issue but not sure exactly what am I
> missing to fix the problem. Can you provide me your inputs on debugging this
> issue?
> 
> Thanks,
> Sachin.
> 
> 
> 
> 
> --
> Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
> 
