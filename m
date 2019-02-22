Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:10:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD7D206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XeRf22e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD7D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TCR4H5bzDqWP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:10:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XeRf22e4"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445T9b1hFnzDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:08:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 445T9V6SL2z9v087;
 Fri, 22 Feb 2019 12:08:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XeRf22e4; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id noy52El0ymAR; Fri, 22 Feb 2019 12:08:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 445T9V5Qpgz9v086;
 Fri, 22 Feb 2019 12:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550833726; bh=lUTUCg+HHznpY4KERZk8fqgVjFcF0DrkwFR0a+XOSMM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XeRf22e4dtUjpL/m9wZa9ujkxfPQOfFxnB9RU2g0ycnxFsYKHMEJNtfu/lTJWSe80
 /YPGuQ53XIIe0ZAsLkt93z1dqLEwj41yK4HqHOW+SAWxUpK6lL3I6WwvG4LoSymKTh
 OKBcjMG+mqulGqb9t7QBTWvccRC5e77a0c1cg4ew=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E70668B8B4;
 Fri, 22 Feb 2019 12:08:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hCfKhYGatiq2; Fri, 22 Feb 2019 12:08:47 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C68378B754;
 Fri, 22 Feb 2019 12:08:47 +0100 (CET)
Subject: Re: [bug report] powerpc/mm: dump block address translation on
 book3s/32
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20190222104302.GA17252@kadam>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <781e2495-20ee-1f85-8e15-cbfbb77e0c7b@c-s.fr>
Date: Fri, 22 Feb 2019 12:08:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222104302.GA17252@kadam>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

  Hello Dan,


Le 22/02/2019 à 11:43, Dan Carpenter a écrit :
> Hello Christophe Leroy,
> 
> The patch 7c91efce1608: "powerpc/mm: dump block address translation
> on book3s/32" from Dec 3, 2018, leads to the following static checker
> warning:
> 
> 	arch/powerpc/mm/dump_bats.c:20 pp_601()
> 	warn: both sides of ternary the same: '"RWX"'
> 
> arch/powerpc/mm/dump_bats.c
>      13 static char *pp_601(int k, int pp)
>      14 {
>      15 	if (pp == 0)
>      16 		return k ? "NA" : "RWX";
>      17 	if (pp == 1)
>      18 		return k ? "ROX" : "RWX";
>      19 	if (pp == 2)
> --> 20 		return k ? "RWX" : "RWX";
>                              ^^^     ^^^
>      21 	return k ? "ROX" : "ROX";
>                      ^^^     ^^^
> 
> Was something else intended here?  Or we could make it simpler:
> 
> 	if (pp == 2)
> 		return "RWX";
> 	return "ROX";
> 
> 
>      22 }
> 

The intention was to map the following table from the mpc601 user manual 
chapter 6.4:

Table 6-7. Access Protection Control with Key

Key(1)  PP(2)  Block or Page Type
0       00     Read/write
0       01     Read/write
0       10     Read/write
0       11     Read only
1       00     No access
1       01     Read only
1       10     Read/write
1       11     Read only

(1) Ks or Ku selected by state of MSR[PR]
(2) PP protection option bits in BAT array entry or
PTE


So I have no objection for your proposed change

Regards
Christophe
