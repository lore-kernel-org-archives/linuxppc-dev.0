Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C98ADDDEF5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 13:45:15 +1100 (EST)
Date: Mon, 8 Dec 2008 21:45:12 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081208214512.461276d2@lappy.seanm.ca>
In-Reply-To: <20081209021115.GA13948@oksana.dev.rtsoft.ru>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
	<20081208193446.37e27e26@lappy.seanm.ca>
	<20081209021115.GA13948@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 9 Dec 2008 05:11:15 +0300
"Anton Vorontsov" <avorontsov@ru.mvista.com> wrote:

> So this is a controller with partitions? ;-)

Actually, I did it this way to mimic the look of the NOR. Really, we
shouldn't care about the NAND chip.

Here is the complete NOR and NAND DTS:

nor@0,0 {
	compatible = "amd,s29gl032a", "cfi-flash";
	bank-width = <2>;
	reg = <0x00000000 0x00000000 0x00400000>;
	#address-cells = <1>;
	#size-cells = <1>;

	partition@0 {
		label = "splash";
		reg = <0x00000000 0x00020000>;
	};
	partition@300000 {
		label = "fpga";
		reg = <0x0300000 0x00040000>;
	};
	partition@340000 {
		label = "env";
		reg = <0x0340000 0x00040000>;
	};
	partition@380000 {
		label = "u-boot";
		reg = <0x0380000 0x00080000>;
	};
};

nand@1,0 {
	compatible = "amcc,ndfc";
	reg = <0x00000001 0x00000000 0x00002000>;
	ccr = <0x00001000>;
	bank-settings = <0x80002222>;
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

Now I know I am cheating a bit.... but it does make it *look*
consistent.

But comments are welcome. I also could remove the partitions for now. A
partially supported NDFC is better than none at all.

Cheers,
   Sean
