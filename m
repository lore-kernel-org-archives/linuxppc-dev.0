Return-Path: <Hans.Schillstrom@lgpallgon.com>
Received: from aseit003.allgon.net (mail.lgpallgon.com [193.235.198.4])
	by ozlabs.org (Postfix) with ESMTP id 9584567A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 20:02:26 +1100 (EST)
From: Hans Schillstrom <hans.schillstrom@pwav.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6474ED@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A6474ED@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1106037124.7900.303.camel@hawk.allgon.net>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 09:32:04 +0100
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Subject: RE: Linux 2.6-10.rc3  8xx  - Only 3 characters are printed well i
	n __ init start_kernel() upon kernel booting - why ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 2005-01-17 at 14:07, Povolotsky, Alexander wrote:
> Hi Hans,
>=20
> Unfortunately I am not using u-boot.
> I am using "custom" bootloader (modified pSOS bootloader),
>  for which I do not have the source (and on top of - even if I would
> have the source for this bootloader - JTAG is not available to me to=20
> reflash new version of the bootloader).
>=20
> Is there any way to control (change) this in the kernel source itself ?

Actualy it's the bd_info struct that has to be correct=20
when calling _start: (in head_8xx.c)=20
I'm not shure about the behavior if it's null (I always use it).

>=20
> Thanks,
> Best Regards,
> Alex
>=20
> -----Original Message-----
> From: Hans Schillstrom [mailto:hans.schillstrom@pwav.com]
> Sent: Monday, January 17, 2005 2:10 AM
> To: Povolotsky, Alexander
> Subject: Re: Linux 2.6-10.rc3 8xx - Only 3 characters are printed well
> in __ init start_kernel() upon kernel booting - why ?
>=20
> Hi,
> If you are using u-boot,
> have you checked the env. varialbe "clocks_in_mhz" ?
> if that one is set it turn out like that.
>=20
> Regards
> /Hans
>=20
> On Sun, 2005-01-16 at 20:54, Povolotsky, Alexander wrote:
> > > Per kind advise I have got, I have added baud rate to the command lin=
e
> (I
> > > did not have it there before):
> > >=20
> > > CONFIG_CMDLINE=3D"console=3DttyCPM0,115200 panic=3D3 root=3D/dev/ram"
> > >=20
> > > 	However, my real current problem (just 3 characters get printed
> > > correctly during the kernel boot) did not go away.
> > >=20
> > > 	Is there a way to check if the baud rate specified in the .config's
> > > commandline is indeed in effect for the kernel booting ?
> > >=20
> > > 	Any other reasons/explanation for my "3 character" problem ?
> > >=20
> > > 	 -----Original Message-----
> > > 	From: 	Povolotsky, Alexander =20
> > > 	Sent:	Sunday, January 16, 2005 5:59 AM
> > > 	To:	'linuxppc-dev@ozlabs.org'
> > > 	Subject:	Linux 2.6-10.rc3  8xx kernel booting - how to set
> > > baud rate for the serial driver ?
> > >=20
> > > 	Hi,
> > > 	...=20
> > > 	    =20
> > > 	My bootloader uses 115200 baud rate for the serial output during
> > > boot strapping.
> > >=20
> > > 	I have:
> > > 	CONFIG_SERIAL_CPM_CONSOLE
> > > 	in my .config=20
> > > 	...=20
> > > I could see some output during the kernel boot -
> > > I noticed that (only 3) characters (see below) from the linux_banner =
are
> > > printed
> > > in __init start_kernel() upon booting . Then a lot of garbage is
> outputted
> > > and eventually kernel hangs ...
> > >=20
> > > after gunzip
> > > done.
> > > Now booting the kernel
> > >
> Lin=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=FF=
=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=FF=
=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF=FF
> > > =FF=C0=D8=C0=FF=FF
> > > <more garbage>
> > > <hangs>
> > >=20
> > > to prove it I added printk("ALEX\n"); in __init start_kernel() prior =
to
> > > printk(linux_banner);
> > >=20
> > > ...=20
> > > lock_kernel();
> > > page_address_init();
> > > printk("ALEX\n");
> > > printk(linux_banner);
> > > setup_arch(&command_line);
> > > setup_per_cpu_areas();
> > > ...
> > >=20
> > > after gunzip
> > > done.
> > > Now booting the kernel
> > >
> ALE=FF=FF=FF=FF=FF=FF=FF=FF=C0=FF=FF=FF=FF=FF=FF=FF=FF=C08=C0=FF=FF=FF=FF=
=FF=FF=FF=FF=C0X=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0x=C0=FF=FF=FF=FF=FF=FF=FF=FF=
=C0~=C0=FF=FF=FF=FF=FF=FF=FF=FF=C0=B8=C0=FF=FF=FF=FF=FF=FF=FF
> > > =FF=C0=D8=C0=FF=FF
> > > <more garbage>
> > > <hangs>
> > >=20
> > > Why would first 3 characters come out right ?
> > > Any ideas ?
> > > Thanks,
> > >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
>=20
