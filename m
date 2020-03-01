Return-Path: <SRS0=60rt=4S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F1C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 12:05:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8CA2087F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nPaZVmh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8CA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48VhmK6Jm0zDrFC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 23:05:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Vhjg2NbQzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Mar 2020 23:02:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=nPaZVmh4; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48Vhjf5tkdz9sSH; Sun,  1 Mar 2020 23:02:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48Vhjf2vTKz9sQt
 for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2020 23:02:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1583064166;
 bh=bWSEe9nVvnvgP9MmMJBzELOxO1XRHHsUG+DHDiAZ+Ho=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=nPaZVmh4+WAXcscmNT03P83nwMdU3Yws5ovb6E2IQrHouxeRiIt3/HM3XK35XMyKV
 pEShyEBYyxQ3kQwiICA4A92KwDZLwDjw/oRlLgFXYaUBZxFPBXI4IbfNetFagqfXiS
 KzkgsmLtSpaYj5UOBLfv7rEWLbRUEj5X6z3o5NOjJdvk+U0UUAxfzVXgPCvTYBAjHy
 57QXt26y4OZNSGoFmF/+u+HNlhdBriGWFXf2R0XdsRk66uhjFBBtYhLOqx6+psDlZU
 PqSqi1lGaJgeAJ0LrIUh7y4vI41QnwZr33S8pMkeQnBV9MK55o1V4M4CxHhsFuRGNW
 Lqs4G9veaQUFw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: fix hardware PMU exception bug on PowerVM
 compatibility mode systems
In-Reply-To: <20200301111717.22236-1-mpe@ellerman.id.au>
References: <20200301111717.22236-1-mpe@ellerman.id.au>
Date: Sun, 01 Mar 2020 23:02:44 +1100
Message-ID: <87mu901dwb.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> From: "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>
>
> PowerVM systems running compatibility mode on a few Power8 revisions are
> still vulnerable to the hardware defect that loses PMU exceptions arriving
> prior to a context switch.
>
> The software fix for this issue is enabled through the CPU_FTR_PMAO_BUG
> cpu_feature bit, nevertheless this bit also needs to be set for PowerVM
> compatibility mode systems.
>
> Fixes: 68f2f0d431d9ea4 ("powerpc: Add a cpu feature CPU_FTR_PMAO_BUG")
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
> Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://lore.kernel.org/r/20200227134715.9715-1-desnesn@linux.ibm.com
> ---
>  arch/powerpc/kernel/cputable.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Ignore, PEBKAC.

Don't try to operate git-send-email after 10pm.

cheers


> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index e745abc5457a..245be4fafe13 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2193,11 +2193,13 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>  		 * oprofile_cpu_type already has a value, then we are
>  		 * possibly overriding a real PVR with a logical one,
>  		 * and, in that case, keep the current value for
> -		 * oprofile_cpu_type.
> +		 * oprofile_cpu_type. Futhermore, let's ensure that the
> +		 * fix for the PMAO bug is enabled on compatibility mode.
>  		 */
>  		if (old.oprofile_cpu_type != NULL) {
>  			t->oprofile_cpu_type = old.oprofile_cpu_type;
>  			t->oprofile_type = old.oprofile_type;
> +			t->cpu_features |= old.cpu_features & CPU_FTR_PMAO_BUG;
>  		}
>  	}
>  
> -- 
> 2.21.1
