Date: Sat, 25 Aug 2001 00:27:20 +0200
From: Matthias Brukner <mb@trajet.de>
Reply-To: Matthias Brukner <mb@trajet.de>
Message-ID: <966053424.20010825002720@trajet.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: debugging problem: PPC405, BDI2000, MV Kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having trouble debugging the montavista kernel on a custom
ppc405gp board with the BDI2000 PPC4xx gdb version. What I'm trying to
do:
1. set a breakpoint in some framebuffer code
2. tell gdb to run the kernel
3. expect gdb to crash into debug mode once it hits that breakpoint,
alas, it doesnt.

when halting the program through the BDI telnet interface and
inspecting the debug registers (dbcr0, dbcr1 and msr) I noticed the
'DE' bit in the msr register was reset to 0 so the cpu couldn't have caused
a debug interrupt. When setting a breakpoint more early in the kernel
bootup procedure almost everything seems to be working ok.. apart from
stepping in or out of a function and some virtual address resolving
seems to fail (that's what the bdi telnet interface is telling me).
When setting SOFT debug mode nothing works.

kdgb stuff is disabled in my kernel config but the 'debugging enable'
bit in the interrupt setup (MSR register) still gets messed with
somewhere in the kernel..

more info on my setup:
- kernel: mvista journeyman edition - latest CD image (late july)
- gdb + insight v5.00
- in bdi setup I set PTBASE to 0xF0 (found this address in the kernel
  sources)
- dbcr0 inits to 0x81000001 in the bdi config file


matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
