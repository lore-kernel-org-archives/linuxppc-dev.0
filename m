Date: Fri, 7 Jan 2000 13:57:08 +0100
From: Olaf Hering <olh@suse.de>
To: Andreas Tobler <toa@pop.agri.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: remote debugging?
Message-ID: <20000107135708.C1891@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <3874C8D8.835DBC64@pop.agri.ch> <3874E237.57063BBE@mitre.org> <3874E9A9.48716917@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3874E9A9.48716917@pop.agri.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 06, Andreas Tobler wrote:

> Charles Lepple wrote:
> > 
> > Andreas Tobler wrote:
> > [...]
> [...] 
> > Paul Mackerras wrote some documentation for xmon that you may want to
> > check out. It doesn't seem to be in Documentation/ but it's probably at
> > linuxppc.cs.nmt.edu or something (search the mail archives -- it has
> > been discussed before).
> 
> This docu I have.
> Thanks for the answer. But my problem is much earlier I think.
> 
> I'd like to redirect the console output from the boot of my pm7200 to
> the serial port. This is what doesn't work.
> Neither the printer nor the modem port. 
> 
> When the system is up, I can check the physical connection which works.
> 
> Isn't it possible to get the boot output to the serial port written?

I had such a configuration a few days ago. 7200 -> ix86 with a usual
modem cable.

You need a kernel with support for PowerMac serial port and console on
serial port.
Then give the arguments like described in
Documentation/serial-console.txt :

console=ttyS0,19200 and you will see an output on your console and the
penguin on your screen. It should be possible to log both to serial and
to the screen.

For a first test you should setup a serial login to check the settings
in zterm. Add a line like this in your inittab:
t:23:respawn:/sbin/agetty -L -h 19200

The 23 mean the runlevels and might be different on a RedHat system.
If you can login to your 7200 then the cable and the settings in zterm
are ok. Somehow you always get a little garbage when you login from a
Mac to another Mac. This does not occour from a ix86 machine, I don't
know why.



Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
