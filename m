Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 17619679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 07:33:26 +1100 (EST)
Date: Wed, 22 Mar 2006 14:33:12 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add FSL SEC node to documentation (whitespace fixed)
Message-Id: <20060322143312.6339cb81.kim.phillips@freescale.com>
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

Documentation: Added FSL SOC SEC node definition

Updated the documentation to include the definition of the SEC device
node format for Freescale SOC devices.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
commit e51555b4bad3188afa02821eb4433929e4293002
tree 41d27e57f82c0f4cd93d323cca027fb995b2e508
parent dd126d5545e6e1bd584b90c0f9da35b7183e08cf
author Kim Phillips <kim.phillips@freescale.com> Wed, 22 Mar 2006 13:56:17 -0600
committer Kim Phillips <kim.phillips@freescale.com> Wed, 22 Mar 2006 13:56:17 -0600

 Documentation/powerpc/booting-without-of.txt |   72 ++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index d02c649..a90dc85 100644
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
+   Example:
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
 
 
