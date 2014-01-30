Return-Path: <michael.moese@men.de>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.116])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BB472C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:27:14 +1100 (EST)
From: "Moese, Michael" <michael.moese@men.de>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: PCIe Access - achieve bursts without DMA
Date: Thu, 30 Jan 2014 12:20:21 +0000
Message-ID: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello PPC-developers,
I'm currently trying to benchmark access speeds to our PCIe-connected IP-co=
res
located inside our FPGA. On x86-based systems I was able to achieve bursts =
for
both read and write access. On PPC32, using an e500v2, I had no success at =
all=20
so far.=20
I tried using ioremap_wc(), like I did on x86, for writing, and it only res=
ults in my
writes just being single requests, one after another.
For reads, I noticed I could not ioremap_cache() on PPC, so I used simple i=
oremap()
here.=20
I used several ways to read from the device, from simple readl(),memcpy_fro=
m_io(),=20
memcpy()  to cacheable_memcpy() - with no improvements.  Even when just iss=
uing
a batch of prefetch()-calls for all the memory to read did not result in re=
ad bursts.

I only get really poor results, writing is possible with around 40 MiByte/s=
, whereas I =20
can read at about only 3 MiByte/s.
After hours of studying the reference manual from freescale, looking into o=
ther code
and searching the web, I'm close to resignation.

Maybe someone of you has some more directions for me, I'd appreciate every =
hint
that leads me to my problem's solution - maybe I just missed something or l=
ack=20
knowledge about this architecture in general.

Thanks for your reading.


Michael
