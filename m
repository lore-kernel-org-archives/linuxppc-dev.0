Date: Tue, 3 Feb 2004 16:17:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Missing isa_ symbols
Message-ID: <20040203231728.GF1860@smtp.west.cox.net>
References: <20040203210321.GA19689@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040203210321.GA19689@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 03, 2004 at 10:03:21PM +0100, Christoph Hellwig wrote:

> I've recently switched CONFIG_ISA on to compile-test various scsi
> drivers and get lots of warnings like:
>
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_bus_to_virt
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_page_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol isa_virt_to_bus
> WARNING: /lib/modules/2.6.2-rc3/kernel/drivers/scsi/wd7000.ko needs unknown symbol udelay
>
> from looking at other architectures it looks like architectures
> supporting CONFIG_ISA are supposed to supply them.  Any idea how to
> implement this properly for ppc?  (and no, I can't test it, by mac
> doesn't actually have an isa bus)

On PPC32, CONFIG_ISA is kinda hack'ish.  I know it will / must work on
PRePs, and it _may_ but I'm not certain of some CHRP machines as well.
So you can probably look at the i386 versions of the functions (save for
udelay as Ben mentioned) and do something like:
if (_machine == _MACH_prep) {
 ... do i386 version ...
} else
 return -EINVAL; // whatever

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
