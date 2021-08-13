Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AEAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 12:01:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8074960E52
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8074960E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmMbN15ZSz3dbr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 22:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmMXl1pkGz3bWT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Aug 2021 21:59:03 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GmMXj3h4bz9t5K; Fri, 13 Aug 2021 21:59:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20210805152308.33988-1-ldufour@linux.ibm.com>
References: <20210805152308.33988-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Fix update of LPAR security flavor after
 LPM
Message-Id: <162885586748.2317031.9018391947607622770.b4-ty@ellerman.id.au>
Date: Fri, 13 Aug 2021 21:57:47 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 5 Aug 2021 17:23:08 +0200, Laurent Dufour wrote:
> After LPM, when migrating from a system with security mitigation enabled to
> a system with mitigation disabled, the security flavor exposed in /proc is
> not correctly set back to 0.
> 
> Do not assume the value of the security flavor is set to 0 when entering
> init_cpu_char_feature_flags(), so when called after a LPM, the value is set
> correctly even if the mitigation are not turned off.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Fix update of LPAR security flavor after LPM
      https://git.kernel.org/powerpc/c/c18956e6e0b95f78dad2773ecc8c61a9e41f6405

cheers
