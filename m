Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	"Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 64260/PCI accesses cached by CPU?
Date: Fri, 16 May 2003 21:06:53 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEPBEFAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3EC57172.9060504@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> If PCI I/O or MEM space was being cached, your PCI drivers wouldn't work
> at all...or at least not for very long.

Only as long as it takes to kick things out of cache. When you are running
md5sum operations of the whole disk drive, this doesn't take very long.
(what was done to generate lots of SCSI I/O) I am sure there are other ways
I could force cache reuse/flushing.

> I also mentioned that the
> GT64260 is very slow when cache coherency is enabled.

Cache coherency is not enabled. It is only enabled if snooping is enabled on
both PCI buses. This isn't the condition with the last Artesyn LSP.

> I don't know what your problem is but I think your "PCI
> I/O and/or MEM being cached" theory is wrong.  My $0.02.

Well, an interesting test would be to run the MPT driver in I/O mode instead
of Memory mode. (the default) There are other interesting things to look at
in the LSP. For instance, the virtual address for the PCI I/O space for each
PCI bus is stored in the "hose" structure. However io.h, uses a constant,
_IO_BASE, for all its in/out() instructions. Each PCI bus I/O space is
ioremap() separately so a single constant offset probably will not work.

> Also, PCI mem space is mapped by the driver.  That's why you don't see
> it mapped by any of the gt64260-specific code.

The MPT driver which uses Memory mapped PCI space works fine. The Ethernet
drivers that use I/O space are not so good.

Hopefully I will have more information next week.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
