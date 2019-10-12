Return-Path: <SRS0=fMWd=YF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50353C4360C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 08:53:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AFA2087E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kaskJOs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AFA2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qzBM5R9JzDqNN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 19:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="kaskJOs6"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qz8C4XydzDqRJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2019 19:51:38 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46qz8544J8z9v1HD;
 Sat, 12 Oct 2019 10:51:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=kaskJOs6; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id B0OR5hSp-zT2; Sat, 12 Oct 2019 10:51:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46qz8530SLz9v1HC;
 Sat, 12 Oct 2019 10:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1570870293; bh=T37HV7ylGEfqox/Ndhtqj4kx82M+0XG0UqFJoDFdeOs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kaskJOs6P8/hdZk+A3A9SQGwS19Qp7FUZcf4xw+OK49TrrNqPavsQvmqT8pL7GyBV
 p79MIP4ShRcg7odcZIi1OlbKzwQBDup+YQxchlqmUTV62jiuwZ0do/KVgVNQAUqKvm
 Ce44rJ/bXvvAh0nrikLBb0bcgcKIcTl+C7WweG4w=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FB888B790;
 Sat, 12 Oct 2019 10:51:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VDCM2eOBBYtA; Sat, 12 Oct 2019 10:51:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2B908B752;
 Sat, 12 Oct 2019 10:51:33 +0200 (CEST)
Subject: Re: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
 <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
 <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
 <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <de06dac0-3103-64ed-0e97-c2b6972c59c2@c-s.fr>
Date: Sat, 12 Oct 2019 10:51:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
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
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/10/2019 à 06:44, Ravi Bangoria a écrit :
> 
>>> @Christophe, Is patch5 works for you on 8xx?
>>>
>>
>> Getting the following :
>>
>> root@vgoip:~# ./ptrace-hwbreak
>> test: ptrace-hwbreak
>> tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
>> PTRACE_SET_DEBUGREG, WO, len: 1: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 2: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 4: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 8: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 1: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 2: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 4: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 8: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 1: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 2: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 4: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 8: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
>> failure: ptrace-hwbreak
>>
> 

I also tried on a 83xx (book3s/32). This one has a regular DABR :

root@vgoippro:~# ./ptrace-hwbreak
test: ptrace-hwbreak
tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
PTRACE_SET_DEBUGREG, WO, len: 1: Ok
PTRACE_SET_DEBUGREG, WO, len: 2: Ok
PTRACE_SET_DEBUGREG, WO, len: 4: Ok
PTRACE_SET_DEBUGREG, WO, len: 8: Ok
PTRACE_SET_DEBUGREG, RO, len: 1: Ok
PTRACE_SET_DEBUGREG, RO, len: 2: Ok
PTRACE_SET_DEBUGREG, RO, len: 4: Ok
PTRACE_SET_DEBUGREG, RO, len: 8: Ok
PTRACE_SET_DEBUGREG, RW, len: 1: Ok
PTRACE_SET_DEBUGREG, RW, len: 2: Ok
PTRACE_SET_DEBUGREG, RW, len: 4: Ok
PTRACE_SET_DEBUGREG, RW, len: 8: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RW, len: 6: Ok
PPC_PTRACE_SETHWDEBUG failed: Invalid argument
failure: ptrace-hwbreak

Christophe
