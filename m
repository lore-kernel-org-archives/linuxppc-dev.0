Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrMzp2fVqzDrZQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 19:28:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Hardware 3D acceleration doesn't work anymore after the PowerPC
 updates 4.14-1
In-Reply-To: <421109ac-41f8-f332-068b-8884cf7322b6@xenosoft.de>
References: <421109ac-41f8-f332-068b-8884cf7322b6@xenosoft.de>
Date: Mon, 11 Sep 2017 19:28:18 +1000
Message-ID: <87vakpbn4d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christian,

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> Hi All,
>
> I tested the latest Git kernel version with the new PowerPC updates 
> 4.14-1 [0][1] on my Varisys Cyrus Plus board (A-EON AmigaOne X5000) 
> [2][3] with a Qoriq P5020 PowerPC CPU from NXP yesterday. Unfortunately 
> the hardware 3D acceleration doesn't work anymore since the PowerPC 
> updates 4.14-1 [0]. I tested it with ubuntu MATE 16.04.3 LTS PowerPC 
> (64-bit kernel and 32-bit userland) and with the MATE PowerPC Remix 2017 
> (64-bit kernel and 32-bit userland) [4]. I reduced the RAM to 3.5GB via 
> kernel boot arguments but without any success. (mem=3500M)
...
>
> I tried to figure out what the problem is yesterday. Here are the results.
>
> export LIBGL_DEBUG=verbose
>
> gdb glxgears
>
> run
>
> Output:
>
> Starting program: /usr/bin/glxgears
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/powerpc-linux-gnu/libthread_db.so.1".
> libGL: OpenDriver: trying /usr/lib/powerpc-linux-gnu/dri/tls/r600_dri.so
> libGL: OpenDriver: trying /usr/lib/powerpc-linux-gnu/dri/r600_dri.so
> [New Thread 0xf7fbd450 (LWP 7135)]
> libGL: Can't open configuration file /home/amigaone/.drirc: No such file 
> or directory.
> libGL: Can't open configuration file /home/amigaone/.drirc: No such file 
> or directory.
> libGL: Using DRI2 for screen 0
>
> Thread 1 "glxgears" received signal SIGBUS, Bus error.
> memset () at ../sysdeps/powerpc/powerpc32/memset.S:293


Can you try Linus' mainline, with just the following commit reverted:

31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")

So just:

$ git revert 31bfdb036f12 

cheers
