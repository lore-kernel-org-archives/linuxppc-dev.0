Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3C69A0EC.2090400@embeddededge.com>
Date: Tue, 12 Feb 2002 18:10:36 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eric.Oosterhof@radisys.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I2C module problem on 8260
References: <OFC97C91CA.1E7BB35E-ON88256B5E.007CD94A@radisys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eric.Oosterhof@radisys.com wrote:

> .....  I discovered in so doing that the virtual address
> space that the module is placed in does not allow the use of __pa to get a
> virtual address.

Welcome to the wonderful world of Linux VM and the need for different
implementations depending upon how you use the driver.  The 8xx and 4xx
processors use the 'iopa()' function within the usual macros to do this.
Outside of those processors, you can call it directly.  Change the __pa()
to iopa() and you should be fine.

There are other things you must consider.  Loadable modules dynamically
allocate pages of memory, so they are likely not to be physically contiguous.
One of the programming techniques for modules is you must explicitly allocate
all objects subject to DMA such that they are known to be physically contiguous
if necessary.  The static buffers you allocate in a built-in driver won't work
for DMA in a module.

Finally, there isn't any deallocation function for CPM memory space.  I thought
someone else was going to contribute this, and I apologize if I misplaced a patch,
but this needs to be done or else your module loading/unloading will exhaust
the CPM dual port memory space.  I guess I can quickly do one that used the old
unix style map allocator, but I never got around to do it.  Due to the interactions
of the devices on the CPM for resource allocation and the configuration
interdependencies, I always found it easier to just build a static driver and
reboot the kernel.

Have fun!


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
