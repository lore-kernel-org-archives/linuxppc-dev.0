Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEBB62C00BE
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 04:24:31 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 12:24:29 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DEFF419D8081
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 12:24:20 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PIOMMQ089944
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 12:24:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PIOKUf032637
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 12:24:21 -0600
Date: Thu, 25 Apr 2013 11:24:06 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/perf: Add support for SIER
Message-ID: <20130425182406.GC28848@us.ibm.com>
References: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
 <1365582765-6939-4-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365582765-6939-4-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| From: Michael Ellerman <michaele@au1.ibm.com>
| 
| On power8 we have a new SIER (Sampled Instruction Event Register), which
| captures information about instructions when we have random sampling
| enabled.
| 
| Add support for loading the SIER into pt_regs, overloading regs->dar.
| Also set the new NO_SIPR flag in regs->result if we don't have SIPR.
| 
| Update regs_sihv/sipr() to look for SIPR/SIHV in SIER.
| 
| Signed-off-by: Michael Ellerman <michaele@au1.ibm.com>
| ---
|  arch/powerpc/include/asm/perf_event_server.h |    1 +
|  arch/powerpc/perf/core-book3s.c              |   19 +++++++++++++++++++
|  2 files changed, 20 insertions(+)
| 
| diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
| index e287aef..a1a1ad8 100644
| --- a/arch/powerpc/include/asm/perf_event_server.h
| +++ b/arch/powerpc/include/asm/perf_event_server.h
| @@ -53,6 +53,7 @@ struct power_pmu {
|  #define PPMU_NO_CONT_SAMPLING	0x00000008 /* no continuous sampling */
|  #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
|  #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
| +#define PPMU_HAS_SIER		0x00000040 /* Has SIER */
| 
|  /*
|   * Values for flags to get_alternatives()
| diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
| index 4255b12..a4bbd4d 100644
| --- a/arch/powerpc/perf/core-book3s.c
| +++ b/arch/powerpc/perf/core-book3s.c
| @@ -116,6 +116,9 @@ static bool regs_sihv(struct pt_regs *regs)
|  {
|  	unsigned long sihv = MMCRA_SIHV;
| 
| +	if (ppmu->flags & PPMU_HAS_SIER)
| +		return !!(regs->dar & SIER_SIHV);
| +

Were SIER_SIHV and SIER_SIPR defined in an earlier patch set ?

|  	if (ppmu->flags & PPMU_ALT_SIPR)
|  		sihv = POWER6_MMCRA_SIHV;
| 
| @@ -126,6 +129,9 @@ static bool regs_sipr(struct pt_regs *regs)
|  {
|  	unsigned long sipr = MMCRA_SIPR;
| 
| +	if (ppmu->flags & PPMU_HAS_SIER)
| +		return !!(regs->dar & SIER_SIPR);
| +
|  	if (ppmu->flags & PPMU_ALT_SIPR)
|  		sipr = POWER6_MMCRA_SIPR;
| 
| @@ -184,6 +190,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
|  /*
|   * Overload regs->dsisr to store MMCRA so we only need to read it once
|   * on each interrupt.
| + * Overload regs->dar to store SIER if we have it.
|   * Overload regs->result to specify whether we should use the MSR (result
|   * is zero) or the SIAR (result is non zero).
|   */
| @@ -200,6 +207,18 @@ static inline void perf_read_regs(struct pt_regs *regs)
|  		regs->result |= 2;
| 
|  	/*
| +	 * On power8 if we're in random sampling mode, the SIER is updated.
| +	 * If we're in continuous sampling mode, we don't have SIPR.
| +	 */
| +	if (ppmu->flags & PPMU_HAS_SIER) {
| +		if (marked)
| +			regs->dar = mfspr(SPRN_SIER);
| +		else
| +			regs->result |= 2;

Can we use a helper, regs_set_no_sipr() to set this - since we set and
test in more than one place ?

Other than these nits, the patchset looks good.

Sukadev
