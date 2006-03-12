Return-Path: <dstn@cs.toronto.edu>
Received: from cliff.cs.toronto.edu (cliff.cs.toronto.edu [128.100.3.120])
	by ozlabs.org (Postfix) with ESMTP id B2DAD679EA
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Mar 2006 13:25:42 +1100 (EST)
Received: from monte.ai (monte.ai.toronto.edu [128.100.5.22])
	by cliff.cs.toronto.edu (Postfix) with ESMTP id 478BD5FD03
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 20:55:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by monte.ai (Postfix) with ESMTP id 31EE7314C0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 20:55:03 -0500 (EST)
Date: Sat, 11 Mar 2006 20:55:02 -0500 (EST)
From: Dustin Lang <dstn@cs.toronto.edu>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: suspend2 on PowerBook: keyboard doesn't work on resume
Message-ID: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm trying to get suspend2 working on my PowerBook G4 of Oct 2003 vintage.

I'm running kernel 2.6.15.6 with the 2.6.15.1 suspend2 patch (it applied
and built fine).

Before suspending, I quit X and logged in as root on the console.  I
unloaded all the modules I could - leaving just agpgart and uninorth-agp.
USB is kernelized and the modules are unloaded.  I started a loop that
printed "Running" every 10 seconds (and also started a job that after 60
seconds would reboot).  I ran the 'hibernate' script.  It completed
successfully and powered down the machine.

On the next startup, the kernel boots and it resumes.  I see the root
terminal again, complete with my "hibernate" command and the syslog
messages detailing the progress of suspend2.  The system does not respond
to keystrokes, however.  After a few seconds, the "Running" message is
printed out, and after 60 seconds, the system reboots.  To me this
suggests that the system is mostly resuming correctly, but something has
gone funny with the keyboard driver.

Keyboard-related dmesg:

MacIO PCI driver attached to Intrepid chipset
input: Macintosh mouse button emulation as /class/input/input0
adb: starting probe task...
[snip]
PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ANSI.
input: ADB keyboard as /class/input/input1
input: ADB Powerbook buttons as /class/input/input2
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse as /class/input/input3
adb: finished probe task...

Does anyone on the list use suspend2 on a PowerBook?  Any success/failure
stories?  Any advice for generating more useful debugging information?

Thanks,
dustin.
