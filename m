Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7365ADDEC7
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 10:30:57 +1100 (EST)
Message-ID: <47ACE630.8090101@pikatech.com>
Date: Fri, 08 Feb 2008 18:30:56 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Could the DTS experts look at this?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Rev B warp is moving to a 4M NOR / 256M NAND flash setup from the 
current 64M NOR / 64M NAND. I would like to keep support for the 64M NOR 
so I modified the boot code to be a bit more dynamic. Here is the new 
NOR parition layout in the DTS:

nor_flash@0,0 {
	compatible = "amd,s29gl512n", "cfi-flash";
	bank-width = <2>;
	reg = <0 0 4000000>;
	#address-cells = <1>;
	#size-cells = <1>;
	partition@300000 {
		label = "fpga";
		reg = <300000 40000>;
	};
	partition@340000 {
		label = "env";
		reg = <340000 40000>;
	};
	partition@380000 {
		label = "u-boot";
		reg = <380000 80000>;
	};
};

Yes, the top of the NOR will be empty. Here is the code from 
cuboot-warp.c to handle fixups for the 64M flash:

static void warp_fixup_one_nor(u32 from, u32 to)
{
	void *devp;
	char name[40];
	u32 v[2];

	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);

	devp = finddevice(name);
	if (!devp) return;

	if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
		v[0] = to;
		setprop(devp, "reg", v, sizeof(v));

		printf("NOR 64M fixup %x -> %x\n", from, to);
	}
}


static void warp_fixups(void)
{
	unsigned long sysclk = 66000000;

	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
	ibm4xx_sdram_fixup_memsize();
	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
	dt_fixup_mac_addresses(&bd.bi_enetaddr);

	/* Fixup for 64M flash on Rev A boards. */
	if(bd.bi_flashsize == 0x4000000) {
		warp_fixup_one_nor(0x300000, 0x3f00000);
		warp_fixup_one_nor(0x340000, 0x3f40000);
		warp_fixup_one_nor(0x380000, 0x3f80000);
	}
}

I have tested this with the 64M NOR, and it seems to work. However, are 
there going to be problems with the partition name not matching the reg 
address entry?

If anybody has suggestions on better ways to do this, fire away.

And looking at this code, and other board ports, why is sysclk a local 
variable and all the other numbers hardcoded in the args? I left it the 
same way as the others but it does look a bit strange.

Cheers,
   Sean
