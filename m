Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCAEC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:49:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769C521A47
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769C521A47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MMgf27J7zDqH4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:49:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSw3CXtzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSw1VvZz9sPX; Sat, 22 Dec 2018 20:54:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 59029136d75022cb8b7c7bebd1738ae70232416e
X-Patchwork-Hint: ignore
In-Reply-To: <1528640822-4800-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/perf: Add constraints for power9 l2/l3 bus events
Message-Id: <43MLSw1VvZz9sPX@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:55 +1100 (AEDT)
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-06-10 at 14:27:01 UTC, Madhavan Srinivasan wrote:
> In previous generation processors, both bus events and direct
> events of performance monitoring unit can be individually
> programmabled and monitored in PMCs.
> 
> But in Power9, L2/L3 bus events are always available as a
> "bank" of 4 events. To obtain the counts for any of the
> l2/l3 bus events in a given bank, the user will have to
> program PMC4 with corresponding l2/l3 bus event for that
> bank.
> 
> Patch enforce two contraints incase of L2/L3 bus events.
> 
> 1)Any L2/L3 event when programmed is also expected to program corresponding
> PMC4 event from that group.
> 2)PMC4 event should always been programmed first due to group constraint
> logic limitation
> 
> For ex. consider these L3 bus events
> 
> PM_L3_PF_ON_CHIP_MEM (0x460A0),
> PM_L3_PF_MISS_L3 (0x160A0),
> PM_L3_CO_MEM (0x260A0),
> PM_L3_PF_ON_CHIP_CACHE (0x360A0),
> 
> 1) This is an INVALID group for L3 Bus event monitoring,
> since it is missing PMC4 event.
> 	perf stat -e "{r160A0,r260A0,r360A0}" < >
> 
> And this is a VALID group for L3 Bus events:
> 	perf stat -e "{r460A0,r160A0,r260A0,r360A0}" < >
> 
> 2) This is an INVALID group for L3 Bus event monitoring,
> since it is missing PMC4 event.
> 	perf stat -e "{r260A0,r360A0}" < >
> 
> And this is a VALID group for L3 Bus events:
> 	perf stat -e "{r460A0,r260A0,r360A0}" < >
> 
> 3) This is an INVALID group for L3 Bus event monitoring,
> since it is missing PMC4 event.
> 	perf stat -e "{r360A0}" < >
> 
> And this is a VALID group for L3 Bus events:
> 	perf stat -e "{r460A0,r360A0}" < >
> 
> Patch here implements group constraint logic suggested by Michael Ellerman.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/59029136d75022cb8b7c7bebd1738a

cheers
