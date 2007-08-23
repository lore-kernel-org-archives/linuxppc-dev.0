Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070823024757.GC7042@localhost.localdomain>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<20070823024757.GC7042@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <725ED7EE-0CEA-4BF7-A6F1-BB769FD02E44@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Wed, 22 Aug 2007 22:22:10 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 9:47 PM, David Gibson wrote:

> On Wed, Aug 22, 2007 at 10:19:21AM -0500, Kumar Gala wrote:
>> Guys,
>>
>> I was wondering if I could get your help with looking at the
>> following lists and determining if we have an issue or not related
>> the following files:
>>
>> Getting some classification on these would be good.  Possibly
>> classifications, doesn't build in ARCH=powerpc, remove include, real
>> issue, etc.
>>
>> - k
>>
>> ./include/asm-powerpc/irq.h:#include <asm/mpc83xx.h>	- protected by !
>> CONFIG_PPC_MERGE
>
> irq.h seems to have a big slab of CONFIG_PPC_MERGE dependent stuff.
> Looks like a good candidate for splitting into asm-ppc/irq.h and
> asm-powerpc/irq.h

Yeah was going to look at a bit of that since the list of  
CONFIG_PPC_MERGE headers is pretty short:
	dcr.h, i8259.h, ipic.h, irq.h

>> ./drivers/ide/ppc/mpc8xx.c:#include <asm/residual.h>
>
> Since mpc8xx is certainly not PReP, I don't think there's any way it
> ought to be including residual.h

Yeah, not sure what's up with that.  It needs a !MERGE in Kconfig for  
now.

>> ./drivers/mtd/maps/tqm834x.c:#include <asm/ppcboot.h>
>> ./drivers/mtd/maps/pq2fads.c:#include <asm/ppcboot.h>
>
> Although these both have an extern of type bd_t (defined in
> ppcboot.h), afaict they don't actually use it, so these should be
> removable.  Longer term, all these ugly hardcoded map files should be
> relegated to arch/ppc only, replaced with physmap_of and suitable
> information in the device tree for arch/powerpc.  However, being able
> to build them on arch/powerpc may be useful during transition.

Yeah was going to kill tqm834x.c since there is no way to Kconfig it  
into existence, and !MERGE pq2fads.c.

>> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ibm4xx.h>
>
> This driver will need significant reworking to port to arch/powerpc
> (similar to the treatment ibm_emac has received).  Such rework will
> remove the dependency on ibm4xx.h and ocp.h
>
>> ./drivers/mtd/maps/walnut.c:#include <asm/ibm4xx.h>
>
> Suspect it's not needed.  But in any case, this too should be replaced
> by physmap_of for arch/powerpc.
>
>> ./include/asm-powerpc/irq.h:#include <asm/ibm4xx.h>	- protected by !
>> CONFIG_PPC_MERGE
>>
>> ./drivers/mtd/maps/ebony.c:#include <asm/ibm44x.h>
>
> Ebony flash now works with physmap_of, so this is only used on
> arch/ppc.
>
>> ./drivers/mtd/maps/ocotea.c:#include <asm/ibm44x.h>
>
> As for drivers/mtd/maps/walnut.c.
>
>> ./drivers/mtd/nand/ndfc.c:#include <asm/ibm44x.h>
>
> This probably also wants rework to make a device-tree-aware
> arch/powerpc version.
>
>> ./include/asm-powerpc/irq.h:#include <asm/ibm44x.h>	- protected by !
>> CONFIG_PPC_MERGE
>>
>> ./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ocp.h>
>
> See above.
>
>> ./drivers/net/ucc_geth_mii.c:#include <asm/ocp.h>	- just bogus, needs
>> removal
>> ./drivers/net/ibm_emac/ibm_emac_core.c:#include <asm/ocp.h>
>> ./drivers/net/ibm_emac/ibm_emac_core.h:#include <asm/ocp.h>
>> ./drivers/net/ibm_emac/ibm_emac_tah.h:#include <asm/ocp.h>
>> ./drivers/net/ibm_emac/ibm_emac_phy.c:#include <asm/ocp.h>
>> ./drivers/net/ibm_emac/ibm_emac_mal.c:#include <asm/ocp.h>
>> ./drivers/net/ibm_emac/ibm_emac_zmii.h:#include <asm/ocp.h>
>
> ibm_emac is arch/ppc only.  BenH and my 'ibm_newemac' patch adds a
> new, device-tree aware arch/powerpc port of this driver.
>
>>
>> ./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>
>
> I think this is just unnecessary, maybe also for a bunch of the ones
> below.

most of the below are 68k or mips uses

>> ./drivers/char/vme_scc.c:#include <asm/bootinfo.h>
>> ./drivers/char/serial167.c:#include <asm/bootinfo.h>
>> ./drivers/serial/dz.c:#include <asm/bootinfo.h>
>> ./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>
>> ./drivers/net/macsonic.c:#include <asm/bootinfo.h>
>> ./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>
>> ./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>
>> ./drivers/video/maxinefb.c:#include <asm/bootinfo.h>
>> ./drivers/video/logo/logo.c:#include <asm/bootinfo.h>
>> ./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>
>> ./drivers/video/macfb.c:#include <asm/bootinfo.h>

- k
