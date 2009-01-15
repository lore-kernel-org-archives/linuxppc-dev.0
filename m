Return-Path: <jhautbois@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id DE957DE2FA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 00:10:02 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so132624eyd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 05:10:00 -0800 (PST)
Message-ID: <8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
Date: Thu, 15 Jan 2009 14:10:00 +0100
From: "Jean-Michel Hautbois" <jhautbois@gmail.com>
To: "Anatolij Gustschin" <agust@denx.de>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
In-Reply-To: <496F318D.6010302@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9654_6238053.1232025000390"
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_9654_6238053.1232025000390
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2009/1/15 Anatolij Gustschin <agust@denx.de>

> Jean-Michel Hautbois wrote:
>
> > I have a MPC8272ADS board, 64MB RAM, 8MB Flash.
> > I compiled u-boot using the existing config file, and compiled my linux
> > kernel successfully with the defconfig file too.
> >
> > I have updated u-boot, downloaded my kernel file, and a ramdisk image
> > from the eldk distribution.
> > I have tried using a lot of bootargs (
> > bootargs root=/dev/ram rw console=ttyS0,115200
> > bootargs through nfs, etc.)
> >
> > When I am resetting my card, it reboots:
> > bootargs=root=/dev/ram rw console=ttyS0,115200
> > bootcmd=bootm ff800000 ff980000
>
> you also need to build a device tree blob for mpc8272ads, load it
> into RAM or flash and boot using "bootm" command as follows:
>
> => bootm ff800000 ff980000 %FDT_ADDR%"
>
> See also http://www.denx.de/wiki/view/DULG/BootingEmbeddedLinux
>
> Best regards,
> Anatolij


I just tried. I created a dtb from the file
arch/powerpc/boot/dst/mpc8272ads.dts file.
It is not rebboting, but handling (my "run" led is switching off).

=> tftp 2000000 mpc8272ads.dtb
Using FCC1 ETHERNET device
TFTP from server 10.0.0.1; our IP address is 10.0.0.2
Filename 'mpc8272ads.dtb'.
Load address: 0x2000000
Loading: #
done
Bytes transferred = 4442 (115a hex)
=> bootm FF800000 FF980000 2000000
## Booting kernel from Legacy Image at ff800000 ...
   Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1487167 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff980000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1730966 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02000000
   Booting using the fdt blob at 0x2000000
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 039d7000, end 03b7d996 ... OK
   Loading Device Tree to 007fb000, end 007ff159 ... OK
Unable to update property /cpus/cpu@0:bus-frequency, err=FDT_ERR_NOTFOUND
Unable to update property /cpus/cpu@0:timebase-frequency,
err=FDT_ERR_NOTFOUND
Unable to update property /cpus/cpu@0:clock-frequency, err=FDT_ERR_NOTFOUND

------=_Part_9654_6238053.1232025000390
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote">2009/1/15 Anatolij Gustschin <span dir="ltr">&lt;<a href="mailto:agust@denx.de">agust@denx.de</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Jean-Michel Hautbois wrote:<br>
<br>
&gt; I have a MPC8272ADS board, 64MB RAM, 8MB Flash.<br>
&gt; I compiled u-boot using the existing config file, and compiled my linux<br>
&gt; kernel successfully with the defconfig file too.<br>
&gt;<br>
&gt; I have updated u-boot, downloaded my kernel file, and a ramdisk image<br>
&gt; from the eldk distribution.<br>
&gt; I have tried using a lot of bootargs (<br>
&gt; bootargs root=/dev/ram rw console=ttyS0,115200<br>
&gt; bootargs through nfs, etc.)<br>
&gt;<br>
&gt; When I am resetting my card, it reboots:<br>
&gt; bootargs=root=/dev/ram rw console=ttyS0,115200<br>
&gt; bootcmd=bootm ff800000 ff980000<br>
<br>
</div>you also need to build a device tree blob for mpc8272ads, load it<br>
into RAM or flash and boot using &quot;bootm&quot; command as follows:<br>
<br>
=&gt; bootm ff800000 ff980000 %FDT_ADDR%&quot;<br>
<br>
See also <a href="http://www.denx.de/wiki/view/DULG/BootingEmbeddedLinux" target="_blank">http://www.denx.de/wiki/view/DULG/BootingEmbeddedLinux</a><br>
<br>
Best regards,<br>
<font color="#888888">Anatolij</font></blockquote><div><br>I just tried. I created a dtb from the file arch/powerpc/boot/dst/mpc8272ads.dts file.<br>It is not rebboting, but handling (my &quot;run&quot; led is switching off).<br>
<br>=&gt; tftp 2000000 mpc8272ads.dtb<br>Using FCC1 ETHERNET device<br>TFTP from server 10.0.0.1; our IP address is 10.0.0.2<br>Filename &#39;mpc8272ads.dtb&#39;.<br>Load address: 0x2000000<br>Loading: #<br>done<br>Bytes transferred = 4442 (115a hex)<br>
=&gt; bootm FF800000 FF980000 2000000<br>## Booting kernel from Legacy Image at ff800000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.29-rc1-01197-g5a7b6e7-<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1487167 Bytes =&nbsp; 1.4 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>## Loading init Ramdisk from Legacy Image at ff980000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Simple Embedded Linux Framework<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1730966 Bytes =&nbsp; 1.7 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>## Flattened Device Tree blob at 02000000<br>&nbsp;&nbsp; Booting using the fdt blob at 0x2000000<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 039d7000, end 03b7d996 ... OK<br>&nbsp;&nbsp; Loading Device Tree to 007fb000, end 007ff159 ... OK<br>Unable to update property /cpus/cpu@0:bus-frequency, err=FDT_ERR_NOTFOUND<br>
Unable to update property /cpus/cpu@0:timebase-frequency, err=FDT_ERR_NOTFOUND<br>Unable to update property /cpus/cpu@0:clock-frequency, err=FDT_ERR_NOTFOUND<br></div></div><br>

------=_Part_9654_6238053.1232025000390--
