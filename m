Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A1432DE42D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:33:06 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Strange behavior with I2C on Sequoia board
Date: Thu, 21 Aug 2008 16:32:36 +0200
References: <48AC84D9.8050809@harris.com> <48AD5FD1.1090809@ru.mvista.com>
	<48AD6D3B.6030701@harris.com>
In-Reply-To: <48AD6D3B.6030701@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211632.36633.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Steven A. Falco wrote:
> Your diagnosis is correct!  I changed the define from 8<<20 to 8<<21 and it
> now boots.  Previously the parameters were at 7ffe70, and this change moved
> them to fffe70.

Good.

> I would like to switch over to using a uImage rather than the
> cuboot.uImage. But I have not figured out whether it is the U-boot build
> that converts the .dts to a .dtb or if the kernel build should do that. 

The dts is part of the kernel source, so its part of the kernel build 
procedure. You can either do this by hand or use the "make kilauea.dtb" 
target.

See also:

http://www.denx.de/wiki/DULG/LinuxFDTBlob

> Also, I have not figured out whether the .dtb can remain part of the kernel
> image, as it is with the cuboot kernel, or if the .dtb must be a separate
> image in a different part of the rom.

When you use uImage, then U-Boot needs the dtb additionally to the kernel 
image. Those two images (and more) can be combined to a single image using 
the new U-Boot image format FIT (Flattened Image Tree) though.

Best regards,
Stefan
