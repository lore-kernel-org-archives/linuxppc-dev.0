Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 3A270DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Dec 2006 22:27:41 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 0598E8780D7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Dec 2006 03:27:40 -0800 (PST)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r6cu032739-03-2
	for linuxppc-embedded@ozlabs.org; Sat, 30 Dec 2006 03:27:39 -0800
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id AD9768780D1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Dec 2006 03:27:39 -0800 (PST)
Message-ID: <45964D27.6020708@gmail.com>
Date: Sat, 30 Dec 2006 16:57:35 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Vijay Sampath <vsampath@gmail.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	
	<d16b1c80611300036x36ec0009r2eb20ebbc6966a97@mail.gmail.com>	
	<12c9fc1a0611300924r406e95acie5c2053c1433ab33@mail.gmail.com>	
	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	
	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	
	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	
	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	
	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	
	<458E384A.108@gmail.com>	
	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>
	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>
In-Reply-To: <758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vijay Sampath wrote:
>> >  I have checked all the above and are enabled in the config.  I 
>> have tried
>> > changing the kernel command line argumnets.
>> >
>> >  I get the same error saying:  (All from init/main.c)
>> >  ----
>> >  unable to open an initial console
>> >  No init found.  Try passing init= option to kernel.
>
> You need to pass init=/path/to/initprogram and console=ttySx,9600n81
> or something similar. This will however only work if you have
> configured your root filesystem correctly. This could be a ramdisk,
> harddisk partition, flash or nfs. The method for doing each is
> different.
>
>> >  I am getting the following error:
>> >
>> >  root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux
>> >  GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
>> >  ...
>> >  This GDB was configured as "--host=i386-redhat-linux 
>> --target=ppc-linux"...
>> >  (gdb) set remotebaud 115200
>> >  (gdb) target remote /dev/ttyS0
>> >  Remote debugging using /dev/ttyS0
>> >  Ignoring packet error, continuing...
>
> This probably means that gdb on host could not communicate with the
> gdb stub on target. To ensure target is running gdb stub, connect a
> terminal program (example minicom on /dev/ttyS0) and ensure you are
> getting output similar to this line: "$T0740:30300a00;01:c0621fb0;#45"
>
> If you are getting this output, you should be able to close the
> terminal program and connect gdb using the same serial port. If you
> are not getting this output, then there could be many things wrong.
> Did you try passing the kgdb=halt argument to the kernel.
>
> Vijay
>
Vijay, Thanks  for the reply.
But before trying these options i want to clear one more issue.
While booting the kgdb kernel the kernel claims "kgdb initialisation 
failure." I have observed it very lately.

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #2 Fri Dec 29 17:58:40 IST
2006
KGDB cannot initialize I/O yet.
Invalid syntax for option kgdb8250=
Malformed early option 'kgdb8250'
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw kgdbwait kgdb8250=0,115200
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)




I have changed the kgdb8250 arg to 1,0, but the result is same.
And ......
I have checked the serial cable NULL Mode connecting  x86 systems 
serially- with Cat and echo and this is fine.
When i try with Unpatched kernel on target and host(x86) - cat < 
/dev/ttyS0 doesnt wait  and returns to prompt.
I tried with 2.6.13 and 2.6.15.5 with resepective kgdb patches, but the 
result is same (kgdb Initialization failure). I am not sure where  am 
doing the mistake.
Please guide me in right way and also please let me know if any  more 
details are required.
Happy New Year in Advance.

Thanks
Sudheer
