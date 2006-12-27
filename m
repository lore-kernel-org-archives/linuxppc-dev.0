Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 7EE95DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Dec 2006 01:18:47 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 1B31C8780D3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Dec 2006 06:18:45 -0800 (PST)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r6cr061845-00-2
	for linuxppc-embedded@ozlabs.org; Wed, 27 Dec 2006 06:18:45 -0800
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D2C898780C2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Dec 2006 06:18:44 -0800 (PST)
Message-ID: <459280BD.40103@gmail.com>
Date: Wed, 27 Dec 2006 19:48:37 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>		<12c9fc1a0611292033p1c0ae010iadcf6afdd4a549ce@mail.gmail.com>		<d16b1c80611300036x36ec0009r2eb20ebbc6966a97@mail.gmail.com>		<12c9fc1a0611300924r406e95acie5c2053c1433ab33@mail.gmail.com>		<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>		<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>		<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>		<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>
	<458E384A.108@gmail.com>
In-Reply-To: <458E384A.108@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


Hello All
> I am able to debug the kernel on x86 systems. Thanks for all the support.
>
> Now I am working with  kgdb on mpc8540 board.
> target kernel version - linux-2.6.13
> KGDB version - linux-2.6.13-kgdb-2.3
>
> I am getting the following error:
>
> root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux
> GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
> ...
> This GDB was configured as "--host=i386-redhat-linux 
> --target=ppc-linux"...
> (gdb) set remotebaud 115200
> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> Ignoring packet error, continuing...
>
> On the target side, i could see that the target kernel kgdb waiting 
> for host communication.
>
> On the target board with  kernel version - linux-2.6.13 , I could boot 
> it only after applying the patches:
> 1. Gain_Phy_update
> 2.patch-2.6.14-rc5
> 3.Phy_Platform_Update
> The patch-2.6.14-rc5  when applied , deleted the file  
> arch/ppc/platforms/pcore.c and
> pcore.h but the kernel boots well.
>
> In the KGDB version - linux-2.6.13-kgdb-2.3
> The ppc-lite.patch tries to modify the pcore.c which is not available.
>
> I am not sure wether this affects the serial communication establishment.
>
> Please help me to solve this.
I am using the document kgdb_docu_full_2.4.pdf from  
http://kgdb.linsyssoft.com/docu.htm.
I have two issues before i look for serial communication establishment 
b'n host and target.

1.
In the document it is said that one serial port is enough on the the 
host and test machine. But in the below steps mentioned, the document 
uses 2 serial ports. I have only one serial port on either side, one on 
host and other on target board.

Can someone please clarify this.

Details are below:
In the document it is mentioned under the section "Prepare the kernel ",

step 3 :
[*] Simple selection of KGDB serial port
(115200) Debug serial port baud rate
(0) Serial port number for KGDB

step:6
kernel /boot/vmlinuz-2.6.13-kgdb ro root=/dev/hda1 kgdbwait 
kgdb8250=1,115200

In section: "Connecting to Debug Kernel"
step :1
$ stty ispeed 115200 ospeed 115200 < /dev/ttyS1

step:4
Connect to the test machine using gdb command "target"
(gdb) target remote /dev/ttyS0

2. And the other issue is:

When i select ttyS0 for kgdb , test kernel hangs before kgdb starts.
- - - - - - - - -
.
.
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
- - - - - - - - -
when is select ttyS1 for kgdb, test kernel boots upto kgdb and then 
kgdb  waits for remote connection.


Please help me in solving this.

Thanks
Sudheer
