Subject: Re: PCI Memory mapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Leeman <marc.leeman@barco.com>
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040401123340.GA6085@smtp.barco.com>
References: <1080086640.23208.164.camel@gaston>
	 <20040324122652.GA22171@smtp.barco.com>
	 <20040324142524.GA22701@smtp.barco.com>
	 <20040324110814.E50148@forte.austin.ibm.com>
	 <20040325154845.GF3696@smtp.barco.com>
	 <20040325103414.C64292@forte.austin.ibm.com>
	 <20040325104529.D64292@forte.austin.ibm.com>
	 <20040326080012.GA7238@smtp.barco.com>
	 <1080676178.7581.30.camel@localhost.localdomain>
	 <20040331155625.GB28919@smtp.barco.com>
	 <20040401123340.GA6085@smtp.barco.com>
Content-Type: text/plain
Message-Id: <1081119234.1285.116.camel@gaston>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 08:53:55 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-04-01 at 22:33, Marc Leeman wrote:

> No real success, until I came accross the PCMBCR register which defines
> the number of PCI to Local Memory Read and Write Buffers. When I set
> both to 1 ( & 0xF0), the data copy back is no longer needed to assure
> data consistency between the PPC and DSP (default is 4 32 byte buffers).
>
> include/mpc824x.h:
> #define PCMBCR          0x800000e1  /* PCI/Memory Buffer Configuration
> Register */
>
> cpu/mpc824x/cpu_init.c:
> CONFIG_READ_BYTE(PCMBCR,val);
> CONFIG_WRITE_BYTE(PCMBCR,(val | 0xF0));
>
> Double checking this by setting both on 4 again (during cpu_init of
> ppcboot) resulted in severe MPEG data corruption. These results at least
> seems to point in the direction you suggested.
>
> This is the only way I seem to be able to assure data consistency (the
> kernel copy back is no longer required), but the documentation also
> suggests that (obviously) this degrades performance and is mainly used
> for debugging.0
>
> Still, when reading the explanations that could case this behaviour
> (copy back buffer and filling the PCMRBs) , they point to cache
> operations, which, I thought, were disabled in the linux kernel for
> these particular PCI mapped buffers.
>
> By adding __asm__ __volatile__("eieio"); in user and kernel space,
> which lets the CCU buffers to be flushed, no change is observed (sect.
> 5.4.3.1; CCU Responses to the Processor Transactions).
>
> It looks to me as if I should disable the bus snooping, but as mentioned
> before, initialising this in ppc boot inhibits the NFS boot process.
>
> Can this be disabled at runtime (possibly with re-enabling it) and if
> so, is this a good practice to do so?

Looks like your north bridge is horribly buggy...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
