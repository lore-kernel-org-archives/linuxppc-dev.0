In-Reply-To: <19990614114347.006593>
Date: Wed, 23 Jun 1999 10:43:45 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: kevyn@apple.com, Paul.Mackerras@cs.anu.edu.au, huberj@WPI.EDU
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: PowerBook sleep, first try
Message-Id: <19990623104345.023685@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I've uploaded a first-try implementation of sleep on PowerBook G3 Series
(Grackle/mac-io based). It's NOT functional yet, it still hangs when
waking up. However, it no longer resets the machine, so it looks like the
ROM code is correctly identifying the wakeup code when the CPU is powered
back on.

I would really appreciate if some people could review it and give me
their feeling about possible bugs and why it's currently not working. The
overall layout along with some strange hacks are directly reverse-eng.
from MacOS nanokernel (MacOS 8.6 version).

The code is at <http://calvaweb.calvacom.fr/bh40/sleep_test.tar.gz>, the
patches were made against a 2.2.9 vger kernel but should apply cleanly
(hum... mostly) on 2.2.10.

For those who didn't follow the whole story, when the PowerBook goes to
sleep, it actually shuts down the CPU (but not Grackle). There is some
code in the ROM reset vectors that detects that Grackle is not in it's
initial state. If it is not, it then looks for the magic value 'Lars' at
address 4 (physical). If found, it looks for a pointer at address 0. at
this pointer address, there's a pointer to the code to be executed.

So basically, just after we have sent the PMU sleep command (we then have
approx. 1/2 second to backup everything) we need to backup the CPU
context and store those magic values. The code also must make sure that
all those datas are properly flushed before the CPU is reset (I disable
the data cache to be sure). Apparently, we must also switch the CPU to
sleep mode (which in turn will put Grackle in NAP mode) and wait to be reset.
For unknown reasons, the MacOS code for that just re-enables the i-cache
and does some strange things around the sleep code. My code does approx.
the same. I've heard "rumors" about Grackle bugs that needed to be worked
around by Apple, I'm wondering if those strange tricks may be related to
those bugs, and in this case, if my fixes are correct.

According to an Apple eng. I met at WWDC, there is no need to save the
pci config registers, PCI devices are not turned off unless explicitely
done by their respective drivers.

Of course, we still lack a sleep notifier for devices like bmac, and the
hack I added to atyfb is probably not correct, but I want to get the core
operation to work first, and then spend time with the various devices.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
