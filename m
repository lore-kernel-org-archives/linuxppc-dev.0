Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 1FDF0B7C1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 10:56:15 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 9 Nov 2009 16:21:10 -0700
Subject: Disable Caching for mmap() address
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310B03B4@midas.usurf.usu.edu>
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

I would like to disable caching for an address that was returned from a cal=
l to mmap().  I am using this address for DMA operations in user space and =
want to make sure that the data cache is turned off for that buffer.

The way this works is the driver simply takes an address I provide and begi=
ns a DMA operation to that location in RAM (I have ensured that this is a p=
hysical address I am passing already).  When the DMA is complete, an interr=
upt fires and the ISR gives a semaphore that the user space application is =
pending on (RT_SEM from Xenomai).  I have tried simply calling a cache inva=
lidate routine in the ISR before I give the semaphore, but the kernel crash=
es when I try to call that routine - my guess it because the kernel does no=
t have direct access to that location in memory (only my application does, =
according to the MMU).

Anyway, all I want to do is make sure that the buffer is never stored in th=
e cache and that I always fetch it from RAM.  How can I specify that using =
mmap() on the /dev/mem device, or is there a better way to accomplish this?

Thanks,

Jonathan
