Date: Wed, 16 May 2001 12:28:16 -0300
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel lockup
Message-ID: <20010516122816.C19737@llama.nslug.ns.ca>
References: <20010516010328.D19015@llama.nslug.ns.ca> <20010516092154.16870@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010516092154.16870@mailhost.mipsys.com>; from benh@kernel.crashing.org on Wed, May 16, 2001 at 11:21:54AM +0200
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 16, 2001 at 11:21:54AM +0200, Benjamin Herrenschmidt wrote:
> >bigfoot:~# kbdrate -h
> >kbdrate: invalid option -- h
> >Machine check in kernel mode.
> >Caused by (from SRR1=c9030): Unknown values in msr
> >
> > What do I do to debug this?
> >
> > The machine is totally locked, not even the SysRQ combination does
> >anything.  (control+command+power still resets though, since it is handled
> >in hardware on oldworlds.)
>
> Well, I guess that kbdrate is yet another dumb x86'ism that will
> directly tap the hardware of a PC's keyboard controller...
>
> Well, I may be wrong, but machine check usually means that you are
> trying to access non-existing hardware.

 Ah, I remember that it sets your repeat rate and delay to something even
after you run it with options it doesn't recognize.  That would explain it.

> There should be other informations displayed about the crash. Those
> should allow you to lookup the location of it in System.map

 Well, there isn't :(  It seems to lock hard, and nothing does anything.

 I just noticed that on bootup, there's a message in the initial bootup
stuff from xmon saying that it will use "screen and keyboard".  If these are
the OpenFirmware devices, then might that be using my serial port instead?
(I still haven't gotten around to getting an adapter so I can look at what
OF is saying.)  My machine is a clone based on the Apple 9500.

 I just looked at my syslog, and there were logs from cron jobs after the
console locked up.  I tried running kbdrate on the console while I was
logged in through ssh from the other machine on my desk.  Well, the ssh
session stayed working completely, so I just su'ed and ran shutdown -r now.
I guess the thing to figure out now is why the console is totally locked
out, even though nothing else stops working.


--
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug. , ns.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BCE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
