Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 5111BDE260
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 04:25:46 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1930591nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 11:25:44 -0700 (PDT)
To: Aaron Sells <aaron.sells@zin-tech.com>
Subject: Re: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
	<480E4EBD.3010202@zin-tech.com>
	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
	<480F4E8E.4010506@zin-tech.com> <87iqy8haf8.fsf@macbook.be.48ers.dk>
	<4810AF87.80602@zin-tech.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 24 Apr 2008 20:25:41 +0200
In-Reply-To: <4810AF87.80602@zin-tech.com> (Aaron Sells's message of "Thu\,
	24 Apr 2008 12\:04\:23 -0400")
Message-ID: <87bq3z2jq2.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: sam.d.karp@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Aaron" == Aaron Sells <aaron.sells@zin-tech.com> writes:

Hi,

 Aaron> I generate the xparameters_ml403.h file using Xilinx's EDK base system
 Aaron> builder wizard.  However, the wizard does not automatically enable the
 Aaron> Cypress device to be interrupt driven.  I have manually done this as
 Aaron> described in the attached patch.

 Aaron> The resulting xparameters_ml403.h has the following defines:

 Aaron> sellsa@SS-SBIR-Ubuntu:~/spacesuit/linux-2.6-xlnx$ cat
 Aaron> arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h | grep USB
 Aaron> /* Definitions for peripheral CYPRESS_USB */
 Aaron> #define XPAR_CYPRESS_USB_PRH0_BASEADDR 0x80800000
 Aaron> #define XPAR_CYPRESS_USB_PRH0_HIGHADDR 0x8080FFFF
 Aaron> #define XPAR_SYSTEM_USB_INT_PIN_MASK 0X000001
 Aaron> #define XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR 0

Ok.

 Aaron> When I boot the Xilinx ML403 board up, I get the following:

 Aaron> [    9.256329] ------------[ cut here ]------------
 Aaron> [    9.260000] Badness at drivers/usb/c67x00/c67x00-ll-hpi.c:244
 Aaron> [    9.260000] NIP: c01b5d6c LR: c01b5d60 CTR: c00170f4
 Aaron> [    9.260000] REGS: c3c19d70 TRAP: 0700   Not tainted
 Aaron> (2.6.24-rc8-xlnx-dirty)
 Aaron> [    9.260000] MSR: 00029030 <EE,ME,IR,DR>  CR: 24000082  XER: 20000073
 Aaron> [    9.260000] TASK = c3c178a0[1] 'swapper' THREAD: c3c18000
 Aaron> [    9.260000] GPR00: 00000001 c3c19e20 c3c178a0 00000000 c032f518
 Aaron> c0372730 27b38fa6 00000001
 Aaron> [    9.260000] GPR08: 00000000 00200200 c3d2b164 c3d2b164 24000082
 Aaron> ffffcd64 c02d4c5c c02d4c6c
 Aaron> [    9.260000] GPR16: c02d4c90 c02d4c98 c02d4ca8 c02d4cd4 c02d4ce8
 Aaron> 00000000 c02d7114 c0370e78
 Aaron> [    9.260000] GPR24: c0360000 c02d4c54 c0330724 00000000 c3d2b148
 Aaron> 00000000 c3d2b140 c0330708
 Aaron> [    9.260000] NIP [c01b5d6c] c67x00_ll_reset+0x48/0x88
 Aaron> [    9.260000] LR [c01b5d60] c67x00_ll_reset+0x3c/0x88
 Aaron> [    9.260000] Call Trace:
 Aaron> [    9.260000] [c3c19e20] [c01b5d60] c67x00_ll_reset+0x3c/0x88 (unreliable)

This is an interrupt timeout. It seems like the interrupt isn't
correctly connected.

 Aaron> Sam, since you have this working, any help would be greatly
 Aaron> appreciated. What else do I need to do in order to get USB host
 Aaron> working on this board?

That should be about it.
 
 Aaron> +/*
 Aaron> + * Cypress USB C67x00 shortcut macro for single instance
 Aaron> + */
 Aaron> +#define XPAR_C67x00_USB(num) { \
 Aaron> +	.name = "c67x00", \
 Aaron> +	.id = num, \
 Aaron> +	.num_resources = 2, \
 Aaron> +	.resource = (struct resource[]) { \
 Aaron> +		{ \
 Aaron> +			.start	= XPAR_CYPRESS_USB_PRH0_BASEADDR, \
 Aaron> +			.end	= XPAR_CYPRESS_USB_PRH0_BASEADDR + 0xf, \
 Aaron> +			.flags	= IORESOURCE_MEM, \
 Aaron> +		}, \
 Aaron> +		{ \
 Aaron> +			.start  = XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR, \
 Aaron> +			.end    = XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR, \
 Aaron> +			.flags  = IORESOURCE_IRQ, \
 Aaron> +		}, \
 Aaron> +	}, \

I guess you need to add a few "num" to those defines to make it work
with multiple devices.

-- 
Bye, Peter Korsgaard
