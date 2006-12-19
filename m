Return-Path: <vitalywool@gmail.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 84658DDEC0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 02:44:12 +1100 (EST)
Date: Tue, 19 Dec 2006 18:44:25 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH][trivial][respin] update MTD OF documentation
Message-Id: <20061219184425.d924c4c2.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dwmw2@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

the patch below updates the Documentation/powerpc part of the MTD OF implementation with the new field probe-type. Its support has already been implemented in MTD part (drivers/mtd/maps/physmap_of.c).

 Documentation/powerpc/booting-without-of.txt |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b3bd366..3399427 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1703,29 +1703,32 @@ platforms are moved over to use the flat
     Required properties:
 
      - device_type : has to be "rom"
-     - compatible : Should specify what this ROM device is compatible with
-       (i.e. "onenand"). Currently, this is most likely to be "direct-mapped"
-       (which corresponds to the MTD physmap mapping driver).
-     - regs : Offset and length of the register set (or memory mapping) for
+     - compatible : Should specify what this flash device is compatible with.
+       Currently, this is most likely to be "direct-mapped" (which
+       corresponds to the MTD physmap mapping driver).
+     - reg : Offset and length of the register set (or memory mapping) for
        the device.
+     - bank-width : Width of the flash data bus in bytes. Required
+       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
 
     Recommended properties :
 
-     - bank-width : Width of the flash data bus in bytes. Required
-       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
      - partitions : Several pairs of 32-bit values where the first value is
        partition's offset from the start of the device and the second one is
        partition size in bytes with LSB used to signify a read only
-       partititon (so, the parition size should always be an even number).
+       partition (so, the parition size should always be an even number).
      - partition-names : The list of concatenated zero terminated strings
        representing the partition names.
+     - probe-type : The type of probe which should be done for the chip
+       (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
 
    Example:
 
  	flash@ff000000 {
  		device_type = "rom";
  		compatible = "direct-mapped";
- 		regs = <ff000000 01000000>;
+ 		probe-type = "CFI";
+ 		reg = <ff000000 01000000>;
  		bank-width = <4>;
  		partitions = <00000000 00f80000
  			      00f80000 00080001>;
