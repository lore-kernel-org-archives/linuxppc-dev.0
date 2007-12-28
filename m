Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device node - How does kernel know about it
Date: Thu, 27 Dec 2007 20:55:04 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AFA32@corpexc01.corp.networkrobots.com>
In-Reply-To: <9e4733910712272015m30ffc13cu6022ee9d29f9bddc@mail.gmail.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
	<Pine.LNX.4.60.0712280936420.1827@rtl14.hofr.at>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7012AFA2D@corpexc01.corp.networkrobots.com>
	<9e4733910712272015m30ffc13cu6022ee9d29f9bddc@mail.gmail.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Nicholas Mc Guire <der.herr@hofr.at>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

Yes!... I have CONFIG_EARLY_PRINTK=3Dy, and I could see early prints
during booting the kernel. Afterwards, printk's also work as expected.
Only printf's from user space has problem.

- Siva


-----Original Message-----
From: Jon Smirl [mailto:jonsmirl@gmail.com]=20
Sent: Thursday, December 27, 2007 8:16 PM
To: Siva Prasad
Cc: Nicholas Mc Guire; linuxppc-dev@ozlabs.org;
linuxppc-embedded@ozlabs.org
Subject: Re: Device node - How does kernel know about it

On 12/27/07, Siva Prasad <sprasad@bivio.net> wrote:
> Thank you Jon and Nicholas.
>
> I already have "console=3DttyS0" in the kernel command line. That is =
not
> helping me.

Do you have
CONFIG_EARLY_PRINTK=3Dy
in .config?


>
> I looked at the major/minor numbers with a good working system and it
> looks correct for the nodes created in ramdisk.
>
> What is the kernel routine that is first called when there is, for
> example a read() function call from user program?
> I would like to start debugging from there and see if any thing at all
> happens when there is a call. Appreciate your help with this question.
>
> Thanks
> Siva
>
>
> -----Original Message-----
> From: Nicholas Mc Guire [mailto:der.herr@hofr.at]
> Sent: Friday, December 28, 2007 12:39 AM
> To: Siva Prasad
> Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
> Subject: Re: Device node - How does kernel know about it
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > * Ramdisk is also executing fine, just that prints are not coming
out
> of
> > serial. I can see the execution of various user programs with a
printk
> > in sys_execve() routine. Ramdisk has all the required files like
> > /dev/console, /dev/ttyS0, etc.
> > * Looking further into tty driver, I noticed that call to
tty_write()
> or
> > do_tty_write() is not happening at all. So, somewhere the interface
> > between kernel and user program is lost.
> > * Just to check it out, I tried to write a small kernel module and a
> > test program.
> >  - Attached memtest.c module (not really testing memory there. :-))
> >  - Attached testmemtest.c user program, that just open's it and
reads
> > the information
> >  - Created a device node using "mknod /dev/memtest c 168 0"
> >  - When I do "insmod memtest.ko" inside the ramdisk bootup scripts,
I
> > could see all the printk's on the console
> >  - When I execute "testmemtest" next in the same script, it does not
> > display the printk inside of memtest.c module. This only indicates
> that
> > read call did not really go to the kernel side.
> >  - Just to check my program's validity, I checked on a similar
machine
> > and all the code works fine.
> >  - "uname -r" also matches with what I built. So, chances of exiting
> > from open call because of mismatch is remote. Since userland cannot
> > print, I have no idea what exactly is happening there.
> >
> The kernel will simply look at the major:minor numbers - so maybe you
> simply have a wrong major/minor for /dev/ttyS0 ? in that case you will
> see nothing but other than that most things will go on working.
>
> hofrat
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
>
> iD8DBQFHdLY2nU7rXZKfY2oRApFpAKCKfGanKHGuFFJmUFy3aQtjmWNjEACfU7uK
> hrfpn2RMn5l23ZqCOXV5rd8=3D
> =3DGfsF
> -----END PGP SIGNATURE-----
>


--=20
Jon Smirl
jonsmirl@gmail.com
