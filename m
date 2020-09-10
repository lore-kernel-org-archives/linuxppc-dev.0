Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CEEC43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 12:58:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523E5206D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 12:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523E5206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnJq74SVjzDqfc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 22:58:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BnJlV19xlzDqcy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BnJlT4jccz9sTr; Thu, 10 Sep 2020 22:55:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joel Stanley <joel@jms.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <1599125247-28488-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1599125247-28488-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle-pseries: Fix CEDE latency conversion from tb
 to us
Message-Id: <159974250748.1017939.3766182148722011711.b4-ty@ellerman.id.au>
Date: Thu, 10 Sep 2020 22:55:33 +1000 (AEST)
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
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Sep 2020 14:57:27 +0530, Gautham R. Shenoy wrote:
> commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> of the Extended CEDE states advertised by the platform. The values
> advertised by the platform are in timebase ticks. However the cpuidle
> framework requires the latency values in microseconds.
> 
> If the tb-ticks value advertised by the platform correspond to a value
> smaller than 1us, during the conversion from tb-ticks to microseconds,
> in the current code, the result becomes zero. This is incorrect as it
> puts a CEDE state on par with the snooze state.
> 
> [...]

Applied to powerpc/fixes.

[1/1] cpuidle: pseries: Fix CEDE latency conversion from tb to us
      https://git.kernel.org/powerpc/c/1d3ee7df009a46440c58508b8819213c09503acd

cheers
