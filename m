Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CFF01DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 09:22:00 +1000 (EST)
Date: Fri, 24 Aug 2007 01:21:57 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Move serial_dev_init to device_initcall()
In-Reply-To: <20070823002637.GA24332@lixom.net>
Message-ID: <Pine.LNX.4.60.0708240117460.3246@poirot.grange>
References: <20070823002637.GA24332@lixom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 22 Aug 2007, Olof Johansson wrote:

> With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
> initcall is now called before I/O space is setup, but it's dependent on
> it being available.
> 
> Since there's no way to make dependencies between initcalls, we'll just
> have to move it to device_initcall(). Yes, it's suboptimal but I'm not
> aware of any better solution at this time.

Do I understand it right, that with this change all UARTs, controlled by 
legacy_serial will be initialized later, and that for example console 
output will be first possible later? Maybe, if there is really no other 
possibility for I/O space devices, we could have both calls

arch_initcall(serial_mem_dev_init);
device_initcall(serial_io_dev_init);

so, that at least MEMIO based UARTs could still initialize as before?

Thanks
Guennadi
---
Guennadi Liakhovetski
