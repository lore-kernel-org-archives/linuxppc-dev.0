Message-ID: <20011104150209.32091.qmail@dag.newtech.fi>
To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: "Dag Nygren" <dag@newtech.fi>,
	linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC (RFC) 
In-Reply-To: Message from "Sarnath Kannan" <sparc64@rediffmail.com>
   of "04 Nov 2001 14:45:38 GMT." <20011104144538.9588.qmail@mailweb31.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Date: Sun, 04 Nov 2001 17:02:09 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
> > And it really makes for an even more simple
> > xxx_setup.c for the different ports.
> >
> > At the same time I would like to suggest an inclusion
> > of the registration of the i8259 interrupts to
> > i8259_init().
> > At the momenty everyone of the drivers are doing exactly
> > the same thing:
> > for ( vec = 0 ; vec < NUM_8259_INTERRUPTS  ; vec++ )
> >         irq_desc[vec].handler = &i8259_pic;
> >
>   Why should all drivers populate irq_desc ??
> I dont get this. It is done once in life time,
> right ? That too, even before driver's init
> routine come into picture.

Sorry for talking about drivers, did get a little
confusing, what I meant is that every
port (see the xxx_setup.c stuff) is doing
the same thing.

> > Moving this to i8259_init() and giving the routine a
> > parameter startvec (even if everyone is starting from 0
> > at the moment) would get rid of even more code from
> > the machine-specific stuff.
> >
>    The best thing is allow the 8259 to retain
> its vector space from 0-15. Program EPIC
> to generate interrupts from 16-40. ( By
> passing "offset" value of 16 to openpic_init)
> That should clear things up and seperate the
> vector spaces of EPIC and PIC.

I am not sure it the i8259 (or similar) will always
have vectors 0-15, what if we have two cascades ?
I think we need to make sure not limiting this
too much by giving the i8259() routing the extra
argument for the first vector.

>    May I know whats the semantics of the
> "regOffset" ?

Well, that was from the first draft, when I wasn't
sure if we still needed it.

Now the interface looks like this:

typedef enum irq_polarity_en {
    OP_IRQ_POS = 1,
    OP_IRQ_NEG = 0
} irq_polarity_type;

typedef enum irq_sense_en {
    OP_IRQ_LEVEL = 1,
    OP_IRQ_EDGE  = 0
} irq_sense_type;

typedef struct openpic_irq_def_str {
    u_int               PICIrq;
    u_int               Vector;
    u_char              Priority;
    irq_sense_type      IrqSense;
    irq_polarity_type   IrqPolarity;
    /* This can be used for cascade, but should work well for the chrp
specials too */
    int                 (*CascadeAckHandler)(int);
} openpic_irq_def;

typedef struct openpic_def_str {
    volatile struct OpenPIC *OpenPIC_Addr;
    int             slave_pic;
    openpic_irq_def *IRQdef;    /* The lovest vector first in the table !!! */
} openpic_def;

> Good Luck

Thanks

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
