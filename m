Date: Fri, 26 Mar 2004 09:00:13 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linas@austin.ibm.com
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040326080012.GA7238@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com> <20040324142524.GA22701@smtp.barco.com> <20040324110814.E50148@forte.austin.ibm.com> <20040325154845.GF3696@smtp.barco.com> <20040325103414.C64292@forte.austin.ibm.com> <20040325104529.D64292@forte.austin.ibm.com>
Mime-Version: 1.0
In-Reply-To: <20040325104529.D64292@forte.austin.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> actually, if you have 32-byte cache lines on your cpu, and you have,
> umm, something maybe 4-way set associative (I've forgotten how it
> works) that might explain it. I don't know what cpu's have what cache
> sizes.

This was also one of the paths we were considering, but the following
tests have been performed in order to validate or invalidate this
assumption:
1. I was under the impression that 'consistent_alloc' (which I
activited by defining CONFIG_NOT_COHERENT_CACHE in the kernel
configuration for our board) assured that the pages were not using
cache, at least the following lines lead me to this:

[malm@bpscltpd linux-2.4.17_bl21]$ vim ./arch/ppc/mm/cachemap.c

<...>
        /*
         * we need to ensure that there are no cachelines in use,
         * or worse dirty in this area.
         */
        invalidate_dcache_range(page, page + size);
<...>

and

<...>
        flags = _PAGE_KERNEL | _PAGE_NO_CACHE;

        err = 0;
        for (i = 0; i < size && err == 0; i += PAGE_SIZE)
                err = map_page(va+i, pa+i, flags);
<...>

As told before, no change with or without this define enabled that uses
consistent_alloc.

2. Next I tried to invalidate the cache the naive way:
I refilled the used buffer with 0xCA in userspace and copied it back to
kernelspace (in the PCI mappded buffer). Next I transferred the next
'useful' data from user to kernel space. Still completely the same: the
data showing up (corrupted) on the DSP side was the 'old' lines of the
buffer last transferred (i.e. the buffer before bringing 0xCA into
kernel space).

3. I took the previous point one step further: I filled the kernel
buffer with 0xCA before copying in the userbuffer. Still the same old
data is showing up on the DSP side. Still, I understand that none of
these two techniques assure purging the cache.

4. I added sync's and the like which should sync cache and mem, still no
change.

Apparently, the closest I can come to pinpointing the location of the
problem at the moment is that 'something' must be happening at the point
where the DSP starts reading from the PPC memory. When no such read is
performed, the problem does not occur. The other way around, the DSP can
write into the PPC memory without corrupting data.

Maybe reading of the DSP over PCI and the resulting DMA setup causes a
[hardware|software] timing problem with purging the cache (which should
not be used for these pages to start with (see [1]), or the DSP ack's
too early on and reading these 97 bytes after the DSP ACK causes some
hardware lock to be released, giving the DSP just enough time to
correctly fetch the data before the PPC starts pumping in new, ...

  marc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
