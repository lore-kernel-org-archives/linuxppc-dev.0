From: unit@panix.com
Date: Mon, 24 Apr 2000 00:27:06 -0400 (EDT)
To: Andreas Tobler <toa@pop.agri.ch>
Cc: Bernhard Reiter <bernhard@intevation.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard) 
In-Reply-To: <3901D09B.4B25722F@pop.agri.ch>
Message-ID: <Pine.SUN.4.21.0004240012000.3430-100000@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 Apr 2000, Andreas Tobler wrote:

i've also been having problems with ppp and kernels > 2.2.15pre9
somewhat similar to below .. only with hard crashes. I can't get
ppp to work w/ either prre17 or pre19 .. seems to be line dicipline:

Apr 16 18:34:05 sophix pppd[2541]: Serial connection established.
Apr 16 18:34:05 sophix modprobe: can't locate module tty-ldisc-3
Apr 16 18:34:05 sophix pppd[2541]: ioctl(TIOCSETD): Invalid argument(22)
Apr 16 18:34:05 sophix pppd[2541]: Hangup (SIGHUP)
Apr 16 18:34:05 sophix pppd[2541]: Exit.

w/ 2.2.15pre14 i can connect but if i reconnect linux crashes w/ no
option other than a force reboot (this has happened on three occasions
under the exact same circumstances).

> Bernhard Reiter wrote:
> >
> > There is a difference in modem device behaviour
> > between 2.2.15pre3(coming with LinuxPPC2000) and 2.2.15pre19(after
> > Paul M's stable tree, build myself using his .config).
> >
> Depends on how you got the 2.2.15p19, I had some difficulties due to the
> fact that I was too fast. Paul did a backport of ppp-2.4.x to 2.2.x and
> I rsynced it with the auvz --delete option; In the wrong moment!!!. But
> it wasn't meant for 2.2.x.
>
> So only a clean download helped me. (not all the stuff, only with the -u
> disabled (update == looks for date))

i rsynced the pre19 two days back so i'm not sure where i fall into the
loop. However it would seem the/my problem is further back

> Now I can report a clean, more or less, well ppp operation.

> > wvdail cannot open /dev/ttyS0 twice with 2.2.51pre19.
> > After I ctrl-ced wvdial to interrupt the network connection
> > I get an I/O error when I try to open it again.

> Do you have the module option in char/devices/serial on? (dumb serial device)
> If so, it can tend to a machine check, when you load a module. The patch
> below will/could help you maybe. I never got as far to include it into
> the kernel stuff....(Paul/Ben?)

> > Running wvdialconf it started scanning ttyS1 and
> > then jumped into the system monitor:
>
> Don't know about a lombard, but a wallstreet has 4 tty's 0,1,2,3
> (serial/printer =0, IRDA =1, modem =2; which is not present in my case;
> third = 3, the third is unused, I think the lombard has only one SCC so
> you can change the SERIAL_DEV_OFFSET to 2 iso 4.
> >
> > vector:200 at pc=d0849344 msr=1030, sp=c7bf3ce0 [c7bf3ce0]
> > current=c7bf2000, pid 745 comm=insmod
> >
> > Maybe that is an irport error and unrelated to the first problem.
> > I have not enquired further, though.
>
> So as for trial and error I'd suggest to disable some serial modules.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
