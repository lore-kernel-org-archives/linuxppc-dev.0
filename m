Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CEAC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 10:32:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C890A20651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C890A20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f69H6VgFzDqWc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 21:32:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f67Y2wgzzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 21:31:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43f67Y0DwVz9s9G;
 Tue, 15 Jan 2019 21:31:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, benh@kernel.crashing.org,
 paulus@samba.org, aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: PCI does not require PowerNV
In-Reply-To: <20190115004745.9996-1-Jason@zx2c4.com>
References: <20190115004745.9996-1-Jason@zx2c4.com>
Date: Tue, 15 Jan 2019 21:31:02 +1100
Message-ID: <87d0oyyzyx.fsf@concordia.ellerman.id.au>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jason,

Thanks for the patch.

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
> did not conditionalize it inside of the PCI pSeries driver. This meant
> that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
> in:
>
> powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
> pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'
>
> This commit therefore wraps that line in an ifdef, so that PCI works
> without PowerNV.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")

I think this should actually be:

  Fixes: 3be2df00e299 ("powerpc/pseries/npu: Enable platform support")

Because that's the commit that added the call to pnv_npu2_init() in the
pseries code. Prior to that it was only called from powernv code.

I'll update the change log to reflect that, unless you disagree.

cheers

> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 7725825d887d..37a77e57893e 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -264,7 +264,9 @@ void __init pSeries_final_fixup(void)
>  			if (!of_device_is_compatible(nvdn->parent,
>  						"ibm,power9-npu"))
>  				continue;
> +#ifdef CONFIG_PPC_POWERNV
>  			WARN_ON_ONCE(pnv_npu2_init(hose));
> +#endif
>  			break;
>  		}
>  	}
> -- 
> 2.20.1
