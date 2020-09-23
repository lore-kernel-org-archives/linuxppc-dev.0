Return-Path: <SRS0=wj8a=DA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E5C2D0E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2020 00:13:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051EE2076B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2020 00:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NWfNdS/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051EE2076B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BwzD16GGyzDqTW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2020 10:13:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bwz9m5z49zDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2020 10:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=NWfNdS/J; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Bwz9m4kHZz9sTh; Wed, 23 Sep 2020 10:11:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1600819884; bh=qxuvilfoTnyNq+tBA0iFeUPCv77I+0VTd8cXq4bIGDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NWfNdS/JTWDcyBku0m3+xPTR5aINhEBrBGiXkZYxihUsfRyEAx8YYXQfSIbuYukYJ
 oUAvy5xWbDlrXOR7+jkKHKKUAPMXVxjmahCCpSd7nrM8GeMCBldurDO67GdaJeAhof
 Q8U2KQAgohzYIPGQ9tDpKD10mineXmYVJ7cfwYIhE0rgruCv3GBZaaiYJdQ+IASBYy
 1BXRkbz/08ecQaEC2NfTKnEVtX80f+wWddpwSF4AV6VNMhlokatZ1obdr/LQfzOuLa
 WfpmD5ZzB2NrdZgCzmiK0R7dH5XcqJInPe7JTaft7Xo42VRE5tB+UjR8rKWgqDSdwK
 ym2fRbUP7tUTw==
Date: Wed, 23 Sep 2020 10:08:00 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Subject: Re: [PATCH -next] powerpc/kvm/books: Fix symbol undeclared warnings
Message-ID: <20200923000800.GB531519@thinks.paulus.ozlabs.org>
References: <20200921112211.82830-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921112211.82830-1-wangwensheng4@huawei.com>
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
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 21, 2020 at 11:22:11AM +0000, Wang Wensheng wrote:
> Build the kernel with `C=2`:
> arch/powerpc/kvm/book3s_hv_nested.c:572:25: warning: symbol
> 'kvmhv_alloc_nested' was not declared. Should it be static?
> arch/powerpc/kvm/book3s_64_mmu_radix.c:350:6: warning: symbol
> 'kvmppc_radix_set_pte_at' was not declared. Should it be static?
> arch/powerpc/kvm/book3s_hv.c:3568:5: warning: symbol
> 'kvmhv_p9_guest_entry' was not declared. Should it be static?
> arch/powerpc/kvm/book3s_hv_rm_xics.c:767:15: warning: symbol 'eoi_rc'
> was not declared. Should it be static?
> arch/powerpc/kvm/book3s_64_vio_hv.c:240:13: warning: symbol
> 'iommu_tce_kill_rm' was not declared. Should it be static?
> arch/powerpc/kvm/book3s_64_vio.c:492:6: warning: symbol
> 'kvmppc_tce_iommu_do_map' was not declared. Should it be static?
> arch/powerpc/kvm/book3s_pr.c:572:6: warning: symbol 'kvmppc_set_pvr_pr'
> was not declared. Should it be static?
> 
> Those symbols are used only in the files that define them so make them
> static to fix the warnings.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>

Thanks, applied.

Paul.
