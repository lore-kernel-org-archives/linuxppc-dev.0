Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10675C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:13:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA37820823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA37820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Ry06NrZzDqQ1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:13:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RN32MLRzDq69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RN24dKKz9sB3; Fri, 22 Feb 2019 20:47:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1b58a975be36994a572ae3b3fb3e023272bc299f
X-Patchwork-Hint: ignore
In-Reply-To: <20190131103022.10218-1-peterx@redhat.com>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv/npu: Remove redundant change_pte() hook
Message-Id: <445RN24dKKz9sB3@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:46 +1100 (AEDT)
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Jason Wang <jasowang@redhat.com>, Mark Hairgrove <mhairgrove@nvidia.com>,
 peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-01-31 at 10:30:22 UTC, Peter Xu wrote:
> The change_pte() notifier was designed to use as a quick path to
> update secondary MMU PTEs on write permission changes or PFN changes.
> For KVM, it could reduce the vm-exits when vcpu faults on the pages
> that was touched up by KSM.  It's not used to do cache invalidations,
> for example, if we see the notifier will be called before the real PTE
> update after all (please see set_pte_at_notify that set_pte_at was
> called later).
> 
> All the necessary cache invalidation should all be done in
> invalidate_range() already.
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Alistair Popple <alistair@popple.id.au>
> CC: Alexey Kardashevskiy <aik@ozlabs.ru>
> CC: Mark Hairgrove <mhairgrove@nvidia.com>
> CC: Balbir Singh <bsingharora@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Jerome Glisse <jglisse@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> Reviewed-by: Alistair Popple <alistair@popple.id.au>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b58a975be36994a572ae3b3fb3e0232

cheers
