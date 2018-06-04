Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfb4R9GzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:31 +1000 (AEST)
In-Reply-To: <20180329060246.9970-1-stewart@linux.ibm.com>
To: Stewart Smith <stewart@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.ibm.com>
Subject: Re: hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()
Message-Id: <40zxfb0Fltz9ryk@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-29 at 06:02:46 UTC, Stewart Smith wrote:
> time_init() will set up tb_ticks_per_usec based on reality.
> time_init() is called *after* udbg_init_opal_common() during boot.
> 
> from arch/powerpc/kernel/time.c:
>   unsigned long tb_ticks_per_usec = 100; /* sane default */
> 
> Currently, all powernv systems have a timebase frequency of 512mhz
> (512000000/1000000 == 0x200) - although there's nothing written
> down anywhere that I can find saying that we couldn't make that
> different based on the requirements in the ISA.
> 
> So, we've been (accidentally) thwacking the (currently) correct
> (for powernv at least) value for tb_ticks_per_usec earlier than
> we otherwise would have.
> 
> The "sane default" seems to be adequate for our purposes between
> udbg_init_opal_common() and time_init() being called, and if it isn't,
> then we should probably be setting it somewhere that isn't hvc_opal.c!
> 
> Signed-off-by: Stewart Smith <stewart@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/447808bf500a7cc92173266a59f8a4

cheers
