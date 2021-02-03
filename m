Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8097C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:54:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B7F64F6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B7F64F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW0Tk3F2HzDwtj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 22:54:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09312z4zDwvC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW0903CHVz9tkZ; Wed,  3 Feb 2021 22:40:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Qian Cai <cai@lca.pw>
In-Reply-To: <20200510051347.1906-1-cai@lca.pw>
References: <20200510051347.1906-1-cai@lca.pw>
Subject: Re: [PATCH] powerpc/powernv/pci: fix a RCU-list lock
Message-Id: <161235200863.1516112.12206707948646314806.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:03 +1100 (AEDT)
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
Cc: aik@ozlabs.ru, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 10 May 2020 01:13:47 -0400, Qian Cai wrote:
> It is unsafe to traverse tbl->it_group_list without the RCU read lock.
> 
>  WARNING: suspicious RCU usage
>  5.7.0-rc4-next-20200508 #1 Not tainted
>  -----------------------------
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c:355 RCU-list traversed in non-reader section!!
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/pci: fix a RCU-list lock
      https://git.kernel.org/powerpc/c/c9790fb5df461c91d3fff1d864c1acb8baf5ad5c

cheers
