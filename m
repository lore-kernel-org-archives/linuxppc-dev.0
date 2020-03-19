Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB68C4332B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:43:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312B02076C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OR2YdyN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312B02076C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48k3PT46sCzDrS6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 10:43:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48k3Cm67QkzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=OR2YdyN3; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48k3Cm5glTz9sSN; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 48k3Cm4pkTz9sSK; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1584660884; bh=8/nwuYSUP1Qm/RPYgjFE8kvBJjM7phd9M7wZLcqKx/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OR2YdyN3kPXkjJCutfQ6yInoGe/69l6616eQ3CoTSqkVjJRsvEV0gDG5HUIbQSSJ9
 JdiuSDjOcuhC8SWDJZ+5CelrVpH4A8guUabTUw5wHAozZyq+ZuHH6m1EJ8p+sfrB3h
 IkI2x1Z4iVQHbR3Xerv5lbHbSv/u4eh/yfIFh9iXJLHC5esji+ULI1ITdERwy2jAGJ
 CcL4Wy52sg9ED5/C8Ka/VxNo2h9eyMRKhekcLuY9qQBaucLALPwc94mp72TWYWbni4
 i6dpoCVUPVhJg3SbnDIAURTfJiijrXWL41Tr535gb/hJTQHyxK8yKFTnBYy2Xok6Uc
 LFtu0VsLIPHQw==
Date: Fri, 20 Mar 2020 10:31:19 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Use RADIX_PTE_INDEX_SIZE in Radix
 MMU code
Message-ID: <20200319233118.GB3260@blackberry>
References: <20200218043650.24410-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218043650.24410-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 03:36:50PM +1100, Michael Ellerman wrote:
> In kvmppc_unmap_free_pte() in book3s_64_mmu_radix.c, we use the
> non-constant value PTE_INDEX_SIZE to clear a PTE page.
> 
> We can instead use the constant RADIX_PTE_INDEX_SIZE, because we know
> this code will only be running when the Radix MMU is active.
> 
> Note that we already use RADIX_PTE_INDEX_SIZE for the allocation of
> kvm_pte_cache.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, applied to my kvm-ppc-next branch.

Paul.
