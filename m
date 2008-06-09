Return-Path: <wg@grandegger.com>
Message-ID: <484D49FF.4090604@grandegger.com>
Date: Mon, 09 Jun 2008 17:19:27 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] booting-without-of: add more bindings for FSL UPM driver
References: <484CECE2.9050605@grandegger.com>
	<519f1a6d9baeca8cfea9e8ad7a92c4d4@kernel.crashing.org>
In-Reply-To: <519f1a6d9baeca8cfea9e8ad7a92c4d4@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +      - chip-delay : may specify a delay value in milliseconds.
> 
> Delay for what?  The binding should say.  "chip-delay" is a bit
> too generic name as well, it could be more descriptive perhaps.

The chip-delay property defines an appropriate maximum delay 
time (tR) required for read operations if the R/B pin is not
connected. It's used as shown below:

+		/* Note: NAND support needs to be enabled in U-Boot */
+		upm@3,0 {
+			#address-cells = <0>;
+			#size-cells = <0>;
+			compatible = "fsl,upm-nand";
+			reg = <3 0x0 0x800>;
+			fsl,upm-addr-offset = <0x10>;
+			fsl,upm-cmd-offset = <0x08>;
+			chip-delay = <25>; // in micro-seconds
+
+			nand@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					    label = "fs";
+					    reg = <0x00000000 0x01000000>;
+				};
+			};
+		};
+	};
+

> Shouldn't this be a property of the NAND device anyway, not the
> NAND controller?

Strictly speaking, it's a property of the NAND device. Therefore it 
should be inside the node nand@0, I thhink:

+			nand@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+			        chip-delay = <25>; // in micro-seconds
+
+				partition@0 {
+					    label = "fs";
+					    reg = <0x00000000 0x01000000>;
+				};
+			};

Where should that be documented?

Wolfgang.
