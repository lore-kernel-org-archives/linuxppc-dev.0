Return-Path: <SRS0=CfD8=BM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A16C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 13:46:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F11A2067D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 13:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F11A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKMkY3x0KzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 23:46:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKMT1538QzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Aug 2020 23:35:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BKMT10RTDz9sSG; Sun,  2 Aug 2020 23:35:01 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BKMT03XzZz9sTM; Sun,  2 Aug 2020 23:35:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
In-Reply-To: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] cpuidle-pseries: Parse extended CEDE information
 for idle.
Message-Id: <159637524065.42190.12857433342577768358.b4-ty@ellerman.id.au>
Date: Sun,  2 Aug 2020 23:35:00 +1000 (AEST)
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
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Jul 2020 11:02:54 +0530, Gautham R. Shenoy wrote:
> This is a v3 of the patch series to parse the extended CEDE
> information in the pseries-cpuidle driver.
> 
> The previous two versions of the patches can be found here:
> 
> v2: https://lore.kernel.org/lkml/1596005254-25753-1-git-send-email-ego@linux.vnet.ibm.com/
> 
> [...]

Applied to powerpc/next.

[1/3] cpuidle: pseries: Set the latency-hint before entering CEDE
      https://git.kernel.org/powerpc/c/3af0ada7dd98c6da35c1fd7f107af3b9aa5e904c
[2/3] cpuidle: pseries: Add function to parse extended CEDE records
      https://git.kernel.org/powerpc/c/054e44ba99ae36918631fcbf5f034e466c2f1b73
[3/3] cpuidle: pseries: Fixup exit latency for CEDE(0)
      https://git.kernel.org/powerpc/c/d947fb4c965cdb7242f3f91124ea16079c49fa8b

cheers
