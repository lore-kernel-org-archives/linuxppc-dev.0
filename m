Return-Path: <wei.li4@elf.mcgill.ca>
Received: from drizzle.cc.mcgill.ca (drizzle.cc.mcgill.ca [132.206.27.48])
	by ozlabs.org (Postfix) with ESMTP id 2548A67C2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 07:43:53 +1000 (EST)
Received: from mailscan3.cc.mcgill.ca (mailscan3.CC.McGill.CA [132.216.77.250])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k9FLhpWb031735
	for <linuxppc-embedded@ozlabs.org>; Sun, 15 Oct 2006 17:43:51 -0400
Received: from wgrappe3.cc.mcgill.ca (wgrappe3.CC.McGill.CA [132.216.46.252])
	by mailscan3.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k9FLho37005290 for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Oct 2006 17:43:50 -0400 (EDT)
Received: from wgrappe3.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe3.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k9FLhnm9032500
	for <linuxppc-embedded@ozlabs.org>; Sun, 15 Oct 2006 17:43:49 -0400
Received: (from apache@localhost)
	by wgrappe3.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k9FLhnb0032497
	for linuxppc-embedded@ozlabs.org; Sun, 15 Oct 2006 17:43:49 -0400
Message-ID: <20061015174349.hnkekpjxpccccc0c@webmail.mcgill.ca>
Date: Sun, 15 Oct 2006 17:43:49 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Strange to me
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am trying to add a C function in m8xx_setup.c and call it in 
head_8xx.S. I checked the final assembler and compared it with other 
functions same called in head_8xx.S (e.g.platform_init()), they used 
the different registers for stack poniter, and normal one used r0 to 
store and recover Link register. How to control comlier or linker, so 
that my own function is treated as same way? Thanks.

Here is my code:

void __init
debugger_init(unsigned char case_NO)
{
	//volatile immap_t      *immap;
	volatile cpm8xx_t     *cp;

	// Get pointer to Communication Processor
	cp = cpmp;

	/* PortB setting */
	/* These setting may be different for you.
	   Refer example 16-443 MPC823 Manual*/

// Port B pin 29, 30 configured as Open-Drain general purpose output

	cp->cp_pbodr &= ~0x0009;              // set 0
	cp->cp_pbdir |=  0x0006;              // set 1
	cp->cp_pbpar &= ~0x0009;              // set 0

	switch (case_NO)
	{
	  case 1:
	// Turn on at BP29(=0) and off at BP30(=1)
	    cp->cp_pbdat &= ~0x0004;
	    cp->cp_pbdat |=  0x0002;
	    break;

	  case 2:
	// Turn off at BP29(=1) and on at BP30(=0)
	    cp->cp_pbdat |=  0x0004;
	    cp->cp_pbdat &= ~0x0002;
	    break;

	  default:
	// Turn on at BP29, BP30(=0)
	    cp->cp_pbdat &= ~0x0006;
	    break;
	}

}

It's working fine if put in the utilitise, the fist part of EFL image.


Regard,
Wei
