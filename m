Message-ID: <393E4156.E7E8153A@eng.uct.ac.za>
Date: Wed, 07 Jun 2000 14:34:30 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: SMC2
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have been looking at uart.c in the kernel and have come across
something that I cannot figure out. Perhaps I am just being stupid.
Perhaps someone can set me straight please.

The following code is taken fron uart.c and is used to set up either
both SMC2 and SMC1 pins or, in the #else, just set up SMC1's pins.

#if USE_SMC2
        cp->cp_pbpar |= 0x00000cc0;
        cp->cp_pbdir &= ~0x00000cc0;
        cp->cp_pbodr &= ~0x00000cc0;
#else
        /* This will only enable SMC1 if you want SMC2 for something
else.
        */
        cp->cp_pbpar |= 0x000000c0;
        cp->cp_pbdir &= ~0x000000c0;
        cp->cp_pbodr &= ~0x000000c0;
#endif

When I look at my manuals, I see no reference made to the bits 20 and 21
in pbpar, pbdir or pbodr. How does setting those bits enable the SMC2
pins? Those are located in Port A (PA8 and PA9)

I guess my point is why are the Port B registers being modified for SMC2
pins which are found in Port A?

Many thanks
Grant

--
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
