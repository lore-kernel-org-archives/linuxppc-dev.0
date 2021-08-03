Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95590C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E13560525
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E13560525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GfF9H2QWRz3cQf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 22:50:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=diDFZ/Uf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=diDFZ/Uf; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GfF8p4fhJz307C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Aug 2021 22:50:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GfF8h75d1z9sRK;
 Tue,  3 Aug 2021 22:50:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627995030;
 bh=+CYpznebU7Ex+1BJ7brPdLmFw2QBMoCXMi1ax8iYBt0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=diDFZ/UfenmPrIxFt+LNqTslMcGHsjOuyv75gr66REdBq+oLb/5HymeyVUlT+ovYR
 NZuZ3QNmrSdsKynLVVkXAgsJbrZrCus8CyRQp2TFqnMWMPK4S45XCHRXJHZW0ydFqt
 M4CVHXu0aQPpuwCVdWg/iyzQeVZFfE+gZw2pTrOi3tGKqzelfsC1+K8LTQ/o0Uj4Fu
 rvXrDmFQb3lLiWAjFR1X5AmsQF7ir3ZBT0ZP2Ra2vhvkYB2GF8D32Tud62zheS1Rox
 uzE+YRMMfvmdEq7FpWmX/ca4K2WokM3RX+Luo8yhjI+09igStqzuPRb77YGRtxrDz2
 FDb3GzWqruBzg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Michal Suchanek <msuchanek@suse.de>, "Gautham R.
 Shenoy" <ego@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 0/2] cpuidle/pseries: cleanup of the CEDE0 latency
 fixup code
In-Reply-To: <162798602812.163057.13114310314725073045.b4-ty@ellerman.id.au>
References: <1626676399-15975-1-git-send-email-ego@linux.vnet.ibm.com>
 <162798602812.163057.13114310314725073045.b4-ty@ellerman.id.au>
Date: Tue, 03 Aug 2021 22:50:28 +1000
Message-ID: <87o8aeofor.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, joedecke@de.ibm.com,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Mon, 19 Jul 2021 12:03:17 +0530, Gautham R. Shenoy wrote:
>> 
>> Hi,
>> 
>> This is the v5 of the patchset to fixup CEDE0 latency only from
>> POWER10 onwards.
>> 
>> 
>> [...]
>
> Applied to powerpc/next.
>
> [1/2] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
>       https://git.kernel.org/powerpc/c/7cbd631d4decfd78f8a17196dce9abcd4e7e1e94
> [2/2] cpuidle/pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
>       https://git.kernel.org/powerpc/c/4bceb03859c1a508669ce542c649c8d4f5d4bd93

First commit had a bad fixes tag, so now these are:

[1/2] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
      https://git.kernel.org/powerpc/c/50741b70b0cbbafbd9199f5180e66c0c53783a4a
[2/2] cpuidle/pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
      https://git.kernel.org/powerpc/c/71737a6c2a8f801622d2b71567d1ec1e4c5b40b8

cheers
