Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66872C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:49:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBC32087F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBC32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wPRD2pVYzDqlB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 17:49:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wNKW2dwhzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 16:59:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44wNKV3pwlz9sPV; Fri,  3 May 2019 16:59:26 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44wNKV0SlRz9sPX; Fri,  3 May 2019 16:59:26 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d6e8a150850601277039a548ffcdddd1bfe3e365
X-Patchwork-Hint: ignore
In-Reply-To: <155656174872.20636.6539465047019566013.stgit@jupiter>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powernv/mce: reduce mce console logs to lesser
 lines.
Message-Id: <44wNKV0SlRz9sPX@ozlabs.org>
Date: Fri,  3 May 2019 16:59:26 +1000 (AEST)
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-04-29 at 18:15:48 UTC, Mahesh Salgaonkar wrote:
> Also add cpu number while displaying mce log. This will help cleaner logs
> when mce hits on multiple cpus simultaneously.
> 
> before the changes the mce o/p was:
> 
> [  127.223515] Severe Machine check interrupt [Recovered]
> [  127.223530]   NIP [d00000000ba80280]: insert_slb_entry.constprop.0+0x278/0x2c0 [mcetest_slb]
> [  127.223539]   Initiator: CPU
> [  127.223544]   Error type: SLB [Multihit]
> [  127.223550]     Effective address: d00000000ba80280
> 
> After this patch series changes the mce o/p will be:
> 
> [  471.959843] MCE: CPU80: machine check (Warning) Host SLB Multihit [Recovered]
> [  471.959870] MCE: CPU80: NIP: [d00000000b550280] insert_slb_entry.constprop.0+0x278/0x2c0 [mcetest_slb]
> [  471.959892] MCE: CPU80: Probable software error (some chance of hardware cause)
> 
> UE in host application:
> 
> [ 1001.831517] MCE: CPU48: machine check (Severe) Host UE Load/Store DAR: 00007fffc6079a80 paddr: 0000000f8e260000 [Not recovered]
> [ 1001.831518] MCE: CPU48: PID: 4584 Comm: find NIP: [0000000010023368]
> [ 1001.831519] MCE: CPU48: Hardware error
> 
> and for MCE in Guest:
> 
> [ 1289.447571] MCE: CPU80: machine check (Warning) Guest SLB Multihit DAR: 000001001b6e0320 [Recovered]
> [ 1289.447615] MCE: CPU80: PID: 24765 Comm: qemu-system-ppc Guest NIP: [00007fffa309dc60]
> [ 1289.447634] MCE: CPU80: Probable software error (some chance of hardware cause)
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d6e8a150850601277039a548ffcdddd1

cheers
