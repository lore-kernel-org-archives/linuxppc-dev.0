Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91DA1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:21:51 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B32C14003E
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 21:21:50 +1100 (AEDT)
Message-ID: <1418120492.13358.45.camel@kernel.crashing.org>
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 09 Dec 2014 21:21:32 +1100
In-Reply-To: <20141209094503.100F81400DE@ozlabs.org>
References: <20141209094503.100F81400DE@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, wsa@the-dreams.de, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 20:45 +1100, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
> 
> >  arch/powerpc/include/asm/opal.h                    |   29 ++
> >  arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 
> >  arch/powerpc/platforms/powernv/opal.c              |   11 +
> 
> This had major conflicts in the above files.
> 
> I've fixed it up but please check I did it correctly:
> 
>   https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c
> 
> It also doesn't build as a module:
> 
>   $ grep CONFIG_I2C_OPAL .config
>   CONFIG_I2C_OPAL=m
>   $ make ...
>   ...
>   ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!

Right that needs to be exported, however for those OPAL wrappers to work
when exported as modules on an LE kernel with ABI v2 (pfiew !) we need
another patch from jk to sort out the external entry to the asm...

Jeremy, is that already in or not yet ?

Cheers,
Ben.

> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
