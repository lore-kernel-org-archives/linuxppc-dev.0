Message-ID: <3B978E09.3A25E2CD@aps.anl.gov>
Date: Thu, 06 Sep 2001 09:54:01 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: =?iso-8859-1?Q?=C0=B1=B5=BF=BC=AE?= <manulsan@daintelecom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't run init... MPC8240
References: <004601c13710$d26abee0$2000a8c0@private>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


À±µ¿¼® wrote:
>
> I am working MPC8240 custom board with Sandpoint8240 BSP
> from MVista CDK 2.0 .   I think that I made something wrong.

Check that your installation of the Sandpoint LSP actually completed
without any errors - I found that the HHL-2.0 release had some problems
and many of the target binaries were not installed properly (the first
time through the install process it hung up, and although it appeared to
work the second time it didn't install all the packages that it should).
You can check this by doing an ls as follows, which from a (fully
installed) development host should look like this:

host$ ls /opt/hardhat/devkit/ppc/82xx/target/sbin
MAKEDEV*    ifdown*                 lsmod@       rmmod@
badblocks*  ifup*                   lspci*       route*
depmod*     init*                   mii-tool*    runlevel*
devfsd*     insmod*                 mke2fs*      setpci*
dumpe2fs*   insmod.static*          mkfs*        shutdown*
e2fsck*     insmod_ksymoops_clean*  mkfs.ext2*   slattach*
fdisk*      install-info*           mkswap*      sln*
fsck*       ipmaddr*                modinfo*     start-stop-daemon*
fsck.ext2*  iptunnel*               modprobe@    sulogin*
fsck.ext3*  kallsyms@               plipconfig*  swapoff@
fsck.nfs*   kbdrate*                pmap_dump*   swapon*
genksyms*   kernelversion*          pmap_set*    sysctl*
getty*      killall5*               portmap*     syslogd*
halt*       klogd*                  poweroff@    telinit@
hdparm*     ksyms@                  rarp*        tune2fs*
hwclock*    ldconfig*               reboot@      unix_chkpwd*
ifconfig*   losetup*                resize2fs*

If many of those files are missing from your installation then you have
the same problem, which explains why your target can't find /sbin/init.  I
modified the HardHat installation script and did some parts of the
installation manually, but I don't have my modified version any more.  I
don't know if MontaVista have developed a fix for this yet, but I did tell
them about it several months ago.

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
