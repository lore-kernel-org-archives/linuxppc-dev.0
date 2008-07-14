Return-Path: <xcarandiru@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id F1115DDF52
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jul 2008 00:47:39 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2210203ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 07:47:33 -0700 (PDT)
Message-ID: <d970ff420807140747s10d8276bt3a378a7cd5a4333d@mail.gmail.com>
Date: Mon, 14 Jul 2008 11:47:32 -0300
From: Alemao <xcarandiru@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: NAND Flash, Localbus and UPM
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Im trying to use a NAND flash (NAND512W3A, from ST) in MPC8360
localbus, with UPM.
My board is based on the mpc8360erdk. I also have a NOR flash
connected in the localbus.

But I have some doubts in how to put this information at the DTS file.
Im doing this way:

       soc8360@e0000000 {
              .
              .
              .
       };

       localbus@e0005000 {
                compatible = "fsl,mpc8360-localbus";
                #address-cells = <2>;
                #size-cells = <1>;
                reg = <e0005000 d8>;

                ranges = <0 0 ff800000   1000000      // nor flash,  16 MB
                                  1 0 60000000 4000000>;   // nand
flash, 64 MB (512 Mb)

                nor-flash@0,0 {
                        compatible = "amd,s29glxxx", "cfi-flash";
                        reg = <0 0 40000>;
                        bank-width = <2>;
                        device-width = <1>;
                };

                nand-flash@1,0 {
                        compatible = "stmicro,NAND512W3A", "fsl,upm-nand";
                        reg = <1 0 4000000>;   //reg = <1 0 1>;
                        width = <1>;
                        upm = "A";
                        upm-addr-offset = <16>;
                        upm-cmd-offset = <8>;
                        gpios = <4 18>;
                        gpio-parent = <&qe_pio>;
                        wait-pattern;
                        wait-write;
                };
       };



In range information:

ranges = <0 0 ff800000 1000000         // nor flash,  16 MB
                   1 0 60000000 4000000>;   // nand flash, 64 MB (512 Mb)

i dont know what ff800000 and 60000000 means,
i got those values from some posts in the mail-list. I also searched
the datasheet and didnt find anything about those values.

The size values, 1000000 and 4000000, im using the memory density.
Is this correct? Cause i read some posts that the nand size was very
small, like 32K, seems that its something like the block size of
nand.



In reg information:

reg = <0 0 1000000>;    // nor-flash
reg = <1 0 4000000>;    // nand-flash

Dont know if its correct. The third argument i used the size,
but the second i dont know what value use.



In other post by Anton, i saw something like these:

       upm@1,0 {		
		flash {		
	           ...
        	};
       };


Should i use it?

I must confess, im really confuse about all this stuffs.
I read linux/Documentation/powerpc/booting-without-of.txt but didnt
clarify so much.

Cheers,

--
Alemao
