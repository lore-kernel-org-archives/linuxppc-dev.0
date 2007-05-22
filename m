Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 4C4A4DDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 18:46:55 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 22 May 2007 10:46:46 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fsl booke MM vs. SMP questions
Message-ID: <20070522084645.GA12009@iram.es>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179785273.32247.742.camel@localhost.localdomain>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Dave Liu <r63238@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 08:07:52AM +1000, Benjamin Herrenschmidt wrote:
> 
> > > The tlb miss handler does:
> > > 
> > >  - tlbbusy = 1
> > >  - barrier (make sure the following read is in order vs. the previous
> > > store to tlbbusy)
> > >  - read linux PTE value
> > >  - write it to the HW TLB
> > 
> > and write the linux PTE with referenced bit?
> 
> I've kept the reference bit rewrite out of that pseudo-code because I
> was approaching a different issue but yes. The idea i have there is to
> do break down the linux PTE operation that way:
> 
> 	 1 - rX = read PTE value (normal load)
> 	 2 - if (!_PAGE_PRESENT)) -> out
>  	 3 - rY = rX | _PAGE_ACCESSED
> 	 4 - if (rX != rY)
> 	 5 -   rZ = lwarx PTE value
> 	 6 -   if (rZ != rX)
> 	 7 -	stdcx. PTE, rZ (rewrite just read value to clear reserv)

Why do you want to clear the reservation here? 

Coming out of some code path with the reservation still held 
can only affect buggy code (someone doing st[dw]cx. before 
l[dw]arx) AFAIK.

> 	 8 - 	goto 1 (try again)
> 	 9 -   stdcx. PTE, rY
> 	10 -   if failed -> goto 1 (try again)
> 	11 - that's it ! 
> 
> In addition, I suppose performance can be improved by also dealing with
> dirty bit right in the TLB refill if the access is a write and the page
> is writeable rather than taking a double fault.

	Regards,
	Gabriel
