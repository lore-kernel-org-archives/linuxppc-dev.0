Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31196C433EA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DF92070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BGKw01gZLzDqv3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2020 01:14:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BGKgP5M8gzDqhK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2020 01:03:20 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AA031B;
 Tue, 28 Jul 2020 08:03:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305F83F718;
 Tue, 28 Jul 2020 08:03:16 -0700 (PDT)
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From: Valentin Schneider <valentin.schneider@arm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 09/10] Powerpc/smp: Create coregroup domain
In-reply-to: <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
Date: Tue, 28 Jul 2020 16:03:11 +0100
Message-ID: <jhjr1sviswg.mognet@arm.com>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Jordan Niethe <jniethe5@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi,

On 27/07/20 06:32, Srikar Dronamraju wrote:
> Add percpu coregroup maps and masks to create coregroup domain.
> If a coregroup doesn't exist, the coregroup domain will be degenerated
> in favour of SMT/CACHE domain.
>

So there's at least one arm64 platform out there with the same "pairs of
cores share L2" thing (Ampere eMAG), and that lives quite happily with the
default scheduler topology (SMT/MC/DIE). Each pair of core gets its MC
domain, and the whole system is covered by DIE.

Now arguably it's not a perfect representation; DIE doesn't have
SD_SHARE_PKG_RESOURCES so the highest level sd_llc can point to is MC. That
will impact all callsites using cpus_share_cache(): in the eMAG case, only
pairs of cores will be seen as sharing cache, even though *all* cores share
the same L3.

I'm trying to paint a picture of what the P9 topology looks like (the one
you showcase in your cover letter) to see if there are any similarities;
from what I gather in [1], wikichips and your cover letter, with P9 you can
have something like this in a single DIE (somewhat unsure about L3 setup;
it looks to be distributed?)

     +---------------------------------------------------------------------+
     |                                  L3                                 |
     +---------------+-+---------------+-+---------------+-+---------------+
     |       L2      | |       L2      | |       L2      | |       L2      |
     +------+-+------+ +------+-+------+ +------+-+------+ +------+-+------+
     |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  |
     +------+ +------+ +------+ +------+ +------+ +------+ +------+ +------+
     |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs|
     +------+ +------+ +------+ +------+ +------+ +------+ +------+ +------+

Which would lead to (ignoring the whole SMT CPU numbering shenanigans)

NUMA     [                                                   ...
DIE      [                                             ]
MC       [         ] [         ] [         ] [         ]
BIGCORE  [         ] [         ] [         ] [         ]
SMT      [   ] [   ] [   ] [   ] [   ] [   ] [   ] [   ]
         00-03 04-07 08-11 12-15 16-19 20-23 24-27 28-31  <other node here>

This however has MC == BIGCORE; what makes it you can have different spans
for these two domains? If it's not too much to ask, I'd love to have a P9
topology diagram.

[1]: 20200722081822.GG9290@linux.vnet.ibm.com
