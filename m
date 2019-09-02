Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0095C3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 03:10:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA8C20656
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 03:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA8C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MFTV6JBLzDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 13:10:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MFN70kGMzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 13:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46MFN66pq4z9sNf; Mon,  2 Sep 2019 13:06:14 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4f916593be9da38c5cf0d3a5c386b57beb70f422
In-Reply-To: <20190826045520.92153-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH kernel] KVM: PPC: Fix incorrect guest-to-user-translation
 error handling
Message-Id: <46MFN66pq4z9sNf@ozlabs.org>
Date: Mon,  2 Sep 2019 13:06:14 +1000 (AEST)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-08-26 at 04:55:20 UTC, Alexey Kardashevskiy wrote:
> H_PUT_TCE_INDIRECT handlers receive a page with up to 512 TCEs from
> a guest. Although we verify correctness of TCEs before we do anything
> with the existing tables, there is a small window when a check in
> kvmppc_tce_validate might pass and right after that the guest alters
> the page with TCEs which can cause early exit from the handler and
> leave srcu_read_lock(&vcpu->kvm->srcu) (virtual mode) or lock_rmap(rmap)
> (real mode) locked.
> 
> This fixes the bug by jumping to the common exit code with an appropriate
> unlock.
> 
> Fixes: 121f80ba68f1 ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/4f916593be9da38c5cf0d3a5c386b57beb70f422

cheers
