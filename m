Date: Wed, 11 Aug 1999 08:39:40 -0700
From: parker42@hotlinehq.com
Message-Id: <199908111539.IAA29757@evildog.hotlinehq.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: ping -f crashes beige G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using LinuxPPC R4 on a beige G3 as a web server. The server was very
unstable, and it appears that the software support for the internal bmac
ethernet interface was the culprit. I have found a specific, repeatable
way to crash a beige G3 (ping -f from the G3 itself), but it seems like a
symptom of a more general problem.

The situation:
Beige G3 used as a disk and CPU intensive web server. It crashes frequently,
usually within 24-48 hours of reboot. Crash times seem unrelated to peak
usage times or any particular server operation. No unexpected log messages
or kernel errors are found - it just stops dead. Using a SCSI-1 disk
instead of the Atto card does not seem to help. Moving the (SCSI-1) disk to a
PowerCenter Pro and running the exact same software system results in a
perfectly stable system which has run for almost a month now.

The specs:
Beige G3 (rev. 1, i.e. ATI Rage II+ not Pro)
266 MHz
256 MB RAM
Atto Fast/Wide SCSI 2 disk
Internal 10baseT Ethernet
LinuxPPC R4 (glibc upgraded to 0.961212-1o)
Primarily running Apache, mySQL, glimpse

The crash:
After taking the server down for testing, I stumbled across a way to crash it:
ping -f (ping flood) from the G3 itself. On our 266 G3, ping -f will crash
within 30 minutes, often in as little as 1 minute. Of course, this is a
network-intensive operation, so the networking appears to be at fault.
I'm guessing that this is a symptom of a larger problem which caused the
other server failures too (we certainly weren't running ping floods).

The evidence:
Other data seems to point to the bmac interface driver:
* ping -f crashes on another rev1 beige G3. This second machine is 300 MHz,
and it often survives for an hour or more - the problem may be a timing error
or race condition which is less frequent on a faster machine.
* ping -f crashes on many kernels. I tested vmlinux.atto-scsicard and
vmlinux-2.1.137 from linuxppc.org, Tom Rini's vmlinux4, and a unknown
2.2.4 kernel (probably also from linuxppc). All fail equally well.
* ping -f crashes on a second LinuxPPC installation (a freakish hybrid of
mkLinux and LinuxPPC R3 and R4 that was on the PowerCenter Pro).
* ping -f works (9+ hours) when using Apple's 10/100 card instead of the
internal interface.
* ping flood from MacOS (using WhatRoute) appears to work.
* ping -f localhost  appears to work - presumably ping to localhost doesn't go
all the way to the NIC.
* receiving a ping flood from another machine appears to work
* ping -f on the replacement PowerCenter Pro appears to work - it's only bad
on the beige G3s.
* Other crash attempts (like copying 400 MB of files back and forth for a
week) did't take down the server. I have not done significant network tests
besides ping flood, except that the machine did die while being used as a
web server.

Twice during testing I got kernal panic printouts and 180-second reboot when
it crashed - all other crashes were simply dead stops with no reboot,
occasionally with dark green garbage on the console. The two errors were
substantially similar, although I didn't have time to write down the full
details of each. Here are some of the highlights:
"regs: c18e9960 machine check signal probably due to mm fault with mm off"
"TASK = c18e8000[430] 'ping' mm->pgd c190b000 lastsyscall 102"
"machine check in kernel mode"
"kernel panic: machine check"
along with a call backtrace and instruction dump and what appear to be some
registers, none of which I've been able to write down. I don't pretend to
understand what most of it means, but "ping" and "kernel panic" are pretty
obvious :-)


Is this a known problem? I didn't see any mention of it in the LinuxPPC
list archives. Can anyone else duplicate it on other beige or non-beige
I don't need a fix because I can use the apparently working 10/100 card,
but if it's a general problem then there are certainly lots of other beige
machines out there on which this would look like a random crash.

--
Greg Parker    parker42@hotlinehq.com
"The above is based mainly on things I've seem written on walls in bathrooms,
and I made the rest up."  - Alexei Kosut

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
