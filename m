Date: Wed, 10 Mar 1999 12:36:39 +0100
From: Hubert Figuiere <hub@point-barre.fr>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
Message-ID: <19990310123639.A292@giordino.point-barre.fr>
References: <19990305110825.A602@giordino.point-barre.fr> <19990305153207.016764@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990305153207.016764@mail.mipsys.com>; from Benjamin Herrenschmidt on Fri, Mar 05, 1999 at 03:32:07PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Benjamin Herrenschmidt <bh40@calva.net>:

> >Can anybody tell me how to reset the ADB bus. Just because when I
> >snooze the PowerBook, the mouse become really slow....
> >
> >How can I ask to redect all the ADB peripherals. I want to be able
> >to plug and unplug my kensington mouse.
> >
> >The goal is to make a small set of utilities for this :-)
> 
> For the reset on snooze, the adb.c code should register a sleep queue
> element to be notified of snooze, and do a reset from it. (For infos
> about sleep notifications, look at other drivers like the chipsfb).
> 
> The reset is currently done thru a function pointer filled by the
> low-level driver (be careful, it could be NULL). You should find it by
> looking at adb.c code.
> 
> As far as plug/unplug is concerned, this could be done by adding a ioctl
> to the ADB driver.

I could reset the adb bus with adb_reset_bus(), but it did
nothing in my case. Mouse was still SLOW, etc.
I called adb_scan_bus() instead. But this happen to not work and
make my mouse no longer be recognized.

Any idea on what to do ?

Hub
-- 
World Wide Wait: the real meaning for WWW.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
