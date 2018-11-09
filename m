Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:13:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64C220818
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64C220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s6DM4c34zF3Sp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 04:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s6BQ6hY2zF3Zb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 04:11:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42s6BB6mTlz9v0XK;
 Fri,  9 Nov 2018 18:11:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9qqDz3jeip2V; Fri,  9 Nov 2018 18:11:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42s6BB6BLNz9v0XJ;
 Fri,  9 Nov 2018 18:11:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AA23E8B899;
 Fri,  9 Nov 2018 18:11:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BY4XbDnqDaX1; Fri,  9 Nov 2018 18:11:20 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 682598B887;
 Fri,  9 Nov 2018 18:11:20 +0100 (CET)
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h in 4.20-rc1
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <dc5e555d-129e-aae8-889d-7b4e82197b3b@c-s.fr>
Date: Fri, 9 Nov 2018 18:11:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(Resending due to error in Paul's address)

Paul

I get the following UBSAN reports in 4.20-rc1 on an MPC8321E 
(powerpc/book3s/32)

I bisected it to 3e31009898699dfc ("rcu: Defer reporting RCU-preempt 
quiescent states when disabled")

Thanks
Christophe

[    4.919995] 
================================================================================
[    4.928428] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h:623:28
[    4.935198] signed integer overflow:
[    4.938766] 0 - -2147483648 cannot be represented in type 'int'
[    4.944678] CPU: 0 PID: 119 Comm: mkdir Not tainted 
4.19.0-rc1-s3k-dev-00005-g5a60513 #214
[    4.952908] Call Trace:
[    4.955382] [dec4fd20] [c02cb0d0] ubsan_epilogue+0x18/0x74 (unreliable)
[    4.962003] [dec4fd30] [c02cb5e0] handle_overflow+0xd0/0xe0
[    4.967588] [dec4fdb0] [c007b424] rcu_preempt_deferred_qs+0xc0/0xc8
[    4.973857] [dec4fdd0] [c007be28] rcu_note_context_switch+0x74/0x608
[    4.980217] [dec4fe10] [c064b790] __schedule+0x58/0x6e0
[    4.985448] [dec4fe50] [c064bfdc] preempt_schedule_common+0x48/0x9c
[    4.991717] [dec4fe70] [c01308c8] handle_mm_fault+0x10fc/0x1ecc
[    4.997639] [dec4fee0] [c001339c] do_page_fault+0x10c/0x760
[    5.003225] [dec4ff40] [c001234c] handle_page_fault+0x14/0x40
[    5.008968] --- interrupt: 401 at 0xff9cff8
[    5.008968]     LR = 0xfeefd78
[    5.016170] 
================================================================================
[    5.024591] 
================================================================================
[    5.033005] UBSAN: Undefined behaviour in kernel/rcu/tree_plugin.h:627:28
[    5.039775] signed integer overflow:
[    5.043342] -2147483648 + -2147483648 cannot be represented in type 'int'
[    5.050118] CPU: 0 PID: 119 Comm: mkdir Not tainted 
4.19.0-rc1-s3k-dev-00005-g5a60513 #214
[    5.058348] Call Trace:
[    5.060813] [dec4fd20] [c02cb0d0] ubsan_epilogue+0x18/0x74 (unreliable)
[    5.067433] [dec4fd30] [c02cb5e0] handle_overflow+0xd0/0xe0
[    5.073014] [dec4fdb0] [c007b408] rcu_preempt_deferred_qs+0xa4/0xc8
[    5.079283] [dec4fdd0] [c007be28] rcu_note_context_switch+0x74/0x608
[    5.085640] [dec4fe10] [c064b790] __schedule+0x58/0x6e0
[    5.090871] [dec4fe50] [c064bfdc] preempt_schedule_common+0x48/0x9c
[    5.097139] [dec4fe70] [c01308c8] handle_mm_fault+0x10fc/0x1ecc
[    5.103059] [dec4fee0] [c001339c] do_page_fault+0x10c/0x760
[    5.108642] [dec4ff40] [c001234c] handle_page_fault+0x14/0x40
[    5.114385] --- interrupt: 401 at 0xff9cff8
[    5.114385]     LR = 0xfeefd78
[    5.121588] 
================================================================================
