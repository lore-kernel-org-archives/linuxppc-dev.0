Message-ID: <4061BEDD.1080304@246tNt.com>
Date: Wed, 24 Mar 2004 18:01:17 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Jack Liu <Jack_liu@usish.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linux booting problem: init start up very slowly and print kernel
 infor character by character
References: <200403241240.i2OCeakY022508@ms.usish.com>
In-Reply-To: <200403241240.i2OCeakY022508@ms.usish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

>  Booting infomation:
>		.......
>		mice: PS/2 mouse device common for all mice
>		VFS: Mounted root (ext2 filesystem) readonly.
>		Freeing unused kernel memory: 64k init
>		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~before this, everything is OK.
>		INIT: version 2.84 booting
>  			              Welcome....
>        From "INIT", system seems to start very slowly. "INIT" and other kernel infomation were printed out character  by character with some kind of delay between them.It took even five minutes to mount a proc file system.
>        What could be the problem?
>		Is this becuase of disk configuation problem since init is the first program got called from disk?
>
>
>
Well, I suppose that it's on a serial console.

For me it sounds like a serial problem. Everything before the "INIT:
..." is printed via printk and is then handled by the 'console' part of
the serial driver. In all the drivers I've used/seen this is done the
simpliest way, often via busy waiting on the uart, without interrupts,
.... When the init program it's called, it doesn't use the console stuff
( it's unidirectionnal anyway ... ) but it open /dev/ttyS0 ( or the
appropriate device ) and it's not at all the same code running. Here (
again, in the driver I worked with ), interrupts are used to know when
the UART is ready or when chars are incoming, ...

What you could try to see if it comes from the serial stuff, is disable
consoel completely and 'see' the time it takes to boot ( of course you
need to have another visible effect that you system is fully booted like
inserting a ping -c 1 at the end of the init scripts ... )

My 2 cents, ...

    Sylvain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
