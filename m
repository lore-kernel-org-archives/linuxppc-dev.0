Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D1EA3DDED5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 15:54:40 +1100 (EST)
Date: Mon, 8 Dec 2008 23:54:37 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081208235437.08323e3a@lappy.seanm.ca>
In-Reply-To: <20081208223227.19a702a9@zod.rchland.ibm.com>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
	<20081208193446.37e27e26@lappy.seanm.ca>
	<20081209021115.GA13948@oksana.dev.rtsoft.ru>
	<20081208214512.461276d2@lappy.seanm.ca>
	<20081208223227.19a702a9@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Dec 2008 22:32:27 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> Except there is no controller in front of the NOR.  It's all just
> MMIOs.  With NDFC, there is a controller, you have to do things to it
> to talk to different chips, etc.

Ok, I have the following dts working... would this be better? It
basically follows the fsl,upm-nand model. I can produce a new patch to
ndfc.c for this:

ndfc@1,0 {
	compatible = "amcc,ndfc";
	reg = <0x00000001 0x00000000 0x00002000>;
	ccr = <0x00001000>;
	bank-settings = <0x80002222>;
	#address-cells = <1>;
	#size-cells = <1>;

	nand {
    		#address-cells = <1>;
    		#size-cells = <1>;

    		partition@0 {
    			label = "kernel";
    			reg = <0x00000000 0x00200000>;
    		};
    		partition@200000 {
    			label = "root";
    			reg = <0x00200000 0x03E00000>;
    		};	
    		partition@40000000 {
    			label = "persistent";
    			reg = <0x04000000 0x04000000>;
    		};
    		partition@80000000 {
    			label = "persistent1";
    			reg = <0x08000000 0x04000000>;
    		};
    		partition@C0000000 {
    			label = "persistent2";
    			reg = <0x0C000000 0x04000000>;
    		};
    	};
};


Here is the boot output for both the NOR and the NAND (just for
comparison):

ffc00000.nor: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
ffc00000.nor: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 4 MTD partitions on "ffc00000.nor":
0x00000000-0x00020000 : "splash"
0x00300000-0x00340000 : "fpga"
0x00340000-0x00380000 : "env"
0x00380000-0x00400000 : "u-boot"
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 3,3V 8-bit)
Scanning device for bad blocks
Creating 5 MTD partitions on "d0000000.ndfc.nand":
0x00000000-0x00200000 : "kernel"
0x00200000-0x04000000 : "root"
0x04000000-0x08000000 : "persistent"
0x08000000-0x0c000000 : "persistent1"
0x0c000000-0x10000000 : "persistent2"

If everybody likes this better, I can produce a code patch.

Cheers,
   Sean
