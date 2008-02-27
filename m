Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id 81E9DDDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Feb 2008 03:25:32 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2813023wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Feb 2008 08:25:30 -0800 (PST)
Message-ID: <dda529d0802270825p527fd1b5i3e5a72a16bd95a75@mail.gmail.com>
Date: Wed, 27 Feb 2008 16:25:30 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.25-rc3 on mpc8548amc doesn't boot
In-Reply-To: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7200_31653630.1204129530183"
References: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7200_31653630.1204129530183
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

I am answering my self sorry for the spam...
Just to say that my problem has been solve if someone has something
similar...
My changes were good, I just didn't compile the good file...

cheers,
Maxime

On Wed, Feb 27, 2008 at 12:37 PM, maxime louvel <m.louvel@gmail.com> wrote:

> Hi,
>
> I am still trying to make a 2.6.25-rc3 vanilla kernel boot (an work fine
> in a second time) on a mpc8548amc board.
> I have add the platform specific stuff from the sources of the current
> kernel running on the cards.
> What I have basically add is:
> - arch/powerpc/platforms/85xx/mpc85xx_amc.c
> - arch/powerpc/boot/dts/mpc8548amc.dts
> I have also changed the Kconfig and Makefile in the
> arch/powerpc/platforms/85xx to make the kernel try to support my board
>
> I have encountered some problem when compiling a uImage that I have
> basically solve like this (in arch/powerpc/boot/Makefile)
> #$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
>
> I have a gcc-3.4.3 embedded compiler with some stuff specific to the
> platform.
>
> After the previous hack, I have been able to compile a uImage.
>
> I have tried to boot it and this is what I got:
> AMC=> bootm 0x1000000
> ## Booting image at 01000000 ...
>   Image Name:   Linux-2.6.24
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1802038 Bytes =  1.7 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>
> No further messages...
>
> I have recently updated the uboot of the cards (to support the new image
> version) and I am capable of booting a 2.6.23.6 image.
> This last image has been compiled from a vanilla kernel where I have add
> the platform specific stuff (cf beginning of this mail).
>
> Since my 2.6.23.6 image works fine, I have tried to adapt the file I have
> added to the 2.6.25-rc3 kernel.
>
> I have made some changes in the arch/powerpc/platforms/85xx/mpc85xx_amc.c
> file and in the mpc8548amc.dts file.
> I have attached the changes I have done on both files.
>
> Do you have an idea ?
>
> cheers,
> Maxime
>
> --
> Maxime Louvel
> 0044 7964 5555 80
> 43 Allen road
> Whitemore reans
> WV60AW Wolverhampton
> United Kingdom




-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_7200_31653630.1204129530183
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,<br><br>I am answering my self sorry for the spam...<br>Just to say that my problem has been solve if someone has something similar...<br>My changes were good, I just didn&#39;t compile the good file...<br><br>cheers,<br>
Maxime<br><br><div class="gmail_quote">On Wed, Feb 27, 2008 at 12:37 PM, maxime louvel &lt;<a href="mailto:m.louvel@gmail.com">m.louvel@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>I am still trying to make a 2.6.25-rc3 vanilla kernel boot (an work fine in a second time) on a mpc8548amc board.<br>I
have add the platform
specific stuff from the sources of the current kernel running on the
cards.<br>



What I have basically add is:<br>- arch/powerpc/platforms/85xx/mpc85xx_amc.c<br>- arch/powerpc/boot/dts/mpc8548amc.dts<br>I have also changed the Kconfig and Makefile in the arch/powerpc/platforms/85xx to make the kernel try to support my board<br>

<br>I have encountered some problem when compiling a uImage that I have basically solve like this (in arch/powerpc/boot/Makefile)<br>#$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405<br>

#$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405<br><br>I have a gcc-3.4.3 embedded compiler with some stuff specific to the platform.<br><br>After the previous hack, I have been able to compile a uImage.<br>

<br>I have tried to boot it and this is what I got:<br>AMC=&gt; bootm 0x1000000<br>## Booting image at 01000000 ...<br> &nbsp; Image Name: &nbsp; Linux-2.6.24<br> &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>





 &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br> &nbsp; Load Address: 00000000<br> &nbsp; Entry Point: &nbsp;00000000<br> &nbsp; Verifying Checksum ... OK<br> &nbsp; Uncompressing Kernel Image ... OK<br><br>No further messages...<br><br>I have recently updated the uboot of the cards (to support the new image version) and I am capable of booting a <a href="http://2.6.23.6" target="_blank">2.6.23.6</a> image.<br>

This last image has been compiled from a vanilla kernel where I have add the platform specific stuff (cf beginning of this mail).<br><br>Since my <a href="http://2.6.23.6" target="_blank">2.6.23.6</a> image works fine, I have tried to adapt the file I have added to the 2.6.25-rc3 kernel.<br>

<br>I have made some changes in the arch/powerpc/platforms/85xx/mpc85xx_amc.c file and in the mpc8548amc.dts file.<br>I have attached the changes I have done on both files.<br><br>Do you have an idea ?<br><br>cheers,<br>
Maxime<br clear="all"><font color="#888888">
<br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom
</font></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_7200_31653630.1204129530183--
