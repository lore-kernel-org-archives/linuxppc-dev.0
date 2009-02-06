Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: "Linuxppc-dev" <Linuxppc-dev@ozlabs.org>
Subject: MPC5121e, MBX driver, pvr.ko ...
Date: Fri, 6 Feb 2009 08:24:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902060824.06851.david.jander@protonic.nl>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I have a custom board with a MPC5121e (rev 1.5) on it. It is the latest git 
kernel from denx ads5121 head with our BSP mixed in.

I decided to try out Application Note AN3793 from Freescale (3D Graphics on 
the ADS512101 Board Using OpenGL ES).

I started trying to load the provided (binary!) kernel modules into our 
kernel, but I am geeting errors inserting the modules using 
insmod: 'clcdc.ko' complains about not being able to register de device major 
number, and 'dbgdrv.ko' oopses with a BUG() in percpu_modfree()! This 
function should never be called in a non-SMP kernel, so I suspect there are 
some important differences between the kernel I have and the one the 
binary-only drivers where built against :-(

In another approach I managed to load the provided kernel binary (which is 
built for the ADS512101 evaluation board) on our platform, by tweaking our 
device-tree until it booted without crashing. In the end I was able to load 
all the modules and run the OpenGL-ES demo programs.
I can't believe this is the intended way of doing this, so I'd like to know if 
there is someone else who has managed to get the MBX running OpenGL-ES on a 
custom board with a custom build of the kernel.

Note: the kernel version number is still the same: 2.6.24.6, only difference 
AFAIK is some minor unrelated patches to drivers for other MPC5121 SoC 
devices, and probably some different configuration options. Apparently this 
is enough to break binary compatibility for the drivers :-(

Any hint is appreciated...

Best regards,

-- 
David Jander
Protonic Holland.
