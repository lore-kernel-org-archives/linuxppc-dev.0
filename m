Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B96A72C009C
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Jun 2013 16:40:37 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 13 Jun 2013 12:05:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 479D91258052
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Jun 2013 12:09:24 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D6eKu323330948
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Jun 2013 12:10:21 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D6eIef027410
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Jun 2013 16:40:18 +1000
Message-ID: <51B96933.60708@linux.vnet.ibm.com>
Date: Thu, 13 Jun 2013 12:09:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/perf: Freeze PMC5/6 if we're not using them on
 Power8
References: <1371086200-16778-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1371086200-16778-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2013 06:46 AM, Michael Ellerman wrote:
> On Power8 we can freeze PMC5 and 6 if we're not using them. Normally they
> run all the time.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/reg.h |    1 +
>  arch/powerpc/perf/power8-pmu.c |    4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 4a9e408..362142b 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -626,6 +626,7 @@
>  #define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
>  #define   MMCR0_PMAO	0x00000080UL /* performance monitor alert has occurred, set to 0 after handling exception */
>  #define   MMCR0_SHRFC	0x00000040UL /* SHRre freeze conditions between threads */
> +#define   MMCR0_FC56	0x00000010UL /* freeze counters 5 and 6 */
>  #define   MMCR0_FCTI	0x00000008UL /* freeze counters in tags inactive mode */
>  #define   MMCR0_FCTA	0x00000004UL /* freeze counters in tags active mode */
>  #define   MMCR0_FCWAIT	0x00000002UL /* freeze counter in WAIT state */
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index f7d1c4f..e791c68 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -378,6 +378,10 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
>  	if (pmc_inuse & 0x7c)
>  		mmcr[0] |= MMCR0_PMCjCE;
> 
> +	/* If we're not using PMC 5 or 6, freeze them */
> +	if (!(pmc_inuse & 0x60))
> +		mmcr[0] |= MMCR0_FC56;
> +
>  	mmcr[1] = mmcr1;
>  	mmcr[2] = mmcra;
> 

Hey Michael,

This looks good. But we need to undo this changes when we terminate the perf session.
That way user would be able to continue reading PMC5 and PMC6 through /sys interface
as before (which may not be ideal). Adding the following changes along with this patch
would keep the status quo as it is.

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29c6482..141756a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -881,6 +881,12 @@ static void power_pmu_disable(struct pmu *pmu)
 		}
 
 		/*
+ 		 * Undo PMC5/PMC6 freeze if already applied
+ 	 	 */
+		if (mfspr(SPRN_MMCR0) & MMCR0_FC56)
+			mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~PMCR0_FC56)
+
+		/*
 		 * Set the 'freeze counters' bit.
 		 * The barrier is to make sure the mtspr has been
 		 * executed and the PMU has frozen the events

Regards
Anshuman






 
