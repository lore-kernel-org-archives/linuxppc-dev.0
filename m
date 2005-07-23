Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 076BA67D81
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 00:48:44 +1000 (EST)
Date: Sat, 23 Jul 2005 07:48:42 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Yasushi SHOJI <yashi@atmark-techno.com>
Message-ID: <20050723074842.C5431@cox.net>
References: <87hdeuosmq.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87hdeuosmq.wl@mail2.atmark-techno.com>;
	from yashi@atmark-techno.com on Sun, Jul 17, 2005 at 03:26:21PM
	+0900
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ppc_sys.c with platform device model or create opb bus?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jul 17, 2005 at 03:26:21PM +0900, Yasushi SHOJI wrote:
> Hi all,
> 
> I've been reading some posts regarding to the transition of OCP to
> platform device mode while searching for a good way to implement a
> device driver for our fpga base platform. And now I have one question
> regarding to ppc_sys.c
> 
>   should I use ppc_sys_*() for platform like fpga?
> 
> since I'm working on FPGA base platform, ppc_sys_spec seems to be too
> static. that is, IMHO, having static array of device list isn't ideal
> for a dynamic system like fpga.
> 
> I feel that the ppc_sys_spec is for SoC, which doesn't dynamically
> change the peripherals it has.  otoh, fpga based platform can have
> arbitrary number of devices if you configured so.
> 
> I usually implement a device with PLB or OPB.  for those bus, should I
> use platform device model or create new buses for each?

Use the platform model.  When you run into a case that can't be
handled properly then the platform model should be expanded to handle
it. If you instantiate a "platform device" by configuring the FPGA
from userspace then that's a hotplug event.  The platform model
should be extended to handle hotplug for these kind of cases since
they are pretty common.

-Matt
