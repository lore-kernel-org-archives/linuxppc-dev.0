Message-ID: <39F732EA.8D97C914@occamnetworks.com>
Date: Wed, 25 Oct 2000 12:22:18 -0700
From: Scott Iveland <siveland@occamnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Dan Malek <dan@mvista.com>
Subject: Re: bug in m8260_mask_and_ack() in Linux/PPC 2.4.x ??
References: <2098.972444748@msa.cmst.csiro.au> <39F722A9.DC7C7EC0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Murray Jensen wrote:
> >
> > Either I'm going crazy, or this code in m8260_mask_and_ack(),
>
> Yes, it looks wrong to me, too.  Now, how in the hell does it work :-)?
> I will immediately fix it in the kernel sources, and once I get 8260
> to build properly again I will test it......
>
> Thanks.
>
>         -- Dan
>

We found this bug  causes problems when you need to use interrupts from an IRQ
line.
Most internal 8260 devices clear this bit when the interrupt is cleared in the
parameter
ram for that device(e.g. FCCE,FCCM).  That is why it worked with the FCC,SMC
etc.
We found and fixed this when we tried to use an IRQ line into the 8260. If you

change it as indicated, it does work properly for things like the external IRQ
line interrupts.

Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
