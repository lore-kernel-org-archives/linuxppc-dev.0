From: g.ramakrishna@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578616C939@AP-BANG-M02>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can not boot linux-2.4.4 using ppcboot-1.0.4 
Date: Mon, 24 Sep 2001 06:14:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

I had already changed the board info in the kernel according to
include/ppcboot.h
of ppcboot-1.0.4. It still fails to start the kernel. It stops at "rfi"
instruction in "turn_on_mmu" in the file "arch/ppc/kernel/head_8xx.S"

	turn_on_mmu:
      	  mfmsr   r0
	        ori     r0,r0,MSR_DR|MSR_IR
      	  mtspr   SRR1,r0
	        lis     r0,start_here@h
      	  ori     r0,r0,start_here@l
	        mtspr   SRR0,r0
      	  SYNC
	        rfi                             /* enables MMU */

I had earlier tried booting the 2.2.13 kernel. It had booted successfully
by just changing the board info.
I am using the same IMMR value in both ppcboot and the linux kernel. Will
this give
some problems ?

Thanks & Regards,
Ramakrishna, G




-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Sunday, September 23, 2001 11:30 PM
To: Ramakrishna, G
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can not boot linux-2.4.4 using ppcboot-1.0.4


In message <301A812E6528D511A8F70008C71E578616C92E@AP-BANG-M02> you wrote:
>
> I am trying to boot Linux-2.4.4 kernel using ppcboot-1.0.4.
> It hangs after printing "## Transferring control to Linux (at address
> 00000000) ..."

This is a FAQ. See the PPCBoot mailing list archive.

The usual reason is that you missed to adapt your board  header  file
used  in  the  LInux  kernel  to  match the definition of the bd_info
structure as passed by PPCBoot. Usually  you  can  just  delete  this
definition  from  your  board header file and include <asm/ppcboot.h>
instead.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'd rather be led to hell than managed to heaven.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
