Return-Path: <wg@grandegger.com>
Message-ID: <48639491.90900@grandegger.com>
Date: Thu, 26 Jun 2008 15:07:29 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] booting-without-of: add more bindings for FSL UPM driver
References: <484CECE2.9050605@grandegger.com>
	<519f1a6d9baeca8cfea9e8ad7a92c4d4@kernel.crashing.org>
	<484D49FF.4090604@grandegger.com>
	<a9f4227722f169bc9c2e712df774b748@kernel.crashing.org>
In-Reply-To: <a9f4227722f169bc9c2e712df774b748@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Segher,

Segher Boessenkool wrote:
>>>> +      - chip-delay : may specify a delay value in milliseconds.
>>>
>>> Delay for what?  The binding should say.  "chip-delay" is a bit
>>> too generic name as well, it could be more descriptive perhaps.
>>
>> The chip-delay property defines an appropriate maximum delay
>> time (tR) required for read operations if the R/B pin is not
>> connected.
> 
> Yeah.  So please put that in the binding.
> 
>>> Shouldn't this be a property of the NAND device anyway, not the
>>> NAND controller?
>>
>> Strictly speaking, it's a property of the NAND device. Therefore it
>> should be inside the node nand@0, I thhink:
>>
>> +            nand@0 {
>> +                #address-cells = <1>;
>> +                #size-cells = <1>;
>> +                    chip-delay = <25>; // in micro-seconds
> 
> Something like that, yes.  You wrote milliseconds before; which is it?
> 
> And, a better property name, please.
> 
>> Where should that be documented?
> 
> In the binding for nand devices.  If there isn't any yet, it might be
> best to include that with the binding for your nand controller (i.e.,
> describe the whole sub node there).

This is another try to get this binding accepted. Below is my revised
patch introducing the proper "read-fetch-delay" for the sub-nodes of
the FSL UPM nodes and documenting all other options as well.

What do you think?

Wolfgang.


From: Wolfgang Grandegger <wg@grandegger.com>
Subject: booting-without-of: add more bindings for FSL UPM driver

This patch adds the bindings for the property "read-fetch-delay" to the
sub-nodes of the "fsl,upm-nand" compatible nodes. It is used by the patch
"[NAND] driver extension to support NAND on TQM85xx modules" posted to
this list some time ago:

      http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057632.html

Furthermore it documents all other properties of the sub-nodes.

Note: this patch is based on the following patches from Anton
      Vorontsov posted to this list some time ago:

      http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056531.html
      http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057244.html

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/booting-without-of.txt |   34 +++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

Index: linux-2.6-galak/Documentation/powerpc/booting-without-of.txt
===================================================================
--- linux-2.6-galak.orig/Documentation/powerpc/booting-without-of.txt
+++ linux-2.6-galak/Documentation/powerpc/booting-without-of.txt
@@ -3036,6 +3036,28 @@ platforms are moved over to use the flat
       - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
       - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
 
+      Each NAND flash is represented as a sub-node of the UPM node.
+      The nodes's name represents the name of the corresponding device.
+
+      NAND flash properties:
+      - compatible : not yet used.
+      - read-fetch-delay : chip dependent delay for transfering data
+        from array to read regs (tR).
+
+      Each partition is represented as a sub-node of the NAND flash device.
+      Each node's name represents the name of the corresponding partition
+      of the flash device.
+
+      NAND flash partitions:
+      - reg : The partition's offset and size within the flash bank.
+      - label : (optional) The label / name for this flash partition. If
+        omitted, the label is taken from the node name (excluding the
+        unit address).
+      - read-only : (optional) This parameter, if present, is a hint to
+        Linux that this flash partition should only be mounted read-only.
+        This is usually used for flash partitions containing early-boot
+        firmware images or data which should not be clobbered.
+
       Example:
 
 	upm@1,0 {
@@ -3049,9 +3071,17 @@ platforms are moved over to use the flat
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "stmicro,NAND512W3A2BN6E";
+			read-fetch-delay = 25
+
+			fs@0 {
+				label = "fs";
+				reg = <0 f80000>;
+			};
 
-			partition@0 {
-				...
+			firmware@f80000 {
+				label ="firmware";
+				reg = <f80000 80000>;
+				read-only;
 			};
 		};
 	};
