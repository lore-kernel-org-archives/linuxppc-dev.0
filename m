From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Gabriel Paubert <paubert@iram.es>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 19:35:48 -0500
Content-Type: text/plain
Cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
References: <Pine.HPX.4.10.10001202357570.18916-100000@gra-ux1.iram.es>
In-Reply-To: <Pine.HPX.4.10.10001202357570.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Message-Id: <00012019473900.07177@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I don't want to be dense here but why two macros (one with eieio and one without
eieio).  Can two processors in an SMP setting be trying to drive the same
video card at the same time?   I didn't think that was possible.  I saw the
eieio usage in the kernel versions and in aty128fb.c but thought that multiple
processors might use those macros at the same time and multiple processors
might have different fbdev drivers running in multi-head applications.  But I
thought only one processor could drive a video hardware card.  Is this a bad
assumption?

So exactly what is the best way to write these macros for Xpmac?  Using
the output constraints approach with eieio following it or is all of this
overkill.

>From the various posts (given the operand ordering done in the original post),
here is what I have tried to piece together.

asm volatile ("stwbrx %1,%2,%3; eieio" : "=m" (*(volatile unsigned
*)(base_addr+regindex))       : "r" (regdata), "b" (regindex), "r" (base_addr));

asm volatile ("lwbrx %0,%1,%2; eieio" : "=r"(val) : "b"(regindex),
"r"(base_addr), "m" (*(volatile unsigned *)(base_addr+regindex)));


Please let me know how to change the above so that I get it right this time.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
