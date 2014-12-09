Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B5471A0267
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 20:45:03 +1100 (AEDT)
In-Reply-To: <20141208063039.14356.34770.stgit@localhost.localdomain>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
Message-Id: <20141209094503.100F81400DE@ozlabs.org>
Date: Tue,  9 Dec 2014 20:45:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.

>  arch/powerpc/include/asm/opal.h                    |   29 ++
>  arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 
>  arch/powerpc/platforms/powernv/opal.c              |   11 +

This had major conflicts in the above files.

I've fixed it up but please check I did it correctly:

  https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c

It also doesn't build as a module:

  $ grep CONFIG_I2C_OPAL .config
  CONFIG_I2C_OPAL=m
  $ make ...
  ...
  ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!

cheers
