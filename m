In-Reply-To: <19990305110825.A602@giordino.point-barre.fr>
Date: Fri, 5 Mar 1999 15:32:07 +0100
To: Hubert Figuiere <hub@point-barre.fr>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB Reset
Message-Id: <19990305153207.016764@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 5, 1999, Hubert Figuiere <hub@point-barre.fr> wrote:

>Can anybody tell me how to reset the ADB bus. Just because when I
>snooze the PowerBook, the mouse become really slow....
>
>How can I ask to redect all the ADB peripherals. I want to be able
>to plug and unplug my kensington mouse.
>
>The goal is to make a small set of utilities for this :-)

For the reset on snooze, the adb.c code should register a sleep queue
element to be notified of snooze, and do a reset from it. (For infos
about sleep notifications, look at other drivers like the chipsfb).

The reset is currently done thru a function pointer filled by the
low-level driver (be careful, it could be NULL). You should find it by
looking at adb.c code.

As far as plug/unplug is concerned, this could be done by adding a ioctl
to the ADB driver.

I have already done part of those in experimental hacks here, if you can
wait one or two weeks, I'll clean all this up and make patches. If you
can't then implement them yourself, it's not very complicated. I'm too
busy to finish that stuff now.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
