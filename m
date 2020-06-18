Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FBCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:42:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B79F20663
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B79F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nhQz3YYDzDrGC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 22:42:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nhK541PHzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 22:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49nhK40cWMz9sSd; Thu, 18 Jun 2020 22:37:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200524093822.423487-1-aneesh.kumar@linux.ibm.com>
References: <20200524093822.423487-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/instruction_dump: Fix kernel crash with
 show_instructions
Message-Id: <159248379637.3471720.14154252041270168626.b4-ty@ellerman.id.au>
Date: Thu, 18 Jun 2020 22:37:11 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 24 May 2020 15:08:19 +0530, Aneesh Kumar K.V wrote:
> With Hard Lockup watchdog, we can hit a BUG() if we take a watchdog
> interrupt when in OPAL mode. This happens in show_instructions()
> where the kernel takes the watchdog NMI IPI with MSR_IR == 0.
> With that show_instructions() updates the variable pc in the loop
> and the second iterations will result in BUG().
> 
> We hit the BUG_ON due the below check in  __va()
> 
> [...]

Patch 1 applied to powerpc/fixes.

[1/4] powerpc: Fix kernel crash in show_instructions() w/DEBUG_VIRTUAL
      https://git.kernel.org/powerpc/c/a6e2c226c3d51fd93636320e47cabc8a8f0824c5

cheers
