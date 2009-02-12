Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (stargate.chelsio.com [12.22.49.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 301CCDDDAA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 12:36:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AMCC ppc440spe 2.6.23.10 kernel boot help
Date: Wed, 11 Feb 2009 17:36:52 -0800
Message-ID: <8A71B368A89016469F72CD08050AD33402D57545@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang=20

Thanks for quick response.=20

I am kind of helpless regarding the kernel version, as our customer is
using it and I need to replicate their environment. I just tried 2.6.28
with katmai_defconfig file and still face the same problem.=20

The config file that I sent before is provided by the customer. It is a
working configuration for them.=20

The exact board that I have is Katmai.

I verified that I am using serial port 0. I tried to set bootargs to
just console=3DttyS0,115200 and I don't see the kernel booting. =
Everything
in env variables seems ok to me unless something trivial is missing my
eyes.=20

My sequence for boot is=20
=3D>tftp 0x1000000 uImage-ppc
=3D> run flash_nfs (I have done this manually also)=20

my printenv output is as follows.

Thanks for your help
Shubhada

-----------------------------------------------------------------
bootdelay=3D5
baudrate=3D115200
loads_echo=3D1
netdev=3Deth0
addtty=3Dsetenv bootargs ${bootargs} console=3DttyS0,${baudrate}
net_nfs=3Dtftp 200000 ${bootfile};run nfsargs addip addtty;bootm
initrd_high=3D30000000
load=3Dtftp 200000 katmai/u-boot.bin
update=3Dprotect off fffc0000 ffffffff;era fffc0000 ffffffff;cp.b
${fileaddr} fffc0000 ${filesize};setenv filesize;saveenv
upd=3Drun load;run update
kozio=3Dbootm ffc60000
loadkernel=3Dfatload ace 0 0x1000000 /mnt-xsa/kernel.img
loadramdisk=3Dfatload ace 0 0x3000000 /mnt-xsa/ramdisk.img
ramargs=3Dsetenv bootargs ramdisk=3D65536 root=3D/dev/ram rw
ramdisk_addr=3D0x3000000
preboot=3Decho;echo Type "run flash_nfs" to mount root filesystem over
NFS;echo
bootcmd=3Drun loadkernel;run loadramdisk;run flash_self
ethact=3Dppc_4xx_eth0
fixedip=3Decho Using IP address ${ipaddr}
addip=3D${fixedip}
setip=3Dsetenv bootargs ${bootargs}
ip=3D${ipaddr}:${severip}:${gatewayip}:${netmask}:${hostname}:${netdev}:o=
f
f panic=3D1
flash_self=3Drun ramargs addip setip addtty;bootm ${kernel_addr}
${ramdisk_addr}
dynip=3Dsetenv autoload n;dhcp
flash_nfs=3Drun nfsargs addip setip addtty;bootm ${kernel_addr}
ethaddr=3D00:01:73:77:56:64
hostname=3Dppcb1
gw=3D10.192.160.1
net_nfs=3Dtftp 200000 ppc-2.6.23.10
severip=3D10.192.165.106
kerel_addr=3D0x100000
kernel_addr=3D0x1000000
filesize=3D1136BB
fileaddr=3D1000000
gatewayip=3D10.192.160.1
netmask=3D255.255.240.0
ipaddr=3D10.192.164.166
serverip=3D10.192.165.106
rootpath=3D/opt/eldk4.1/ppc_4xx
nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw
nfsroot=3D10.192.165.106:/opt/eldk4.1/ppc_4xx
bootfile=3DuImage-ppc
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial
ver=3DU-Boot 1.3.1-gc1d16334 (Jan  9 2008 - 11:26:13)
bootargs=3Droot=3D/dev/nfs rw =
nfsroot=3D10.192.165.106:/opt/eldk4.1/ppc_4xx
ip=3D10.192.164.166:10.192.165.106:10.192.160.1:255.255.240.0:ppcb1:eth0:=
o
ff console=3DttyS0,115200

Environment size: 1770/16379 bytes

------------------------------------------------------------------------
--




-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]=20
Sent: Wednesday, February 11, 2009 3:56 PM
To: Shubhada Pugaonkar
Cc: linuxppc-dev@ozlabs.org
Subject: Re: AMCC ppc440spe 2.6.23.10 kernel boot help

Dear "Shubhada Pugaonkar",

In message
<8A71B368A89016469F72CD08050AD33402D57544@maui.asicdesigners.com> you
wrote:
>=20
> I am trying to bringup AMCC ppc440sPE  board with 2.6.23.10 kernel
from

2.6.23.10 is very old. Please use current code. 2.6.23 was long before
the switch to arch/powerpc, so all the efforts you are spnding now on
this old stuff are really wasted.

Use at least 2.6.28 or later.

> kernel.org. My .config file is attached. I used ARCH=3Dppc and

Why don't you start with a good, known to work kernel config file
like 44x/katmai_defconfig ?

For example, you mention a 440SPe processor above, but your config
file seems to be derived from a Luan board, which is 440SP (not SPe)
so there is not much surprise if it doesn't work.


> CROSS_COMPILE=3Dppc-linux- (also tried ppc_4xx-) and did 'make =
uImage',
> but unable to boot into the kernel. My nfs and uboot settings seem to
be
> correct. The kernel gets stuck as shown below. Any help appreciated.
> Please let me know if any more information is required.

In the first place, please use current code.

Second - which exact board is this? Katmai?

> =3D> run flash_nfs

What exactly are your environment settings? Which exact value of
"bootargs" do you pass to Linux? Does it include a valid console=3D
argument?


Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"If you'll excuse me a minute, I'm going to have a cup of coffee."
- broadcast from Apollo 11's LEM, "Eagle", to Johnson  Space  Center,
Houston July 20, 1969, 7:27 P.M.
