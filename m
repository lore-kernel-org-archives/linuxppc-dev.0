Return-Path: <rimas@cnmat.berkeley.edu>
Received: from cnmat.berkeley.edu (cnmat.CNMAT.Berkeley.EDU [128.32.122.12])
	by ozlabs.org (Postfix) with ESMTP id A5BA267CCD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 13:55:28 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37DEF3E4-EBAB-46FA-A922-D72582474F3D@cnmat.berkeley.edu>
From: rimas <rimas@cnmat.berkeley.edu>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
Date: Thu, 9 Nov 2006 17:55:25 -0800
To: linuxppc-embedded@ozlabs.org
Cc: robert corley <rdcorle@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

i had problems getting the plb_temac driver to work at speeds higher  
than 10 mbps until i modified the adapter.c
file to have the correct PHY address for my setup (i am using the  
avnet V4FX12 mini-module board and the correct value was 4).
the phy address is usually determined by pullup/pulldowns on certain  
pins on the gig phy chip.

this was under 2.4, but i looked at the adapter.c for the 2.6  
xilinx_temac driver and it appears to just set this value to 0

look at line 2905 of adapter.c:

	/* Assume the PHY to be at address 0x00 */
	lp->gmii_addr = 0;

you should change that to reflect the address of your hardware setup.

hope this helps

-rimas

> Pradeep;
>
> I found the process of "uprading" the xapp902 reference design to  
> be troublesome when I removed the GMII loop-back; as
> such, I aborted the process and just started from scratch.
>
> I am currently debugging my design and have a functional plb_temac  
> but only at 10Mbps speeds.
>
> -R. Corley
>
>
