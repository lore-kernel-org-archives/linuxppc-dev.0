Message-ID: <20011104142724.31899.qmail@dag.newtech.fi>
To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC (RFC) 
In-Reply-To: Message from "Sarnath Kannan" <sparc64@rediffmail.com>
   of "04 Nov 2001 10:45:14 GMT." <20011104104514.19103.qmail@mailweb23.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Nov 2001 16:27:24 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Somehow I feel that Patching or changing
> the openPIC code would make it shabby.
>  Why should we change open_pic code,
> just because that EPIC is non-conforming ?
> The best is to rewrite open_pic code for
> EPIC. ( ofcourse, we can reuse code. )
>  I dont find anything wrong with open_pic
> interface. If people dont follow standards,
> we dont make standards comply with them. We
> make them comply with standards.

I dont agree,
we would end up duplicating 90% of the open_pic
code, and this is also an excellent opportunity to
move out the cascade-handling from the open_pic stuff.

Just stay tuned, I already did the rewriting of the
open_pic.c, just need to get to work on Monday,
testing the result.
I will then submit this as a suggestion.
It actually looks more clean that the original code,
at last to my eyes ;-)
And it really makes for an even more simple
xxx_setup.c for the different ports.

At the same time I would like to suggest an inclusion
of the registration of the i8259 interrupts to i8259_init().
At the momenty everyone of the drivers are doing exactly
the same thing:
for ( vec = 0 ; vec < NUM_8259_INTERRUPTS  ; vec++ )
        irq_desc[vec].handler = &i8259_pic;

Moving this to i8259_init() and giving the routine a
parameter startvec (even if everyone is starting from 0
at the moment) would get rid of even more code from
the machine-specific stuff.

BRGDS

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
