Date: Sun, 22 Aug 2004 10:57:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 hoses 2.4 on old-world?
Message-ID: <20040822085709.GA7319@mars.ravnborg.org>
References: <p06100200bd4c49c3daeb@[192.168.0.23]> <p06100203bd4c5e3aa6d9@[192.168.0.23]> <p06100204bd4c604f23ac@[192.168.0.23]> <20040821225118.GB18858@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040821225118.GB18858@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 22, 2004 at 12:51:18AM +0200, Olaf Hering wrote:
>
>  On Fri, Aug 20, Stefan Jeglinski wrote:
>
> >
> > >Steps:
> > >
> > >make menuconfig
> > >(do some config)
> > >make
> > >make modules_install
> > >reboot
> >
> > Confirmed. Something about this procedure with 2.6.8-rc4 is hosing
> > /dev/null, and I have to delete it and mknod again. Is this a known
> > bug, or have I discovered something that everybody's known about
> > forever, and I should slink away. Or maybe I don't understand how to
> > build/install 2.6 correctly?
>
> for starters:
>
> useradd -m jeglin
> su - jeglin
> tar xfj linux-2.6.8.1.tar.bz2
> cd linux-2.6.8.1
> make menuconfig
> make all
> cd ~jeglin/linux-2.6.8.1
> make modules_install
sudo make modules_install
> reboot
>
> the binutils check (?) will remove /dev/null

Yep - Tom Rini already notified me about this issue.
Problem is the way as handle output files.

Now I wonder why I do not see the problem here when executing the
culprint part of arch/ppc/Makefile manually:

sam@mars kbuild $ sudo ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 Jun 15 23:54 /dev/null
sam@mars kbuild $ sudo echo dssall | as -many -o /dev/null >/dev/null 2>&1
sam@mars kbuild $ sudo ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 Jun 15 23:54 /dev/null

Tom asked if we could use mktemp in the build process,
but I really do not know enough about potential security issues
to start doing this.
With mktemp we could avoid using /dev/null in the as check.

Another possibility was to parse the output of:
as --version | head -n 1 | cut -d ' ' -f 3
And then some sed/awk magic to fetch the three first numbers and
always make then two digits wide: 2.14.90.0.8 => 021490

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
