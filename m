Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 72478DE0BA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 00:45:46 +1100 (EST)
Message-ID: <47E267E4.3070408@grandegger.com>
Date: Thu, 20 Mar 2008 14:34:28 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thomas_H=E4berle?= <thomas.haeberle@vipco.de>
Subject: Re: Xenomai on TQ MPC5200
References: <47E2620C.4020406@vipco.de>
In-Reply-To: <47E2620C.4020406@vipco.de>
Content-Type: multipart/mixed; boundary="------------050707030307000701090004"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050707030307000701090004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Thomas Häberle wrote:
> Hello!
> 
> My target hardware is a MPC5200 on a TQ STK52xx.
> I am developing in a Linked Setup with ELDK 3.1.1 under a Debian Linux
> (Release 2.6.18-4-686 ; gcc 4.1.2).
> The whole ELDK was already used in a former project with identical
> hardware and some early tests I ran showed that it works fine (as far as
> I can see).
> 
> My goal is to get a real time Linux OS running on the target (preferably
> Xenomai) and establish a RT ethernet connection with a identical
> hardware setup (planning to use RTnet). But I am somehow stuck in the
> first place for I can't get the kernel built:
> I tried quite a number of Kernel-Xenomai-Adeos-Version-combinations in
> the past four days without any actual success.
> 
> Yesterday I downloaded the Linuxppc_2_4_develop-sources from the GIT
> repository of the DENX site and set them to the exact point where the
> Adeos-Patch coming along with Xenomai 2.4.2 is build for (commit # ).
> The patch worked fine (ran trough), I configured the kernel and built
> the dependencies, but I am still unable to crosscompile the kernel and
> am also slowly running out of ideas.
> 
> I am relatively new to this part of the software world, so forgive me
> for my maybe basic questions:
> I found no explicit information on the web, whether Xenomai can be run
> on my specific target at all:
> Has anyone tried or knows something about that?
> Or where could I check whether it is (besides asking TQ of course)?
> Maybe the better way would be trying  with RTAI?
> Are there any known oddities of the STK52xx and/or MPC5200?
> Do I have to adapt my ELDK in any further way to get things going and
> using the DENX-sources (okay I guess this is hard to say without
> detailed information about my ELDK setup...)?
> Any other helpful experience, hints or tricks?

I have a STK52xx on my desk running Xenomai and RTnet under DENX Linux
2.4.25. I have attached my installation README. But your request is
off-topic here. Please switch to an appropriate list for further
questions, e.g. Xenomai-help of RTnet.

Wolfgang.

--------------050707030307000701090004
Content-Type: text/plain;
 name="README.rtnet"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.rtnet"

README on how to configure, build, install and use RTnet with Linux 2.4.25
==========================================================================

For cross development, please use the ELDK version 3.1.1. For further
information check http://www.denx.de/wiki/DULG/ELDK.

This README is for the TQM5200 evaluation board. I actually use an
EEPRO100 PCI NIC to boot Linux and mount the root file system via NFS.


Get and unfold sources:
-----------------------

  $ cd <work-dir>
  $ export WORKDIR=$PWD

- DENX Linux 2.4.25

  $ cd $WORKDIR
  $ git clone git://www.denx.de/git/linuxppc_2_4_devel.git
  $ export KERNELDIR=$PWD/linuxppc_2_4_devel

- Xenomai 2.3.5

  $ cd $WORKDIR
  $ wget http://download.gna.org/xenomai/stable/xenomai-2.3.5.tar.bz2
  $ tar xjf xenomai-2.3.5.tar.bz2
  $ export XENODIR=$PWD/xenomai-2.3.5

- RTnet SVN trunk (>= 0.9.10rc1):

  $ cd $WORKDIR
  $ svn co https://rtnet.svn.sourceforge.net/svnroot/rtnet/trunk
  $ export RTNETDIR=$PWD/trunk/rtnet


Configure, build and install kernel and user space binaries:
------------------------------------------------------------

- Required environment settings

  $ export CROSS_COMPILE=ppc_6xx-
  $ export DESTDIR=/opt/eldk/ppc_6xx

- Configure and build Xenomai patched kernel

  $ cd $KERNELDIR
  $ patch -p1 < <path>/linuxppc_2_4_devel-wait-event.patch
  $ patch -p1 < <path>/linuxppc_2_4_devel-fec.patch
  $ make TQM5200_config

  $ cd $XENODIR
  $ ./scripts/prepare-kernel.sh --linux=$KERNELDIR --arch=ppc --verbose

  $ cd $KERNELDIR
  $ make menuconfig
    ... check loadable module support ...
    ... disable FEC driver ...
    MPC5xxx I/O Options  --->
       [*] Use USE Motorola BestComm API Implementation
       [ ] FEC Ethernet
    ... enable EEPRO100 PCI driver ...
    Network device support  --->
       Ethernet (10 or 100Mbit)  --->
           [*]   EISA, VLB, PCI and on board controllers
           <*>     EtherExpressPro/100 support (eepro100, ...
    ... exit and save default configuration ...
  $ make dep
  $ make uImage
  $ cp -pv arch/ppc/boot/images/uImage /tftpboot

- Configure, build and install Xenomai user space stuff

  $ cd $XENODIR
  $ ./configure --host=ppc-linux --prefix=/root/xenomai
  $ make
  $ make install

- Configure, build and install RTnet

  $ cd $RTNETDIR
  $ patch -p1 < <path>rt-mpc52xx-fec.patch
  $ ./configure --host=ppc-linux \
    --with-linux=$KERNELDIR \
    --with-rtext-config=$DESTDIR/root/xenomai/bin/xeno-config \
    --disable-e1000 --disable-8139  --disable-8139too \
    --enable-mpc52xx-fec --enable-eepro100 \
    --prefix=/root/xenomai --enable-proxy
  $ make
  $ make install


Load, configure and run RTnet on the target:
--------------------------------------------

Check if the device file /dev/rtnet exists. If not, create it with:

  # mknod /dev/rtnet c 10 240

I use the following script to load the RTnet modules and to startup the
network:

  # cat load-rtnet
  export RTNET=/root/xenomai
  moddir=$RTNET/modules

  export PATH=$PATH:$RTNET/sbin:$RTNET/bin:$RTNET/examples/xenomai/posix
  export LD_LIBRARY_PATH=$RTNET/lib

  insmod -m $moddir/rtnet.o          >  /root/insmod.log
  insmod -m $moddir/rtipv4.o         >> /root/insmod.log
  insmod -m $moddir/rt_mpc52xx_fec.o >> /root/insmod.log

  rtifconfig rteth0 up 172.16.0.20
  rtroute solicit 172.16.0.1 dev rteth0

  rtifconfig
  rtroute

Then you can use "rtping" to check the connection:

  # rtping 172.16.0.1


Testing:
--------

For testing RTnet communication and response time, the example RTnet
applications rtt_sender and rtt_responder are quite useful. You can make
and install them as shown below:

  $ cd $RTNETDIR/examples/xenomai/posix/
  $ make
  $ make install

In $DISTDIR/rtt-examples are the corresponding programs for plain
Linux.

--------------050707030307000701090004--
