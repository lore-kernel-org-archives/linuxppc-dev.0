Return-Path: <vsampath@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id E8FCE67C65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 04:26:32 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so123957nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 09:26:31 -0800 (PST)
Message-ID: <758a2bbf0612130926w56d468dejf0e8e51c918d2175@mail.gmail.com>
Date: Wed, 13 Dec 2006 09:26:31 -0800
From: "Vijay Sampath" <vsampath@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem porting linux 2.6 on IBM405EP based boards
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to port a timesys reference kernel based on 2.6.16 to our
IBM 405 EP based board. I enabled early console print and some debug
prints, and after initial configuration, snippet A below is as far as
the bootup got.

Then in head_4xx.S, I commented out the tlbia instruction (right before jump
to start_kernel). This was not because I knew what I was
doing, but the debugger indicated that I was having a TLB exception,
and that is how the code is in our working 2.4 port of the kernel.

After this, the code started executing start_kernel, but stopped
shortly thereafter (snippet B). After this every time I press a key,
the following line gets printed:

$T0740:30300a00;01:c0621fb0;#45

Its possible that I have something configured wrong, but
any guidance on what that message could possibly mean would be
appreciated. Also any information on how the tlbia instruction was
working on other platforms would also help.

Thanks,

Vijay


========snippet A======================
Transfering control to downloaded image at [0x400000]
loaded at:     00400000 00612134
zimage at:     0040582D 00524D87
initrd at:     00525000 0060FBA5
avail ram:     00613000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit

========snippet B======================
Transfering control to downloaded image at [0x400000]
loaded at:     00400000 00612134
zimage at:     0040582D 00524D87
initrd at:     00525000 0060FBA5
avail ram:     00613000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
paging: exit
tb_ticks_per_jiffy: 512000


$T0740:30300a00;01:c0621fb0;#45
