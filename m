Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: hjzgq@sohu.com
Message-ID: <116411.1086934938680.JavaMail.postfix@mx27.mail.sohu.com>
Date: Fri, 11 Jun 2004 14:22:18 +0800 (CST)
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Re: Change FEC and SCC1 sequence,But SCC1 not work? 
Cc: <wd@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk:
       Thanks a lot!
       My bootargs is "setenv bootargs root=/dev/ram ip=10.32.5.17:10.32.5.15::255.255.0.0:bug
:::off"
       Today,I found fec device down when linux kernel running ,but I can see "eth1(fec ethernet)"  status with "ifconfig" command,I checked linux kernel and found fec device down when kernel running.

       After debugging,I found linux kernel close the device when  running "ip_auto_config()" function  in "net/ipv4/ipconfig.c",then, I deleted "ic_open_devs()" funtions, AND EVERYING
WORKS WELL!

      But why  do it be added to Linux kernel?

      Best regards,
      Michael.  Z.
-----  Original Message  -----
From: Wolfgang Denk
Subject: Re: Change FEC and SCC1 sequence,But SCC1 not work?
Sent: Fri Jun 11 01:17:56 CST 2004

> In message <5357004.1086858754080.JavaMail.postfix@mx27.mail.sohu.com> you wrote:
> >
> > Briefly, my platform is MPC860T from Motorola. I'm using ppcboot
> > 1.1.16 to tftp the kernel 2.4.4 through FEC and then load
> > NFS/RAMDISK. If I configure the kernel with only FEC, then
> > everything works well(NFS works and ping through eth0 works). If I
> > configure the kernel with both FEC(as eth0) and SCC1(as eth1),it
> > works well too,but when I configure ther kernel with both SCC1(eth0)
> > and FEC(as eth1) (net/setup.c)! . I try to ping out through
> > FEC(eth1), I get ring buffer dumps and no ping response:
>
> Please post the "Kernel command line" as printed when your kernel
> boots. You did include a network device parameter in your ip= boot
> argument, didn't you?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
