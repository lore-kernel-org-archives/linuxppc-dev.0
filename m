Message-ID: <20011103065133.20653.qmail@dag.newtech.fi>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Dag Nygren <dag@newtech.fi>,
	linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC (RFC) 
In-Reply-To: Message from "Mark A. Greer" <mgreer@mvista.com>
   of "Fri, 02 Nov 2001 15:35:26 MST." <3BE31FAE.32941913@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Nov 2001 08:51:33 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Mark A. Greer wrote:
>
>
> This is along the lines that I was thinking except add a struct member to specify
> whether edge or level sensitive--i.e., separate members for hi/lo and edge/level

Actually this evolved after I posted it :-), after I started
to modify open_pic.c

> What exactly is the "IrqEnable" for?  Is this so you can set up the IRQ but not
> enable it?  Then the driver can enable it later and its set up correctly (e.g.,
> I2C)??

Not really, it was more or less a mistake in the first draft. Would there be a
need
for that ?

> Doesn't the new struct eliminate the need for "RegOffset"?

Have to think about that when implementing the stuff.

>  And as you noted,
> "programmer_switch_irq" probably isn't needed either.  Right?

Yep, and I also came up with another scheme for the cascading as the
special handling for chrp is actually.....drum roll.... a cascade!
And it would remove the i8259 refs from the openpic stuff.

> If you're up to it, how about implementing, testing, then posting a patch for
> everyone to check out??

I'm trying, but I am a bit scared of destroying too much of the open_pic
code...

Here is the newest suggestion for that interface:

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
    irq_polarity_type   IrqPolarity;
    int                 (*CascadeHandler)();
} openpic_irq_def;

typedef struct openpic_def_str {
    struct OpenPIC  *OpenPIC_Addr;
    int             main_pic;
    u_char          RegOffset; /* 0 for "standard", 16 for MPC107 */
    int             programmer_switch_irq;
    openpic_irq_def *IRQdef;    /* The lovest vector first in the table !!! */
} openpic_def;

Comments?


Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
