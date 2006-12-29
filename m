Return-Path: <vsampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 2CA3BDDE28
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Dec 2006 12:02:22 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so3127851pyb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Dec 2006 17:02:21 -0800 (PST)
Message-ID: <758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>
Date: Thu, 28 Dec 2006 17:02:21 -0800
From: "Vijay Sampath" <vsampath@gmail.com>
To: "Reeve Yang" <yang.reeve@gmail.com>
Subject: Re: regarding kgdb in ppc
In-Reply-To: <198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

> >  I have checked all the above and are enabled in the config.  I have tried
> > changing the kernel command line argumnets.
> >
> >  I get the same error saying:  (All from init/main.c)
> >  ----
> >  unable to open an initial console
> >  No init found.  Try passing init= option to kernel.

You need to pass init=/path/to/initprogram and console=ttySx,9600n81
or something similar. This will however only work if you have
configured your root filesystem correctly. This could be a ramdisk,
harddisk partition, flash or nfs. The method for doing each is
different.

> >  I am getting the following error:
> >
> >  root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux
> >  GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
> >  ...
> >  This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux"...
> >  (gdb) set remotebaud 115200
> >  (gdb) target remote /dev/ttyS0
> >  Remote debugging using /dev/ttyS0
> >  Ignoring packet error, continuing...

This probably means that gdb on host could not communicate with the
gdb stub on target. To ensure target is running gdb stub, connect a
terminal program (example minicom on /dev/ttyS0) and ensure you are
getting output similar to this line: "$T0740:30300a00;01:c0621fb0;#45"

If you are getting this output, you should be able to close the
terminal program and connect gdb using the same serial port. If you
are not getting this output, then there could be many things wrong.
Did you try passing the kgdb=halt argument to the kernel.

Vijay
