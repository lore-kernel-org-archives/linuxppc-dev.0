Date: Thu, 23 Nov 2000 12:37:16 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Avery Pennarun <apenwarr@worldvisions.ca>, daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.LNX.4.10.10011231212270.18581-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10011231227170.13127-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Nov 2000, Avery Pennarun wrote:

> Then it should go in /var, I think.  We have standards for this stuff.
> (FSSTND, FHS, Debian policy.)  I might want to mount /etc read-only (and
> /usr too, while I'm at it)... and this sounds like it would prevent me from
> doing so.

On Thu, 23 Nov 2000, Michael Schmitz wrote:

> Granted. pmud was first packaged for LinuxPPC which is rpm based and cares
> about FHS about as much as RedHat does. I'll look for a better place to
> stick the fifo.
>
> Re: mounting /etc readonly: how do you handle /etc/mtab in that case? :-)
>
> 	Michael

I agree that power management status/log should go to /var. On the other
hand /etc has to be on the root fs for several reasons (/etc/inittab among
others is quite important): IOW you don't use a separate mount point for
/etc unless you want to play dirty tricks with init.

Of cuorse there is a precedent for modifying /etc: /etc/mtab, but
admittedly for good reasons. mount also puts lock files in /etc and has to
have these funky option (-n and -f) to work around the chicken and egg
problem of initial read only root filesystem mount by the kernel. Once you
have these option I don't see any reason not to have /var/mtab instead for
example but maybe I miss something.

Now /etc/mtab is also somewhat redundant with /proc/mounts. Actually you
should be able to link /etc/mtab to /proc/mounts but it raises a lot of
problems and does not work satifactorily in my experience.

I have a setup of a lot of different diskless machines which share
basically everything: /usr and /home on the same mount point, and almost
all files in the root directories are hardlinked, except for files in
/etc and /var, where it turned out to be impossible (and I don't mind an
additional megabyte or so of disk space per diskless system, it's still
about 99.9% shared).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
