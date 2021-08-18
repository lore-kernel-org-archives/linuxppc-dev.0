Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D0EC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:53:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F2360238
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31F2360238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTr76FMtz3ff0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:53:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqTh34lG7z3d8W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:46:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTh06bxbz9sX2; Wed, 18 Aug 2021 23:46:08 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Parth Shah <parth@linux.ibm.com>
In-Reply-To: <20210728175607.591679-1-parth@linux.ibm.com>
References: <20210728175607.591679-1-parth@linux.ibm.com>
Subject: Re: [PATCHv2 0/3] Subject: [PATCHv2 0/3] Make cache-object aware of
 L3 siblings by parsing "ibm, thread-groups" property
Message-Id: <162929389333.3619265.2561500273870932225.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:13 +1000
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
Cc: parths1229@gmail.com, mikey@neuling.org, svaidy@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 28 Jul 2021 23:26:04 +0530, Parth Shah wrote:
> Changes from v1 -> v2:
> - Based on Gautham's comments, use a separate thread_group_l3_cache_map
>   and modify parsing code to build cache_map for L3. This makes the
>   cache_map building code isolated from the parsing code.
> v1 can be found at:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-June/230680.html
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/cacheinfo: Lookup cache by dt node and thread-group id
      https://git.kernel.org/powerpc/c/a4bec516b9c0823d7e2bb8c8928c98b535cf9adf
[2/3] powerpc/cacheinfo: Remove the redundant get_shared_cpu_map()
      https://git.kernel.org/powerpc/c/69aa8e078545bc14d84a8b4b3cb914ac8f9f280e
[3/3] powerpc/smp: Use existing L2 cache_map cpumask to find L3 cache siblings
      https://git.kernel.org/powerpc/c/e9ef81e1079b0c4c374fba0f9affa7129c7c913b

cheers
