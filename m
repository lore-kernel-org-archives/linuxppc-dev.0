Message-Id: <5.1.0.14.2.20020418075224.02319a00@falcon.si.com>
Date: Thu, 18 Apr 2002 08:03:05 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: SB Interrupt problem (OT)
In-Reply-To: <scbda4cd.072@mx.amx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In x86 hardware, the 8259 is configured to be EDGE sensitive, not level.  I
assume you carried this over to your new design.  Edge triggering means
that, if your interrupt occurred before or during the warm boot reset (it
likely occurs as a side effect of the warm boot reset), when your system
comes out of reset, your interrupt line will be steady low.  Obviously, if
it is steady low, you will never see a high->low transition and you will
never get an interrupt on that line.  The interrupt isn't masked, it is LOST.

You will have to work out the solution on your own since I'm not familiar
enough with the chips to tell you how to clear lost interrupts.  I would
suggest you start by polling all of your peripherals that can cause
interrupts to clear any pending interrupts.  This should bring the
interrupt line(s) back high.  You have to do software interrupt clearing
operations (EOI) to the 8259 to clear the lost interrupt(s).

gvb


At 04:37 PM 4/17/2002 -0500, Chuck Partridge wrote:

>This may be off topic, but I am having problem with my custom 8245
>board.  We migrated an x86 design to a MPC8245 and kept the ALI M1535
>Southbridge.  the problem is that the 8259 interrupt controllers output
>always seems to be masked after a warm reset, but everything works fine
>from a cold boot.
>
>When poking at the 8259 registers, they show that interrupts are ready but
>the INTR pin is never asserted to the  8245s EPIC, hence no interrupt.
>
>After a cold boot, it will run fine until it resets.  Once it resets,
>there are no interrutps reported by the INTR line to the EPIC (but
>internal EPIC interrupts like the internal DUART work fine).
>
>Any ideas?
>
>Thanks for indulging me on the OT message but I'm stumped..
>
>CHuck
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
