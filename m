Subject: RE: ppc826x BAD interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muhammad Sarwar <msarwar@mangrovesystems.com>
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <8529B5552D4EAA4DAEDF49650C64B2B436E589@tarpon.mangrovesystems.com>
References: 
	 <8529B5552D4EAA4DAEDF49650C64B2B436E589@tarpon.mangrovesystems.com>
Content-Type: text/plain
Message-Id: <1074309733.8360.20.camel@gaston>
Mime-Version: 1.0
Date: Sat, 17 Jan 2004 14:22:13 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-01-17 at 03:29, Muhammad Sarwar wrote:
> This problem was discussed on mailing list before also and you can eliminate this problem by inserting a sync instruction at a certain place in the 8260 interrupt handling code. See, for example, http://www.geocrawler.com/archives/3/8358/2002/11/100/10173445/
>
> Add a __asm__ volatile("sync"); at the end of the m8260_mask_and_ack  function in arch/ppc/kernel/ppc8260_pic.c to fix it.

The code looks like crap... do we have any guarantee that those accesses
are done in order and did read the controller ?

I'd rather add eieios and read back the value to enforce ordering...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
