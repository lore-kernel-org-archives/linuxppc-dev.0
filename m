Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id E8484DDFEE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 12:16:15 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so4297946wra.1
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 19:16:13 -0700 (PDT)
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807170058.53599.arnd@arndb.de>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<200807161646.02306.arnd@arndb.de>
	<20080716154646.GH24045@secretlab.ca>
	<200807170058.53599.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 22:15:53 -0400
Message-Id: <1216260953.13063.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 00:58 +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2008, Grant Likely wrote:
> > 
> > > Shouldn't it be enough to have a common compatible value in each
> > > of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
> > > specific type unless you need to do something special?
> > 
> > This is bad for the same reason that "amcc,44x-<blah>" compatible values
> > are bad in device nodes.  The definition of '*-44x-*' changes over time as
> > new parts are added.  Compatible values should always reflect an exact
> > part number.
> 
> I agree in general, but I also think that all 44x boards should be
> regarded as the same machine time, in the same way that all powermacs
> are detected as compatible with "Power Macintosh" or "MacRISC", or
> how all sorts of serial ports claim compatibility with i8250.
> 
> For classic SOCs like 4xx or 52xx, the SOC familiy more or less defines
> the platform, and all the details about peripherals can be expressed
> in the device tree elsewhere.

This is what Grant has done for 52xx and what I was talking about with
"4xx_board.c", though 4xx_soc.c is probably a better name.

My hesitation is that while it's true today that 440<chip name> defines
the SoC, it might not always be.  And the Virtex boards are craziness
with the core and FPGA setup.  So we need to be careful a bit when
chosing what do "bind" to for generics.

> If one board is so different that you need a separate board setup
> in the kernel, it should simply not claim compatibility with the
> SOC platform.

Right.  Today we only have a few "overrides" in 4xx.  Namely
Canyonlands/Glacier, and Bamboo/Yosemite (Sequoia/Rainier should also
really be that way, but they aren't).  So if we decide to go to a
different scheme, it shouldn't be a big deal to switch.

josh
