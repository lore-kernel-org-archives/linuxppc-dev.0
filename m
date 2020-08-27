Return-Path: <SRS0=o3hI=CF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02EC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C580720786
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C580720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BcZcS4q78zDqf0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 17:49:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BcZYk16slzDqM5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 17:46:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BcZYj6JMQz9sTS; Thu, 27 Aug 2020 17:46:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1598424029-1662-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1598424029-1662-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Fix reading of MSR[HV PR] bits in trace-imc
Message-Id: <159851436161.52163.1873318093208618820.b4-ty@ellerman.id.au>
Date: Thu, 27 Aug 2020 17:46:49 +1000 (AEST)
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
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 26 Aug 2020 02:40:29 -0400, Athira Rajeev wrote:
> IMC trace-mode uses MSR[HV PR] bits to set the cpumode
> for the instruction pointer captured in each sample.
> The bits are fetched from third DW of the trace record.
> Reading third DW from IMC trace record should use be64_to_cpu
> along with READ_ONCE inorder to fetch correct MSR[HV PR] bits.
> Patch addresses this change.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/perf: Fix reading of MSR[HV/PR] bits in trace-imc
      https://git.kernel.org/powerpc/c/82715a0f332843d3a1830d7ebc9ac7c99a00c880

cheers
