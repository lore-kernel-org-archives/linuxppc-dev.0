Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 66A49DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 02:59:16 +1100 (EST)
Date: Thu, 27 Dec 2007 19:00:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071227160029.GA31294@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD544.2050807@freescale.com>
	<20071224121546.GA7903@localhost.localdomain>
	<47716BBE.5090000@freescale.com>
	<20071226162943.GB11230@localhost.localdomain>
	<4773C6EF.1020106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4773C6EF.1020106@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 27, 2007 at 09:38:23AM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >I wonder what are the symptoms if microcode is at fault? According
> >to errata description, hang isn't something I should get on the
> >transmit attempt.
> 
> Well, if the microcode fails, you'll never know.  I tried to explain the 
> need for a unified microcode validation mechanism to the QE microcode 
> developers, but I didn't get very far.
> 
> >Well. All I've found is: QERAMPTCH.zip ("RAM Microcode Patches for
> >PowerQUICC II Pro Family QE Errata"), which should fix QE_UART5 errata
> >for MPC8323 Rev 1.1. 
> 
> I don't know what that is, but it doesn't apply.  I'm talking about the 
> QE and QE UART patches I've posted to this mailing list over the past 
> month.

:-) I didn't get it wrong. QERAMPTCH.zip is the microcode (they
name it "microcode patches") I've tried, it has nothing to do with
your Linux patches.

> Once Kumar applies them to them to his for-2.6.25 branch, it'll 
> make life easier for everyone.
> 
> Can I assume it works for MPC8360 too?
> 
> No.  Microcode is very sensitive to the processor and the revision.  A 
> microcode for 8360 2.1 won't work on 8360 2.0.
> 
> I forgot to give you the actual microcode. :-)  I'll email it to you later.

Much thanks! Also, could you provide the magic python script to
generate binary firmwares to try loading fw from the linux? Or
just a .bin file.

> >Here are dts entries I use:
> >
> >		firmware {
> >			id = "Soft-UART";
> >			extended_modes = <0 0>;
> >			virtual_traps = <0 0 0 0 0 0 0 0>;
> >		};
> 
> This entry is created by U-Boot only if it uploads the microcode.  This 
> should not be in the DTS.

Sure thing. That was just a quirk for the quick testing, to not tinker
with u-boot part.

> >
> >		ucc@2400 {
> >			device_type = "serial";
> >			compatible = "ucc_uart";
> >			reg = <0x2400 0x200>;
> >			device-id = <5>;
> >			port-number = <0>;
> >			rx-clock-name = "brg7";
> >			tx-clock-name = "brg8";
> >			interrupts = <40>;
> >			interrupt-parent = <&qeic>;
> >			soft-uart;
> >		};
> >
> >		ucc@3400 {
> >			device_type = "serial";
> >			compatible = "ucc_uart";
> >			reg = <0x3400 0x200>;
> >			device-id = <6>;
> >			port-number = <1>;
> >			rx-clock-name = "brg14";
> >			tx-clock-name = "brg14";
> >			interrupts = <41>;
> >			interrupt-parent = <&qeic>;
> >		};
> 
> You need to have separate BRGs for TX and RX when using soft-uart mode, 
> and you MUST use soft-uart mode on the 8360.

Yup, I know. In the original email I've explained that I deliberately
configured two uarts differently for the testing purposes.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
