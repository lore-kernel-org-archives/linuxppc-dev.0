Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FAFB212.CFB06600@integrinautics.com>
Date: Mon, 10 Nov 2003 07:43:14 -0800
From: Dave Lawrence <dgl@integrinautics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC5200LITE U-boot/Linux howto
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MPC5200LITE U-boot/Linux howto

Written: Oct. 31 2003

Scope: This howto is intended to be a step-by-step process for bringing
up an MPC5200LITE evalutation board (AKA IceCube) with U-Boot and
Linux without overwriting the dBUG loader that comes with the board.
In the process outlined here, U-boot isn't written to flash at all...
you need to load it into RAM every time you boot.

An alternative solution which has become available in the meantime is
to configure U-Boot in a boot-low setup which allows the  coexistence
of  dBUG  (at  the  upper  end of the flash) and U-Boot (at the lower
end). Wolfgang Denk  posted the necessary information to both the PPC
and  U-Boot mailing lists.  Search the lists for
MPC5200LITE_LOWBOOT_config
for details on this solution.

Prerequisites:
Some familiarity with Linux.
an x-86 linux desktop (mine is redhat9)

Disclaimer:  This howto was written by a novice.  Use at your own risk.
You could permanantly damage your MPC5200LITE and/or your desktop.

Connect a serial port on your desktop to the DB9 serial header
on your MPC5200 board using a "null modem" cable.

Configure the "cu" program on your desktop for serial communication
at 9600 (the default MPC5200 baud rate) and 115200 (the default U-boot
baud rate).  Assuming you're using ttyS0, edit /etc/uucp/sys and
/etc/uucp/port to look something like mine:

# cat /etc/uucp/sys

system          S0@9600
port            serial0_9600
time            any

system          S0@115200
port            serial0_115200
time            any

# cat /etc/uucp/port

port            serial0_9600
type            direct
device          /dev/ttyS0
speed           9600
hardflow        false

port            serial0_115200
type            direct
device          /dev/ttyS0
speed           115200
hardflow        false

#################################
Then type:
cu S0@9600

Next, power up your MPC5200LITE and you should see a "dBUG> " prompt.
You can enter "show" to see the default setup.  Write down these
defaults.

>From here on, I'm assuming your desktop IP address is 192.168.116.67
and your MPC5200 will be configured to be 192.168.117.24.  In this
case, set the new values from dBUG:

set server 192.168.116.67
set client 192.168.117.24
set netmask 255.255.254.0

Next, change the baud rate:

set baud 115200

At this point, your desktop will be at the wrong baud rate.
Unplug the null modem cable (probably optional) and type
~.
with no return.  cu should disconnect.

reconnect cu at 115200:
cu S0@115200
Then plug your null modem back in.

Then enter "show" to see the current settings.  So far, none
of the changes are permanent.  You can enter "store" to save
the new configuration.  From then on, your MPC5200 will default
to 115200 baud.

Next, obtain the following three things:

The latest release of ELDK (2.1.0 at the time this was written).
You can purchase this on CD or download it.

The linuxppc_2_4_mpc5200 kernel source directory from CVS

U-boot from CVS


To download them:
#U-boot
cd ~
cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/u-boot login
(no password)
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/u-boot co
u-boot

#Linux
cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
(no password)
cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co -P
linuxppc_2_4_mpc5200

#Get release of ELDK
ncftp ftp://ftp.leo.org/pub/eldk/2.1.0/
bin
get -R eldk-ppc-linux-x86
bye

#Start bash shell if that's not what you already use
bash

#change permissions
for file in \
       tools/bin/rpm \
       tools/usr/lib/rpm/rpmd \
       install \
       ELDK_MAKEDEV \
       ELDK_FIXOWNER
 do
 chmod +x eldk-ppc-linux-x86/$file
done

#Make an ISO image of ELDK
mkisofs \
 -A "ELDK-2.1 -- Target: PowerPC -- Host: x86 Linux" \
 -P "(C) `date "+%Y"` DENX Software Engineering,   www.denx.de" \
 -p "`id -nu`@`hostname` -- `date`" \
 -V eldk-ppc-linux-x86 \
 -l -J -R -o eldk-ppc-linux-x86.ISO eldk-ppc-linux-x86

#burn, then mount CD, or mount the image using loopback
#(you'll probably have to be root to do these steps)
#the details of how to do this are beyond the scope of this howto,
#but here's what I did:

cdrecord -v speed=8 dev=0,0,0  -data eldk-ppc-linux-x86.ISO
mount /dev/cdrom /mnt/cdrom

#or for the loopback alternative
mount -o loop eldk-ppc-linux-x86.ISO /mnt/cdrom

#make a directory to install eldk (again probably requires root
permissions)
mkdir -k /opt/eldk

#change permissions of eldk directory
chmod a+rw /opt/eldk

#Install eldk (don't need to be root for this step)
/mnt/cdrom/install -d /opt/eldk ppc_82xx

#Need to be root for a while
#Make root devices so opt/eldk/ppc_82xx can be the NFS root of your
target
cd /opt/eldk/ppc_82xx/dev
/mnt/cdrom/ELDK_MAKEDEV

cd /opt/eldk
/mnt/cdrom/ELDK_FIXOWNER

#while you're root, prepare tftp sever for later

chmod a+rw /tftpboot

#Create or edit /etc/xinetd.d/tftp to look something like:
service tftp
{
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        user                    = root
        server                  = /usr/sbin/in.tftpd
        server_args             = -s /tftpboot
        disable                 = no
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}
#(all I did was change disable from yes to no)

#Restart the xinetd
/etc/rc.d/init.d/xinetd restart

#Add /opt/eldk/ppc_82xx to /etc/exports so it can be NFS root of your
target
#The details of how to do this are beyond the scope of this howto, but
#my exports looks like:
/opt/eldk/ppc_82xx      192.168.117.24(rw,no_root_squash)

#(re)start NFS services
/etc/rc.d/init.d/nfs restart

#No longer need to be root
#Set CROSS_COMPILE environment variable for u-boot and linux compilation
export CROSS_COMPILE=ppc_82xx-

#Add the new ELDK bin directories to your path
export PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin

#The next step allows you to play with u-boot without permanently
messing
#with your MPC5200LITE flash.

#edit ~/u-boot/board/icecube/config.mk
#uncomment the line "#TEXT_BASE = 0x0010000"
#and comment the line "TEXT_BASE = 0xfff00000"

#configure and compile u-boot
cd ~/u-boot
make distclean
make IceCube_5200_config
make all

#inspect u-boot.srec and make sure it's destined for RAM
more  u-boot.srec
S00E0000752D626F6F742E73726563C0
S21410000000000000000000000000000000000000DB
S21410001000000000000000000000000000000000CB
#note that it is to be loaded at 0x100000, which is in RAM
#copy u-boot.srec so it's accessible to tftp
cp u-boot.srec /tftpboot

# Compile Linux
cd ~/linuxppc_2_4_mpc5200
make mrproper
make icecube_5200_config
make oldconfig
make dep
make uImage
#copy linux kernel image so it's accessible to tftp
cp arch/ppc/boot/images/uImage /tftpboot

#Now you're ready to download u-boot and linux to your MPC5200LITE
#go back to (or restart) your "cu" session
#at the dBUG> prompt, enter:
dn -s u-boot.srec
dn -i uImage -o 300000

#start U-boot (dunno why but I had to add 0x100)
go 100100

#You should get the U-boot prompt

setenv bootargs root=/dev/nfs rw
nfsroot=192.168.116.67:/opt/eldk/ppc_82xx
ip=192.168.117.24:192.168.116.67:192.168.116.67:255.255.254.0:r2d2::off
init=/bin/bash

#boot the linux kernel
bootm 300000

#here endeth the lesson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
