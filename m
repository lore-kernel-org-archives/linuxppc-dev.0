Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B3C433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:53:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A23A23D99
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A23A23D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsDNt0YtYzDqXw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 23:53:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsBXb4Yp3zDqcD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 22:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CsBXZ5m2Fz9sX4; Thu, 10 Dec 2020 22:29:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
References: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/xmon: Change printk() to pr_cont()
Message-Id: <160756607247.1313423.10499331913215542406.b4-ty@ellerman.id.au>
Date: Thu, 10 Dec 2020 22:29:50 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 4 Dec 2020 10:35:38 +0000 (UTC), Christophe Leroy wrote:
> Since some time now, printk() adds carriage return, leading to
> unusable xmon output:
> 
> [   54.288722] sysrq: Entering xmon
> [   54.292209] Vector: 0  at [cace3d2c]
> [   54.292274]     pc:
> [   54.292331] c0023650
> [   54.292468] : xmon+0x28/0x58
> [   54.292519]
> [   54.292574]     lr:
> [   54.292630] c0023724
> [   54.292749] : sysrq_handle_xmon+0xa4/0xfc
> [   54.292801]
> [   54.292867]     sp: cace3de8
> [   54.292931]    msr: 9032
> [   54.292999]   current = 0xc28d0000
> [   54.293072]     pid   = 377, comm = sh
> [   54.293157] Linux version 5.10.0-rc6-s3k-dev-01364-gedf13f0ccd76-dirty (root@po17688vm.idsi0.si.c-s.fr) (powerpc64-linux-gcc (GCC) 10.1.0, GNU ld (GNU Binutils) 2.34) #4211 PREEMPT Fri Dec 4 09:32:11 UTC 2020
> [   54.293287] enter ? for help
> [   54.293470] [cace3de8]
> [   54.293532] c0023724
> [   54.293654]  sysrq_handle_xmon+0xa4/0xfc
> [   54.293711]  (unreliable)
> [   54.293859] [cace3e18]
> [   54.293918] c03885a8
> [   54.294056]  __handle_sysrq+0xe4/0x1d4
> [   54.294108]
> [   54.294255] [cace3e48]
> [   54.294314] c0388704
> [   54.294441]  write_sysrq_trigger+0x34/0x74
> [   54.294493]
> [   54.294641] [cace3e68]
> [   54.294700] c01f65d0
> [   54.294822]  proc_reg_write+0xac/0x11c
> [   54.294875]
> [   54.295023] [cace3e88]
> [   54.295082] c0179910
> [   54.295198]  vfs_write+0x134/0x46c
> [   54.295250]
> [   54.295396] [cace3f08]
> [   54.295455] c0179de8
> [   54.295567]  ksys_write+0x78/0x11c
> [   54.295619]
> [   54.295766] [cace3f38]
> [   54.295825] c00110d0
> [   54.295951]  ret_from_syscall+0x0/0x34
> [   54.296002]
> [   54.296159] --- Exception: c01 (System Call) at
> [   54.296217] 0fd4e784
> [   54.296303]
> [   54.296375] SP (7fca6ff0) is in userspace
> [   54.296431] mon>
> [   54.296484]  <no input ...>
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xmon: Change printk() to pr_cont()
      https://git.kernel.org/powerpc/c/7c6c86b36a36dd4a13d30bba07718e767aa2e7a1

cheers
