Message-Id: <200012051220.eB5CKJF10867@denx.local.net>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: mount via nfs using MontaVista's Linux for IBM405 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Dec 2000 13:59:19 +0200."
             <Pine.GSO.4.30.0012051357150.16118-100000@stekt6>
Date: Tue, 05 Dec 2000 13:20:19 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.GSO.4.30.0012051357150.16118-100000@stekt6> you wrote:
>
> >When I do a: mount -t nfs <nfs-servers-ip>:/home/matthias /test on the
> >405 board, I get this output (after some delay):
> >
> >	nfs warning: mount version older than kernel
> >	portmap: server localhost not responding, timed out
> >	portmap: server localhost not responding, timed out
> >	lockd_up: makesock failed, error=-5
...
> (5 minutes or so)... I don't exactly know what is the reason for that,
> but have you tried to set up a loopback interface for the localhost
> aswell? It just might solve the problem, obviously portmap is trying
> to contact the portmapper on localhost aswell...

Try what happens when you run the following commands on  your  target
(soon after booting):

/sbin/ifconfig lo 127.0.0.1
/bin/mount -n -o rsize=8192,wsize=8192,rw,remount /
>/etc/mtab
/bin/mount -t proc proc /proc
/usr/sbin/portmap &
rdate -s `sed -n -e 's/\/dev\/root .*addr=\([^ ][^ ]*\).*/\1/p' /proc/mounts`

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...though his invention worked superbly -- his theory was a crock  of
sewage from beginning to end.         - Vernor Vinge, "The Peace War"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
