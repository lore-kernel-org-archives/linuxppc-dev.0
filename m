Return-Path: <SRS0=AMrL=FT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D8C4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 02:19:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B1020782
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 02:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B1020782
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cw25J1cLPzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Dec 2020 13:19:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cw20y16NXzDqN3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2020 13:15:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=iGCM4a+7; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4Cw20x4l5jz9sS8; Tue, 15 Dec 2020 13:15:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1607998545; bh=ugDMLz0cIJY/0yg0ituBv2aXJJ7eai8cH4y0v0j0eN0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iGCM4a+7RiM9qj+CscAoWeiRykkq9SUrNAcnOlDbvTJpijcsRiBiClMIIvZ4Z0gpW
 rLlyGbj8APkhDBWSEqX0AxaF8aH4xRvPKJ7SvpbE1tVUNPo51senBpgwLW9yYRtR+E
 sWbJbhgUlDcn+fhe++QeMiFMQ9yxuCBOQGcHw9UtQw4x5lmLffGHGO6z2O2Wi5ZQ+4
 KGd/ilXRVxMACnZPa6txDg4rLcdP62pH0RYpd+8FdYXzZlItXAHy4A1KUUXVUcfcEg
 cQx/vmAx0vA6nREW5kfghPM63uxF8aAGOgZPQaJhKUDNxfEMCSfNlBzS6p7P3jyKgq
 2fpczAAPHPGBA==
Date: Tue, 15 Dec 2020 13:14:57 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: xiakaixu1987@gmail.com
Subject: Re: [PATCH] KVM: PPC: Book3S: Assign boolean values to a bool variable
Message-ID: <20201215021457.GB2441086@thinks.paulus.ozlabs.org>
References: <1604730382-5810-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604730382-5810-1-git-send-email-kaixuxia@tencent.com>
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 07, 2020 at 02:26:22PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle warnings:
> 
> ./arch/powerpc/kvm/book3s_xics.c:476:3-15: WARNING: Assignment of 0/1 to bool variable
> ./arch/powerpc/kvm/book3s_xics.c:504:3-15: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
