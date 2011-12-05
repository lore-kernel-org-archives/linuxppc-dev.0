Return-Path: <alexander.lyasin@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
 [209.85.214.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF7661007D4
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2011 23:59:21 +1100 (EST)
Received: by bkcjf3 with SMTP id jf3so1199660bkc.15
 for <linuxppc-dev@ozlabs.org>; Mon, 05 Dec 2011 04:59:17 -0800 (PST)
From: Alexander Lyasin <alexander.lyasin@gmail.com>
Date: Mon, 5 Dec 2011 19:02:34 +0500
MIME-Version: 1.0
To: galak@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Problem with eLBC?
Content-Type: multipart/alternative; boundary="Boundary-01=_77M3O37aUwpKJ10"
Message-Id: <201112051902.35285.alexander.lyasin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Boundary-01=_77M3O37aUwpKJ10
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Kumar Gala!

Our company is a client Freescale company, we use mpc8308, mpc8321 and other 
microprocessors. 
I have a board on the mpc8308 chip. This board runs the Linux kernel.
On this board there is NAND flash and DSP proc. on the Local Bus.
Chunk from DTS-file is below:

        localbus@e0005000 {
                #address-cells = <2>;
                #size-cells = <1>;
                compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
                reg = <0xe0005000 0x1000>;
                interrupts = <77 0x8>;
                interrupt-parent = <&ipic>;

                // CS0 and CS1 are swapped when
                // booting from nand, but the
                // addresses are the same.
                ranges = <0x0 0x0 0xfe000000 0x00800000
                          0x1 0x0 0xe0600000 0x00002000
                          0x2 0x0 0xf0000000 0x00020000
                          0x3 0x0 0xfa000000 0x00008000>;

                nand@1,0 {
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "fsl,mpc8315-fcm-nand",
                                     "fsl,elbc-fcm-nand";
                        reg = <0x1 0x0 0x2000>;

                        u-boot@0 {
                                reg = <0x0 0x100000>;
                                read-only;
                                label = "U-Boot-NAND";
                        };
                        dtb@100000 {
                                reg = <0x100000 0x40000>;
                                read-only;
                                label = "DTB-NAND";
                        };
                        kernel@140000 {
                                reg = <0x140000 0x200000>;
                                read-only;
                                label = "Kernel-NAND";
                        };
                        jffs2@340000 {
                                reg = <0x00340000 0x01c00000>;
                                label = "JFFS2-NAND";
                        };
                        reserve@1f40000 {
                                reg = <0x01f40000 0x000c0000>;
                                label = "Reserve";
                        };
                };

                dsp0@D0020000 {
                        reg = <0xD0020000 0x10000>;
                        interrupts = <18 0x8>;
                        interrupt-parent = <&ipic>;
                        dsp0;
                };

                dsp1@D0030000 {
                        reg = <0xD0030000 0x10000>;
                        interrupts = <19 0x8>;
                        interrupt-parent = <&ipic>;
                        dsp1;
                };

User-level application periodically reads data from the DSP and writes the 
data to the DSP via a character device. When the application is reading from 
DSP or writing to the DSP, file system calls to cause errors:

[root@mpc8308-kd-124 /root]# ls -l                                                                                                                           
mtd->read(0xdc bytes from 0x8af524) returned ECC error                                                                                                       
mtd->read(0x1fc bytes from 0x8aee04) returned ECC error                                                                                                      
mtd->read(0xac bytes from 0x8ae554) returned ECC error                                                                                                       
mtd->read(0x200 bytes from 0x8adc00) returned ECC error
..............
..............
...............
when writing to flash errors occur following items:

Write of 1662 bytes at 0x01935244 failed. returned -5, retlen 0                                                                                              
Not marking the space at 0x01935244 as dirty because the flash driver returned 
retlen zero                                                                   
Write of 1662 bytes at 0x01930000 failed. returned -5, retlen 0                                                                                              
Not marking the space at 0x01930000 as dirty because the flash driver returned 
retlen zero                                                                   
nand_erase: start = 0x000001c70000, len = 16384                                                                                                              
nand_isbad_bbt(): bbt info for offs 0x01c70000: (block 1820) 0x00                                                                                            
nand_write_oob: to = 0x01c70000, len = 8                                                                                                                     
cannot write OOB for EB at 01930000, requested 8 bytes, read 0 bytes, error -5

I write to support this problem and I was told the following:

	In reply to your Service Request SR 1-807899446: 

	Yes, due to several design peculiarities in local bus nand controller, 		
	simultaneous accesses to nand flash and to other local bus memory 		
	controller may cause nand flash controller access failure. Our linux team 	
	suggested to use "software lock" method to avoid this problem - please do 
	not use other local bus controllers, when nand flash is accessed. 

	Thank you for your interest in Freescale Semiconductor products and for 		
	the opportunity to serve you.
	Best regards.

Do you think, Kumar, how can solve this problem? Perhaps this problem is not 
in eLBS?

Alexander V. Lyasin <alexander.lyasin@gmail.com>
Linux system developer
TAKT Inc

--Boundary-01=_77M3O37aUwpKJ10
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Dear Kumar Gala!</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Our company is a client Freescale company, we use mpc8308, mpc8321 and other microprocessors. </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I have a board on the mpc8308 chip. This board runs the Linux kernel.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On this board there is NAND flash and DSP proc. on the Local Bus.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Chunk from DTS-file is below:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">        localbus@e0005000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                #address-cells = &lt;2&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                #size-cells = &lt;1&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                compatible = &quot;fsl,mpc8315-elbc&quot;, &quot;fsl,elbc&quot;, &quot;simple-bus&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                reg = &lt;0xe0005000 0x1000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                interrupts = &lt;77 0x8&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                interrupt-parent = &lt;&amp;ipic&gt;;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                // CS0 and CS1 are swapped when</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                // booting from nand, but the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                // addresses are the same.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                ranges = &lt;0x0 0x0 0xfe000000 0x00800000</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                          0x1 0x0 0xe0600000 0x00002000</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                          0x2 0x0 0xf0000000 0x00020000</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                          0x3 0x0 0xfa000000 0x00008000&gt;;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                nand@1,0 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        #address-cells = &lt;1&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        #size-cells = &lt;1&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        compatible = &quot;fsl,mpc8315-fcm-nand&quot;,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                     &quot;fsl,elbc-fcm-nand&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        reg = &lt;0x1 0x0 0x2000&gt;;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        u-boot@0 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                reg = &lt;0x0 0x100000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                read-only;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                label = &quot;U-Boot-NAND&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        };</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        dtb@100000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                reg = &lt;0x100000 0x40000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                read-only;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                label = &quot;DTB-NAND&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        };</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        kernel@140000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                reg = &lt;0x140000 0x200000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                read-only;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                label = &quot;Kernel-NAND&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        };</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        jffs2@340000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                reg = &lt;0x00340000 0x01c00000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                label = &quot;JFFS2-NAND&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        };</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        reserve@1f40000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                reg = &lt;0x01f40000 0x000c0000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                                label = &quot;Reserve&quot;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        };</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                };</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                dsp0@D0020000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        reg = &lt;0xD0020000 0x10000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        interrupts = &lt;18 0x8&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        interrupt-parent = &lt;&amp;ipic&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        dsp0;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                };</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                dsp1@D0030000 {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        reg = &lt;0xD0030000 0x10000&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        interrupts = &lt;19 0x8&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        interrupt-parent = &lt;&amp;ipic&gt;;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                        dsp1;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">                };</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a name="result_box"></a>User-level application periodically reads data from the DSP and writes the data to the DSP via a character device. <a name="gt-res-content"></a>When the application is reading from DSP or writing to the DSP, file system calls to cause errors:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">[root@mpc8308-kd-124 /root]# ls -l                                                                                                                           </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">mtd-&gt;read(0xdc bytes from 0x8af524) returned ECC error                                                                                                       </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">mtd-&gt;read(0x1fc bytes from 0x8aee04) returned ECC error                                                                                                      </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">mtd-&gt;read(0xac bytes from 0x8ae554) returned ECC error                                                                                                       </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">mtd-&gt;read(0x200 bytes from 0x8adc00) returned ECC error</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">..............</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">..............</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">...............</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a name="result_box"></a>when writing to flash errors occur following items:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Write of 1662 bytes at 0x01935244 failed. returned -5, retlen 0                                                                                              </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Not marking the space at 0x01935244 as dirty because the flash driver returned retlen zero                                                                   </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Write of 1662 bytes at 0x01930000 failed. returned -5, retlen 0                                                                                              </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Not marking the space at 0x01930000 as dirty because the flash driver returned retlen zero                                                                   </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">nand_erase: start = 0x000001c70000, len = 16384                                                                                                              </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">nand_isbad_bbt(): bbt info for offs 0x01c70000: (block 1820) 0x00                                                                                            </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">nand_write_oob: to = 0x01c70000, len = 8                                                                                                                     </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">cannot write OOB for EB at 01930000, requested 8 bytes, read 0 bytes, error -5</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I write to support this problem and <a name="result_box"></a>I was told the following:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br />	In reply to your Service Request SR 1-807899446: <br /><br />	Yes, due to several design peculiarities in local bus nand controller, 			simultaneous accesses to nand flash and to other local bus memory 			controller may cause nand flash controller access failure. Our linux team 		suggested to use &quot;software lock&quot; method to avoid this problem - please do 	not use other local bus controllers, when nand flash is accessed. <br /><br />	Thank you for your interest in Freescale Semiconductor products and for 			the opportunity to serve you.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	Best regards.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Do you think, Kumar, how can solve this problem? Perhaps this problem is not in eLBS?</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Alexander V. Lyasin &lt;alexander.lyasin@gmail.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Linux system developer</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">TAKT Inc</p></body></html>
--Boundary-01=_77M3O37aUwpKJ10--
