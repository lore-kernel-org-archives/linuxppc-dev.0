Return-Path: <lee.nipper@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 1695AB7BC5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:42:28 +1100 (EST)
Received: by ewy10 with SMTP id 10so46608ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Nov 2009 06:42:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849F9AFBA@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E849F9AFBA@ex01.ads.ubidyne.de>
Date: Thu, 5 Nov 2009 08:42:21 -0600
Message-ID: <eabe9a7b0911050642k516f9fb3ud5c9ef944dd75585@mail.gmail.com>
Subject: Re: System hangs when exceeding a certain initramfs size
From: Lee Nipper <lee.nipper@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 5, 2009 at 04:02, Frank Prepelica
<Frank.Prepelica@ubidyne.com> wrote:
>
> I experience the issue when the kernel image (including the initramfs)
> exceeds a
> certain size (>6MB) that after unpacking the kernel the systems hangs
> at:
>
> bootm 2000000 - 3000000
> ## Booting image at 02000000 ...
> =A0 Image Name: =A0 Linux-2.6.29
> =A0 Created: =A0 =A0 =A02009-11-04 =A014:25:01 UTC
> =A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)
> =A0 Data Size: =A0 =A06798037 Bytes =3D =A06.5 MB
> =A0 Load Address: 00000000
> =A0 Entry Point: =A000000000
> =A0 Verifying Checksum ... OK
> =A0 Uncompressing Kernel Image ... OK
> =A0 Booting using the fdt at 0x3000000
> =A0 Loading Device Tree to 00ffc000, end 00ffefff ... OK
>
>
> I've found some hints regarding this problem (load_address in the
> wrapper script)
> but this doesn't works for me.
>
> I'm using Kernel v2.6.29 and U-Boot v1.3.0 on a customized MPC8313ERDB
> board
>

I think it's possibly because the expansion of the compressed image
extends into the region where u-boot puts the device tree (0x00FFC000).
I remember seeing this situation with 2.6.31 when using a large initramfs.

If this _is_ this case, it would be useful if there were a way to
protect against clobbering a loaded device tree with kernel/initramfs.

ln
