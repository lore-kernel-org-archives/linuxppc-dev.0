Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CFF46818E
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 17:21:48 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 2 Sep 2005 09:21:36 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050902072136.GA19676@iram.es>
References: <20050901183808.GA23764@localhost.localdomain>
	<86F3DB1B-C396-45F4-8DBA-87176648D143@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86F3DB1B-C396-45F4-8DBA-87176648D143@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Christian <evil@g-house.de>
Subject: Re: use of rtc.c on chrp/prep?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 01, 2005 at 01:47:36PM -0500, Kumar Gala wrote:
> On Sep 1, 2005, at 1:38 PM, Sven Luther wrote:
> 
> >On Thu, Sep 01, 2005 at 12:57:55PM -0500, Kumar Gala wrote:
> >
> >>Does anyone enable CONFIG_RTC on chrp/prep?  Tom tells me these are
> >>the only platforms that it is even valid to do so on.
> >>
> >
> >The debian powerpc kernels enables :
> >
> >  $ grep RTC /boot/config-2.6.12-1-powerpc
> >  CONFIG_GEN_RTC=y
> >  CONFIG_GEN_RTC_X=y
> >
> >and not the CONFIG_RTC variant, and it works well on pegasos, and prep
> >boxes,
> >and probably on ibm chrps too, altough i have not tested personally.
> 
> Thanks, as far as I can tell no one is using CONFIG_RTC, which means  
> I can "fix" asm-ppc/mc146818rtc.h to no longer #define RTC_IRQ 8

For the record, on MVME boards with PowerPlus bridges, the RTC driver 
cannot work because the interrupt output is not connected. IRQ 8 is 
instead connected to a front panel switch labelled abort that nobody 
uses either (at least under Linux).

Anyway, there are better ways to obtain regularly spaced interrupts
on PPC. They are just not implemented (yet).

	Gabriel
