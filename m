Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5FF2C67A58
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 12:10:17 +1100 (EST)
Date: Tue, 21 Mar 2006 19:10:12 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
Message-Id: <20060321191012.2ef20179.kim.phillips@freescale.com>
In-Reply-To: <3C6218C3-3FC0-437E-A798-3AD6FEB69713@kernel.crashing.org>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
	<20060321114806.6bcf3885.kim.phillips@freescale.com>
	<3C6218C3-3FC0-437E-A798-3AD6FEB69713@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Mar 2006 12:21:47 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> Drop the part about Most modern... in five years when someone reads  
> this it will not be modern anymore.
> 
[snip]
> 
> ditto about modern.
> 
[snip]
> 
> Would this be a bit more clear, if you explicitly stated that the  
> DESC_TYPE value directly corresponds to the bit encoding, like you  
> did for EU_SEL0.
> 
[snip]

ok, here's the replacement replacement patch with the above fixes:


Documentation: Added FSL SOC SEC node definition

Updated the documentation to include the definition of the SEC device
node format for Freescale SOC devices.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
commit e1e1b8f7d958d7f25a0085ec529a3ebbd6dc1fa5
tree 2e2b12fe07b6d367da4c5609971178838c9321a2
parent 6b0efd3e3b07afc9fc7222066b0b37ecd1d31e44
author Kim Phillips <kim.phillips@freescale.com> Tue, 21 Mar 2006 16:43:16 -0600
committer Kim Phillips <kim.phillips@freescale.com> Tue, 21 Mar 2006 16:43:16 -0600

 Documentation/powerpc/booting-without-of.txt |   72 ++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index d02c649..d6626b6 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1365,6 +1365,78 @@ platforms are moved over to use the flat
        };


+   g) Freescale SOC SEC Security Engines
+
+   Required properties:
+
+    - device_type : Should be "crypto"
+    - model : Model of the device.  Should be "SEC1" or "SEC2"
+    - compatible : Should be "talitos"
+    - reg : Offset and length of the register set for the device
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+    - num-channels : An integer representing the number of channels
+      available.
+    - channel-fifo-len : An integer representing the number of
+      descriptor pointers each channel fetch fifo can hold.
+    - exec-units-mask : The bitmask representing what execution units
+      (EUs) are available. It's a single 32 bit cell. EU information
+      should be encoded following the SEC's Descriptor Header Dword
+      EU_SEL0 field documentation, i.e. as follows:
+
+        bit 0 = reserved - should be 0
+        bit 1 = set if SEC has the ARC4 EU (AFEU)
+        bit 2 = set if SEC has the DES/3DES EU (DEU)
+        bit 3 = set if SEC has the message digest EU (MDEU)
+        bit 4 = set if SEC has the random number generator EU (RNG)
+        bit 5 = set if SEC has the public key EU (PKEU)
+        bit 6 = set if SEC has the AES EU (AESU)
+        bit 7 = set if SEC has the Kasumi EU (KEU)
+
+      bits 8 through 31 are reserved for future SEC EUs.
+
+    - descriptor-types-mask : The bitmask representing what descriptors
+      are available. It's a single 32 bit cell. Descriptor type
+      information should be encoded following the SEC's Descriptor
+      Header Dword DESC_TYPE field documentation, i.e. as follows:
+
+        bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
+        bit 1  = set if SEC supports the ipsec_esp descriptor type
+        bit 2  = set if SEC supports the common_nonsnoop desc. type
+        bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
+        bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
+        bit 5  = set if SEC supports the srtp descriptor type
+        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
+        bit 7  = set if SEC supports the pkeu_assemble descriptor type
+        bit 8  = set if SEC supports the aesu_key_expand_output desc.type
+        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
+        bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
+        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
+
+      ..and so on and so forth.
+
+  Example:
+
+       /* MPC8548E */
+       crypto@30000 {
+               device_type = "crypto";
+               model = "SEC2";
+               compatible = "talitos";
+               reg = <30000 10000>;
+               interrupts = <1d 3>;
+               interrupt-parent = <40000>;
+               num-channels = <4>;
+               channel-fifo-len = <24>;
+               exec-units-mask = <000000fe>;
+               descriptor-types-mask = <073f1127>;
+       };
+
+
    More devices will be defined as this spec matures.
