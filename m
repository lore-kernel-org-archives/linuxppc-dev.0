Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 378EADDEEC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 11:34:50 +1100 (EST)
Date: Mon, 8 Dec 2008 19:34:46 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081208193446.37e27e26@lappy.seanm.ca>
In-Reply-To: <20081204090107.20269571@zod.rchland.ibm.com>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
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

On Thu, 4 Dec 2008 09:01:07 -0500
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> In addition to an example DTS patch (probably to warp itself), could
> you briefly write up a binding and put it in
> Documentation/powerpc/dts-bindings/amcc (or similar)?  Also please CC
> the devicetree-discuss list on that part.

Here is a start at the doc. I have sent it as a patch, but could just
as easily send raw text.

The example comes from the warp dts, just with less partitions, so I
have not included a warp dts patch here.

Cheers,
   Sean

diff --git a/Documentation/powerpc/dts-bindings/amcc/ndfc.txt
b/Documentation/powerpc/dts-bindings/amcc/ndfc.txt new file mode 100644
index 0000000..668f4a9
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/amcc/ndfc.txt
@@ -0,0 +1,31 @@
+AMCC NDFC (NanD Flash Controller)
+
+Required properties:
+- compatible : "amcc,ndfc".
+- reg : should specify chip select and size used for the chip (0x2000).
+
+Optional properties:
+- ccr : NDFC config and control register value (default 0).
+- bank-settings : NDFC bank configuration register value (default 0).
+- partition(s) - follows the OF MTD standard for partitions
+
+Example:
+
+nand@1,0 {
+	compatible = "amcc,ndfc";
+	reg = <0x00000001 0x00000000 0x00002000>;
+	ccr = <0x00001000>;
+	bank-settings = <0x80002222>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	partition@0 {
+		label = "kernel";
+		reg = <0x00000000 0x00200000>;
+	};
+	partition@200000 {
+		label = "root";
+		reg = <0x00200000 0x03E00000>;
+	};
+};
+
