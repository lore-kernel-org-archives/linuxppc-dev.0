Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t10604s0kzDvcx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:02:32 +1100 (AEDT)
In-Reply-To: <4a99340c-b773-51e4-0466-3d9a72ac83b2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: powerpc/boot: fix boot on systems with uncompressed kernel image
Message-Id: <3t10603krCz9t0p@ozlabs.org>
Date: Sat, 22 Oct 2016 09:02:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-12-10 at 19:00:43 UTC, Heiner Kallweit wrote:
> This commit broke boot on systems with an uncompressed kernel image,
> namely systems using a cuImage. On such systems the compressed boot
> image (boot wrapper, uncompressed kernel image, ..) is decompressed
> by u-boot already, therefore the boot wrapper code sees an
> uncompressed kernel image.
> 
> The old decompression code silently assumed an uncompressed kernel
> image if it found no valid gzip signature, whilst the new code
> bailed out in this case.
> 
> Fix this by re-introducing such a fallback if no valid compressed
> image is found.
> 
> Fixes: 1b7898ee276b ("Use the pre-boot decompression API")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/65bc3ece84ef6340cbd80eec10ab9b

cheers
