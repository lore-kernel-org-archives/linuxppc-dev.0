Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A0C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:12:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DD72087D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DD72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsbSb1FgVzDqNP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:12:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsZSf6qXXzDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 21:27:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BsZSf1CWwz9sVb; Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
In-Reply-To: <20200807074517.27957-1-srikar@linux.vnet.ibm.com>
References: <20200807074517.27957-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Allow archs to override
 cpu_smt_mask
Message-Id: <160034200734.3339803.9987418393320708886.b4-ty@ellerman.id.au>
Date: Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
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
Cc: Ingo Molnar <mingo@kernel.org>, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 7 Aug 2020 13:15:16 +0530, Srikar Dronamraju wrote:
> cpu_smt_mask tracks topology_sibling_cpumask. This would be good for
> most architectures. One of the users of cpu_smt_mask(), would be to
> identify idle-cores. On Power9, a pair of SMT4 cores can be presented by
> the firmware as a SMT8 core for backward compatibility reasons.
> 
> Powerpc allows LPARs to be live migrated from Power8 to Power9. Do note
> Power8 had only SMT8 cores. Existing software which has been
> developed/configured for Power8 would expect to see SMT8 core.
> Maintaining the illusion of SMT8 core is a requirement to make that
> work.
> 
> [...]

Applied to powerpc/next.

[1/2] sched/topology: Allow archs to override cpu_smt_mask
      https://git.kernel.org/powerpc/c/3babbe447d76ac2919ec4d0eb3b0adfb22f5b03c
[2/2] powerpc/topology: Override cpu_smt_mask
      https://git.kernel.org/powerpc/c/f3232321db58480804f80d59aeb651a5c859a200

cheers
