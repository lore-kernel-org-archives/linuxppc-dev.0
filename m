Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4056qQ4FZdzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 20:20:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/5] powerpc/zImage: Rework serial driver probing
In-Reply-To: <20180319051403.23275-4-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
 <20180319051403.23275-4-oohall@gmail.com>
Date: Tue, 20 Mar 2018 20:20:49 +1100
Message-ID: <87lgenf6ha.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> Rather than checking the compatible string in serial_driver_init()
> we call into the driver's init function and wait for a driver to
> inidicate it bound to the device by returning zero.
>
> The pointers to each driver probe functions are stored in the
> ".serialdrv" section of the zImage, similar to how initcalls and
> whatnot are handled inside Linux. This structure allows us to
> conditionally compile specific driver files based on the KConfig
> settings. This is needed because we don't have access to the
> KConfig #defines in the zImage source files (it's a giant #include
> headache) so conditional compilation is the only way to eliminate
> unnecessary code.

Did you actually get the config.h include working? Or was it such a big
headache that it doesn't even work?

I'm pretty happy with this patch regardless, but it would be simpler and
less bug prone if the CONFIG_ symbols were usable in the boot code.

cheers
