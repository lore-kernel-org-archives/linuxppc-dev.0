Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFWHx0k6SzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 11:09:01 +1000 (AEST)
Message-ID: <1464224939.31009.2.camel@ellerman.id.au>
Subject: Re: how can i see the *actual* bus and brg frequencies on running
 system?
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, Linux PPC Mailing List
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 26 May 2016 11:08:59 +1000
In-Reply-To: <alpine.LFD.2.20.1605251052330.30194@localhost.localdomain>
References: <alpine.LFD.2.20.1605251052330.30194@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-25 at 10:59 -0400, Robert P. J. Day wrote:

>   i asked about this a while ago, didn't see any response, and i'm
> still curious ... i have an MPC8360 system, ported u-boot to it, and
> in the dts file i got from someone, the bus and brg frequencies were
> set to lower values than they should have been, but we left them there
> and, once the system was up, i tried to check what the *actual*
> frequencies were being used.
> 
>   i checked under both /proc/device-tree, and way down under /sys, and
> both showed lower frequencies, but one of the embedded guys wrote a
> utility to read the actual PPC register that contained the bus
> frequency, and assured us it was running at 533MHz, which is what we
> wanted all along.
> 
>   so dts stuff aside, is there a simple user space way to display the
> frequencies that are actually being used on the system? because it
> appears that what's under both /proc and /sys are showing only what is
> set in the device tree blob passed to the kernel, but that's not where
> the kernel is getting the final value from.

There is no generic way to ask parts of the system what frequency they're
running at.

The contents of /proc/device-tree should match exactly what is in the dts, or
whatever was put there by firmware.

If the frequency values are set in the dts then it's certainly possible they
don't match reality. There would need to be code in the firmware or kernel to
take the values in the dts and tell the hardware to use them.

If the value is set by firmware then you would hope it matches reality, but
firmware can have bugs.

> p.s. we got the BSP for this board from elsewhere, so it's possible
> that during kernel boot, the kernel has been patched to ignore what it
> sees in the DTB, and gets the value from somewhere unique to this BSP.

OK, so if you don't know what code you're using then anything could be
happening.

>   but still, if that's the case, should it not still be possible to
> view the frequency that was finally set and used on the running
> system?

Sure it's possible, you just need to write code to do it :)

cheers
