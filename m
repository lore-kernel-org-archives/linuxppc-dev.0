Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D0C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 14:00:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3502360241
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 14:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3502360241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzTNB6QQjz3cMQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 00:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ellerman.id.au; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzTLH550Dz2yPF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 23:58:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GzTLG5cRpz9t1r;
 Tue, 31 Aug 2021 23:58:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210826100521.412639-1-srikar@linux.vnet.ibm.com>
References: <20210826100521.412639-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/5] Updates to powerpc for robust CPU online/offline
Message-Id: <163041822403.889087.10564783622583001521.b4-ty@ellerman.id.au>
Date: Tue, 31 Aug 2021 23:57:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Laurent Dufour <ldufour@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 26 Aug 2021 15:35:16 +0530, Srikar Dronamraju wrote:
> Changelog v2 -> v3:
> v2: https://lore.kernel.org/linuxppc-dev/20210821102535.169643-1-srikar@linux.vnet.ibm.com/t/#u
> Add patch 1: to drop dbg and numa=debug (Suggested by Michael Ellerman)
> Add patch 2: to convert printk to pr_xxx (Suggested by Michael Ellerman)
> 	Use pr_warn instead of pr_debug(WARNING) (Suggested by Laurent)
> 
> Changelog v1 -> v2:
> Moved patch to this series: powerpc/numa: Fill distance_lookup_table for offline nodes
> fixed a missing prototype warning
> 
> [...]

Patches 1-4 applied to powerpc/next.

[1/5] powerpc/numa: Drop dbg in favour of pr_debug
      https://git.kernel.org/powerpc/c/544af6429777cefae2f8af9a9866df5e8cb21763
[2/5] powerpc/numa: convert printk to pr_xxx
      https://git.kernel.org/powerpc/c/506c2075ffd8db352c53201ef166948a272e3bce
[3/5] powerpc/numa: Print debug statements only when required
      https://git.kernel.org/powerpc/c/544a09ee7434b949552266d20ece538d35535bd5
[4/5] powerpc/numa: Update cpu_cpu_map on CPU online/offline
      https://git.kernel.org/powerpc/c/9a245d0e1f006bc7ccf0285d0d520ed304d00c4a

cheers
