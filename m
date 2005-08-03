Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8508.mail.in.yahoo.com (web8508.mail.in.yahoo.com
	[202.43.219.170]) by ozlabs.org (Postfix) with SMTP id 2FE0667D69
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 20:56:00 +1000 (EST)
Message-ID: <20050803105556.5187.qmail@web8508.mail.in.yahoo.com>
Date: Wed, 3 Aug 2005 03:55:56 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Rev B MPC5200 , Hardware related Querry
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

  I have been spending some time with the MPC5200 Rev
B processors, mostly concentrating to make it go to
DEEP SLEEP MODE, also posted many times regarding
this.

 Sylvain has given me his previous work on his attempt
to make the core to Sleep and i found that when
asserting bit mode_en in SDRAM control register (MBAR
+ 0x0104), the core restarts.

 Initaially I was thinking that the core restarts bcos
of some very bad exception or something but when i
tried to debug Instruction by instruction i found that
the core just restarts when we try to set mode_en bit
like below


	/* Put SDRAM to self refresh */
	lwz     r11, 0x0104(r3)
	oris	r10, r11, 0x8000
	stw	r10, 0x0104(r3)		/* Enable SDRAM mode register */
	eieio
 /*  r3 has the address of MBAR */

The above code make the core to restart when i comment
the stw instruction

	/* Put SDRAM to self refresh */
	lwz     r11, 0x0104(r3)
	oris	r10, r11, 0x8000
  //	stw	r10, 0x0104(r3)			
        eieio

It doesnt restart now...

Has anyone seen this behaviour with the Rev B ... 


		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 
