Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0785A67B2F
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 06:49:49 +1000 (EST)
To: jagadeesh kalisetty <jagadeesh.k@rediffmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: help requesting for mounting eldk tools on AMCC PPC 405EP Taihu
	kit
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "18 Jun 2006 15:23:44 -0000."
	<20060618152344.13300.qmail@webmail18.rediffmail.com>
Date: Sun, 18 Jun 2006 22:49:46 +0200
Sender: wd@denx.de
Message-Id: <20060618204946.96E93352655@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20060618152344.13300.qmail@webmail18.rediffmail.com> you wrote:
> 
> but the kernel is failed to mount on /dev/nfs as below please can you
> provide necessary steps to fix the problem.
...
> => setenv setboot setenv bootargs root=/dev/pts nfsroot=192.168.2.18:/opt/eldk/ppc_4xx ip=192.168.1.62:::::eth0:off

What's /dev/pts? You mentioned you intended to use NFS as  root  file
system. Then I'd expect to see /dev/nfs here. [Note: 'n' != 'p']

> bootcmd=run setboot;bootm 0xfc000000 0xfc300000

You mentioned you intended to use NFS as root file system.  Then  why
do you use a ramdisk?

> ## Loading RAMDisk Image at fc300000 ...
>    Image Name:   Taihu Ramdisk
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    15447973 Bytes = 14.7 MB

Your ramdisk image is much bigger than  the  default  maximum  kernel
ramdisk  size (4 MB). But you don't pass any ramdisk size information
with your boot arguments:

> Kernel command line: root=/dev/pts nfsroot=192.168.2.18:/opt/eldk/ppc_4xx ip=192.168.1.62:::::eth0:off

If you really want to use this  ramdisk,  you  should  set  the  root
device and the ramdisk size appropriately.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
NOTE: The  Most  Fundamental  Particles  in  This  Product  Are  Held
Together  by  a  "Gluing" Force About Which Little is Currently Known
and Whose Adhesive Power Can Therefore Not Be Permanently Guaranteed.
