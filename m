Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F1B2CDE16C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 02:57:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Booting Linux from an ACE File
Date: Mon, 19 May 2008 09:54:59 -0700
In-reply-to: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
References: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080519165501.E6C6416E005C@mail90-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of mojtaba
> Sent: Friday, May 16, 2008 4:58 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Booting Linux from an ACE File
> =

> Dear all,
> =

> Could you please explain what happens exactly when Linux is booting
from a
> compact flash?

The systemAce file is essentially a script of JTAG commands, some of
which target the FPGA with configuration data and some target the
PowerPC/microblaze with memory write commands.

> To my few knowledge, the Linux compressed image will be copied
somewhere in
> memory, will be uncompressed and the control will jump to the
beginning
> address of the Linux kernel.
> =

> Is there any boot loader that copies the Linux compressed image to the
> memory?

Essentially SystemAce does this for you and jumps to the Linux
bootwrapper code which begins decompressing the kernel.

> Where in memory does it put the Linux kernel? For example, if I have 2
DDRs
> in my hardware, in which of them it will be put the kernel?

The kernel is compiled at a particular address, typically targetting
whatever memory is low in the system.  I believe the default target
address is 0x40000.  So whatever DDR memory lives at this address will
be targetted.

> Can I set the kernel location in memory manually?

If you change how the bootwrapper code and linker script work, yes.

> Might be an stupid question but: Is it possible for the kernel to be
half in
> BRAMS and half in DDR?

There have been some recent patches on the microblaze mailing lists that
attempt to put some of the latency-critical code (exception handlers and
the like) in BRAM.  Doing this is likely pretty architecture specific,
since you probably have a particular goal in mind.

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
