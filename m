From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: "Sylvain Munaut" <tnt@246tnt.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on MPC5200 - LITE5200EVAL 
Date: Wed, 11 Feb 2004 15:48:36 +1100
Message-ID: <002301c3f05a$4f971490$4000a8c0@ANDREWDT3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040210220007.54753C1215@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message <40294AD9.1070407@246tNt.com> you wrote:
> >
> > I've just received the motorola eval board ( one, with 64M SDR and 16Mb
> > flash). And I'm a little lost.
> > I've tool u-boot sources from CVS compiled them ( compiled fine exect
> > for the samples apps ), then took the appropriate kernel sources, build
> > it ( make uImage ). And .... then ?
>
> Either use the default configuration of U-Boot and replace  dBUG,  or
> use  the  "LOWBOOT"  configuration and install U-Boot at the start of
> the flash area.
>
> Then use U-Boot to load and boot Linux.
>
> > I haven't found any "manual" or so.
>
> There is the DULG - there is no  LITE5200  specific  version  of  the
> document (yet), but it should get you started.
> See http://www.denx.de/twiki/bin/view/DULG/Manual
>
> Best regards,
>
> Wolfgang Denk
>

I installed and browsed the Montavista BSP for the MPC5200LITE as a starting
point. So far the best documentation I've found is the source for their
deploy script...

You can extract specific examples of dBUG and u-boot command sequences from
there - both for installing u-boot LOW and booting linux.

The following worked for me to get u-boot going:
$cd u-boot
$make MPC5200LITE_LOWBOOT_config
$make CROSS_COMPILE=/path/to/bin/powerpc-linux-
$su -c "cp u-boot.bin /tftpboot"

#dBUG commands to load u-boot via tftp
set mac 00:01:AF:52:01:xx # see MPC5200LITE doco for how to choose xx value
set client lite.ip.address
set server tftpserver.ip.address
set netmask your.netmask
dn -i -o 0x100000 /tftpboot/u-boot.bin
fe 0xff000000 0xff050000
fp 0xff000000 0xff040000 0x100000
#power off and change link to boot low
#power up to u-boot

I've currently configured u-boot to load my kernel via bootp and nfs mount a
root filesystem built with buildroot (see uclibc.org). I did this as follows
(nfsargs line will wrap):

setenv ethaddr 00:01:af:52:01:xx
setenv nfsargs setenv bootargs root=/dev/nfs
nfsroot=\$\(serverip\):/tftpboot/\$\(ipaddr\) console=ttyS0,115200
ip=\$\(ipaddr\):\$\(serverip\):\$\(gatewayip\):\$\(netmask\):\$\(hostname\):
\$\(netdev\):off
setenv bootdelay 2
setenv bootcmd bootp\; run nfsargs\; bootm
saveenv

read u-boot wiki to do it differently:)

NOTE: if you have a Version 2.0 board and want 16MiB flash to actually work
you should ensure J24 is in the 2-3 position (J24 is a 0R resistor on the
bottom of the board).
It is stupid for the jumper to be in the 1-3 position when 16MiB is loaded
but that is the way my board was. Seems like a manufacturing error:(

Andrew


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
