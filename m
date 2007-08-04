Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E36BADDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 09:17:01 +1000 (EST)
Date: Sun, 5 Aug 2007 01:17:07 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-serial@vger.kernel.org
Subject: 8250.c::autoconfig() fails loopback test on MPC824[15]
Message-ID: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
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

Hi,

I tried using of_serial.c on a (PPC) MPC8241 based system, which has a 
"16650A" compatible double UART built into the SoC. Using of_serial.c 
causes the ports to be autoconfigured, and this fails. The loopback test 
fails, because the MSR register on 824[15] doesn't implement the 
UART_MSR_DCD bit. Question: what's better, teach 8250.c to handle UARTs 
without this bit, or set the UPF_SKIP_TEST bit in of_serial.c for these 
SOCs to skip the loopback test altogether? The latter is certainly easier 
and affects much fewer systems, so, I'd go for that.

Thanks
Guennadi
---
Guennadi Liakhovetski
