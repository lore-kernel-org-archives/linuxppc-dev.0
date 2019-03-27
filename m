Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE0C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 11:39:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3287F204EC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 11:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3287F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TmH44478zDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 22:38:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TmF14zZxzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 22:37:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44TmF118KHz9sSg; Wed, 27 Mar 2019 22:37:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44TmF05q6wz9sPB;
 Wed, 27 Mar 2019 22:37:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/pseries/mce: fix misleading print for TLB
 mutlihit.
In-Reply-To: <155360342407.7831.11678112859745188108.stgit@jupiter>
References: <155360342407.7831.11678112859745188108.stgit@jupiter>
Date: Wed, 27 Mar 2019 22:37:04 +1100
Message-ID: <87mulgo8f3.fsf@concordia.ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> On pseries, TLB multihit are reported as D-Cache Multihit. This is because
> the wrongly populated mc_err_types[] array. Per PAPR, TLB error type is 0x04
> and mc_err_types[4] points to "D-Cache" instead of "TLB" string. Fixup the
> mc_err_types[] array.
>
> Machine check error type per PAPR:
> 0x00 = Uncorrectable Memory Error (UE)
> 0x01 = SLB error
> 0x02 = ERAT Error
> 0x04 = TLB error
> 0x05 = D-Cache error
> 0x07 = I-Cache error
>
> Fixes: 8f0b80561f21 ("powerpc/pseries: Display machine check error details.")
> Cc: <stable@vger.kernel.org> # v4.19+
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/ras.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index d97d52772789..452dcfd7e5dd 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -550,6 +550,7 @@ static void pseries_print_mce_info(struct pt_regs *regs,
>  		"UE",
>  		"SLB",
>  		"ERAT",
> +		"Unknown",
>  		"TLB",
>  		"D-Cache",
>  		"Unknown",

It seems like we might have avoided the bug if we'd numbered them from
the start, eg.

	static const char * const mc_err_types[] = {
		[0] = "UE",
		[1] = "SLB",
		[2] = "ERAT",
		[3] = "Unknown",
		[4] = "TLB",
		[5] = "D-Cache",
		[6] = "Unknown",
		[7] = "I-Cache",
	};


cheers
