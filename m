In-Reply-To: <199903102251.JAA08378@tango.anu.edu.au>
Date: Thu, 11 Mar 1999 12:53:29 +0100
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB Reset
Message-Id: <19990311125329.016856@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 11, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>If we have two devices with the same default ID, they may get assigned
>different IDs after re-probing.  Any ideas how to cope with that?
>
>On my 3400, after a snooze, sometimes the adb bus has been reset and
>sometimes it hasn't.  I haven't been able to discern any pattern,
>e.g. it doesn't seem to depend on how long the machine is asleep for.
>I believe that the power to the adb bus is supposed to stay on during
>sleep, so I don't see why it's getting reset.

I plan to re-do the entire bus reset, probing and intialisation after the
sleep. Actually, anyone (and so ADB device handlers) will be able to
register a notification proc with the ADB core. Messages will be sent to
devices before and after a bus reset, at initialisation time, and
eventually in other circumstances.
Sleep will cause a reset (but with an additional parameter indicating
that it's coming from a sleep, so that the device knows that the power on
the bus may be turned off. This may be useful for some devices).

Under MacOS, the bus is reset after sleep and devices are notified via a
low-memory hook just before and after the bus reset.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
