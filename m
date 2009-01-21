Return-Path: <daniel.ng1234@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id DA6AFDDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 18:37:35 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so225339rne.16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 23:37:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090120164124.GC8978@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
	<547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
	<20090120164124.GC8978@ld0162-tx32.am.freescale.net>
Date: Wed, 21 Jan 2009 18:37:32 +1100
Message-ID: <547eba1b0901202337g624f79b2uaa7f7f2f61990ad1@mail.gmail.com>
Subject: Re: Device Tree setup for 8272-based board
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Wed, Jan 21, 2009 at 3:41 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Tue, Jan 20, 2009 at 06:23:08PM +1100, Daniel Ng wrote:
>> PID hash table entries: 128 (order: 7, 512 bytes)
>> time_init: decrementer frequency =3D 16.500000 MHz
>> time_init: processor frequency   =3D 330.000000 MHz
>> clocksource: timebase mult[f26c9b2] shift[22] registered
>> clockevent: decrementer mult[439] shift[16] cpu[0]
>> Console: colour dummy =FC
>>
>> -at this point the board just reboots.
>
> Looks like something goes wrong when the real serial driver kicks in.

I've managed to enable more debug and see the following boot sequence:

cpm_uart_init_port()
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 11a00
OF: one level translation: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D11a00
OF: parent translation for: f0000000
OF: with offset: 11a00
OF: one level translation: f0011a00
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 8000
OF: one level translation: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D8000
OF: parent translation for: f0000000
OF: with offset: 8000
OF: one level translation: f0008000
OF: reached root node
of_irq_map_one: dev=3D/soc@f0000000/cpm@119c0/serial@11a00, index=3D0
 intsize=3D2 intlen=3D2
of_irq_map_raw:
par=3D/soc@f0000000/interrupt-controller@10c00,intspec=3D[0x00000028 0x
00000008...],ointsize=3D2
of_irq_map_raw: ipar=3D/soc@f0000000/interrupt-controller@10c00, size=3D2
 -> addrsize=3D1
 -> got it !
irq: irq_create_mapping(0xc02d1320, 0x28)
irq: -> using host @c02d1320
irq: -> obtained virq 40
cpm2_pic_host_map(40, 0x28)
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
cpm_uart_request_port()
CPM uart[=FE

I think the of_get_gpio() error messages are a result of the following
code in cpm_uart_init_port()-

  for (i =3D 0; i < NUM_GPIOS; i++)
    pinfo->gpios[i] =3D of_get_gpio(np, i);

-why is this code here? Is it for processing modem control lines? I
know our board doesn't make use of the modem control lines for
ttyCPM0. Therefore, have I misconfigured something in the Device Tree?

Here's the relevant part of the Device Tree-

    cpm@119c0 {
      #address-cells =3D <1>;
      #size-cells =3D <1>;
      #interrupt-cells =3D <2>;
      compatible =3D "fsl,mpc8272-cpm", "fsl,cpm2";
      reg =3D <0x119c0 0x30>;
      ranges;

      muram@0 {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges =3D <0x0 0x0 0x10000>;

        data@0 {
          compatible =3D "fsl,cpm-muram-data";
          reg =3D <0x0 0x2000 0x9800 0x800>;
        };
      };

      brg@119f0 {
        compatible =3D "fsl,mpc8272-brg",
                     "fsl,cpm2-brg",
                     "fsl,cpm-brg";
        reg =3D <0x119f0 0x10 0x115f0 0x10>;
      };

      serial@11a00 {
        device_type =3D "serial";
        compatible =3D "fsl,mpc8272-scc-uart",
                     "fsl,cpm2-scc-uart";
        reg =3D <0x11a00 0x20 0x8000 0x100>;
        interrupts =3D <40 8>;
        interrupt-parent =3D <&PIC>;
        fsl,cpm-brg =3D <1>;
        fsl,cpm-command =3D <0x800000>;
      };

  };

    PIC: interrupt-controller@10c00 {
      #interrupt-cells =3D <2>;
      interrupt-controller;
      reg =3D <0x10c00 0x80>;
      compatible =3D "fsl,mpc8272-pic", "fsl,cpm2-pic";
    };


Would you please explain what the following lines mean, so I can use
some more appropriate values for my particular board?-

1) In the serial@11a00 node-

a) reg =3D <0x11a00 0x20 0x8000 0x100>;
b) interrupts =3D <40 8>;
c) fsl,cpm-brg =3D <1>;
d) fsl,cpm-command =3D <0x800000>;


2) In the brg@119f0 node-
reg =3D <0x119f0 0x10 0x115f0 0x10>;


3) In the PIC: interrupt-controller@10c00 node-
reg =3D <0x10c00 0x80>;


I have read the relevant documentation under Documentation/powerpc and
Documentation/powerpc/dts-bindings, but these do not seem to go into
enough detail eg.
Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/brg.txt says the
following about the reg property-

- reg : There may be an arbitrary number of reg resources; BRG
  numbers are assigned to these in order.

-> does this mean that each number represents a BRG register? So there
can be a maximum of 1+8=3D9 reg values, since there are 8 BRG registers?

As for Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt, there
is no explanation at all for what the 'reg', 'interrupts', 'brg' and
'command' values mean... Am I missing something obvious?

Similarly for Documentation/powerpc/dts-bindings/fsl/cpm_qe/pic.txt,
there is no explanation of the 'reg' value. Also, it mentions a
'second interrupt cell' but I only see one in the example it gives.
Here is what it says-

* Interrupt Controllers

Currently defined compatibles:
- fsl,cpm1-pic
  - only one interrupt cell
- fsl,pq1-pic
- fsl,cpm2-pic
  - second interrupt cell is level/sense:
    - 2 is falling edge
    - 8 is active low

Example:
  interrupt-controller@10c00 {
    #interrupt-cells =3D <2>;
    interrupt-controller;
    reg =3D <10c00 80>;
    compatible =3D "mpc8272-pic", "fsl,cpm2-pic";
  };


Does the level/sense refer to ALL interrupts?

Cheers,
Daniel
