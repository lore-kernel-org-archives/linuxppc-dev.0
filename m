Return-Path: <SRS0=DHJf=KY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A58C4708E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 16:12:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B548461157
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 16:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B548461157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FsmmH3Jrjz3bs0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 May 2021 02:12:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fsmlt286lz2xvJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 May 2021 02:12:06 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4Fsmlk146wzBCPP;
 Sat, 29 May 2021 18:12:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sZhn_teJbZ1; Sat, 29 May 2021 18:12:02 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Fsmlk099zzBCNt;
 Sat, 29 May 2021 18:12:02 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id B06C317A; Sat, 29 May 2021 18:16:30 +0200 (CEST)
Received: from 37.167.209.238 ([37.167.209.238]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Sat, 29 May 2021 18:16:30 +0200
Date: Sat, 29 May 2021 18:16:30 +0200
Message-ID: <20210529181630.Horde.rvXKyt8t9f8DiqTVTuSKUw3@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 11/15] powerpc: convert to setup_initial_init_mm()
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-12-wangkefeng.wang@huawei.com>
In-Reply-To: <20210529105504.180544-12-wangkefeng.wang@huawei.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kefeng Wang <wangkefeng.wang@huawei.com> a =C3=A9crit=C2=A0:

> Use setup_initial_init_mm() helper to simplify code.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c=20=20
>=20b/arch/powerpc/kernel/setup-common.c
> index 046fe21b5c3b..c046d99efd18 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -928,10 +928,7 @@ void __init setup_arch(char **cmdline_p)
>
>  	klp_init_thread_info(&init_task);
>
> -	init_mm.start_code =3D (unsigned long)_stext;
> -	init_mm.end_code =3D (unsigned long) _etext;
> -	init_mm.end_data =3D (unsigned long) _edata;
> -	init_mm.brk =3D klimit;
> +	setup_initial_init_mm(_stext, _etext, _edata, _end);

This looks wrong, should be klimit instead of _end IIUC

>
>  	mm_iommu_init(&init_mm);
>  	irqstack_early_init();
> --
> 2.26.2


