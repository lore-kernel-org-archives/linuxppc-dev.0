Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlc6S3BzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:20 +1100 (AEDT)
In-Reply-To: <1483659589-23208-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Enable IO path on permanent error
Message-Id: <3v3Qlc5vMCz9t8j@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-05 at 23:39:49 UTC, Gavin Shan wrote:
> We give up recovery on permanent error, simply shutdown the affected
> devices and remove them. If the devices can't be put into quiet state,
> they spew more traffic that is likely to cause another unexpected EEH
> error. This was observed on "p8dtu2u" machine:
> 
>    0002:00:00.0 PCI bridge: IBM Device 03dc
>    0002:01:00.0 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.1 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.2 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.3 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
> 
> On P8 PowerNV platform, the IO path is frozen when shutdowning the
> devices, meaning the memory registers are inaccessible. It is why
> the devices can't be put into quiet state before removing them.
> This fixes the issue by enabling IO path prior to putting the devices
> into quiet state.
> 
> Link: https://github.com/open-power/supermicro-openpower/issues/419
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/387bbc974f6adf91aa635090f73434

cheers
