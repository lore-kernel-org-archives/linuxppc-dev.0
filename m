Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 52AC7B7BDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 Nov 2009 10:37:47 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 3 Nov 2009 16:37:38 -0700
Subject: DMA to User-Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I have what may be an unconventional question:

Our application consists of data being captured by an FPGA, processed, and =
transferred to SDRAM.  I simply give the FPGA an address of where I want it=
 stored in SDRAM and it simply DMAs the data over and interrupts me when fi=
nished.  I then take that data and store it to disk.

I have code in user space that handles all of the writing to disk nicely an=
d fast enough for my application (I am capturing data at about 35-40 Mbytes=
/sec).

My question is this:  is it possible to give a user-space pointer to the FP=
GA to DMA to?  It seems like I would have problems with alignment, address =
manipulation, and a whole slew of other issues.

What would be the best way to accomplish something like that?  I want to ha=
ndle all the disk access in user-space, but I do not want to have to copy 4=
0 MB/s from kernel space to user-space either.

I can maintain an allocated, DMA-safe buffer in kernel space if needed.  Ca=
n I simply get a user-space pointer to that buffer?  What calls are needed =
to translate addresses?

Thanks for the help!  I am still a newbie when it comes to kernel programmi=
ng, so I really appreciate the help!

Jonathan
