Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 37BE9DE092
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 00:06:14 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so352190anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 07:06:13 -0700 (PDT)
Message-ID: <fa686aa40805090706q572b44e9n2b39a6808562b2ad@mail.gmail.com>
Date: Fri, 9 May 2008 08:06:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Fabri <rider4ever@gmail.com>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <ed84ed090805090651g65ab474fk13d549e7166c3f1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
	<4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
	<482317E2.7000308@libero.it>
	<fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
	<ed84ed090805090640w11dcfc57r1303ac4fceb482cb@mail.gmail.com>
	<ed84ed090805090651g65ab474fk13d549e7166c3f1c@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Fabio Tosetto <tosettofabio83@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

See if this patch makes any difference for you:

diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite520
index 8505e97..70d9a8e 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -342,4 +342,8 @@
                          0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
                          0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
        };
+
+       chosen {
+               linux,stdout-path = "/soc5200@f0000000/serial@2000";
+       };
 };


Oh, and the fix I told you about (fixing the unterminated list) didn't
make it into 2.6.25.2.  You still need to manually apply it.  It
should be in 2.6.25.3.

Cheers,
g.

On Fri, May 9, 2008 at 7:51 AM, Fabri <rider4ever@gmail.com> wrote:
> Errage corrige: Excuse me, bad cut and paste :)
> This is the right output of the first try
>
> ## Booting image at 03000000 ...
>   Image Name:   Linux-2.6.25.2
>   Created:      2008-05-09  12:46:22 UTC
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1518744 Bytes =  1.4 MB
>   Load Address: 00400000
>   Entry Point:  00400550
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 04000000 ...
>  Image Name:   RamDisk Image Lite5200b
>  Created:      2008-03-04  11:28:40 UTC
>  Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>  Data Size:    1135278 Bytes = 1109 kB
>  Load Address: 00000000
>  Entry Point:  00000000
>  Verifying Checksum ... OK
>  Loading Ramdisk to 0fe68000, end 0ff7d2ae ... OK
>
> By the way, Grant, you seem to be very expert in making a kernel with
> ARCH=powerpc. Can you tell me how to find some docs to improve my
> knowledge in this field? I've found something interesting in
> Documentation/powerpc, but they are not too explicative about the
> differences between PPC/Powerpc building, and about how to make the
> last one.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
