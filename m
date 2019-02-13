Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E4C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:36:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915A6222B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="G+qBx1kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915A6222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zzXn1x8XzDqTs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:36:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zzRX63xfzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:31:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="G+qBx1kX"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43zzRX3c52z8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:31:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43zzRX23s8z9sDX; Wed, 13 Feb 2019 23:31:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="G+qBx1kX"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43zzRW3wmxz9s7h
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 23:31:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43zzRR2vbXz9vBwY;
 Wed, 13 Feb 2019 13:31:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=G+qBx1kX; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NPVoxRb7s4oV; Wed, 13 Feb 2019 13:31:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43zzRR1n9Bz9vBwS;
 Wed, 13 Feb 2019 13:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550061107; bh=GFxRQ3enaLlVBHGEbysLRdxZkhkuM+z7VRIVpFRQ58g=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=G+qBx1kX6CYymylqT2rwb8Ab9AXDNKuStcUR0ATVvp1MB6xEoLNUUtl9umrvKA4hX
 NMWGZ61fgo5hzSv7x1T4dboHrbCFerVgEVnzRkfye6vd03faztvq5WHbni3wjyPKWw
 ZDJuRVWmOtlqo41KioRk6JujT/BbzMGr4fU3Gs3c=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A0E28B860;
 Wed, 13 Feb 2019 13:31:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0KwhRrG8DA4s; Wed, 13 Feb 2019 13:31:48 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 698D38B756;
 Wed, 13 Feb 2019 13:31:48 +0100 (CET)
Subject: Re: Kernel panic when loading the IDE controller driver
To: sgosavi1 <Sachin.Gosavi@emerson.com>, linuxppc-dev@ozlabs.org
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
Date: Wed, 13 Feb 2019 13:31:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550060685213-0.post@n7.nabble.com>
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



Le 13/02/2019 à 13:24, sgosavi1 a écrit :
>> What it the last linux version known to work properly?
> 
> 
> We have used it successfully in the Linux-2.6.17.6 version.

Oh, ok, there's a big gap between the two versions.

Why using 4.15.13 which is obsolete instead of using one of the Long 
Term Support versions which are still maintained, like 4.14 or 4.19 ? 
(see the complete list at https://www.kernel.org/category/releases.html)

Christophe

> 
> 
> Thanks,
> Sachin.
> 
> 
> 
> --
> Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
> 
