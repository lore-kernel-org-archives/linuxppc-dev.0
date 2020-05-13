Return-Path: <SRS0=uIst=63=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB5CA90AF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 13:09:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F9520E90
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YvG1WvWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F9520E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49MZlN1m9FzDqC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 23:09:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49MZMF0NJDzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2020 22:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YvG1WvWc; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49MZMC3vWyz9sRK;
 Wed, 13 May 2020 22:52:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589374343;
 bh=4hbbjTrl8Oyb6OQ8HlwSWB7PGv1s+h8H8v3564mNcIs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YvG1WvWckNOBx4ibiW0kC7pS+WK/qbVplR+JhAeGPGjovLNwCn6GSGZe+QgDXNjh0
 KqjJbLFoA0DAFXyHxzQFOdZ64IcwF8fou4LwFq4qG7/0WT3lC9TvVMGSl6TAJYWuqA
 k5bDd7XI1UV2o4EG+Ck6VecHu2PTuqR1MIAb/f/rw3PSeFW3GSnqz8WiNrnjDNVpMy
 VsCvMGNWl7lhvqxNYGNqVO7GIWsr70mNdtQmfH9786ewT0cCl87M2YQBdGGomnsvNG
 E2EsZRtQbyf+FyxhghM/KHfaMbdNzfWfo6MCTDx2OIuBInZY25ag7sSP4H/cV310mY
 T7jE5dsKVzx8A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 13/30] powerpc: Add a probe_user_read_inst() function
In-Reply-To: <20200506034050.24806-14-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-14-jniethe5@gmail.com>
Date: Wed, 13 May 2020 22:52:42 +1000
Message-ID: <87blmsatet.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: christophe.leroy@c-s.fr, alistair@popple.id.au, npiggin@gmail.com,
 bala24@linux.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 naveen.n.rao@linux.vnet.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe <jniethe5@gmail.com> writes:
> diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
> new file mode 100644
> index 000000000000..eaf786afad2b
> --- /dev/null
> +++ b/arch/powerpc/lib/inst.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright 2020, IBM Corporation.
> + */
> +
> +#include <linux/uaccess.h>
> +#include <asm/inst.h>
> +
> +int probe_user_read_inst(struct ppc_inst *inst,
> +			 struct ppc_inst *nip)
> +{
> +	unsigned int val;
> +	int err;
> +
> +	err = probe_user_read(&val, nip, sizeof(val));
> +	*inst = ppc_inst(val);

We shouldn't be storing to *inst if the read failed?

I changed it to:

+	if (!err)
+		*inst = ppc_inst(val);
+

Similarly for probe_kernel_read_inst().

cheers
