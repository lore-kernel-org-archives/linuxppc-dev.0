Return-Path: <root@hofr.at>
Date: Fri, 28 Dec 2007 09:39:13 +0100 (CET)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: Device node - How does kernel know about it
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
Message-ID: <Pine.LNX.4.60.0712280936420.1827@rtl14.hofr.at>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7012AF958@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> * Ramdisk is also executing fine, just that prints are not coming out of
> serial. I can see the execution of various user programs with a printk
> in sys_execve() routine. Ramdisk has all the required files like
> /dev/console, /dev/ttyS0, etc.
> * Looking further into tty driver, I noticed that call to tty_write() or
> do_tty_write() is not happening at all. So, somewhere the interface
> between kernel and user program is lost.
> * Just to check it out, I tried to write a small kernel module and a
> test program.
>  - Attached memtest.c module (not really testing memory there. :-))
>  - Attached testmemtest.c user program, that just open's it and reads
> the information
>  - Created a device node using "mknod /dev/memtest c 168 0"
>  - When I do "insmod memtest.ko" inside the ramdisk bootup scripts, I
> could see all the printk's on the console
>  - When I execute "testmemtest" next in the same script, it does not
> display the printk inside of memtest.c module. This only indicates that
> read call did not really go to the kernel side.
>  - Just to check my program's validity, I checked on a similar machine
> and all the code works fine.
>  - "uname -r" also matches with what I built. So, chances of exiting
> from open call because of mismatch is remote. Since userland cannot
> print, I have no idea what exactly is happening there.
>
The kernel will simply look at the major:minor numbers - so maybe you
simply have a wrong major/minor for /dev/ttyS0 ? in that case you will
see nothing but other than that most things will go on working.

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFHdLY2nU7rXZKfY2oRApFpAKCKfGanKHGuFFJmUFy3aQtjmWNjEACfU7uK
hrfpn2RMn5l23ZqCOXV5rd8=
=GfsF
-----END PGP SIGNATURE-----
