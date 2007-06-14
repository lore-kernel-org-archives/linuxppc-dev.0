Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 3D576DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 20:32:14 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 14 Jun 2007 12:32:03 +0200
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class driver
	subsystem
Message-ID: <20070614103203.GA21400@iram.es>
References: <1181548600.5217.16.camel@mark> <20070611121145.GA11297@iram.es>
	<1181656776.3975.16.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181656776.3975.16.camel@mark>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2007 at 09:59:36PM +0800, Mark Zhan wrote:
> Hi Gabriel,
> 
> On Mon, 2007-06-11 at 14:11 +0200, Gabriel Paubert wrote:
> ....
> > There are other boards which have exactly the same chip, but use
> > a very different (uglier) access method: using ISA 2 I/O ports
> > (0x74 and 0x75) to write the address and another port (0x77) to 
> > read/write the data.
> > 
> > Besides that, these boards also use the NVRAM part which means that
> > a spinlock must be used to serialize between RTC and NVRAM access.
> > 
> > I have no idea whether the drivers should be shared or two
> > different drivers should be written... But if there are two
> > different drivers, there should be a way to distinguish them
> > (different config name, different module names, and some
> > explanation in the config help text).
> > 
> 
> I will rework this driver to add a platform data structure which enables
> the platform to provide the platform specific access method.

I'm not even sure that this is a good idea: the direct mapped nvram/RTC 
is much simpler, and adding another indirection layer transforms many 
leaf functions into non leaf one, which makes the code significantly bigger.

> 
> For the NVRAM issue, I have no idea how other boards access the NVRAM.
> So could you provide me more information?

That's the hardest problem. Since you use the same ISA (yuck) I/O
ports to access the NVRAM and the RTC (after all it is the same chip,
using the same address pins), the accesses need to be serialized
through a shared spinlock. 

With a direct mapped like your machine, the drivers can be completely 
independent: they will never step on each other's toes. 

I've not yet made up my mind on which is the best way to handle
the problem and am leaving tomorrow for about 1 week. For
now I think that your patch is fine (using NO_IRQ as I suggested)
and I shall revisit it when time comes to port the kernel
to these boards (running 2.2 for 8 years, it's not a few
more months to switch to 2.6 that matters).

	Regards,
	Gabriel
