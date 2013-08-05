Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] powerpc: Correctly context switch DSCR on POWER8
In-reply-to: <15850.1375694796@ale.ozlabs.ibm.com>
References: <1375687686-5633-1-git-send-email-mikey@neuling.org>
 <1375687686-5633-3-git-send-email-mikey@neuling.org>
 <20130805184205.79cafb9ac299313228ec53cc@canb.auug.org.au>
 <15850.1375694796@ale.ozlabs.ibm.com>
Date: Mon, 05 Aug 2013 20:16:23 +1000
Message-ID: <21599.1375697783@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > >  	};
> > > -	char *facility, *prefix;
> > > +	char *facility;
> > >  	u64 value;
> > > +	u8 status;
> > > +	bool hv;
> > >  
> > >  	if (regs->trap == 0xf60) {
> > >  		value = mfspr(SPRN_FSCR);
> > > -		prefix = "";
> > > +		hv = false;
> > >  	} else {
> > >  		value = mfspr(SPRN_HFSCR);
> > > -		prefix = "Hypervisor ";
> > > +		hv = true;
> > >  	}
> > 
> > Maybe:
> > 	hv = regs->trap == 0xf60;
> > 	if (hv)
> > 		value = mfspr(SPRN_HFSCR);
> > 	else
> > 		value = mfspr(SPRN_HFSCR);
> > or
> > 	value = mfspr(hv ? SPRN_HFSCR : SPRN_HFSCR);
> 
> ok.

So this doesn't work...  I forgot that mfspr is just a macro around the
mfspr instruction, so we can't dynamically pass in the SPR number,

So I have to use your first version. 

Mikey
