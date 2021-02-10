Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E74C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:28:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4D364D73
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4D364D73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLF341nvzDvbh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:28:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY34qTzzDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKXy4HVgz9sS8; Wed, 10 Feb 2021 23:57:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <1612516492-1428-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1612516492-1428-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/perf: Record counter overflow always if
 SAMPLE_IP is unset
Message-Id: <161296172306.3178259.2351405924746629740.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:22 +1100 (AEDT)
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
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 5 Feb 2021 04:14:52 -0500, Athira Rajeev wrote:
> While sampling for marked events, currently we record the sample only
> if the SIAR valid bit of Sampled Instruction Event Register (SIER) is
> set. SIAR_VALID bit is used for fetching the instruction address from
> Sampled Instruction Address Register(SIAR). But there are some usecases,
> where the user is interested only in the PMU stats at each counter
> overflow and the exact IP of the overflow event is not required.
> Dropping SIAR invalid samples will fail to record some of the counter
> overflows in such cases.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Record counter overflow always if SAMPLE_IP is unset
      https://git.kernel.org/powerpc/c/d137845c973147a22622cc76c7b0bc16f6206323

cheers
