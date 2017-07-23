Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xFRJS2VQCzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 11:10:32 +1000 (AEST)
Message-ID: <1500772210.10674.29.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/24] powerpc/mm: Pre-filter SRR1 bits before
 do_page_fault()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Sun, 23 Jul 2017 11:10:10 +1000
In-Reply-To: <20170722184314.Horde.gxxJYSiYc2SSqQhjpzVdwQ1@messagerie.c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-2-benh@kernel.crashing.org>
 <20170722184314.Horde.gxxJYSiYc2SSqQhjpzVdwQ1@messagerie.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-22 at 18:43 +0200, LEROY Christophe wrote:
> 
> > @@ -203,23 +203,13 @@ static int __do_page_fault(struct pt_regs  
> > *regs, unsigned long address,
> >  	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> >  	int code = SEGV_MAPERR;
> >  	int is_write = 0;
> > -	int trap = TRAP(regs);
> > - 	int is_exec = trap == 0x400;
> > + 	int is_exec = TRAP(regs) == 0x400;
> 
> Don't we have a tab/space issue here ?

There seem to be indeed an extra space before the tab at the beginning
of the line, though it looks like it was already there in the orignal
code :-) I didn't notice it and thus didn't fix it. If I respin I'll
take care of it.

> >  	int is_user = user_mode(regs);
> >  	int fault;
> >  	int rc = 0, store_update_sp = 0;
> > 
> >  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> > -	/*
> > -	 * Fortunately the bit assignments in SRR1 for an instruction
> > -	 * fault and DSISR for a data fault are mostly the same for the
> > -	 * bits we are interested in.  But there are some bits which
> > -	 * indicate errors in DSISR but can validly be set in SRR1.
> > -	 */
> > -	if (is_exec)
> > -		error_code &= 0x48200000;
> > -	else
> > -		is_write = error_code & DSISR_ISSTORE;
> > +	is_write = error_code & DSISR_ISSTORE;
> >  #else
> >  	is_write = error_code & ESR_DST;
> >  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> > --
> > 2.13.3
> 
> 
