Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v734)
Message-Id: <268E83D3-853C-4752-88D1-A7354E924C07@freescale.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 13:42:34 -0500
Subject: RFC: merging of cputables between ppc32/64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was hoping to get some idea on which direction we wanted to head  
with cputable between ppc32/64.  The only major difference that  
exists between the two is the use of cpu_setup().

On ppc32, cpu_setup is called for each processor in an SMP  
configuration.  Which gives us the following signature:

typedef void (*cpu_setup_t)(unsigned long offset, int cpu_nr, struct  
cpu_spec* spec);

On ppc64, cpu_setup is only called for the boot cpu.  It is left to  
the cpu save/restore functions to handle setting up the state for  
additional CPUs.  Which gives is the following signature:

typedef void (*cpu_setup_t)(unsigned long offset, struct cpu_spec*  
spec);

So my question is do we just extend the ppc64 signature to match the  
ppc32 by having a dummy "int cpu_nr" that is ignored or do we do  
something else?  As far as I can tell cpu_nr is only used by ppc32 as  
temp storage so that the cpu_setup functions can return properly.

- kumar
