Message-ID: <3EC92F65.1050503@mvista.com>
Date: Mon, 19 May 2003 12:24:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64260/PCI accesses cached by CPU?
References: <NCBBIINEHIPFGJPLBEIFGEPBEFAA.acurtis@onz.com>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFGEPBEFAA.acurtis@onz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

>>If PCI I/O or MEM space was being cached, your PCI drivers wouldn't work
>>at all...or at least not for very long.
>>
>>
>
>Only as long as it takes to kick things out of cache. When you are running
>md5sum operations of the whole disk drive, this doesn't take very long.
>(what was done to generate lots of SCSI I/O) I am sure there are other ways
>I could force cache reuse/flushing.
>
Not true unless you get very, very lucky.

If a driver is accessing a device/controller's registers through PCI I/O
or MEM space and that space has cacheing enabled, that driver isn't
going to work (unless the cache fills and flushes happen to hit the
registers in "just the right order" (tm).  It won't work because reads
from the controllers registers may return cached data and not really
read the reg at that point in time (consider an interrupt status
register read).  Also, writes to a register will only go into cache and
probably not to the register in the order or at the time required.  It
doesn't matter what else is going on in the system to flush cache.

>>I also mentioned that the
>>GT64260 is very slow when cache coherency is enabled.
>>
>>
>
>Cache coherency is not enabled. It is only enabled if snooping is enabled on
>both PCI buses. This isn't the condition with the last Artesyn LSP.
>
>
>
>>I don't know what your problem is but I think your "PCI
>>I/O and/or MEM being cached" theory is wrong.  My $0.02.
>>
>>
>
>Well, an interesting test would be to run the MPT driver in I/O mode instead
>of Memory mode. (the default) There are other interesting things to look at
>in the LSP. For instance, the virtual address for the PCI I/O space for each
>PCI bus is stored in the "hose" structure. However io.h, uses a constant,
>_IO_BASE, for all its in/out() instructions. Each PCI bus I/O space is
>ioremap() separately so a single constant offset probably will not work.
>
In include/asm-ppc/gt64260.h you will see that the default PCI I/O space
mapping defaults were carefully calculated to be contiguous so both
hoses work with one _IO_BASE_ value.  Its been tested and works.  If
Artysen or you used different values, then all bets are off.  I am
assuming that gt64260_find_bridges() was used.

>>Also, PCI mem space is mapped by the driver.  That's why you don't see
>>it mapped by any of the gt64260-specific code.
>>
>>
>
>The MPT driver which uses Memory mapped PCI space works fine. The Ethernet
>drivers that use I/O space are not so good.
>
>Hopefully I will have more information next week.
>
Okay.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
