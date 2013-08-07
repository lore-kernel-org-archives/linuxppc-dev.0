Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/4] powerpc: Add new save_tar() register function.
In-reply-to: <20130807080744.GA12112@iris.ozlabs.ibm.com>
References: <1375855918-3625-1-git-send-email-mikey@neuling.org>
 <1375855918-3625-2-git-send-email-mikey@neuling.org>
 <20130807080744.GA12112@iris.ozlabs.ibm.com>
Date: Wed, 07 Aug 2013 20:55:55 +1000
Message-ID: <25550.1375872955@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +_GLOBAL(_save_tar)
> > +	/*
> > +	 * Back up the TAR across context switches.  Note that the TAR is not
> > +	 * available for use in the kernel.  (To provide this, the TAR should
> > +	 * be backed up/restored on exception entry/exit instead, and be in
> > +	 * pt_regs.  FIXME, this should be in pt_regs anyway (for debug).)
> > +	 */
> > +	mfspr	r0,SPRN_TAR
> > +	std	r0,THREAD_TAR(r3)
> > +	blr
> > +#endif
> 
> Why not do this in C, as in prev->tar = mfspr(SPRN_TAR); ?

Good point! 

I'd just copied the original code which was inline asm in _switch().  

Thanks,
Mikey
