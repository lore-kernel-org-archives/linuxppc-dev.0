Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 443A467B75
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 09:51:40 +1000 (EST)
Subject: Re: [PATCH] PPC 4xx: Enable XMON on PPC 4xx boards
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17663.20973.922238.823386@cargo.ozlabs.ibm.com>
References: <1157569083.6098.29.camel@zod.rchland.ibm.com>
	<17663.20973.922238.823386@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 18:50:47 -0500
Message-Id: <1157586647.2721.27.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mporter@embeddedalley.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 08:55 +1000, Paul Mackerras wrote:
> Josh Boyer writes:
> 
> > -		excp->msr |= 0x400;
> > +		excp->msr |= MSR_SSTEP_ENABLE;
> > +#ifdef CONFIG_4xx
> > +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> > +#endif
> >  	} else if (at_breakpoint(excp->nip)) {
> >  		xmon_trace[smp_processor_id()] = BRSTEP;
> > -		excp->msr |= 0x400;
> > +		excp->msr |= MSR_SSTEP_ENABLE;
> > +#ifdef CONFIG_4xx
> > +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> > +#endif
> 
> This would be neater with a little inline xmon_enable_sstep(excp)
> function...
> 
> Other than that, looks fine.

Agreed.  I'll make that change and resend in the morning.

josh
