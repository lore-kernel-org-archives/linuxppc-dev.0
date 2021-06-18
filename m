Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E784C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B67611AC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B67611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5mC20p95z3fXZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 14:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5m4M2vqDz3c3L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 14:22:59 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5m4L0LT0z9sXN; Fri, 18 Jun 2021 14:22:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1622708530.git.christophe.leroy@csgroup.eu>
References: <cover.1622708530.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/12] powerpc: Optimise KUAP on book3s/32
Message-Id: <162398829609.1363949.12564499479080252170.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:51:36 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Jun 2021 08:41:35 +0000 (UTC), Christophe Leroy wrote:
> This series is a rework of KUAP on book3s/32.
> 
> On book3s32, KUAP is heavier than on other platform because it can't
> be opened globaly at once, it must be done for each 256Mb segment.
> 
> Instead of opening access to all necessary segments via a heavy logic,
> only open access to the segment matching the start of the range.
> 
> [...]

Applied to powerpc/next.

[01/12] powerpc/32s: Move setup_{kuep/kuap}() into {kuep/kuap}.c
        https://git.kernel.org/powerpc/c/91ec66719d4c5c0e7b4e32585b01881660d1bc53
[02/12] powerpc/32s: Refactor update of user segment registers
        https://git.kernel.org/powerpc/c/91bb30822a2e1d7900f9f42e9e92647a9015f979
[03/12] powerpc/32s: move CTX_TO_VSID() into mmu-hash.h
        https://git.kernel.org/powerpc/c/7235bb3593781ed022d0714a73c2c0d8eb8a835f
[04/12] powerpc/32s: Convert switch_mmu_context() to C
        https://git.kernel.org/powerpc/c/863771a28e27dc9eaeaa88cea300370d032f0e0f
[05/12] powerpc/32s: Simplify calculation of segment register content
        https://git.kernel.org/powerpc/c/882136fb2f5208a35ddad9205b20e5791edd4782
[06/12] powerpc/32s: Initialise KUAP and KUEP in C
        https://git.kernel.org/powerpc/c/86f46f3432727933be82f64b739712a6edb9d704
[07/12] powerpc/32s: Allow disabling KUEP at boot time
        https://git.kernel.org/powerpc/c/50d2f104cd9572af476579eae9aa1b38de602ec7
[08/12] powerpc/32s: Allow disabling KUAP at boot time
        https://git.kernel.org/powerpc/c/6b4d630068b0c5cdd6d8e599182b131448e0cb06
[09/12] powerpc/32s: Rework Kernel Userspace Access Protection
        https://git.kernel.org/powerpc/c/16132529cee586ee9a058bb33cfbdcb5d884f6b3
[10/12] powerpc/32s: Activate KUAP and KUEP by default
        https://git.kernel.org/powerpc/c/9f5bd8f1471d7498c934c0a686fd0997cf872653
[11/12] powerpc/kuap: Remove KUAP_CURRENT_XXX
        https://git.kernel.org/powerpc/c/d008f8f8a0c3efe4fe1008a797f9497ea5965e27
[12/12] powerpc/kuap: Remove to/from/size parameters of prevent_user_access()
        https://git.kernel.org/powerpc/c/cb2f1fb205cc20695fcaef84baf80d9d3e54c88b

cheers
