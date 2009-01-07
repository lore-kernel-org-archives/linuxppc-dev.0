Return-Path: <loko@el-kfa.net>
Received: from taurus.el-kfa.net (unknown [193.24.199.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1839DDFAE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 12:30:48 +1100 (EST)
Received: from localhost (unknown [193.24.199.40])
	by taurus.el-kfa.net (Postfix) with ESMTP id 4FF5B17021
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 02:02:24 +0100 (CET)
Received: from taurus.el-kfa.net ([193.24.199.40])
	by localhost (taurus.el-kfa.net [193.24.199.40]) (amavisd-new,
	port 10024) with ESMTP id fS+6UV0WGAxo for <linuxppc-dev@ozlabs.org>;
	Wed,  7 Jan 2009 02:02:00 +0100 (CET)
Date: Wed, 7 Jan 2009 02:02:00 +0100
From: "Pawel P. Kusmierski" <loko-r@el-kfa.net>
To: linuxppc-dev@ozlabs.org
Subject: Linux on Memec Virtex4 FX12 Minimodule
Message-ID: <20090107010200.GA89569@taurus.el-kfa.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="posting-ppc-devel.txt"

Dear friends,

I have a following problem:
I'm trying to boot linux kernel on a PowerPC405 inside a Virtex4 FX12
sitting on an Avnet/Memec FX12 Mini Module plugged into its mother board.
I was able to go as far as booting the kernel, mounting a nfs root,
as well as an ext2 one sitting on a sysace CF.
The problem is that the kernel stops outputting the following line:

Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

Now, I know the init is being found, both in ext2 and nfs setup, has the
right rights, and all. I tried supplying a simple printf C program as
init, even an assembly one, with one stupid syscall to write out a line,
with the very same effect.
I edited the init/main.c file around the run_init_process(), and modified it
to analyse the kernel_execve return value. The effects are:

Freeing unused kernel memory: 104k init
Failed to execute /sbin/init: -2 <4>: No such file or directory.
Failed to execute /etc/init: -14 <4>: Bad address.
Failed to execute /bin/init: -14 <4>: Bad address.
Failed to execute /bin/sh: -14 <4>: Bad address.
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

and after I deleted /sbin/init the effects were:

Failed to execute /sbin/init: -2 <4>: No such file or directory.
Failed to execute /etc/init: -2 <4>: No such file or directory.
Failed to execute /bin/init: -14 <4>: Bad address.
Failed to execute /bin/sh: -14 <4>: Bad address.

The interesting thing is, that in both cases /bin/init does not exist,
and /etc/init does.

Now am I searching already too low or yet too high?
I put my kernel configs, dmesgs and xparameters.h here:
http://keymaster.el-kfa.net/~loko/linux-ppc/

My kernel is pulled from git://git.xilinx.com/linux-2.6-xlnx.git
I'm using ARCH=ppc in the makefile and building both the kernel
and the apps (including the buildroot on the nfs and sysace)
using the same crosstool setup, gcc-3.4.5-glibc-2.3.6.

Many thanks in advance for your help.
-- 
Pawel Kusmierski
loko-r a.t el-kfa.net


--sm4nu43k4a2Rpi4c--
