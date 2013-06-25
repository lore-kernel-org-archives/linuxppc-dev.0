Return-Path: <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 11:36:07 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Freeze PMC5/6 if we're not using them on
 Power8
Message-ID: <20130625013607.GA14051@concordia>
References: <1371086200-16778-1-git-send-email-michael@ellerman.id.au>
 <51B96933.60708@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51B96933.60708@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 13, 2013 at 12:09:47PM +0530, Anshuman Khandual wrote:
> On 06/13/2013 06:46 AM, Michael Ellerman wrote:
> > On Power8 we can freeze PMC5 and 6 if we're not using them. Normally they
> > run all the time.
> >
> > index f7d1c4f..e791c68 100644
> > --- a/arch/powerpc/perf/power8-pmu.c
> > +++ b/arch/powerpc/perf/power8-pmu.c
> > @@ -378,6 +378,10 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
> >  	if (pmc_inuse & 0x7c)
> >  		mmcr[0] |= MMCR0_PMCjCE;
> > 
> > +	/* If we're not using PMC 5 or 6, freeze them */
> > +	if (!(pmc_inuse & 0x60))
> > +		mmcr[0] |= MMCR0_FC56;
> > +
> >  	mmcr[1] = mmcr1;
> >  	mmcr[2] = mmcra;
> > 
> 
> Hey Michael,
> 
> This looks good. But we need to undo this changes when we terminate the perf session.
> That way user would be able to continue reading PMC5 and PMC6 through /sys interface
> as before (which may not be ideal). Adding the following changes along with this patch
> would keep the status quo as it is.

Yep.

> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 29c6482..141756a 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -881,6 +881,12 @@ static void power_pmu_disable(struct pmu *pmu)
>  		}
>  
>  		/*
> + 		 * Undo PMC5/PMC6 freeze if already applied
> + 	 	 */
> +		if (mfspr(SPRN_MMCR0) & MMCR0_FC56)
> +			mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~PMCR0_FC56)

The intent here is correct. But you've added two mfsprs() and an mtspr()
when the surrounding code has already read MMCR0, and will soon write
it. They may not be that expensive but still.

See my updated patch.

cheers
