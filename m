Message-ID: <3BD2E3A5.6EFA4AF8@cefetgo.br>
Date: Sun, 21 Oct 2001 13:03:01 -0200
From: Cloves Ferreira Jr <cfj@cefetgo.br>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com, dwayne@austin.ibm.com,
	linuxppc-dev@lists.linuxppc.org
Subject: 7025 F40 CHRP IBM
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

  I am trying to produce a zImage that can boot on a 7025 F40 CHRP IBM
workstation using linux kernel 2.4.3 with 110 tarball patches.
  I debuged some kernel code and found an abnormal execution at
arch/ppc/kernel/i8259.c in i8259_init function. This function is called
by arch/ppc/kernel/chrp_setup.c in chrp_init_IRQ function.

  When the start init sequence is executed a MachineCheckException is
generated printing a text message like: OUT to bad port 21 at...

  Can anyone help me with a correct code to this controller? Can anyone
point me with documentation to study about this? Can anyone give me
e-mails to change some experiences about this model of workstation (F40)

programing in IBM linux group?

  Thanks,
     Cloves.

  The code is:

----------------------------------------
void __init i8259_init(void)
{
        unsigned long flags;

        spin_lock_irqsave(&i8259_lock, flags);
        /* init master interrupt controller */
        outb(0x11, 0x20); /* Start init sequence */
        outb(0x00, 0x21); /* Vector base */
        outb(0x04, 0x21); /* edge tiggered, Cascade (slave) on IRQ2 */
        outb(0x01, 0x21); /* Select 8086 mode */
        outb(0xFF, 0x21); /* Mask all */
        /* init slave interrupt controller */
        outb(0x11, 0xA0); /* Start init sequence */
        outb(0x08, 0xA1); /* Vector base */
        outb(0x02, 0xA1); /* edge triggered, Cascade (slave) on IRQ2 */
        outb(0x01, 0xA1); /* Select 8086 mode */
        outb(0xFF, 0xA1); /* Mask all */
        outb(cached_A1, 0xA1);
        outb(cached_21, 0x21);
        spin_unlock_irqrestore(&i8259_lock, flags);
        request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
                     "82c59 secondary cascade", NULL );
}
----------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
