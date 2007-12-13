Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: initrd - console
Date: Wed, 12 Dec 2007 18:06:50 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A808A@corpexc01.corp.networkrobots.com>
In-Reply-To: <1197336860.7378.29.camel@concordia>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A7AFE@corpexc01.corp.networkrobots.com>
	<1197336860.7378.29.camel@concordia>
From: "Siva Prasad" <sprasad@bivio.net>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks for the response Michael.

Yes!... I do have /dev/console
I also have the following line in /etc/inittab (::respawn:/sbin/getty -L
ttyS0 115200 VT100)

Still  it does not print any thing from the user land. All the kernel
printk's are working fine.

I tried to print the arguments and environment variables for getty and
echo /dev/console. Below is the info.

sys_execve - filename=3D/sbin/getty.
copy_strings: kaddr =3D /sbin/getty.
copy_strings: kaddr =3D USER=3Droot.
copy_strings: kaddr =3D SHELL=3D/bin/sh.
copy_strings: kaddr =3D PATH=3D/usr/bin:/bin:/usr/sbin:/sbin.
copy_strings: kaddr =3D TERM=3Dvt102.
copy_strings: kaddr =3D HOME=3D/.
copy_strings: kaddr =3D VT100.
copy_strings: kaddr =3D 115200.
copy_strings: kaddr =3D ttyS0.
copy_strings: kaddr =3D -L.
copy_strings: kaddr =3D /sbin/getty.

sys_execve - filename=3D/bin/echo.
copy_strings: kaddr =3D /bin/echo.
copy_strings: kaddr =3D GATEWAY0=3D172.27.255.254.
copy_strings: kaddr =3D NETMASK0=3D255.255.0.0.
copy_strings: kaddr =3D PWD=3D/.
copy_strings: kaddr =3D SMBD_ARGS=3D.
copy_strings: kaddr =3D NAMESERVER0=3D172.27.0.1.
copy_strings: kaddr =3D NTP_SERVER=3D.
copy_strings: kaddr =3D SHELL=3D/bin/sh.
copy_strings: kaddr =3D INETD_ARGS=3D.
copy_strings: kaddr =3D BOA_ARGS=3D.
copy_strings: kaddr =3D NMBD_ARGS=3D.
copy_strings: kaddr =3D TMPFS=3Dtmpfs.
copy_strings: kaddr =3D PATH=3D/usr/bin:/bin:/usr/sbin:/sbin.
copy_strings: kaddr =3D READONLY_FS=3D.
copy_strings: kaddr =3D TERM=3Dvt102.
copy_strings: kaddr =3D MODLIST=3D.
copy_strings: kaddr =3D SYSCFG_IFACE0=3Dy.
copy_strings: kaddr =3D IPADDR0=3D172.27.180.41.
copy_strings: kaddr =3D DEPLOYMENT_STYLE=3DRAMDISK.
copy_strings: kaddr =3D SYSCFG_DHCPC_CMD=3Dudhcpc -b -i .
copy_strings: kaddr =3D DHCP_ARG=3D.
copy_strings: kaddr =3D RAMDIRS=3D.
copy_strings: kaddr =3D BROADCAST0=3D172.27.255.255.
copy_strings: kaddr =3D HOME=3D/.
copy_strings: kaddr =3D HOSTNAME=3Dmpc8641hpcn.
copy_strings: kaddr =3D USER=3Droot.
copy_strings: kaddr =3D INTERFACE0=3Deth0.
copy_strings: kaddr =3D /dev/console.
copy_strings: kaddr =3D echo.

Thanks
Siva


-----Original Message-----
From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
Sent: Monday, December 10, 2007 5:34 PM
To: Siva Prasad
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: initrd - console

On Mon, 2007-12-10 at 17:26 -0800, Siva Prasad wrote:
> Hi,
>=20
> I am trying to boot kernel with initrd. However, it hangs in
> run_init_process("/sbin/init"). I went into the system calls to see
what
> it is doing.=20
>=20
> As part of debugging, I ended up adding a printk statement in
> arch/powerpc/kernel/process.c:sys_execve() routine. Noticed that all
the
> calls are coming here, however nothing is printed on the screen. I
think
> initrd is executing fine (unless one of you says otherwise). See the
> capture below for boot log.
>=20
> Question 1: how come nothing is printed from ramdisk (userland
programs)
> to the serial console, while all the kernel printk's are working
> perfectly?

Do you have a /dev/console etc. in your initrd?

> Question 2: How important is to have interrupts working for just
> printing. I know that interrupts are must to enter input.

Depends on what your console is, but if it's something simple then you
should be able to write to it without taking interrupts.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
