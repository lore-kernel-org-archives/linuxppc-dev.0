Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A77C3679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 11:34:39 +1000 (EST)
Message-ID: <443B0718.3050001@ovro.caltech.edu>
Date: Mon, 10 Apr 2006 18:32:08 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Howard, Marc" <Marc.Howard@kla-tencor.com>
Subject: Re: Create permanent mapping from PCI bus to region of physical memory
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Howard, Marc wrote:
> Hi,
> 
> I'm working on a PPC440GX based board in which a PCI based peripheral
> communicates with the host via a shared region of processor memory.  The
> peripheral will read and write this region autonomously.  Because of
> this I need a fixed mapping FROM the PCI bus TO system memory.
> 
> It's easy enough to rope off the top 16 MB or so of system physical
> memory by lying to linux in the boot arguments.  What I can't seem find
> is a system call to use to create a fixed, permanent mapping of PPC
> memory as seen from the PCI bus.
> 
> Has anyone out there done this and could share a code snippet with me?
> 

Hi Marc,

So the PPC440GX is the host, but what is the peripheral, and
what restricts it to require a fixed address? Can it handle
a set of fixed addresses, eg. a scatter-gather buffer setup
by the host? Can the host and peripheral communicate in any
other way, eg. when the peripheral changes something in the
shared memory, surely it has to interrupt the host to let it
know?

Does the peripheral contain a CPU, if thats the case, then
the host and peripheral could also maintain a smaller region
that contains addresses of other pages, i.e., no need to
restrict the design to a single block of memory, you just
need a page of pointers to other shared blocks of pages.

For example, the alloc_pages call can be used to get order 11
pages, eg. 2^11 x 4096-byte pages, 8MB (hmm, thats sounds a bit
big, I seem to recall 2MB was the maximum). So your 16MBs
could be 8 separate blocks.

Anyway the comment is that you can use alloc_pages() to give
you a contiguous chunk of memory at some allocation-time
address, but not a 16MB chunk.

Of course if the peripheral is fairly dumb, then you can't do
this. But if it indicates a buffer-used condition, perhaps you
can swap over to a new 2MB block.

If you can provide a few more details on the restriction of
the peripheral, then I or others can suggest options.

Dave
