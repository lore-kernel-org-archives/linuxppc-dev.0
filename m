Message-ID: <20011102201747.17244.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Cc: dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC  (RFC)
Content-type: text/plain; charset=us-ascii 
In-reply-to: Your message of "Fri, 02 Nov 2001 10:41:22 MST."
             <3BE2DAC2.FEB5AAC2@mvista.com>
Date: Fri, 02 Nov 2001 22:17:47 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Sarnath, Dag, Andrew,
>
> What I think you guys are discovering is an artifact of the inadequate
> interface to openpic_init()--its wider than just a 8259/107 problem.  This has
> been discussed before and some ideas kick around.
>
> Since you guys seem to have the time & motivation, why don't you go back &
> check out the mail archives for that/those discussion(s).  If you like what
> was talked about there, go with it or come up with a better solution and post
> it here for everyone to comment on.  It would be really nice to have a more
> flexible interface to openpic_init(), et. al.

Would something like this be sufficient/good as interface ?:



typedef enum irq_level_en
    {OP_IRQ_HIGH=1,
     OP_IRQ_LOW=0}
irq_level_type;

typedef enum irq_enable_en
    {OP_IRQ_ON=1,
    OP_IRQ_OFF=0}
irq_enable_type;

typedef struct openpic_irq_def_str {
    u_int           PICIrq;
    u_int           LinuxIrq;
    u_char          Priority;
    irq_level_type  IrqLevel;
    irq_enable_type IrqEnable;
} openpic_irq_def;

typedef struct openpic_def_str {
    struct OpenPIC  *OpenPIC_Addr;
    int             main_pic;
    u_char          RegOffset; /* 0 for "standard", 16 for MPC107 */
    char            *chrp_ack;
    int             programmer_switch_irq; /* Not really needed with the
Priority/IRQ poss. */
    openpic_irq_def *IRQdef;
} openpic_def;

extern void openpic_init(*openpic_def);


If so, I could try to implement it in the current open_pic.c

BRGDS

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
