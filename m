Subject: Re: PCI Memory mapping
From: Adrian Cox <adrian@humboldt.co.uk>
To: Marc Leeman <marc.leeman@barco.com>
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	linuxppc-dev@lists.linuxppc.org
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
Message-Id: <1081154768.7999.878.camel@newt>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 09:46:09 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-04-01 at 13:33, Marc Leeman wrote:

> By adding __asm__ __volatile__("eieio"); in user and kernel space,
> which lets the CCU buffers to be flushed, no change is observed (sect.
> 5.4.3.1; CCU Responses to the Processor Transactions).
>
> It looks to me as if I should disable the bus snooping, but as mentioned
> before, initialising this in ppc boot inhibits the NFS boot process.

Here's one possible scenario:

Your user space buffer is cleared with dcbz operations. This may be done
by standard library functions, rather than explicitly in your code. (If
that's not true, what follows could still bite someone else.)

The 603e core will only broadcast the dcbz when the page is marked
coherent. The page is only marked coherent when the kernel is compiled
for SMP.

If the above hypothesis is correct, the 824x CPUs will need to have
CPU_FTR_NEED_COHERENT set in this patch:

 http://lists.linuxppc.org/linuxppc-embedded/200403/msg00218.html

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
