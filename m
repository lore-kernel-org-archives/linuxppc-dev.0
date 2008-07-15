Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 7DEBCDDF23
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jul 2008 16:36:33 +1000 (EST)
Message-ID: <487C45F7.80504@coritel.it>
Date: Tue, 15 Jul 2008 08:38:47 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Alemao <xcarandiru@gmail.com>
Subject: Re: NAND Flash, Localbus and UPM
References: <d970ff420807140747s10d8276bt3a378a7cd5a4333d@mail.gmail.com>
In-Reply-To: <d970ff420807140747s10d8276bt3a378a7cd5a4333d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alemao ha scritto:
> Hi all,
> 
> Im trying to use a NAND flash (NAND512W3A, from ST) in MPC8360
> localbus, with UPM.
> My board is based on the mpc8360erdk. I also have a NOR flash
> connected in the localbus.
> 
> But I have some doubts in how to put this information at the DTS file.
> Im doing this way:
> 
>        soc8360@e0000000 {
>               .
>               .
>               .
>        };
> 
>        localbus@e0005000 {
>                 compatible = "fsl,mpc8360-localbus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 reg = <e0005000 d8>;
> 
>                 ranges = <0 0 ff800000   1000000      // nor flash,  16 MB
>                                   1 0 60000000 4000000>;   // nand
> flash, 64 MB (512 Mb)
> 
>                 nor-flash@0,0 {
>                         compatible = "amd,s29glxxx", "cfi-flash";
>                         reg = <0 0 40000>;
>                         bank-width = <2>;
>                         device-width = <1>;
>                 };
> 
>                 nand-flash@1,0 {
>                         compatible = "stmicro,NAND512W3A", "fsl,upm-nand";
>                         reg = <1 0 4000000>;   //reg = <1 0 1>;
>                         width = <1>;
>                         upm = "A";
>                         upm-addr-offset = <16>;
>                         upm-cmd-offset = <8>;
>                         gpios = <4 18>;
>                         gpio-parent = <&qe_pio>;
>                         wait-pattern;
>                         wait-write;
>                 };
>        };
> 

Maybe it'd be better:

          NOR: flash@0,0 {
                  compatible = "amd,s29glxxx", "cfi-flash";
                  reg = <0 0 40000>;
                  bank-width = <2>;
                  device-width = <1>;
          };

          NAND: flash@1,0 {
                  compatible = "stmicro,NAND512W3A", fsl,upm-nand";
                  reg = <1 0 4000000>;   //reg = <1 0 1>;
                  width = <1>;
                  upm = "A";
                  upm-addr-offset = <16>;
                  upm-cmd-offset = <8>;
                  gpios = <4 18>;

> 
> 
> In range information:
> 
> ranges = <0 0 ff800000 1000000         // nor flash,  16 MB
>                    1 0 60000000 4000000>;   // nand flash, 64 MB (512 Mb)
> 
> i dont know what ff800000 and 60000000 means,

They are the physical addresses. You have to write the addresses 
according to your memory map.

> i got those values from some posts in the mail-list. I also searched
> the datasheet and didnt find anything about those values.
> 
> The size values, 1000000 and 4000000, im using the memory density.
> Is this correct? Cause i read some posts that the nand size was very
> small, like 32K, seems that its something like the block size of
> nand.
> 

Ok the last value is the size.

> 
> 
> In reg information:
> 
> reg = <0 0 1000000>;    // nor-flash
> reg = <1 0 4000000>;    // nand-flash
> 
> Dont know if its correct. The third argument i used the size,
> but the second i dont know what value use.
> 

Ok, right. The second value is simply an offset.

> 
> 
> In other post by Anton, i saw something like these:
> 
>        upm@1,0 {		
> 		flash {		
> 	           ...
>         	};
>        };
> 
> 
> Should i use it?

No I think it's not needed, however, follow the instruction of 
booting-without-of.txt. In this guide you can find all the nodes you can 
use.

> 
> I must confess, im really confuse about all this stuffs.
> I read linux/Documentation/powerpc/booting-without-of.txt but didnt
> clarify so much.
> 
> Cheers,
> 
> --
> Alemao
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
