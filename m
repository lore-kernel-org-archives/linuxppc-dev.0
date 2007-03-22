Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CE41DDF94
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 08:10:46 +1100 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19
Date: Thu, 22 Mar 2007 14:10:37 -0700
References: <200703212044.40611.tmaenner@aehr.com>
	<20070322074052.34DD535260B@atlas.denx.de>
	<f001edbb0703220801m68622465j397a007bb85570cd@mail.gmail.com>
In-Reply-To: <f001edbb0703220801m68622465j397a007bb85570cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703221410.37767.tmaenner@aehr.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tried out the following u-boot "setting":
setenv ramargs setenv bootargs ramdisk_size=3D6144 root=3D/dev/ram console=
=3DttyCPM0=20
rw

No change; still no output in the console

Note that my module has 64MB, rather that 16; I thought it doesn't matter, =
or?

Thanks again for your help
Tom

On Thursday 22 March 2007 08:01, Thomas Maenner wrote:
> Thanks Wolfgang for your reply,
>
> You're right, I can not really tell, whether it's frozen since I don't
> have a BDM...
> I'll try the console command you suggested, which I haven't had to use
> before (U-boot 1.1.2 and older, Kernel 2.4, older ELDK)
>
> Thanks
> Tom
>
> On 3/22/07, Wolfgang Denk <wd@denx.de> wrote:
> > In message <200703212044.40611.tmaenner@aehr.com> you wrote:
> > > need from the experts on the list again.
> > > The CPU freezes after the ramdisk gets loaded!
> >
> > Does it really  freeze?  I  mean,  did  you  verify  this  witha  BDM
> > debugger,  or  do you just see no further output on the console? Note
> > that these are two fundamentally different things...
> >
> > > u-boot environment:
> > > =3D> printenv
> > > bootcmd=3Drun flash_self
> > > bootdelay=3D5
> > > baudrate=3D115200
> > > loads_echo=3D1
> > > preboot=3Decho;echo TQ-Module Bootloader for ABTS;echo Type "run
> > > flash_nfs" to mount root filesystem over NFS;echo
> > > netdev=3Deth0
> > > nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw
> > > nfsroot=3D${serverip}:${rootpath} addip=3Dsetenv bootargs ${bootargs}
> > > ip=3D${ipaddr}:${serverip}:${gatewayip}:
> > > ${netmask}:${hostname}:${netdev}:off panic=3D1
> > > flash_nfs=3Drun nfsargs addip;bootm ${kernel_addr}
> > > flash_self=3Drun ramargs addip;bootm ${kernel_addr} ${ramdisk_addr}
> > > net_nfs=3Dtftp 200000 ${bootfile};run nfsargs addip;bootm
> > > rootpath=3D/opt/eldk/ppc_8xx
> > > kernel_addr=3D40040000
> > > serial#=3DTQM860LDDBA3-P80.210 11090659
> > > ethaddr=3D00:D0:93:04:DC:1B
> > > eth1addr=3D00:D0:93:04:DC:1B
> > > ethprime=3DFEC ETHERNET
> > > bootfile=3D/TQM860L/uImage
> > > fileaddr=3D100000
> > > ramdisk_addr=3D40200000
> > > ramargs=3Dsetenv bootargs ramdisk_size=3D6144 root=3D/dev/ram rw
> > > initrd_high=3D30000000
> > > stdin=3Dserial
> > > stdout=3Dserial
> > > stderr=3Dserial
> > > ethact=3DFEC ETHERNET
> > > bootcount=3D39
> >
> > I don't see you passing any console=3DttyCPM0 argument here?
> >
> > Best regards,
> >
> > Wolfgang Denk
> >
> > --
> > DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
> > Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
> > Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> > Not one hundred percent efficient, of course ... but nothing ever is.
> >         -- Kirk, "Metamorphosis", stardate 3219.8

=2D-=20
Thomas Maenner
Engineering Project Manager
AEHR Test Systems
400 Kato Terrace
=46remont, CA 94539
Phone: =A0+1-510-623-9400x323
Cell: =A0 +1-925-389-6653
=46ax: =A0 =A0+1-510-623-9450
E-Mail: mailto:tmaenner@aehr.com
