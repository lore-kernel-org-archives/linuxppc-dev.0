Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] powerpc: Correctly context switch DSCR on POWER8
In-reply-to: <20130805184205.79cafb9ac299313228ec53cc@canb.auug.org.au>
References: <1375687686-5633-1-git-send-email-mikey@neuling.org>
 <1375687686-5633-3-git-send-email-mikey@neuling.org>
 <20130805184205.79cafb9ac299313228ec53cc@canb.auug.org.au>
Date: Mon, 05 Aug 2013 19:26:36 +1000
Message-ID: <15850.1375694796@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> [This time from a good email address :-)]
> 
> Hi Mikey,
> 
> On Mon,  5 Aug 2013 17:28:06 +1000 Michael Neuling
> <mikey@neuling.org> wrote:
> >
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -1296,43 +1294,56 @@ void vsx_unavailable_exception(struct pt_regs *regs)
> >  	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
> >  }
> >  
> > +#ifdef CONFIG_PPC64
> >  void facility_unavailable_exception(struct pt_regs *regs)
> >  {
> >  	static char *facility_strings[] = {
> > -		"FPU",
> > -		"VMX/VSX",
> > -		"DSCR",
> > -		"PMU SPRs",
> > -		"BHRB",
> > -		"TM",
> > -		"AT",
> > -		"EBB",
> > -		"TAR",
> > +		[FSCR_FP_LG] = "FPU",
> > +		[FSCR_VECVSX_LG] = "VMX/VSX",
> > +		[FSCR_DSCR_LG] = "DSCR",
> > +		[FSCR_PM_LG] = "PMU SPRs",
> > +		[FSCR_BHRB_LG] = "BHRB",
> > +		[FSCR_TM_LG] = "TM",
> > +		[FSCR_EBB_LG] = "EBB",
> > +		[FSCR_TAR_LG] = "TAR",
> 
> I assume that you intentionally dropped "AT".

Yeah.

> 
> >  	};
> > -	char *facility, *prefix;
> > +	char *facility;
> >  	u64 value;
> > +	u8 status;
> > +	bool hv;
> >  
> >  	if (regs->trap == 0xf60) {
> >  		value = mfspr(SPRN_FSCR);
> > -		prefix = "";
> > +		hv = false;
> >  	} else {
> >  		value = mfspr(SPRN_HFSCR);
> > -		prefix = "Hypervisor ";
> > +		hv = true;
> >  	}
> 
> Maybe:
> 	hv = regs->trap == 0xf60;
> 	if (hv)
> 		value = mfspr(SPRN_HFSCR);
> 	else
> 		value = mfspr(SPRN_HFSCR);
> or
> 	value = mfspr(hv ? SPRN_HFSCR : SPRN_HFSCR);

ok.

> 
> > -	value = value >> 56;
> > +	status = value >> 56;
> > +
> > +	if (status < ARRAY_SIZE(facility_strings))
> > +		facility = facility_strings[status];
> > +	else
> > +		facility = "unknown";
> 
> For entries in the array that are not set, this will give facility ==
> NULL.  Is that what you intended?

No it wasn't, I'll catch that case, thanks.

> 
> >  	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
> > -		prefix, facility, regs->nip, regs->msr);
> > +	       hv ? "Hypervisor ":"", facility, regs->nip, regs->msr);
> 
> ... and this may attempt to print a NULL pointer with %s.  Also please
> put spaces around the : .

OK.

Mikey
