Message-ID: <3975C701.FB6B19D9@lucent.com>
Date: Wed, 19 Jul 2000 10:19:29 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do I shoot myself in the foot first or HEAD.S?
References: <1.5.4.32.20000719011945.006845c0@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


clark@esteem.com wrote:
> 3. What do I need to do in the ROM before jumping to HEAD.S other than
> programming the ram timmings in the UPM( I assume HEAD.S is where everything
> starts )?

My startup code at 0xFFF00100 simply loads values into r3-r7 and then
jumps to physical address 0 (where vmlinux was loaded). But our hardware
is initialized from the host, not the on-board CPUs.


> 4. Has any one managed to get an EST VisionICE in circuit emulator to work
> with linuxPPc? If so How? Would I be better off using the GNU Debuger?

I never figured out how to use any of that stuff. I debugged head.S
by using r11 and r12 (otherwise unused) to poke cookies into low
memory, and traced through head.S until it took off (:-)). But my
architecture may be different from yours -- I have a PPC board which
plugs into a host which can read/write the on-board RAM via the PCI
bus. So I could always dump memory on the board.

I had to develop custom console and network drivers using that PCI
memory-to-memory interface. I debugged them using our proprietary OS,
so once I threaded through head.S it was a short trip to a bash console
prompt. Once you get to start_kernel() I doubt any debugger will be of
much use (gdb perhaps, because it understands memory mapping, but the
ICE won't).


Several people have said "don't change head.S". I found I had to,
because my board is not anything like any of the CONFIG choices.
I did, at least, move it into my private directory and symlink it
back where it belongs; ditto for the half-dozen other files I had
to change.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
