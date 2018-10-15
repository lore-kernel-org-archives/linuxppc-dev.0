Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2030CC71130
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 13:28:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A942064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 13:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A942064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YfQP37T7zF3Nv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 00:28:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YfMz1nk9zF3Nr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 00:26:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YfMz15Hgz9sBq; Tue, 16 Oct 2018 00:26:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YfMy4jjRz9s5c;
 Tue, 16 Oct 2018 00:26:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org>
Subject: Stack protector crash in pnv_smp_cpu_kill_self()
Date: Tue, 16 Oct 2018 00:26:06 +1100
Message-ID: <87k1mjz6hd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi all,

Spotted this today, haven't had time to debug it further, just FYI in
case anyone else sees it.

  Running tests in cpufreq
  ========================================
  selftests: cpufreq: main.sh
  pid 9727's current affinity mask: ffffffffffffffffffffffffffffffffffffffffffff
  pid 9727's new affinity mask: 1
  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pnv_smp_cpu_kill_self+0x2a0/0x2b0
  
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc3-gcc-7.3.1-00168-g4ffe713b7587 #94
  Call Trace:
  [c000000007a1fb00] [c000000000ae7b4c] dump_stack+0xb0/0xf4 (unreliable)
  [c000000007a1fb40] [c0000000000e59cc] panic+0x144/0x328
  [c000000007a1fbe0] [c0000000000e544c] __stack_chk_fail+0x2c/0x30
  [c000000007a1fc40] [c00000000009eca0] pnv_smp_cpu_kill_self+0x2a0/0x2b0
  [c000000007a1fe10] [c0000000000475f8] cpu_die+0x48/0x70
  [c000000007a1fe30] [c000000000020620] arch_cpu_idle_dead+0x20/0x40
  [c000000007a1fe50] [c00000000012da94] do_idle+0x274/0x390
  [c000000007a1fec0] [c00000000012de08] cpu_startup_entry+0x38/0x50
  [c000000007a1fef0] [c000000000047334] start_secondary+0x5e4/0x600
  [c000000007a1ff90] [c00000000000ac70] start_secondary_prolog+0x10/0x14
  Rebooting in 10 seconds..
  [39378.502863506,5] OPAL: Reboot request



cheers
