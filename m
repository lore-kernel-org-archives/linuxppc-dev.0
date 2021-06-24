Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D52C49EA6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:04:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24221613F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24221613F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9hhr5992z3cSM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 00:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9hh94Cm0z306f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 00:04:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G9hh760LFz9sVt; Fri, 25 Jun 2021 00:04:07 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Jordan Niethe <jniethe5@gmail.com>
In-Reply-To: <20210609013431.9805-1-jniethe5@gmail.com>
References: <20210609013431.9805-1-jniethe5@gmail.com>
Subject: Re: [PATCH v15 0/9] powerpc: Further Strict RWX support
Message-Id: <162454339857.2931445.8178221923293563086.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 00:03:18 +1000
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
Cc: ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
 cmr@codefail.de, naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 9 Jun 2021 11:34:22 +1000, Jordan Niethe wrote:
> Adding more Strict RWX support on powerpc, in particular Strict Module RWX.
> It is now rebased on ppc next.
> 
> For reference the previous revision is available here:
> https://lore.kernel.org/linuxppc-dev/20210517032810.129949-1-jniethe5@gmail.com/
> 
> Changes for v15:
> 
> [...]

Applied to powerpc/next.

[1/9] powerpc/mm: Implement set_memory() routines
      https://git.kernel.org/powerpc/c/1f9ad21c3b384a8f16d8c46845a48a01d281a603
[2/9] powerpc/lib/code-patching: Set up Strict RWX patching earlier
      https://git.kernel.org/powerpc/c/71a5b3db9f209ea5d1e07371017e65398d3c6fbc
[3/9] powerpc/modules: Make module_alloc() Strict Module RWX aware
      https://git.kernel.org/powerpc/c/4fcc636615b1a309b39cab101a2b433cbf1f63f1
[4/9] powerpc/kprobes: Mark newly allocated probes as ROX
      https://git.kernel.org/powerpc/c/6a3a58e6230dc5b646ce3511436d7e74fc7f764b
[5/9] powerpc/bpf: Remove bpf_jit_free()
      https://git.kernel.org/powerpc/c/bc33cfdb0bb84d9e4b125a617a437c29ddcac4d9
[6/9] powerpc/bpf: Write protect JIT code
      https://git.kernel.org/powerpc/c/62e3d4210ac9c35783d0e8fc306df4239c540a79
[7/9] powerpc: Set ARCH_HAS_STRICT_MODULE_RWX
      https://git.kernel.org/powerpc/c/c35717c71e983ed55d61e523cbd11a798429bc82
[8/9] powerpc/mm: implement set_memory_attr()
      https://git.kernel.org/powerpc/c/4d1755b6a762149ae022a32fb2bbeefb6680baa6
[9/9] powerpc/32: use set_memory_attr()
      https://git.kernel.org/powerpc/c/c988cfd38e489d9390d253d4392590daf451d87a

cheers
