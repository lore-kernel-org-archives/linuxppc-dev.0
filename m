Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060803200043.0EF78352660@atlas.denx.de>
References: <20060803200043.0EF78352660@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 15:12:18 -0500
Message-Id: <1154635939.5094.37.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 22:00 +0200, Wolfgang Denk wrote:
> > So to clarify. The current method has a zImage with a compressed
> kernel
> 
> No, it does not. We do  not  use  zImage  (which  includes  bootstrap
> wrapper  code).  U-Boot  uses  a plain stripped and compressed kernel
> image, i. e. something like this:
> 
>         objcopy  -O binary vmlinux vmlinux.bin
>         gzip -f -9 <vmlinux.bin >vmlinux.gz
>         mkimage ... -C gzip -d vmlinux.gz uImage 

I'm referring to the zImage target as what the current method does. My
changes would in no way effect the current method of booting, with the
current method being a plain uImage target.

The zImage can have a compressed kernel section or an uncompressed
kernel section. The new 'cuImage' always has an uncompressed kernel
section and which is packaged in the U-Boot image format.

You might refer to the code in my original email for clarification. This
in no way effects the current method of booting, it simply adds a method
to package the bootwrapper + kernel + fdt to pass to old version of
U-Boot so they can use the new 'powerpc' kernels

As a side note, the final cuImage (which is a U-Boot image) can be
either compressed or uncompressed. That is irrelevant. The major point
is the kernel section within the cuImage is not compressed, and the
final cuImage is in fact a U-Boot image which can be started with the
'bootm' command from within U-Boot.

Phew!

-Matthew
