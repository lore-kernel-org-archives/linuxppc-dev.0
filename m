Date: Fri, 14 Feb 2003 10:49:29 -0700
From: Matt Porter <porter@cox.net>
To: vinai <vroopcha@mcw.edu>
Cc: Matt Porter <porter@cox.net>,
	"LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: vmalloc limits in PPC kernels ?
Message-ID: <20030214104929.A4320@home.com>
References: <Pine.LNX.4.44.0302141128590.273-100000@kaiso.biophysics.mcw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0302141128590.273-100000@kaiso.biophysics.mcw.edu>; from vroopcha@mcw.edu on Fri, Feb 14, 2003 at 11:32:44AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 14, 2003 at 11:32:44AM -0600, vinai wrote:
> Matt,
>
> Thanks much for the information you provided below.  Are there any
> pointers/references as to why these changes were actually implemented,
> or is it really a case of "the source being the guide" ?  As I said,
> this issue is really troubling for us, and I want to see if there is
> a "clean" way to circumvent that limit without screwing up the MM
> subsystem (at least not too badly :) ...

No docs beyond mailing list archives (for x86, lkml. for ppc,
-dev/-embedded/#mklinux).  Use the source.

x86's reasons for changes are off-topic here. :) I think you'll
find out that much of the reason had to do with the the transition
from various bigmem hacks to the current highmem solution for large
system memory.  This transition caused i386 to rework their limits
around the pkmap pool for one.  They probably also made their usual
choices around trying to be targetted at the mid-level of ia32
machines.

It's the same thought process that goes into the PPC VM defaults.
The difference is that we have developers that consciously worry
about common embedded application usage.  That led to the VM
tweaking options.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
