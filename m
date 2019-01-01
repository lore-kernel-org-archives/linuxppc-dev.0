Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C254C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 16:54:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB5721871
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 16:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5721871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43TgJG494DzDqHG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 03:54:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43TgG54ccNzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 03:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43TgG53Bcpz8t1X
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 03:52:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43TgG52gTXz9sCh; Wed,  2 Jan 2019 03:52:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43TgG43HJ8z9s2P
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2019 03:52:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43TgFw3rP6z9v0dZ;
 Tue,  1 Jan 2019 17:52:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3BJixBSvpv5C; Tue,  1 Jan 2019 17:52:20 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43TgFw3DRBz9v0dY;
 Tue,  1 Jan 2019 17:52:20 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 1A37564D; Tue,  1 Jan 2019 17:52:20 +0100 (CET)
Received: from 37.170.146.148 ([37.170.146.148]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 01 Jan 2019 17:52:19 +0100
Date: Tue, 01 Jan 2019 17:52:19 +0100
Message-ID: <20190101175219.Horde.M9y96Jn9ywiZ5BbROIsFAg1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
In-Reply-To: <20190101035601.13200-1-mpe@ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@ozlabs.org, chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> Currently the code produces several warnings, eg:
>
>   arch/powerpc/platforms/4xx/ocm.c:240:38: error: format '%llx'
>   expects argument of type 'long long unsigned int', but argument 3
>   has type 'phys_addr_t {aka unsigned int}'
>      seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
>                                    ~~~^     ~~~~~~~~~
>
> Fix it by using the special %pa[p] format for printing phys_addr_t.
> Note we need to pass the value by reference for the special specifier
> to work.

When I fixed the same problem in prom.c, you suggested to simply cast=20=20
it=20to unsigned long long. Is this a better solution ?

Christophe

>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/4xx/ocm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/4xx/ocm.c=20=20
>=20b/arch/powerpc/platforms/4xx/ocm.c
> index c22b099c42f1..a1aaa1569d7c 100644
> --- a/arch/powerpc/platforms/4xx/ocm.c
> +++ b/arch/powerpc/platforms/4xx/ocm.c
> @@ -237,12 +237,12 @@ static int ocm_debugfs_show(struct seq_file=20=20
>=20*m, void *v)
>  			continue;
>
>  		seq_printf(m, "PPC4XX OCM   : %d\n", ocm->index);
> -		seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
> +		seq_printf(m, "PhysAddr     : %pa[p]\n", &(ocm->phys));
>  		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
>  		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
>  		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
>
> -		seq_printf(m, "NC.PhysAddr  : 0x%llx\n", ocm->nc.phys);
> +		seq_printf(m, "NC.PhysAddr  : %pa[p]\n", &(ocm->nc.phys));
>  		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
>  		seq_printf(m, "NC.MemTotal  : %d Bytes\n", ocm->nc.memtotal);
>  		seq_printf(m, "NC.MemFree   : %d Bytes\n", ocm->nc.memfree);
> @@ -252,7 +252,7 @@ static int ocm_debugfs_show(struct seq_file *m, void =
*v)
>  							blk->size, blk->owner);
>  		}
>
> -		seq_printf(m, "\nC.PhysAddr   : 0x%llx\n", ocm->c.phys);
> +		seq_printf(m, "\nC.PhysAddr   : %pa[p]\n", &(ocm->c.phys));
>  		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
>  		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
>  		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);
> --
> 2.17.2


