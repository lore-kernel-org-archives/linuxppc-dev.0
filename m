Return-Path: <michael@lug-owl.de>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C399ADDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 08:32:10 +1100 (EST)
Date: Mon, 29 Jan 2007 22:02:42 +0100
From: Michael Westermann <michael@dvmwest.de>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: Booting a simple Program to a MCA IBM 7013J or BULL ESCALA 204 D 
Message-ID: <20070129210242.GA20296@dvmwest.dvmwest.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I've a Bull ESCALA-D With MCA and 8 PPC 604 and one gig ram. I work for
a few years on the booting and loading this box with linux.

My first step is loading and starting simple program via tftp-boot.

I've attached a simple bootfile. This load and display an hexvalue
to the Small user display, and loop until power off. This Programm use
the BUMP-Processor.

My next step is using the serial console...

I think that all IBM MCA have a similarly boot and io concept.

Are anyone interested  on linux on PPC-MCA?

I've compiled with a gcc ppc-crosscompile on i386.

<-Start- tftp_boot.S->
#include "ppc.h" 

#define BOOTSTRAP	0x400
#define NVRAM		0xff60
		.org	0
		.byte 0xc9,0xc2,0xd4,0xc1
		.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x22
		.byte 0x00,0x00,0x00,0x22
		.byte 0x00,0x00,0x00,0x02
		.byte 0x00,0x00,0x00,0x02
		.byte 0x00,0x00,0x00,0x22
		.byte 0x00,0x00,0x00,0x00
		.byte 0x01,0x02,0x00,0x00
		
		.byte 0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x00
		.byte 0x00,0x00,0x00,0x22
		.byte 0x00,0x00,0x03,0x8c
		.byte 0x00,0x00,0x00,0x02
		.byte 0x00,0x00,0x00,0x02
		.byte 0x00,0x00,0x00,0x22
		.byte 0x00,0x00,0x00,0x00
		.org	BOOTSTRAP 
		.org	BOOTSTRAP+0x38c
		lis	r1,32		// Stack 0x200000

		addi	r28, r4 ,0	

		mtibatu	0,r3
		mtdbatu	0,r3
		mtibatu	1,r3
		mtdbatu	1,r3
		mtibatu	2,r3
		mtdbatu	2,r3
		mtibatu	3,r3
		mtdbatu	3,r3
		addi	r0,r4,19	
		mtibatl	0,r0		// BPRN=0,      PP = 11 WIMG=0010
		addi	r0,r4,18
		mtdbatl	0,r0		// BPRN=0,      PP = 10 WIMG=0010
		addi	r0,r4,255
		mtibatu	0,r0		// BEPI=0, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	0,r0		// BEPI=0, Area Length=8MB, Vs=1,Vp=1
		li	r4,0
		oris	r4,r4,65472	
		addi	r0,r4,19	
		mtibatl	1,r0		// BPRN=0xffc0, PP = 11 WIMG=0010, 
		addi	r0,r4,19
		mtdbatl	1,r0		// BPRN=0xffc0, PP = 11 WIMG=0010, 
		addi	r0,r4,127	
		mtibatu	1,r0		// BEPI=0xffc0, Area Length=1MB, Vs=1,Vp=1
		mtdbatu	1,r0		// BEPI=0xffc0, Area Length=1MB, Vs=1,Vp=1
		lis	r4,-256
		addi	r0,r4,35
		mtibatl	2,r0		// BPRN=0xff00, PP = 11 WIMG=0100, 
		addi	r0,r4,34	// BPRN=0xff00, PP = 10 WIMG=0100, 
		mtdbatl	2,r0
		addi	r0,r4,255
		mtibatu	2,r0		// BEPI=0xff00, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	2,r0		// BEPI=0xff00, Area Length=8MB, Vs=1,Vp=1
		lis	r4,384		
		addi	r0,r4,19
		mtibatl	3,r0		// BPRN=0x0180, PP = 11 WIMG=0010, 
		addi	r0,r4,18	// BPRN=0x0180, PP = 10 WIMG=0010, 
		mtdbatl	3,r0
		addi	r0,r4,255
		mtibatu	3,r0		// BEPI=0x0180, Area Length=8MB, Vs=1,Vp=1
		mtdbatu	3,r0		// BEPI=0x0180, Area Length=8MB, Vs=1,Vp=1
		sync	
		isync
		li	r0,12400
		mtmsr	r0
		isync
		sync
		
		bl 	set_led_copy

		li	r3, 0x444
		bl	dump_IPL	
		sync
		isync
loop:		b	loop				

dump_IPL:	mflr	r0		
      		mtctr	r0
		rlwinm	r4,r3,20,0,11
		li	r3,	0x300
		oris	r3,r3,	NVRAM
		stw	r4,0(r3)
		sync
		bctr

set_led_copy:	cmpwi	r3,0		// set_led_copy
		lis	r3,-158
		addic	r3,r3,2528
		li	r0,1
		beq-	L00004f68
		stw	r0,-2376(r3)
		blr
L00004f68:	li	r0,0
		stw	r0,-2376(r3)
		blr

		.org	0x43ff
		.byte 0	
<-end- tftp_boot.S->

Print on the Console:
 
SYSTEM WIRD GESTARTET (BOOT)                                                    
                                                                                
Boot-Vorgang lauft . . .  Bitte warten.                                         
                                                                                
Ethernet: Steckplatz 0/6, BNC / modular Jacks                                   
Hardware-Adresse .......................................... 0800382113B3        
                                                                                
....              Packete gesendet     Packete empfangen                        
                                                                                
BOOTP             00002                00001                                    
                                                                                
TFTP              00036                00035                                    
<< 299 >>                                                                       
<< 444 >>

and on User-Display 

444

Michael
