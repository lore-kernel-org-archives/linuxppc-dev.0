Return-Path: <will_schmidt@vnet.ibm.com>
Message-ID: <4320A258.1080706@vnet.ibm.com>
Date: Thu, 08 Sep 2005 15:43:04 -0500
From: will schmidt <will_schmidt@vnet.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <268E83D3-853C-4752-88D1-A7354E924C07@freescale.com>
In-Reply-To: <268E83D3-853C-4752-88D1-A7354E924C07@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: RFC: merging of cputables between ppc32/64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I was hoping to get some idea on which direction we wanted to head  with 
> cputable between ppc32/64.  The only major difference that  exists 
> between the two is the use of cpu_setup().
> 
> On ppc32, cpu_setup is called for each processor in an SMP  
> configuration.  Which gives us the following signature:
> 
> typedef void (*cpu_setup_t)(unsigned long offset, int cpu_nr, struct  
> cpu_spec* spec);
> 
> On ppc64, cpu_setup is only called for the boot cpu.  It is left to  the 
Yeah, at the time, we figured all cpu's in a system would be the same. 
with the merge of 32/64, is this still going to be the case?

> cpu save/restore functions to handle setting up the state for  
> additional CPUs.  Which gives is the following signature:
> 
> typedef void (*cpu_setup_t)(unsigned long offset, struct cpu_spec*  spec);
> 
> So my question is do we just extend the ppc64 signature to match the  
> ppc32 by having a dummy "int cpu_nr" that is ignored or do we do  
> something else?  As far as I can tell cpu_nr is only used by ppc32 as  
> temp storage so that the cpu_setup functions can return properly.

If cpu_nr is just used as temp storage, then can it be removed and 
replaced with a local variable?

> 
> - kumar
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
