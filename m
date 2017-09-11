Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrLvR6ZbgzDrZf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 18:39:31 +1000 (AEST)
Received: from [192.168.1.134] (ppp-188-174-78-194.dynamic.mnet-online.de
 [188.174.78.194]) by smtp.strato.de (RZmta 41.4 DYNA|AUTH)
 with ESMTPSA id D010cdt8B8XRF02
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 11 Sep 2017 10:33:27 +0200 (CEST)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Hardware 3D acceleration doesn't work anymore after the PowerPC
 updates 4.14-1
Message-ID: <421109ac-41f8-f332-068b-8884cf7322b6@xenosoft.de>
Date: Mon, 11 Sep 2017 10:33:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I tested the latest Git kernel version with the new PowerPC updates 
4.14-1 [0][1] on my Varisys Cyrus Plus board (A-EON AmigaOne X5000) 
[2][3] with a Qoriq P5020 PowerPC CPU from NXP yesterday. Unfortunately 
the hardware 3D acceleration doesn't work anymore since the PowerPC 
updates 4.14-1 [0]. I tested it with ubuntu MATE 16.04.3 LTS PowerPC 
(64-bit kernel and 32-bit userland) and with the MATE PowerPC Remix 2017 
(64-bit kernel and 32-bit userland) [4]. I reduced the RAM to 3.5GB via 
kernel boot arguments but without any success. (mem=3500M)

On my Varisys Nemo board (A-EON AmigaOne X1000) [5], the hardware 3D 
acceleration works without any problems with the new PowerPC updates 
4.14-1 [0][1]. It also works with the Git version from Thu Sep 07, 2017 
6:29 pm [6] on my Varisys Cyrus Plus board (A-EON AmigaOne X5000) 
[2][3]. (without the PowerPC updates 4.14-1 [0])

I was able to remove the first PowerPC updates.

git revert bac65d9d87b383471d8d29128319508d71b74180 -m 1

Output: [master 5fd2e41] Revert "Merge tag 'powerpc-4.14-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux"

After that I compiled a new Git kernel version without the first PowerPC 
updates [7]. I tested this version yesterday and the hardware 3D 
acceleration works again on my Varisys Cyrus Plus board. That means, 
there is a bug in the first PowerPC updates.

I tried to figure out what the problem is yesterday. Here are the results.

export LIBGL_DEBUG=verbose

gdb glxgears

run

Output:

Starting program: /usr/bin/glxgears
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/powerpc-linux-gnu/libthread_db.so.1".
libGL: OpenDriver: trying /usr/lib/powerpc-linux-gnu/dri/tls/r600_dri.so
libGL: OpenDriver: trying /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
[New Thread 0xf7fbd450 (LWP 7135)]
libGL: Can't open configuration file /home/amigaone/.drirc: No such file 
or directory.
libGL: Can't open configuration file /home/amigaone/.drirc: No such file 
or directory.
libGL: Using DRI2 for screen 0

Thread 1 "glxgears" received signal SIGBUS, Bus error.
memset () at ../sysdeps/powerpc/powerpc32/memset.S:293
293   ../sysdeps/powerpc/powerpc32/memset.S: No such file or directory.

----------

bt

Output:

#0  memset () at ../sysdeps/powerpc/powerpc32/memset.S:293
#1  0x0efad840 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#2  0x0f3966f8 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#3  0x0ef84334 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#4  0x0f1fb4d0 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#5  0x0f38d1dc in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#6  0x0f390a10 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#7  0x0f39cd28 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#8  0x0f39d56c in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#9  0x0f390150 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#10 0x0f1fe9bc in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#11 0x0eef0a24 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#12 0x0eee92c0 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#13 0x0ed9fd54 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#14 0x0eda0928 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#15 0x0eee8ab8 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#16 0x0eee7414 in ?? () from /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
#17 0x0ffb46b8 in ?? () from /usr/lib/powerpc-linux-gnu/mesa/libGL.so.1
#18 0x0ff7c174 in glXMakeCurrentReadSGI ()
    from /usr/lib/powerpc-linux-gnu/mesa/libGL.so.1
#19 0x10001090 in ?? ()
#20 0x0fb78854 in generic_start_main (main=0x10000eb0, argc=1,
     argv=0xffffe1b4, auxvec=0xffffe29c, init=<optimised out>,
---Type <return> to continue, or q <return> to quit---
     rtld_fini=<optimised out>, stack_end=<optimised out>, 
fini=<optimised out>)
     at ../csu/libc-start.c:291
#21 0x0fb78a1c in __libc_start_main (argc=<optimised out>,
     argv=<optimised out>, ev=<optimised out>, auxvec=<optimised out>,
     rtld_fini=<optimised out>, stinfo=<optimised out>,
     stack_on_entry=<optimised out>)
     at ../sysdeps/unix/sysv/linux/powerpc/libc-start.c:116
#22 0x00000000 in ?? ()

----------

Mesa is trying to access memory that the CPU cannot physically address. 
This problem didn't exist before the first PowerPC updates. This bug 
only affects my Varisys Cyrus Plus board (A-EON AmigaOne X5000) [2][3] 
with a Qoriq P5020 PowerPC CPU from NXP.

Could you please help me to find the bug in the first PowerPC updates? 
Maybe my kernel config isn't correct [8]. I've seen a lot of memory 
patches in the first PowerPC updates but I don't know which one is the 
problematic patch. I need your help because you have a better knowledge 
about the memory patches.

Thanks,
Christian


[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bac65d9d87b383471d8d29128319508d71b74180
[1] http://www.xenosoft.de/vmlinux-4.14-alpha2-AmigaOne_X1000_X5000.tar.gz
[2] http://www.amigaos.net/hardware/133/amigaone-x5000
[3] http://wiki.amiga.org/index.php?title=AmigaONE_X5000
[4] 
http://forum.hyperion-entertainment.biz/viewtopic.php?f=58&t=3592&start=80#p41611
[5] https://en.wikipedia.org/wiki/AmigaOne_X1000
[6] http://www.xenosoft.de/vmlinux-4.14-alpha1-AmigaOne_X1000_X5000.tar.gz
[7] http://www.xenosoft.de/uImage-4.14-alpha2-without-powerpc-updates
[8] http://www.xenosoft.de/cyrus-4.14-alpha2.config
