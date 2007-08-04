Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D93F5DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 09:35:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 01:35:07 +0200
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708050135.07753.arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> I tried using of_serial.c on a (PPC) MPC8241 based system, which has a 
> "16650A" compatible double UART built into the SoC. Using of_serial.c 
> causes the ports to be autoconfigured, and this fails. The loopback test 
> fails, because the MSR register on 824[15] doesn't implement the 
> UART_MSR_DCD bit. Question: what's better, teach 8250.c to handle UARTs 
> without this bit, or set the UPF_SKIP_TEST bit in of_serial.c for these 
> SOCs to skip the loopback test altogether? The latter is certainly easier 
> and affects much fewer systems, so, I'd go for that.

Yes, that sounds good. Just make sure you test the "compatible" property
in the device node for something appropriate. In of_platform_serial_probe(),
you can then do something like

	if (of_device_is_compatible(ofdev, "mpc8241-serial"))
		flags |= UPF_SKIP_TEST;

	Arnd <><
