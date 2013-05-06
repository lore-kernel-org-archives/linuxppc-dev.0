Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc,
 perf: Fix processing conditions for invalid BHRB entries
In-reply-to: <5187A144.9080307@linux.vnet.ibm.com>
References: <1367831206-16331-1-git-send-email-khandual@linux.vnet.ibm.com>
 <24261.1367838705@ale.ozlabs.ibm.com> <5187A144.9080307@linux.vnet.ibm.com>
Date: Tue, 07 May 2013 07:22:51 +1000
Message-ID: <26310.1367875371@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 05/06/2013 04:41 PM, Michael Neuling wrote:
> > Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> > 
> >> Fixing some conditions during BHRB entry processing.
> > 
> > I think we can simplify this a lot more... something like the below.
> > 
> 
> I feel that the conditional handling of the invalid BHRB entries should be
> present which would help us during the debug and also could be used for more
> granular branch classification or error handling later on.

If we need that, then we can add it later on.  You'd still need to
modify the code to do any debug, branch classification or error handling
as the code is now.  It's just an unnecessary place holder.  

The code is unnecessarily verbose now.  This patch removes about 20
lines of code and does the same thing.

Mikey

> 
> > Also, this marks the "to" address as all 1s, which is better poison
> > value since it's possible to branch to/from 0x0.
> >
> 
> Agreed.
> 
> 
> > diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> > index c627843..d410d65 100644
> > --- a/arch/powerpc/perf/core-book3s.c
> > +++ b/arch/powerpc/perf/core-book3s.c
> > @@ -1463,65 +1463,45 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
> >  {
> >  	u64 val;
> >  	u64 addr;
> > -	int r_index, u_index, target, pred;
> > +	int r_index, u_index, pred;
> > 
> >  	r_index = 0;
> >  	u_index = 0;
> >  	while (r_index < ppmu->bhrb_nr) {
> >  		/* Assembly read function */
> > -		val = read_bhrb(r_index);
> > +		val = read_bhrb(r_index++);
> > 
> >  		/* Terminal marker: End of valid BHRB entries */
> > -		if (val == 0) {
> > +		if (!val) {
> >  			break;
> >  		} else {
> >  			/* BHRB field break up */
> >  			addr = val & BHRB_EA;
> >  			pred = val & BHRB_PREDICTION;
> > -			target = val & BHRB_TARGET;
> > 
> > -			/* Probable Missed entry: Not applicable for POWER8 */
> > -			if ((addr == 0) && (target == 0) && (pred == 1)) {
> > -				r_index++;
> > +			if (!addr)
> > +				/* invalid entry */
> >  				continue;
> > -			}
> > -
> > -			/* Real Missed entry: Power8 based missed entry */
> > -			if ((addr == 0) && (target == 1) && (pred == 1)) {
> > -				r_index++;
> > -				continue;
> > -			}
> > 
> > -			/* Reserved condition: Not a valid entry  */
> > -			if ((addr == 0) && (target == 1) && (pred == 0)) {
> > -				r_index++;
> > -				continue;
> > -			}
> > -
> > -			/* Is a target address */
> >  			if (val & BHRB_TARGET) {
> >  				/* First address cannot be a target address */
> > -				if (r_index == 0) {
> > -					r_index++;
> > +				if (r_index == 0)
> >  					continue;
> > -				}
> > 
> >  				/* Update target address for the previous entry */
> >  				cpuhw->bhrb_entries[u_index - 1].to = addr;
> >  				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
> >  				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
> > -
> > -				/* Dont increment u_index */
> > -				r_index++;
> >  			} else {
> >  				/* Update address, flags for current entry */
> >  				cpuhw->bhrb_entries[u_index].from = addr;
> > +				cpuhw->bhrb_entries[u_index].to =
> > +					0xffffffffffffffff;
> >  				cpuhw->bhrb_entries[u_index].mispred = pred;
> >  				cpuhw->bhrb_entries[u_index].predicted = ~pred;
> > 
> >  				/* Successfully popullated one entry */
> >  				u_index++;
> > -				r_index++;
> >  			}
> >  		}
> >  	}
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
