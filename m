Message-ID: <000e01bfd090$7a322d40$cc879e89@sar7>
From: "Grant Carter" <gcarter@eng.uct.ac.za>
To: "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <A3E34B558F5CD211B4980008C7A4A99001D60AB0@sparrow.eng.gilbarco.com>
Subject: Re: SMC2
Date: Wed, 7 Jun 2000 16:55:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Sorry I forgot to mention that this was for an 823. I am told that those
bits are correct for the 860, as PB20/PB21 are SMRXD2/SMTXD2 of SMC2. I just
wasn;t sure how that code worked for the 823. The manual I am currently
using is the MPC823UM/D and have also looked at the preliminary manuals for
the 823e but with no further luck.

Regards
Grant

--
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"

----- Original Message -----
From: "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>
To: "'Grant Carter'" <gcarter@eng.uct.ac.za>; "'linuxppc-embedded'"
<linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, June 07, 2000 4:19 PM
Subject: RE: SMC2


> Grant,
>
> Look in your PowerQuicc 860 User's Manual on page 34-9,
>
> Their is a table which show the proper pbpar,pbdir setting to enable smc2
(I
> think).  I don't know how to explain the pbodr setting right off the top
of
> my head.  But it is in pages close to this one.
>
> Hope that helps,
> Jason
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Grant
> Carter
> Sent: Wednesday, June 07, 2000 8:35 AM
> To: linuxppc-embedded
> Subject: SMC2
>
>
>
> Hi
>
> I have been looking at uart.c in the kernel and have come across
> something that I cannot figure out. Perhaps I am just being stupid.
> Perhaps someone can set me straight please.
>
> The following code is taken fron uart.c and is used to set up either
> both SMC2 and SMC1 pins or, in the #else, just set up SMC1's pins.
>
> #if USE_SMC2
>         cp->cp_pbpar |= 0x00000cc0;
>         cp->cp_pbdir &= ~0x00000cc0;
>         cp->cp_pbodr &= ~0x00000cc0;
> #else
>         /* This will only enable SMC1 if you want SMC2 for something
> else.
>         */
>         cp->cp_pbpar |= 0x000000c0;
>         cp->cp_pbdir &= ~0x000000c0;
>         cp->cp_pbodr &= ~0x000000c0;
> #endif
>
> When I look at my manuals, I see no reference made to the bits 20 and 21
> in pbpar, pbdir or pbodr. How does setting those bits enable the SMC2
> pins? Those are located in Port A (PA8 and PA9)
>
> I guess my point is why are the Port B registers being modified for SMC2
> pins which are found in Port A?
>
> Many thanks
> Grant
>
> --
> Grant Carter                              gcarter@eng.uct.ac.za
> Department of Electrical Engineering      University of Cape Town
> Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
>                      "Coffee not found - operator halted!"
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
