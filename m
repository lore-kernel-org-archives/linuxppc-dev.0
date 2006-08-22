Return-Path: <philn@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7FBB67BDE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 17:41:55 +1000 (EST)
Received: from caxton.int.avalon.com.au (caxton.int.avalon.com.au
	[192.168.1.14])
	by camden.avalon.com.au (8.13.1/8.13.1) with ESMTP id k7M7f9K2010984
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Aug 2006 17:11:09 +0930
Subject: ioremap() fails for >64 MB
From: Phil Nitschke <philn@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 22 Aug 2006 17:11:09 +0930
Message-Id: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
Mime-Version: 1.0
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
of it at boot-time, then ioremap() it into the kernel space inside a
device driver.  So far I've succeeded with 64 MB, but can't go any
higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
space - use vmalloc=<size> to increase size."

So I tried adding a vmalloc line to the kernel command line as follows:
Kernel cmd line: root=/dev/nfs rw mem=1920M vmalloc=1024M nfsroot=... 

After booting the processor, here is my memory arrangement:

bash-3.00# cat /proc/meminfo 
MemTotal:      1943232 kB
MemFree:       1910508 kB
...
HighTotal:     1179648 kB
HighFree:      1154608 kB
LowTotal:       763584 kB
LowFree:        755900 kB
...
VmallocTotal:   145024 kB
VmallocUsed:     65944 kB
VmallocChunk:    78972 kB

After inserting my device driver module (which ioremap()s 64 MB),
meminfo is as follows:

bash-3.00# cat /proc/meminfo 
MemTotal:      1943232 kB
MemFree:       1916512 kB
...
HighTotal:     1179648 kB
HighFree:      1160748 kB
LowTotal:       763584 kB
LowFree:        755764 kB
...
VmallocTotal:   145024 kB
VmallocUsed:    133568 kB
VmallocChunk:    10364 kB

So the vmalloc=<size> argument has made no difference.  What do I need
to do to make this work?

TIA,

-- 
Phil

bash-3.00# uname -a
Linux arty9 2.6.16-pmppc744x #211 Fri Aug 18 19:03:36 CST 2006 ppc ppc
ppc GNU/Linux
