To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Misc problems with Lombard (serial, ethernet, SCSI)
References: <m2vgvlthiy.fsf@c469597-a.grlnd1.tx.home.com> <19340820005344.27517@192.168.1.10>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 03 Oct 2000 23:57:26 -0500
In-Reply-To: Benjamin Herrenschmidt's message of "Mon, 25 Sep 2000 09:22:00 +0200"
Message-ID: <m2snqdfbk9.fsf@c469597-a.grlnd1.tx.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I upgraded to 2.4-test9 (from LinuxCare) and I've got some new data.

Benjamin Herrenschmidt <bh40@calva.net> writes:

> >* Serial drivers - At least when talking to the modem, it will occasionally
> >  cease to work.  I use pppd to connect, and when it disconnects I cannot
> >  reconnect.  Once this happens, anything that tries to open the port get
> >  an I/O error.  If I unload the serial module and then reload it, the
> >  problem goes away for a while.  This started happening around 2.2.15.
>
> Dan Malek recently "ported" a workaround for a HW SCC bug which seem to
> fix such problems. (The SCC get stuck sometimes when receiving certain
> kinds of bad characters). I'll try to get that merged ASAP.

This seems to be fixed in 2.4-test9

>
> >* MESH Driver - It won't work with my scanner.  The scanner works fine
> >  under MacOS and used to work under Linux x86.  It has problems with
> >  disconnects.  Also, once I use it then sleeping and awaking will locks up
> >  the machine.  Also, unloading the MESH module and reloading it locks up
> >  the machine.
>
> Paul ? Any clue ? MESH is still a weird beast to me ;)

This also seem to be fixed.

>
> >* Ethernet driver (BMAC) - The driver will occasionally lock up under heavy
> >  load (I haven't seen this yet with 2.2.17, though).  If I define an alias
> >  address, bringing down the alias address will also bring down the main
> >  address (this is still happening under 2.2.17).  Unloading the ethernet
> >  driver and loading it again causes a lockup.
>
> I've not experieced that before, there are some known issues with bmac
> (HW bugs uncovered by comments in Apple's Darwin source code) but AFAIK,
> nothing that cause a kernel lockup.

I haven't had the port lockup (it's not a kernel lockup, but the port
just stops working), but I haven't done much heavy traffic.  Unloading
and reloading the driver as a module still causes a machine lockup.

>
> >I'm also seeing random lockups after long periods of running under
> >heavy load, but this is new and I'm thinking it may be a heat problem.
> >But just in case, I'll say it.
>
> It may also be a RAM problem. Some Lombards are known to have memory
> controller (or RAM, we don't know for sure) problems.
> Also, which boot method are you using ?
>

Haven't done any big builds, but I haven't seen this eithers.


I upgraded to a USB scanner and a USB CDRW, which seem to work fine, BTW.

I am having wakeups from sleeping lock up the machine occasionally;
this seems related to the USB stuff, it only seems to happen when I
remove USB devices, sleep, wakup without them, sleep again, then plug
them back in and wake up.  But I do this fairly often.

Thanks,

Corey

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
