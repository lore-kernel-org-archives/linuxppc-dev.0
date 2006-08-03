Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060803201441.C8A89352660@atlas.denx.de>
References: <20060803201441.C8A89352660@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 15:20:38 -0500
Message-Id: <1154636438.5094.45.camel@localhost>
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

On Thu, 2006-08-03 at 22:14 +0200, Wolfgang Denk wrote:
> Both approaches seem broken to me.
> 
> You should make sure that  your  bootstrap  code  comes  *after*  the
> kernel  image,  so  you  can  load  the  whole blob at address 0x0000
> (mkimage option "-a 0") while starting  it  at  the  bootstrap  entry
> point (mkimage option "-e <your_address>").

However, currently the zImage has an elfheader which will come before
the code. But, since we are making a new target we don't actually need
to preserve this. I like this idea. I will look into it further.

> 
> This way U-Boot will load (and if necessary  uncompress)  the  kernel
> image plus your attached bootstrap code to it's normal start address.
> Then  it starts your bootstrap code which can fixup DTB and then just
> start the kernel.
> 

We do not need to worry about this with cuImage because the kernel
section will not be compressed. If compression is desired it will be
done at the U-Boot level (were U-Boot would do the uncompressing).

> Please avoid any aditional memory copy. It's not necessary.
> 

Agreed.

-Matthew
