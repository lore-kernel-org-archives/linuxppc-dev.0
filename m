Date: Thu, 13 Feb 2003 15:40:40 -0700
From: Matt Porter <porter@cox.net>
To: vinai <vroopcha@mcw.edu>
Cc: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: vmalloc limits in PPC kernels ?
Message-ID: <20030213154040.A1738@home.com>
References: <Pine.LNX.4.44.0302131412270.278-100000@kaiso.biophysics.mcw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0302131412270.278-100000@kaiso.biophysics.mcw.edu>; from vroopcha@mcw.edu on Thu, Feb 13, 2003 at 02:19:41PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 13, 2003 at 02:19:41PM -0600, vinai wrote:
> I've been doing a little work trying to update an in-house custom driver
> for x86.  We acquired fairly large chunks of data, and we can't afford
> to lose any of it. To do this, we reserve a fairly large chunk of memory
> in which the data can be stored, as we can't afford system latencies
> when writing to disk.  We were able to this in 2.2 without any problems,
> but in 2.4, a new "feature" was introduced to x86 that limited how much
> memory one can "vmalloc".  I did a quick check, but didn't find anything
> in the ppc asm directory.  Do we have such a limit ?

All architectures have a limit.  Its size is defined by
VMALLOC_END-VMALLOC_START and further limited by the size of each
preceding allocation (+ a PAGE_SIZE pad) before the allocation in
question.  Allocations also include ioremaps and on some architectures
consistent memory allocations absorb vmalloc space.

You can see the constraints in asm-ppc/pgtable.h.  On PPC, it is
possible to change the default parameters in order to expand the
amount of vmalloc space available.  This is accomplished via
config options under the advanced kernel options menu.  With
PAGE_OFFSET at 0x40000000 and highmem, I've run a system with
nearly 3GB of vmalloc space.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
