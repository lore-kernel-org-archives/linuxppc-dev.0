Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 6487C1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 14:50:13 +1100 (AEDT)
Date: Sun, 1 Feb 2015 14:39:42 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
In-Reply-To: <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sun, 4 Jan 2015, Geert Uytterhoeven wrote:

> On Sun, Jan 4, 2015 at 8:21 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Thu, 1 Jan 2015, Rickard Strandqvist wrote:
> > > Removes some functions that are not used anywhere:
> > > mac_pram_write() mac_pram_read()
> >
> > ... I'd rather not remove all of this code. Better to finish the 
> > implementation.
> 
> Indeed.
> 
> > Would it be acceptable to utilize drivers/char/generic_nvram.c and 
> > CONFIG_GENERIC_NVRAM? This is the PowerMac PRAM driver but looks 
> > generic enough that it may not need any modification for 68k Macs.
> 
> Yes, that would be great.
> 

Unfortunately, it seems to be unworkable.

The only user of generic_nvram is PPC32 (PPC64 could benefit though). 
PPC32 uses the driver by defining both CONFIG_NVRAM and 
CONFIG_GENERIC_NVRAM.

I tried to simplify this so that CONFIG_GENERIC_NVRAM would build 
drivers/char/generic_nvram, while CONFIG_NVRAM would build 
drivers/char/nvram, in order that it would become possible to have a 
multi-platform kernel with both, either, or niether.

But that approach brings new problems:

- An m68k multi-platform kernel would need to contain both modules, and 
  both modules would need MODULE_ALIAS_MISCDEV(NVRAM_MINOR). This isn't 
  going to work. (It's likely that other platforms might also want to use 
  generic_nvram and the same problem would apply to x86 and ARM.)

- The misc device code in drivers/char/nvram is duplicated in 
  generic_nvram. To avoid this duplication, the nvram module could 
  leverage the generic_nvram module instead. This doesn't work either.  
  Systems like mine (Gentoo) have "alias char-major-10-144 nvram" in 
  /etc/modprobe.d/i386.conf, which means that accessing /dev/nvram causes 
  the wrong module to load.

In the end I concluded that the only plausible "generic" driver is 
actually drivers/char/nvram itself. Otherwise it would be under an arch/ 
directory and not under drivers/.

So the nvram module should be the one with 
MODULE_ALIAS_MISCDEV(NVRAM_MAJOR), and it should work on any architecture 
that needs to use it. (Sure enough, drivers/char/generic_nvram lacks the 
MODULE_ALIAS.)

So I believe that the solution is to eliminate drivers/char/generic_nvram 
altogether, and move the architecture-specific code out of 
drivers/char/nvram, so the nvram module can be re-used more easily. I 
think that PPC32, PPC64 and m68k could readily re-use it.

Drivers themselves all test for CONFIG_NVRAM; never CONFIG_GENERIC_NVRAM. 
This is another indication that the generic_nvram driver is surplus to 
requirement.

The CONFIG_PROC_FS support (/proc/driver/nvram) in the drivers/char/nvram 
module is inherently architecture-specific. I suspect that the 
Atari-specific code should move to arch/m68k/atari/ and the x86-specific 
code should move to arch/x86/.

I find the ARM support in drivers/char/nvram to be surprising, not to say 
questionable. The /proc/driver/nvram implementation, given 
defined(__arm__), decodes the NVRAM contents in exactly the same format as 
when defined(__i386__) || defined(__x86_64__). Whereas, only MIPS and 
PowerPC defconfigs set CONFIG_RTC_DRV_CMOS at all, and without that symbol 
the driver will never be built for ARM. This raises the question, does 
/proc/driver/nvram do anything useful on any ARM platforms?

Some guidance on this problem would be appreciated; all the approaches I 
tried led to unsatisfactory compromises. I don't want to keep re-writing 
these patches without a workable plan.

-- 
