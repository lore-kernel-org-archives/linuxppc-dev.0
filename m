Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F2C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 13:31:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D612064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 13:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D612064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YfVP4j3yzF3Nh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 00:31:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YfS23lpRzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 00:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42YfS2375kz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 00:29:38 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42YfS22x3Cz9sCw; Tue, 16 Oct 2018 00:29:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42YfS13PjYz9sBq
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2018 00:29:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42YfRl01NQz9ttBt;
 Mon, 15 Oct 2018 15:29:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3lrpGNo3TB9b; Mon, 15 Oct 2018 15:29:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42YfRk6cskz9ttBp;
 Mon, 15 Oct 2018 15:29:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 371268B7AD;
 Mon, 15 Oct 2018 15:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nw5oPrBRTuap; Mon, 15 Oct 2018 15:29:32 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 04AE48B7A5;
 Mon, 15 Oct 2018 15:29:32 +0200 (CEST)
Subject: Re: Stack protector crash in pnv_smp_cpu_kill_self()
To: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
References: <87k1mjz6hd.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a23f6298-f860-190c-4b45-333198fdc160@c-s.fr>
Date: Mon, 15 Oct 2018 15:29:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87k1mjz6hd.fsf@concordia.ellerman.id.au>
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
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Looks like a lack of initialisation of the canary for the non-boot CPUs 
on SMP, you applied this morning the patch I sent you for that.

Is the patch in ?

Christophe

Le 15/10/2018 à 15:26, Michael Ellerman a écrit :
> Hi all,
> 
> Spotted this today, haven't had time to debug it further, just FYI in
> case anyone else sees it.
> 
>    Running tests in cpufreq
>    ========================================
>    selftests: cpufreq: main.sh
>    pid 9727's current affinity mask: ffffffffffffffffffffffffffffffffffffffffffff
>    pid 9727's new affinity mask: 1
>    Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
>    
>    CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-g4ffe713b7587 #94
>    Call Trace:
>    [c000000007a1fb00] [c000000000ae7b4c] dump_stack+0xb0/0xf4 (unreliable)
>    [c000000007a1fb40] [c0000000000e59cc] panic+0x144/0x328
>    [c000000007a1fbe0] [c0000000000e544c] __stack_chk_fail+0x2c/0x30
>    [c000000007a1fc40] [c00000000009eca0] pnv_smp_cpu_kill_self+0x2a0/0x2b0
>    [c000000007a1fe10] [c0000000000475f8] cpu_die+0x48/0x70
>    [c000000007a1fe30] [c000000000020620] arch_cpu_idle_dead+0x20/0x40
>    [c000000007a1fe50] [c00000000012da94] do_idle+0x274/0x390
>    [c000000007a1fec0] [c00000000012de08] cpu_startup_entry+0x38/0x50
>    [c000000007a1fef0] [c000000000047334] start_secondary+0x5e4/0x600
>    [c000000007a1ff90] [c00000000000ac70] start_secondary_prolog+0x10/0x14
>    Rebooting in 10 seconds..
>    [39378.502863506,5] OPAL: Reboot request
> 
> 
> 
> cheers
> 
