Message-ID: <F14842317963D111817100805F0DFE4D4FFFAC@server1.controlnet.com>
From: Mark Knecht <mknecht@controlnet.com>
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: RE: [Linux1394-devel] Re: FireWire + Apple PB G3: some success
Date: Thu, 24 Feb 2000 13:37:58 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<snip..>

>This may not be visible to something like 'top' because the cache flush it
>is a hardware process in the processor and it is possible that the front
>side bus gets bogged down with cache flush traffic.

Hum, the RAM/cache bus is way much faster than the PCI and in the case of
writes with invalidate, the destination datas is just killed from the CPU
cache, not actually flushed, so this should not cause a significant
performance impact.

<end snip..>

Actually this is exactly the purpose of the MWI invalidate command in PCI.
With this feature turned off, which is the TI default, anytime the PCI bus
presents the chipset with a cacheable address the cache lines are written
back into memory before the chipset lets the OHCI DMA controller write data
to memory, so it can impact performance, sometimes quite a lot.

However, if the feature is turned on, then the chipset tells the processor
to simply invalidate the cache line internally because the PCI controller is
going to take responsibility for writing the complete cache line in memory.
There would be no purpose to flushing the cache line and then writing over
it in memory, and bus bandwidth is saved.

The bus in question here isn't necessarily the cache bus, but is the
front-side bus on the processor hooking to the chipset. On systems with
shallow posting PCI FIFOs this can be a pretty big impact if you are talking
about transfers of 100's of bytes. On newer chipsets with deeper
write-posting FIFOs it may not be a big deal.

None of this makes any difference if the buffers in memory are not
cacheable. How are buffers allocated in Linux? Are they cacheable? (I'm a
hardware guy and wouldn't know that part of the C-code if it walked up and
said hi!)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
