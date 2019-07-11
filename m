Return-Path: <SRS0=Bl8b=VI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C49C74A52
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 12:59:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3C821019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 12:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3C821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kx3T4cgjzDqgw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 22:59:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kx0Q4VVmzDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 22:57:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45kx0Q2FGrz9sNT; Thu, 11 Jul 2019 22:57:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45kx0P2Pdmz9sNH;
 Thu, 11 Jul 2019 22:57:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Claudio Carvalho <cclaudio@linux.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4 1/8] KVM: PPC: Ultravisor: Introduce the MSR_S bit
In-Reply-To: <20190628200825.31049-2-cclaudio@linux.ibm.com>
References: <20190628200825.31049-1-cclaudio@linux.ibm.com>
 <20190628200825.31049-2-cclaudio@linux.ibm.com>
Date: Thu, 11 Jul 2019 22:57:07 +1000
Message-ID: <87muhkg258.fsf@concordia.ellerman.id.au>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, Ryan Grimm <grimm@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>
> The ultravisor processor mode is introduced in POWER platforms that
> supports the Protected Execution Facility (PEF). Ultravisor is higher
> privileged than hypervisor mode.
>
> In PEF enabled platforms, the MSR_S bit is used to indicate if the
> thread is in secure state. With the MSR_S bit, the privilege state of
> the thread is now determined by MSR_S, MSR_HV and MSR_PR, as follows:
>
> S   HV  PR
> -----------------------
> 0   x   1   problem
> 1   0   1   problem
> x   x   0   privileged
> x   1   0   hypervisor
> 1   1   0   ultravisor
> 1   1   1   reserved

What are you trying to express with the 'x' value?

I guess you mean it as "either" or "don't care" - but then you have
cases where it could only have one value, such as hypervisor. I think it
would be clearer if you spelled it out more explicitly.

> The hypervisor doesn't (and can't) run with the MSR_S bit set, but a
> secure guest and the ultravisor firmware do.

I know you're trying to be helpful, but this comment is really just
confusing to someone who doesn't have all the documentation.

I'd really like to see something in Documentation/powerpc describing at
least the outline of how the system works. I'm pretty sure most of that
is public, so even if it's mostly a list of references to other
documentations or presentations that would be fine. But I'm not really
happy with a whole new processor mode appearing with zero documentation
in the tree.

> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> [ Update the commit message ]

It's normal to prefix these comments with your handle to make it clear
who is saying it.

> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 10caa145f98b..39b4c0a519f5 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -38,6 +38,7 @@
>  #define MSR_TM_LG	32		/* Trans Mem Available */
>  #define MSR_VEC_LG	25	        /* Enable AltiVec */
>  #define MSR_VSX_LG	23		/* Enable VSX */
> +#define MSR_S_LG	22		/* Secure VM bit */

I don't think that's the best description, because it's also the
Ultravisor bit when MSR[HV] = 1.

So "Secure state" as you have below would be better IMO.

cheers

>  #define MSR_POW_LG	18		/* Enable Power Management */
>  #define MSR_WE_LG	18		/* Wait State Enable */
>  #define MSR_TGPR_LG	17		/* TLB Update registers in use */
> @@ -71,11 +72,13 @@
>  #define MSR_SF		__MASK(MSR_SF_LG)	/* Enable 64 bit mode */
>  #define MSR_ISF		__MASK(MSR_ISF_LG)	/* Interrupt 64b mode valid on 630 */
>  #define MSR_HV 		__MASK(MSR_HV_LG)	/* Hypervisor state */
> +#define MSR_S		__MASK(MSR_S_LG)	/* Secure state */
>  #else
>  /* so tests for these bits fail on 32-bit */
>  #define MSR_SF		0
>  #define MSR_ISF		0
>  #define MSR_HV		0
> +#define MSR_S		0
>  #endif
>  
>  /*
> -- 
> 2.20.1
