Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.246])
	by ozlabs.org (Postfix) with ESMTP id 37A96DE05A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:15:35 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1158411hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 14:15:34 -0700 (PDT)
Message-ID: <fa686aa40804211415q7a477651q3b1b516a5fb262e5@mail.gmail.com>
Date: Mon, 21 Apr 2008 15:15:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
In-Reply-To: <20080421164128.GA28561@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
	<fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
	<20080421143313.GB18008@polina.dev.rtsoft.ru>
	<20080421144938.GA25627@polina.dev.rtsoft.ru>
	<fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
	<20080421164128.GA28561@polina.dev.rtsoft.ru>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 10:41 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Mon, Apr 21, 2008 at 08:58:09AM -0600, Grant Likely wrote:
>  > Its not great.  It has a boot time impact for every platform compiled
>  > into the kernel.  The problem gets worse every time another block of
>  > code uses this method.  Personally I prefer platform code calling it
>  > explicitly.
>  >
>  > Making it an of_platform device would also eliminate that problem, but
>  > you'd need a method to synchronize the driver with its users.
>  >
>  > I'm not going to raise a big stink about it, but the issue should not
>  > be ignored.
>
>  Heh.. how QE GPIO is different from FSL GTM then? Should I call
>  fsl_gtm_init() from the board file too? For the every board? I do
>  believe that years later someone will show up with something like this:
>
>
>   From: J. Random Hacker
>   Subject: [POWERPC] cleanup board initialization code
>
>   This patch removes vast amount of machine_arch_initcall()s that were
>   used to solely initialize some hardware, like this:
>
>   qe_add_gpio_chips();
>   fsl_gtm_init();
>   fsl_spi_init();

Or have a soc-level helper function for calling them for you; but yes.

And, no, we shouldn't have a vast array of individual initcalls
because the platform code shouldn't be that large.  As much as
possible, multiple boards should be supported by the same platform
code.  I argue that most boards using the same SoC should use the same
platform code. (see platforms/52xx/mpc5200_simple.c)

Individual calls has the added advantage that if a board port needs
those functions to *not* be called (for whatever reason) then it has
the ability to not call them.

It is for the same reason that the platform code is responsible for
calling of_platform_bus_probe() instead of it being an initcall; it
give the platform code control over the device registrations.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
