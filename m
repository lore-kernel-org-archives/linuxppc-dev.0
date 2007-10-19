Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C0CDFDDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 00:20:02 +1000 (EST)
Date: Fri, 19 Oct 2007 18:19:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071019141932.GA20582@localhost.localdomain>
References: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
	<20071018180104.GB16748@localhost.localdomain>
	<C2A61B74-FDB4-4571-A2F4-F0B7317FD7C7@kernel.crashing.org>
	<20071018222927.GA1475@zarina>
	<E7D255D6-D30B-4457-898D-1FC601F35A4B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <E7D255D6-D30B-4457-898D-1FC601F35A4B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 08:23:19AM -0500, Kumar Gala wrote:
>
> On Oct 18, 2007, at 5:29 PM, Anton Vorontsov wrote:
>
>> On Thu, Oct 18, 2007 at 02:58:25PM -0500, Kumar Gala wrote:
>> [...]
>>>> +
>>>> +		flash@0,0 {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
>>>> +			reg = <0 0 2000000>;
>>>> +			bank-width = <2>;
>>>> +			device-width = <1>;
>>>> +
>>>
>>> Are you basing the partition map on something or making it up?
>>> Clearly hrcw & u-boot are at fixed offsets, wondering about kernel &
>>> rootfs?
>>
>> I'm making it up. From the brief look at the u-boot* git sources,
>> there is no `flashboot` yet, thus I'm free to make this up...
>>
>> I've partitioned this flash based on these thoughts:
>>
>> 1. HRCW - whole sector, to not wear out it, plus it's impossible to
>>    create just 64 bytes partition;
>
> this makes sense.

[Unrelated to the patch.

I've tried to erase first (hrcw) sector, everything passes fine, but
`md fe000000` still gives data back. Probably some hardware magic used
to prevent this? ;-)

=> erase fe000000 fe03ffff

.. done
Erased 2 sectors
=> md fe000000
fe000000: 42424242 42424242 05050505 05050505    BBBBBBBB........
fe000010: 00000000 00000000 83838383 83838383    ................
fe000020: a0a0a0a0 a0a0a0a0 60606060 60606060    ........````````
...
=> md fe020000
fe020000: ffffffff ffffffff ffffffff ffffffff    ................
...]

>
>> 2. Kernel - 2MB, should be enough for bootup kernels?
>
> seems reasonable.
>
>> 3. Rootfs - the rest up to...
>
> do we need a small section for the device tree?

Yes, apparently. :-)

>> 4. U-Boot at the end.
>
> can we reorder partitions?  not sure if there is any value in having the 
> things we know will always be there like hrcw & u-boot at fixed mtd0, mtd1, 
> etc.

Good idea.

>>
>> I'm not saying that it's best map ever, I'm open to suggestions. ;-)
>>
>> * Unfortunately I didn't look at the stock Freescale u-boot, maybe
>>   there was flashboot, most probably.. I'll find the CD to look this
>>   up.
>
> Yeah I have no idea what we ship w/regards to the BSPs.

Here it is:

bootcmd=run ramargs;cp.b fff00000 400000 2000;bootm ff800000 ffa00000 400000

I.e.

0xFF800000 - kernel
0xFFA00000 - ramdisk
0xFFF00000 - dtb, one sector


Reworked patch (lbus+flash) follow, using this stock partitions map:

0x00000000-0x00020000 : "hrcw"    <- 128   kB
0x01f80000-0x02000000 : "u-boot"  <- 512   kB
0x00020000-0x01800000 : "rootfs"  <- 24448 kB
0x01800000-0x01a00000 : "kernel"  <- 2048  kB
0x01a00000-0x01f00000 : "ramdisk" <- 5120  kB
0x01f00000-0x01f20000 : "dtb"     <- 128   kB
0x01f20000-0x01f80000 : "spare"   <- 384   kB

I'm not sure about "ramdisk" partition though, maybe concatenate
kernel+ramdisk to use with initramfs kernels instead?

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] [POWERPC] MPC8568E-MDS: create localbus node, add flash support

This patch:

- creates localbus node;
- moves bcsr into it;
- creates flash node (1 32MB Spansion x16 CFI) and its partitions;
- adds localbus to the probe path.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |   61 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 5439437..8ddeaf8 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -42,9 +42,64 @@
 		reg = <00000000 10000000>;
 	};
 
-	bcsr@f8000000 {
-		device_type = "board-control";
-		reg = <f8000000 8000>;
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8568-localbus";
+		reg = <e0005000 d8>;
+		ranges = <1 0 f8000000 0008000
+			  0 0 fe000000 2000000>;
+
+		bcsr@1,0 {
+			device_type = "board-control";
+			reg = <1 0 8000>;
+		};
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
+			reg = <0 0 2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			hrcw@0 {
+				label = "hrcw";
+				reg = <0 20000>;
+				read-only;
+			};
+
+			uboot@1f80000 {
+				label = "u-boot";
+				reg = <1f80000 80000>;
+				read-only;
+			};
+
+			rootfs@20000 {
+				label = "rootfs";
+				reg = <20000 17e0000>;
+			};
+
+			kernel@1800000 {
+				label = "kernel";
+				reg = <1800000 200000>;
+			};
+
+			ramdisk@1a00000 {
+				label = "ramdisk";
+				reg = <1a00000 500000>;
+			};
+
+			dtb@1f00000 {
+				label = "dtb";
+				reg = <1f00000 20000>;
+			};
+
+			spare@1f20000 {
+				label = "spare";
+				reg = <1f20000 60000>;
+			};
+		};
 	};
 
 	soc8568@e0000000 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..45ffca4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -139,6 +139,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "qe", },
+	{ .compatible = "fsl,mpc8568-localbus", },
 	{},
 };
 
-- 
1.5.0.6
