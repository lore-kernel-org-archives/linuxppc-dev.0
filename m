Message-ID: <20011102112155.3436.qmail@dag.newtech.fi>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: RFC 8259 handling suggestion and MPC107 in openpic
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Date: Fri, 02 Nov 2001 13:21:55 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just browsed through the different PPC setups
with an 8259.

Every single one has  the following code in xxx_init_IRQ:

 for ( i = 0 ; i < NUM_8259_INTERRUPTS  ; i++ )
        irq_desc[i].handler = &i8259_pic;
 i8259_init();

Seems like everyone having an i8259 wants to use it ;-)
Would it make sense to move the loop into
the beginning of i8259_init()
in the following format ?

for ( i =i8259_pic.irq_offset  ; i < i8259_pic.irq_offset +
NUM_8259_INTERRUPTS  ; i++ )
        irq_desc[i].handler = &i8259_pic;

I would also suggest that the "dummy" handling of
the MPC107, now in some ports (my project included)
would be integrated into open_pic.c

BRGDS



--
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
