Date: Thu, 23 Nov 2000 15:18:53 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Avery Pennarun <apenwarr@worldvisions.ca>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, Hadess <hadess@writeme.com>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.LNX.4.10.10011231431070.3480-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10011231514150.21126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Nov 2000, Michael Schmitz wrote:

>
> > On Thu, Nov 23, 2000 at 12:15:32PM +0100, Michael Schmitz wrote:
> >
> > > Re: mounting /etc readonly: how do you handle /etc/mtab in that case? :-)
> >
> > Symlink it to /proc/mounts, of course. :)
>
> Good answer. I'd have used a symlink to some writeable directory on the
> root fs, mainly because using /proc all over the place tends to confuse
> Unix admins with no Linux experience. Let's not fall into the Solaris trap
> (you are in a maze of twisty little config files, all different from the
> rest of Unix').

At boot, before the first mount command executes, there may be _no_
writable directory and there may be none for a while, and you have the
problem of having an existing non-empty /etc/mtab (or equivalent) from a
non-clean shutdown which you would have to erase before the first mount is
done (adding another funky option to mount). Unless you make some kind of
ramdisk compulsory, which might not be bad idea after all with current
memory sizes.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
