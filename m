Message-ID: <40C6B0EE.1000506@fh-landshut.de>
Date: Wed, 09 Jun 2004 08:40:46 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE0@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE0@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heater, Daniel (GE Infrastructure) wrote:

>>Could you check, whether the patch to your driver (version
>>7433-3.2 of your
>>Linux support) still compiles on an Intel platform, and works
>>as intended?
>>
>>
>
>Yep. I only did a quick test, but it appears to work fine on x86.
>I've merged your patch up with the code base for the next release.
>
>
>
Great!

I don't know about x86 bus organization, but maybe it limits the address
range for available addresses too strongly (on a single bus, where the
Universe is on). Comparing how much window space you can map with the
old version and the new one on x86 could prove useful.

>I think I have an idea for the read/write question, but I need to
>look at it a little closer. I'll get back to you in a bit.
>
>
With a little bit of "luck" maybe there's a way around it, and I'm
currently looking into it:

readb(), readw() and readl() work fine (and their writeb/w/l
counterparts do as well), but pointer derefencing does not. Every
pointer dereference does trigger an 8 long word read from the bus first.
I asked what could trigger a long read from a single dereference of
memory? Cache. Not surprisingly cache line length of my current
development board (MVME2100) is 8 long words for Cache Burst
Transactions. So I have the wanted single-beat transactions when using
readx()/writex(), as documented when using cache-inhibited, guarded or
write-through memory or if the cache is disabled, but am getting cache
bursts on pointers.

I will take a closer look at the properties of the pages I'm using in
kernel space and in user space, and the page tables, and maybe that
fixes it.

BTW, everywhere where you use pci_alloc_consistent (dma, slaves), it
ports perfectly fine.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
