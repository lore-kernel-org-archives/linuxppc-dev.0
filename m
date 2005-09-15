Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 16 Sep 2005 00:37:02 +0200
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050915223702.GA322@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
	<20050915205709.GA31156@iram.es>
	<17193.61187.613745.15444@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17193.61187.613745.15444@cargo.ozlabs.ibm.com>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 16, 2005 at 08:00:35AM +1000, Paul Mackerras wrote:
> Gabriel Paubert writes:
> 
> > So yes, I object strongly object if I don't have a way 
> > of removing useless PMAC code. The kernel is already very 
> > bloated compared with the 2.2 we started with, which was 
> > well below 1MB with the minimal setup: serial console, root 
> > on NFS, no swap, some locally modules to control the PCI<->VME 
> > bridge and what is behind on the VME bus. 
> 
> I assume you compile custom kernels for these machines, so you're
> happy with using config options to remove the code you don't want?

Yes, and I have no problems with it. 

Actually I even wrote my own bootloader, which reorganizes the 
host bridge memory map to make the MVME 2400/2600 have a more 
CHRP-like map, like the MVME5100. The reason is that people 
with VME systems like sparsely populated huge memory space
and the 1GB IO space of Prep came in the way.

Actually I announced this bootloader on these lists a long 
time ago; Cort Dougan (the maintainer at the time) liked it
very much but I failed at pushing it. It had a few interesting
features: among them it could initialize a video board by 
executing the BIOS since it included an x86 emulator (24kB
code + data). It had a relatively clean memory management,
etc... 

But I have no time to work on it in the next few months.

> Having the .pmac.text, .prep.text etc. sections lets us remove
> unneeded code at runtime, but it sounds like that isn't actually the
> issue for you (i.e. you don't have a need to run the same kernel on
> both a pmac and a prep).

Not at all. For example my pmac kernels need usb to boot 
(literally), the MVME machines have CONFIG_USB off (this 
saves a lot).

Now there are other architectures that could be merged,
an example is PreP/PowerPlus/MVME5100. 

	Gabriel
