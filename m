Subject: RE: 2.6 kernel ppc tree
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 18 Feb 2004 14:13:21 +1300
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F41030A01@ExchWENZ02.wenz.global.vpn>
From: "Rod Boyce" <rod_boyce@stratexnet.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Lokesh Kumar" <kumar.lokesh@wrx-us.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wow that was great I got a lot further once I copied the 2.5 kernel uart.c file across.

I had to comment out both referances to ret_from_intercept in the head_8xx.S file I cannot see what is going on there.  I then got to this:
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/ppc/kernel/built-in.o: In function `DoSyscall':
arch/ppc/kernel/entry.S(.data+0x350): undefined reference to `sys_pciconfig_iobase'
make: *** [.tmp_vmlinux1] Error 1

I have not more time to spend on this and track down the PCI issues.
I am using a miniumal config file I will be happy to send to any body who is interested.

Regards,
Rod Boyce

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Wednesday, February 18, 2004 11:20 AM
To: Rod Boyce
Cc: Lokesh Kumar; linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 kernel ppc tree


On Wed, Feb 18, 2004 at 10:30:41AM +1300, Rod Boyce wrote:

> I downloaded the the 2.6.1 Linux kernel and compiled it for the RPX-Lite board.  I discovered that the UART driver in arch/ppc/8xx_io/ has not been ported to the 2.6 kernel otherwise I had no problems.  I have not had time to get back to the 2.6 porting effort and update the uart.c file.  If ther eis another one out there I could try it out but that is where I left my effort.  Otherwise I would guess you may not have too many more problems but I have not been able to spend much time on this.

The linuxppc-2.5 tree already has most of this done (as it did as of
2.6.1 or 2.6.2, I haven't re-checked the drivers).  However, head_8xx.S
still needs some updates for VM/exception changes.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
