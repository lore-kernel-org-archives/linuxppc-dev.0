Date: Mon, 4 Dec 2000 10:11:06 -0500
From: Jonathan Lane <jingai@shell.faradic.net>
Message-Id: <200012041511.eB4FB6P19204@shell.faradic.net>
To: debian-powerpc@lists.debian.org, jingai@shell.faradic.net,
        nicoya@apia.dhs.org
Subject: Re: 3COM 3c905c again
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Also, in my syslog, dhcpd complains with:
> >
> >Aug 27 16:42:20 colour dhcpd-2.2.x: DHCPDISCOVER from 08:00:46:05:9c:c8
> >via eth1
> >>Aug 27 16:42:20 colour dhcpd-2.2.x: no free leases on subnet 192.168.1.0
> >
> >(Ignore the date, my clock had yet to be set).  But this indicates that
> >packets *are* getting thru, as the MAC address shown above is correct.
>
>
> Check your DHCP server configuration and logfiles. It would appear your
> server doesn't want to give your client an IP address.

Actually, I think it had something to do with the date not being set, as
this went away just after I reset the clock.

> >I'd also like to know why the last four PCI slots don't work properly,
> >although it appears it's not incredibly important now, unless X doesn't
> >work...
>
> I think there's some PCI bogosity in the standard 2.2 kernels when it comes
> to PCI-PCI bridges. I've had fairly good luck with 2.2 with a PCI patchset

This was the problem.  I moved the NIC to slot 2, and moved my video board
to slot 4.  Everything works fine now.  The actual problem with packets
not making it to the other machine had to do with my homemade cable (works
over 10BT, but not 100BT... probably either due to length and/or quality).

Also, if you or anyone else can ever recall the source for the PCI patch,
I'd appreciate it.  Wonder why it hasn't been rolled into the 2.2 kernels
yet, though...?

Thanks for everyone's help.  Also, just to summarize, here are the cards
I tried, just in case anyone else here attempts to add a second NIC and
runs into the same problems I did:

Netgear FA311 -- not recognized at all; link light didn't even light up.

Linksys NC100 & LNE100TX -- both seemed to function, as I was able to
   send a couple packets out, but seemed flaky; however, this was
   most likely due to my crummy cable, so I'd say give these cards a
   shot since they're significantly cheaper than the 3com...

3COM 3c905c-tx-m -- works beautifully, if you're cables don't suck :)

Regards,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
