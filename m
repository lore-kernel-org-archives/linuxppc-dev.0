Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 7EF94DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Dec 2006 19:43:25 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 41BB18780A3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Dec 2006 00:20:33 -0800 (PST)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r6co002033-01-2
	for linuxppc-embedded@ozlabs.org; Sun, 24 Dec 2006 00:20:33 -0800
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 01AB7878096
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Dec 2006 00:20:32 -0800 (PST)
Message-ID: <458E384A.108@gmail.com>
Date: Sun, 24 Dec 2006 13:50:26 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: kernelnewbies@nl.linux.org
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	
	<12c9fc1a0611292033p1c0ae010iadcf6afdd4a549ce@mail.gmail.com>	
	<d16b1c80611300036x36ec0009r2eb20ebbc6966a97@mail.gmail.com>	
	<12c9fc1a0611300924r406e95acie5c2053c1433ab33@mail.gmail.com>	
	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	
	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	
	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	
	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>
	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>
In-Reply-To: <12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------030000070102070006090606"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030000070102070006090606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All

> Hi Shakti
>
>     > Then executed the command mkinird and copied and added  initrd
>     in the
>     > grub.conf - situation is same.
>     > I changed the root parameter to LABEL=/ - situation is same.
>
>     Basically, block device, initrd support for ramdisk should be enabled:
>       CONFIG_BLK_DEV_RAM
>       CONFIG_BLK_DEV_INITRD
>
>     Double check your .config file.
>
>
> I have checked all the above and are enabled in the config.  I have 
> tried changing the kernel command line argumnets.
>
> I get the same error saying:  (All from init/main.c)
> ----
> unable to open an initial console 
> No init found.  Try passing init= option to kernel.
-----
I am able to debug the kernel on x86 systems. Thanks for all the support.

Now I am working with  kgdb on mpc8540 board.
target kernel version - linux-2.6.13
KGDB version - linux-2.6.13-kgdb-2.3

I am getting the following error:

root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux
GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
...
This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux"...
(gdb) set remotebaud 115200
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
Ignoring packet error, continuing...

On the target side, i could see that the target kernel kgdb waiting for 
host communication.

On the target board with  kernel version - linux-2.6.13 , I could boot 
it only after applying the patches:
1. Gain_Phy_update
2.patch-2.6.14-rc5
3.Phy_Platform_Update
The patch-2.6.14-rc5  when applied , deleted the file  
arch/ppc/platforms/pcore.c and
pcore.h but the kernel boots well.

In the KGDB version - linux-2.6.13-kgdb-2.3
The ppc-lite.patch tries to modify the pcore.c which is not available.

I am not sure wether this affects the serial communication establishment.

Please help me to solve this.

Thanks
Sudheer







--------------030000070102070006090606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello All<br>
<br>
<blockquote
 cite="mid12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com"
 type="cite">Hi Shakti<br>
  <br>
  <div><span class="gmail_quote"></span>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;
Then executed the command mkinird and copied and added&nbsp;&nbsp;initrd in the
    <br>
&gt; grub.conf - situation is same.<br>
&gt; I changed the root parameter to LABEL=/ - situation is same.<br>
    <br>
Basically, block device, initrd support for ramdisk should be enabled:<br>
&nbsp;&nbsp;CONFIG_BLK_DEV_RAM<br>
&nbsp;&nbsp;CONFIG_BLK_DEV_INITRD
    <br>
    <br>
Double check your .config file.
    <br>
  </blockquote>
  </div>
  <br>
I have checked all the above and are enabled in the config.&nbsp; I have
tried changing the kernel command line argumnets. <br>
  <br>
I get the same error saying:&nbsp; (All from init/main.c)<br>
----<br>
unable to open an initial console&nbsp; <br>
No init found.&nbsp; Try passing init= option to kernel.<br>
</blockquote>
-----<br>
I am able to debug the kernel on x86 systems. Thanks for all the
support.<br>
<br>
Now I am working with&nbsp; kgdb on mpc8540 board.<br>
target kernel version - linux-2.6.13<br>
KGDB version - linux-2.6.13-kgdb-2.3<br>
<br>
I am getting the following error:<br>
<br>
root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux<br>
GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)<br>
...<br>
This GDB was configured as "--host=i386-redhat-linux
--target=ppc-linux"...<br>
(gdb) set remotebaud 115200<br>
(gdb) target remote /dev/ttyS0<br>
Remote debugging using /dev/ttyS0<br>
Ignoring packet error, continuing...<br>
<br>
On the target side, i could see that the target kernel kgdb waiting for
host communication.<br>
<br>
On the target board with&nbsp; kernel version - linux-2.6.13 , I could boot
it only after applying the patches:<br>
1. Gain_Phy_update<br>
2.patch-2.6.14-rc5<br>
3.Phy_Platform_Update<br>
The patch-2.6.14-rc5&nbsp; when applied , deleted the file&nbsp;
arch/ppc/platforms/pcore.c and<br>
pcore.h but the kernel boots well.<br>
<br>
In the KGDB version - linux-2.6.13-kgdb-2.3<br>
The ppc-lite.patch tries to modify the pcore.c which is not available.<br>
<br>
I am not sure wether this affects the serial communication
establishment.<br>
<br>
Please help me to solve this.<br>
<br>
Thanks<br>
Sudheer<br>
<br>
<br>
<br>
<br>
<br>
<br>
</body>
</html>

--------------030000070102070006090606--
