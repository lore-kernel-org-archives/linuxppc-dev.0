Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 4D306DE311
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 23:55:33 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so147673anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 06:55:32 -0700 (PDT)
Message-ID: <fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
Date: Fri, 11 Apr 2008 07:55:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: zImage.embedded
In-Reply-To: <014701c89bda$09380060$ad289e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <014701c89bda$09380060$ad289e86@LPSC0173W>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 7:43 AM, Guillaume Dargaud
<dargaud@lpsc.in2p3.fr> wrote:
> Hello all,
>
>  I'm not sure what kind of error this is. I'm trying to generate a kernel
> image suitable for network boot and it seems to fail at the very end (wrong
> target ?)
>
>  $ make ARCH=ppc CROSS_COMPILE=powerpc-linux-uclibc-  znetboot
>
>  powerpc-linux-uclibc-objcopy -O elf32-powerpc arch/ppc/boot/simple/zvmlinux
> arch/ppc/boot/simple/zvmlinux -R .comment -R .stab \
>                -R .stabstr -R .ramdisk
>  cp -f arch/ppc/boot/simple/zvmlinux arch/ppc/boot/images/zImage.elf
>  rm -f arch/ppc/boot/simple/zvmlinux
>  cp arch/ppc/boot/images/zImage.embedded /tftpboot/zImage.embedded
>  cp: cannot stat `arch/ppc/boot/images/zImage.embedded': No such file or
> directory
>  make[2]: *** [znetboot] Error 1
>  make[1]: *** [simple] Error 2
>  make: *** [znetboot] Error 2
>
>  is the file zImage.elf my proper network image ?

What bootloader is on your board?  zImage.elf *might* be the proper
image.  If you're using u-boot, then you want to build a uImage
instead.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
