Return-Path: <SRS0=+eBE=FK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2588C4361B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Dec 2020 23:58:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061E5206FC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Dec 2020 23:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061E5206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cq3LG3lCfzDqZD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Dec 2020 10:58:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cq3HP3BZrzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2020 10:56:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=popple.id.au header.i=@popple.id.au header.a=rsa-sha256
 header.s=202006 header.b=OqofDlcK; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cq3HN0ZWfz9sW0;
 Mon,  7 Dec 2020 10:56:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=popple.id.au;
 s=202006; t=1607298960;
 bh=uJnLjHG8XDQtNpSijOLX+nT8QW710mtLpPMcymdw4cA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OqofDlcKqQ8/oAweiV+TNp+OBs0evCq0vtXx239/UpcuY0qv2hKDa7AwTRg2jXqss
 kofK+Qqk2T0NiuPf7H0yx2Uk3vJ3JiR8YLvBZtxl+ts6QrVOwVz1gUV8mb7Jz/JgJM
 rFr25vYotbHdDFLAIy4mNmn/ufZj8qNXBQFZNWE12DmwUJAfIcTY3EZZfmsio6sm8P
 1jZhDoaTUAavMWb0AlINyvLNDLikny7CH1IG1ODMz/2mA+/8oo1z4k4tQHESzIfNf5
 8OOFp0IAOzmbZ8auHWCsIRgqRnEEEx7b9yuJQEX705mcN5KE6YGzXc6cP2/8+k/amR
 P0z4qzAYjAleA==
From: Alistair Popple <alistair@popple.id.au>
To: bharata@linux.ibm.com
Subject: Re: [PATCH] powerpc/book3s_hv_uvmem: Check for failed page migration
Date: Mon, 07 Dec 2020 10:55:49 +1100
Message-ID: <7619698.bcDb2GHn21@cleo>
In-Reply-To: <20201204101841.GA621541@in.ibm.com>
References: <20201203050812.5234-1-alistair@popple.id.au>
 <20201204101841.GA621541@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: linuxppc-dev@lists.ozlabs.org, Ram Pai <linuxram@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Friday, 4 December 2020 9:18:41 PM AEDT Bharata B Rao wrote:
> 
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
> 
> Did you actually hit this scenario with secure VMs where a UV-paged-in
> page was later found to be not migratable?

No, this was found by inspection. I have no way of testing this but we had a 
similar issue in Nouveau and I think you would have a similar issue here 
although it might be hard to hit.

migrate_vma_pages() will fail a page migration if a CPU thread has raced and 
established a non-zero page PTE for the address. See migrate_vma_insert_page() 
for the implementation. It will also fail if something else has taken a 
reference on the page after calling migrate_vma_setup(), but that is less 
likely as any existing pages will have been isolated.

 - Alistair

> Regards,
> Bharata.
> 




