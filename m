Date: Fri, 11 Feb 2000 17:43:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-bk@fsmlabs.com
Subject: Latest OpenPic changes
Message-ID: <Pine.LNX.4.05.10002111739060.387-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Ben,

After two days of hacking I finally found out what went wrong. Your changes to
the OpenPIC code cause my machine to hang in openpic_enable_irq(). I added a
timeout to the do { ... } while (...) loop:

void openpic_enable_irq(u_int irq)
{
        int timeout = 1000000;
        check_arg_irq(irq);
        openpic_clearfield(&ISU[irq - open_pic_irq_offset].Vector_Priority, OPENPIC_MASK);
        /* make sure mask gets to controller before we return to user */
        do {
                mb(); /* sync is probably useless here */
        } while(openpic_readfield(&OpenPIC->Source[irq].Vector_Priority,
                        OPENPIC_MASK) && --timeout);
        if (!timeout)
            printk("openpic_enable_irq %d timeout status 0x%08x\n", irq, openpic_readfield(&OpenPIC->Source[irq].Vector_Priority,OPENPIC_MASK));
}

and OPENPIC_MASK is still set when the loop times out on enabling
IRQ_8259_CASCADE in chrp_init_IRQ(). How is this possible? There's an eieio()
after each register write and the mb() does sync.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
