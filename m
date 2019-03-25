Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A232C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:55:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E55C20854
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SsJewLc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E55C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SQ4X321RzDqKl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:55:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SsJewLc+"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SQ2F5vKbzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:53:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44SQ223mkBz9v0Rt;
 Mon, 25 Mar 2019 07:52:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SsJewLc+; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id XTaxsEE-PT-g; Mon, 25 Mar 2019 07:52:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44SQ222g8Lz9v0Rr;
 Mon, 25 Mar 2019 07:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553496778; bh=U6aYjqz/73cS/hlJOauTV57AvkWh/SqU5alecyRDuTU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SsJewLc+FZm7Q871t4+5dm/+daz9m+iiWFbUiElaihL/jA2TH88ouLr6mBUO7wXng
 5EXTCgTShpATeIlnGS3nzciPjJeAiHdsTvfZgf6/jqilt57BZMcw01IsPgxij1tw6u
 7oS1s7emtb+FaTuO3fWgXmvB3zzY2tOnTuzKIcXU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C6FE28B7BC;
 Mon, 25 Mar 2019 07:53:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qtcAkNnR5onj; Mon, 25 Mar 2019 07:53:02 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 84FD88B74F;
 Mon, 25 Mar 2019 07:53:02 +0100 (CET)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ee247f37-8889-934c-571c-01c43fc31071@c-s.fr>
Date: Mon, 25 Mar 2019 07:53:01 +0100
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

Can you please be more explicit ? What do you mean by "issues the 
appropriate start" ? What is "that point" ? Any messages on the console ?

Thanks
Christophe


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
> 
> Attached is the .config that I used.
> 
> Thanks,
> 
> Larry
