Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8505.mail.in.yahoo.com (web8505.mail.in.yahoo.com
	[202.43.219.167]) by ozlabs.org (Postfix) with SMTP id 5576A67F81
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 16:14:26 +1000 (EST)
Message-ID: <20050817061423.34406.qmail@web8505.mail.in.yahoo.com>
Date: Tue, 16 Aug 2005 23:14:23 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: SDRAM init
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

 I have been facing problems while writing to SDRAM
control regsiter. Somehow the hardware doesnt allow me
to write to SDRAM control register costing me a reboot
everytime.

I took the code from u-boot sdram_init and it works
fine only while i am executing it from the flash.

I want to leave the SDRAM control register value to be
0xd04f0000 at setup instead of 0x504f0000.

How should I do it??? 

It seems that the control register has to be
manipulated with some special care, like, precharging
all banks  before manipulating or something ...

the below code works fine from flash
void sdram_init()
{
        initdram ();
        /* unlock mode register */
        *(int *)MPC5XXX_SDRAM_CTRL = 0xd04f0000 |
hi_addr_bit;
        /* precharge all banks */
        *(int *)MPC5XXX_SDRAM_CTRL = 0xd04f0002 |
hi_addr_bit;
        /* set mode register */

        *(int *)MPC5XXX_SDRAM_MODE = 0x00cd0000;

        /* precharge all banks */
        *(int *)MPC5XXX_SDRAM_CTRL = 0xd04f0004 |
hi_addr_bit;
        /* auto refresh */
        *(int *)MPC5XXX_SDRAM_CTRL = 0xd04f0004 |
hi_addr_bit;
 /* set mode register */
        *(int *)MPC5XXX_SDRAM_MODE = 0x00cd0000;
 /* normal operation */

        *(int *)MPC5XXX_SDRAM_CTRL = 0x504f0000 |
hi_addr_bit;
            
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
             
}

but If i want to deave MPC5xxx_SDRAM_CTRL to
0xd04f0000 it doesnt allow me . By the way just for
reference the address of this register is (MBAR +
0x0104)

I tried all trial and errors for understanding how to
manipulating with this register but in vain.

Please do help me ....


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
