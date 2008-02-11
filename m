Return-Path: <dgibson@ozlabs.org>
Date: Mon, 11 Feb 2008 11:14:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080211001451.GA11572@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47ACE630.8090101@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 08, 2008 at 06:30:56PM -0500, Sean MacLennan wrote:
> The Rev B warp is moving to a 4M NOR / 256M NAND flash setup from the 
> current 64M NOR / 64M NAND. I would like to keep support for the 64M NOR 
> so I modified the boot code to be a bit more dynamic. Here is the new 
> NOR parition layout in the DTS:
> 
> nor_flash@0,0 {
> 	compatible = "amd,s29gl512n", "cfi-flash";
> 	bank-width = <2>;
> 	reg = <0 0 4000000>;
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	partition@300000 {
> 		label = "fpga";
> 		reg = <300000 40000>;
> 	};
> 	partition@340000 {
> 		label = "env";
> 		reg = <340000 40000>;
> 	};
> 	partition@380000 {
> 		label = "u-boot";
> 		reg = <380000 80000>;
> 	};
> };
> 
> Yes, the top of the NOR will be empty. Here is the code from 
> cuboot-warp.c to handle fixups for the 64M flash:
> 
> static void warp_fixup_one_nor(u32 from, u32 to)
> {
> 	void *devp;
> 	char name[40];
> 	u32 v[2];
> 
> 	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);
> 
> 	devp = finddevice(name);
> 	if (!devp) return;
> 
> 	if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
> 		v[0] = to;
> 		setprop(devp, "reg", v, sizeof(v));
> 
> 		printf("NOR 64M fixup %x -> %x\n", from, to);
> 	}
> }
> 
> 
> static void warp_fixups(void)
> {
> 	unsigned long sysclk = 66000000;
> 
> 	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
> 	ibm4xx_sdram_fixup_memsize();
> 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
> 	dt_fixup_mac_addresses(&bd.bi_enetaddr);
> 
> 	/* Fixup for 64M flash on Rev A boards. */
> 	if(bd.bi_flashsize == 0x4000000) {
> 		warp_fixup_one_nor(0x300000, 0x3f00000);
> 		warp_fixup_one_nor(0x340000, 0x3f40000);
> 		warp_fixup_one_nor(0x380000, 0x3f80000);
> 	}
> }

This doesn't seem right.  warp_fixup_one_nor() changes only the
partition's offset, so you're not changing the size of any
partitions.  If you're not going to actually use any of the extra
flash space with 64M, I can't see why you'd bother moving around the
partitions you have.

> I have tested this with the 64M NOR, and it seems to work. However, are 
> there going to be problems with the partition name not matching the reg 
> address entry?

In practice, probably not.  We already do a similar fixup on Ebony for
different flash layouts that won't leave the unit names correct.  We
really should get this right - and the fdt_set_name() function that's
now in libfdt should make that possible, it just needs some wiring up
to use in the bootwrapper.  That can come later, though, for now I
think applying your fixups without correcting the unit addresses is
adequate.

> If anybody has suggestions on better ways to do this, fire away.
> 
> And looking at this code, and other board ports, why is sysclk a local 
> variable and all the other numbers hardcoded in the args? I left it the 
> same way as the others but it does look a bit strange.

I think this also came from Ebony.  IIRC, the sysclk isn't strictly
speaking fixed, although it almost always has initialized value.  The
point of the local variable was that I planned to replace the static
initialization with some sort of probing once I figured out the
details.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
