Date: Fri, 23 Mar 2001 14:46:45 -0500
From: thewalthamgroup@netscape.net (Mark Phillips)
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Fwd: Re: Execute boot code out of Flash on SBC8260]
Mime-Version: 1.0
Message-ID: <6F679C4E.1EB17E57.C7F6CBA8@netscape.net>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-------- Original Message --------
Subject: Re: Execute boot code out of Flash on SBC8260
Date: Fri, 23 Mar 2001 14:40:40 -0500
From: thewalthamgroup@netscape.net (Mark Phillips)
To: mag@sysgo.de
References: <Pine.LNX.4.30.0103231928320.5837-100000@mag.devdep.sysgo.de>

Marius,
A hardware guy I have been working with has just solved (after 3 weeks)
a very similar problem on an MPC855T board.  Here were the symptoms:
Code worked fine from the debugger, either running in DRAM or running from
FLASH (and then copying itself to DRAM, etc...)

Code would not boot from flash.  Crashed when it tried to jump to DRAM

We tried adding a LONG delay loop at the very beginning of the code.  We started from the debugger, and then pulled off the debugger connection.
The code ran.  We had the debugger set to do "NO" initialization of anything.  (We had to put the delay a couple of instructions in, after the software watchdog was disabled).

We verified that the code copied to DRAM was BYTE-FOR-BYTE identical to the code in the flash.

The problem?  The DRAM sequences needed read-precharge and write-precharge states at the end of reads and writes.  (In this case, we had solved the write precharge, but not the read).  I can get him to send you the fix we used (as an example, you'll probably have to mess with it for your configuration).  Also I'm not a hardware guy (any more) so I have only a foggy idea of what these precharges actually do.

What still mystifies us us that it WORKED UNDER THE DEBUGGER!  There's no earthly reason it should have, particularly since we disabled all initialization of the processor from the debugger.  Nevertheless, it was completely consistent.

Hope this helps...
Mark Phillips

Marius Groeger <mag@sysgo.de> wrote:
>
>
> Hi,
>
> For some reason I'm unable to get my SBB8260 board execute the boot
> code (ppcboot and limon) properly. Both monitors begin execution, and
> even start to make printouts on the serial console, but hang before
> being able to relocate to RAM. I just looks like the instruction
> fetches don't work for the Flash (SIMM). Limon, apparently being
> quicker with the boot-up, very rarely made it through the relocation
> and from then worked ok. Both monitors work fine when downloaded
> directly to RAM after initialisation of the memory controller by the
> JTAG probe. I replaced the DIMM, but that didn't make any difference.
>
> I'm about to send the board back to Windriver and ask for a
> replacement. Has anyone ever observed such behavior on their SBC8260?
>
> Marius
>
> -----------------------------------------------------------------------------
> Marius Groeger           SYSGO Real-Time Solutions GmbH     www.elinos.com
> Software Engineering     Embedded and Real-Time Software    www.sysgo.de
>
>
>
>
--
Please reply to markphillips@alum.mit.edu

--
Please reply to markphillips@alum.mit.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
