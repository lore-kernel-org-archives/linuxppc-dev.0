Return-Path: <SRS0=mxpJ=ZD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC13C43331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 05:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DFD206C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 05:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="tzO9kkm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DFD206C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47BKf00rdRzF4gq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Nov 2019 16:47:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47BKCb6NwMzF1bv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2019 16:28:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="tzO9kkm+"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 47BKCY6XtWz9sPn; Mon, 11 Nov 2019 16:28:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1573450089; bh=Gk49bVSafO6qIOkqpX6nJCaX1ioKZx1OXiY1Eid0yQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tzO9kkm++WvSl259JyipYeMhoPff9fwIU5yZswgTFotSFTW8+QyqmIoXIsPh8/GWx
 C1d7HZsIxm7gjhzHagA36jMYph6dSnsKJu4vtzSQpp/NvijxvGXUd14h13HucKCJnV
 P/Y+PyMcPtwNQr2pqrJgmCD9OmL7bQaTwBiW+p3Lne0GkchrCKb6S2sP+Je+g3YgQp
 1zMuYge180wtE6ElW8JGmUgzb6CjWrpCCFL4TD1w6KshiemCO4opWIUzd6F+TVNquI
 qvtQ5FLv7KjaWBTKtAVWDy9a5bbcZCaJp1jxbphDRimvSNLEWgwj8xGkbf7PM+HiaL
 aS+a880rDPU/Q==
Date: Mon, 11 Nov 2019 16:28:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v10 6/8] KVM: PPC: Support reset of secure guest
Message-ID: <20191111052806.GC4017@oak.ozlabs.ibm.com>
References: <20191104041800.24527-1-bharata@linux.ibm.com>
 <20191104041800.24527-7-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104041800.24527-7-bharata@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxram@us.ibm.com, cclaudio@linux.ibm.com, kvm-ppc@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 04, 2019 at 09:47:58AM +0530, Bharata B Rao wrote:
> Add support for reset of secure guest via a new ioctl KVM_PPC_SVM_OFF.
> This ioctl will be issued by QEMU during reset and includes the
> the following steps:
> 
> - Ask UV to terminate the guest via UV_SVM_TERMINATE ucall
> - Unpin the VPA pages so that they can be migrated back to secure
>   side when guest becomes secure again. This is required because
>   pinned pages can't be migrated.

Unpinning the VPA pages is normally handled during VM reset by QEMU
doing set_one_reg operations to set the values for the
KVM_REG_PPC_VPA_ADDR, KVM_REG_PPC_VPA_SLB and KVM_REG_PPC_VPA_DTL
pseudo-registers to zero.  Is there some reason why this isn't
happening for a secure VM, and if so, what is that reason?
If it is happening, then why do we need to unpin the pages explicitly
here?

> - Reinitialize guest's partitioned scoped page tables. These are
>   freed when guest becomes secure (H_SVM_INIT_DONE)

It doesn't seem particularly useful to me to free the partition-scoped
page tables when the guest becomes secure, and it feels like it makes
things more fragile.  If you don't free them then, then you don't need
to reallocate them now.

> - Release all device pages of the secure guest.
> 
> After these steps, guest is ready to issue UV_ESM call once again
> to switch to secure mode.

Paul.
