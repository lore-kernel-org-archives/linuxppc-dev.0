In-Reply-To: <F14842317963D111817100805F0DFE4D4FFF9A@server1.controlnet.com>
Date: Thu, 24 Feb 2000 20:21:31 +0100
To: Mark Knecht <mknecht@controlnet.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [Linux1394-devel] Re: FireWire + Apple PB G3: some success
Message-Id: <20000224202131.012502@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 24, 2000, Mark Knecht <mknecht@controlnet.com> wrote:

>According to the LV23 spec the IO_ENB bit is read only, so one would presume
>that writing the a 1 to the IO_ENB ( I presume that this is what is actually
>happening with PCI_COMMAND_IO) would not cause any problems.
>
>As for some of the performance issues, is the Memory Write and Invalidate
>bit in the same PCI register turned off or is it getting turned on? The
>default state is OFF. If not, then DMA writes from the OHCI controller could
>potentially be causing cache flushes and slowing the system down. I am
>presuming here that all or some of the memory addressed by OHCI is marked as
>cacheable which may or may not be the case...)

Hum... I didn't check the driver, but correct handling of cache coherency
issues is not very familiar to most Linux drivers. So I would suggest
sticking with invalidate. Note that I think the bridge will handle
coherency in all cases anyway.

>This may not be visible to something like 'top' because the cache flush it
>is a hardware process in the processor and it is possible that the front
>side bus gets bogged down with cache flush traffic.

Hum, the RAM/cache bus is way much faster than the PCI and in the case of
writes with invalidate, the destination datas is just killed from the CPU
cache, not actually flushed, so this should not cause a significant
performance impact.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
