Date: Fri, 6 Feb 2004 14:37:18 +1100 (EDT)
Message-Id: <200402060337.OAA03632@sprint.tenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Interrupts on PPC 405Gr
From: "MERRITT Nigel" <Nigel.Merritt@tenix.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The kernel is 2.4.18 from Timesys.
We have a logic analyser hooked up so we know for certain that the
signal is being generated on the correct line and is entering the UIC.

CPC0_CR0 is being set using the (probably very wrong) code:

      register_val = mfdcr(CPC0_CR0); // Read value from the register.

      // Set to 0.
      register_val = register_val & MASK_BIT_NOT_6;
      register_val = register_val & MASK_BIT_NOT_7;
      register_val = register_val & MASK_BIT_NOT_16;
      register_val = register_val & MASK_BIT_NOT_17;
      register_val = register_val & MASK_BIT_NOT_18;

      // Set to 1.
      register_val = register_val | MASK_BIT_9;
      register_val = register_val | MASK_BIT_10;
      register_val = register_val | MASK_BIT_12;
      register_val = register_val | MASK_BIT_13;

      // Write the value back to the register.
      mtdcr(CPC0_CR0, register_val);

Please tell me the correct way to set these registers, as I can't find
the functions to call in our documentation.
Polarity and trigger settings are being set in a similar manner, i.e:

      // Write the value back to the register.
      mtdcr(CPC0_CR0, register_val);

      //////////////////////////////////////
      // Set the interrupts to falling edge.
      //////////////////////////////////////
      register_val = mfdcr(UIC0_TR);
      register_val = register_val | MASK_BIT_24;
      register_val = register_val | MASK_BIT_30;
      register_val = register_val | MASK_BIT_31;
      mtdcr(UIC0_TR, register_val);

Again, how do these get set if not by adjusting the registers?

The GPIO lines are set up as follows:

      reg = (unsigned int*)GPIO0_TCR;
      register_val = *reg;
      register_val = register_val | MASK_BIT_14;
      register_val = register_val | MASK_BIT_17;
      *reg = register_val;

The request_irq call is:

   res = request_irq(5, DataReadyInterrupt,
                     SA_INTERRUPT, "fpga_o", reg_handle_o);

..with the handler being:

   void DataReadyInterrupt(int par1, void *par2, struct pt_regs *par3)

Many thanks,
   Nigel

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Friday, 6 February 2004 1:38 PM
To: MERRITT Nigel
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interrupts on PPC 405Gr


On Fri, Feb 06, 2004 at 01:47:28PM +1100, MERRITT Nigel wrote:
>
> I am using an IBM PowerPC 405Gr and have been trying to set up IRQ5 as
an interrupt.
> My problem is that the UIC0_ER (interrupt enable) register is not
being set by the request_irq call.
> Does anyone know of other calls that need to be made in order to allow
the interrupt enable register to stay set?
> I have used enable_irq after request_irq but this also has no affect.
As this is from a driver,
> I have even tried setting the correct bit (bit 30 for IRQ 5) directly,
by reading UIC0_ER, ORing
> bit 30 and writing the value back - reading and writing were performed
using mfdcr and mtdcr.
> I also use mtmsr to set the general interrupt enable bit (EE - bit
16)) in the MSR register.
>

Please, don't touch MSR and UIC registers. request_irq should work
just fine (I never had problems with UIC on 405 boards).

Probably you are doing something completely wrong.

Some questions:

1) What kernel tree are you using?

2) Are you sure IRQ5 is actually _generated_ by your external device?
Did you use scope to verify this?

3) Are you sure IRQ5 is enabled in CPC0_CR0 register and not used as
GPIO? Are the polarity and trigger settings are correct for your
external device?

Please, provide more detailed info (with all registers values and/or
code samples) if you wanted somebody to help you.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
