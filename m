Date: 4 Nov 2001 14:45:38 -0000
Message-ID: <20011104144538.9588.qmail@mailweb31.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dag Nygren" <dag@newtech.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: EPIC Vs OpenPIC (RFC)
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> I dont agree,
> we would end up duplicating 90% of the open_pic
> code, and this is also an excellent opportunity to
> move out the cascade-handling from the open_pic stuff.
>
  Moving the cascading part away from open_pic is
a good one. I dont know, why on earth it assumes
that only IRQ0 would be cascaded. Its really
very innocent.

> Just stay tuned, I already did the rewriting of the
> open_pic.c, just need to get to work on Monday,
> testing the result.
> I will then submit this as a suggestion.
> It actually looks more clean that the original code,
> at last to my eyes ;-)

             Good Work !

> And it really makes for an even more simple
> xxx_setup.c for the different ports.
>
> At the same time I would like to suggest an inclusion
> of the registration of the i8259 interrupts to
> i8259_init().
> At the momenty everyone of the drivers are doing exactly
> the same thing:
> for ( vec = 0 ; vec < NUM_8259_INTERRUPTS  ; vec++ )
>         irq_desc[vec].handler = &i8259_pic;
>
  Why should all drivers populate irq_desc ??
I dont get this. It is done once in life time,
right ? That too, even before driver's init
routine come into picture.

Do the ISA drivers assume the
vector number starts from 0 and register IRQs ?
Even if it is so, its fine. See below.


> Moving this to i8259_init() and giving the routine a
> parameter startvec (even if everyone is starting from 0
> at the moment) would get rid of even more code from
> the machine-specific stuff.
>
   The best thing is allow the 8259 to retain
its vector space from 0-15. Program EPIC
to generate interrupts from 16-40. ( By
passing "offset" value of 16 to openpic_init)
That should clear things up and seperate the
vector spaces of EPIC and PIC.

   May I know whats the semantics of the
"regOffset" ?


Good Luck

Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
