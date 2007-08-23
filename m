Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 790ABDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 10:10:08 +1000 (EST)
Date: Thu, 23 Aug 2007 18:15:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] Move serial_dev_init to device_initcall()
Message-ID: <20070823231510.GA5619@lixom.net>
References: <20070823002637.GA24332@lixom.net>
	<Pine.LNX.4.60.0708240117460.3246@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0708240117460.3246@poirot.grange>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 01:21:57AM +0200, Guennadi Liakhovetski wrote:
> On Wed, 22 Aug 2007, Olof Johansson wrote:
> 
> > With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
> > initcall is now called before I/O space is setup, but it's dependent on
> > it being available.
> > 
> > Since there's no way to make dependencies between initcalls, we'll just
> > have to move it to device_initcall(). Yes, it's suboptimal but I'm not
> > aware of any better solution at this time.
> 
> Do I understand it right, that with this change all UARTs, controlled by 
> legacy_serial will be initialized later, and that for example console 
> output will be first possible later?

Yes, unfortunately. Unless they've got a udbg driver, since that
would give console output during early boot anyway (even without using
EARLY_DEBUG).

> Maybe, if there is really no other 
> possibility for I/O space devices, we could have both calls
>
> arch_initcall(serial_mem_dev_init);
> device_initcall(serial_io_dev_init);
> 
> so, that at least MEMIO based UARTs could still initialize as before?

That's quite a hack, I hope we can avoid it. Maybe Ben has some suggestion
on how to get the IO setup earlier instead.


-Olof
