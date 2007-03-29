Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BE92DDE46
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 07:27:10 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l2TLR0qs025835
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 23:27:00 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <460C2F0F.3050808@246tNt.com>
Date: Thu, 29 Mar 2007 23:26:39 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: publishing OF platform devices
References: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
In-Reply-To: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
> I have a question about the "right" way to publish platform
> devices via of_platform_bus_probe.
>
> On 5200 platforms it gets called from
> mpc52xx_declare_of_platform_devices which is registered as the
> machdep_calls init routine.
>   
It's called by machdep calls so that it's only called if the platform is
detected ...
> On other platforms it is called via a device_initcall
>   
That will always be called which is bad.

Because if you have a kernel will multiple platform support built in, it
will
be called everytime, even if it's not running on the good platform.
> Also I noticed that some 83xx platforms don't call
> of_platform_bus_probe at all.  Thats ok because most of those devices
> are register various routines in fsl_soc.c.  The one I have not
> figured out yet is spi, I don't see anyone registering mpc83xx_spi?
>   
On theses I have no idea ...

    Sylvain
