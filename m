Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id D413D67A46
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jan 2005 00:59:21 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j0GDxIDR024391
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 08:59:18 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id IAA11506
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 08:59:20 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474EA@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Sun, 16 Jan 2005 08:57:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE: Linux 2.6-10.rc3  8xx  - Only 3 characters are printed well i
	n __init start_kernel() upon kernel booting - why ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Per kind advise I have got, I have added baud rate to the command
line (I did not have it there before):

	CONFIG_CMDLINE=3D"console=3DttyCPM0,115200 panic=3D3 root=3D/dev/ram"

		However, my real current problem (just 3 characters get
printed correctly during the kernel boot) did not go away.

		Is there a way to check if the baud rate specified in the
.config's commandline is indeed in effect for the kernel booting ?

		Any other reasons/explanation for my "3 character" problem ?

> 	 -----Original Message-----
> 	From: 	Povolotsky, Alexander =20
> 	Sent:	Sunday, January 16, 2005 5:59 AM
> 	To:	'linuxppc-dev@ozlabs.org'
> 	Subject:	Linux 2.6-10.rc3  8xx kernel booting - how to set
> baud rate for the serial driver ?
>=20
> 	Hi,
		...=20
		    =20
> 	My bootloader uses 115200 baud rate for the serial output during
> boot strapping.
>=20
> 	I have:
> 	CONFIG_SERIAL_CPM_CONSOLE
> 	in my .config=20
		...=20
I could see some output during the kernel boot -
I noticed that (only 3) characters (see below) from the linux_banner =
are
printed
in __init start_kernel() upon booting . Then a lot of garbage is =
outputted
and eventually kernel hangs ...

after gunzip
done.
Now booting the kernel
Lin=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=FF=
=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=FF=
=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0
=D8=C0=FF=FF
<more garbage>
<hangs>

to prove it I added printk("ALEX\n"); in __init start_kernel() prior to
printk(linux_banner);

...=20
lock_kernel();
page_address_init();
printk("ALEX\n");
printk(linux_banner);
setup_arch(&command_line);
setup_per_cpu_areas();
...

after gunzip
done.
Now booting the kernel
ALE=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=FF=
=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=FF=
=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0
=D8=C0=FF=FF
<more garbage>
<hangs>

Why would first 3 characters come out right ?
Any ideas ?
Thanks,
