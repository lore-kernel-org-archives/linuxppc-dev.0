Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0D16679F5
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 14:14:17 +1000 (EST)
Subject: Re: Clock running fast on Mac Mini?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mich Lanners <mlan@cpu.lu>
In-Reply-To: <E1FY8kd-0000mH-PO@owl.grunz.lu>
References: <E1FY8kd-0000mH-PO@owl.grunz.lu>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 14:14:03 +1000
Message-Id: <1145938443.29938.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-24 at 23:37 +0200, Mich Lanners wrote:
> Hello all,
> 
> I have a problem on my Mac Mini with the kernel clock, which is running
> fast.
> 
> In fact, it is gaining 10 ms every 5 seconds, as can be seen here, with
> ntpdate called every 5 seconds:
> 
> owl:~# while true; do ntpdate -u be.pool.ntp.org; sleep 5; done
> 24 Apr 23:14:17 ntpdate[2601]: adjust time server 195.47.215.226 offset 0.151197 sec
> 24 Apr 23:14:22 ntpdate[2607]: adjust time server 195.47.215.226 offset 0.160348 sec
> 24 Apr 23:14:28 ntpdate[2613]: adjust time server 195.47.215.226 offset 0.170311 sec
> [...]
> 24 Apr 23:17:15 ntpdate[2813]: adjust time server 195.47.215.226 offset 0.489635 sec
> 24 Apr 23:17:20 ntpdate[2819]: adjust time server 195.47.215.226 offset 0.499386 sec
> 24 Apr 23:17:25 ntpdate[2825]: step time server 195.47.215.226 offset 0.509342 sec
> 24 Apr 23:17:31 ntpdate[2831]: adjust time server 195.47.215.226 offset 0.013693 sec
> 24 Apr 23:17:36 ntpdate[2837]: adjust time server 195.47.215.226 offset 0.021668 sec
> 
> and so on.
> 
> This is with ntpd stopped, after a fresh boot with /etc/adjtime removed
> to make sure hwclock is not falsly tuning the kernel timekeeping (I did
> this because I once had a 2.6.16 kernel running, where clock problems
> have been reported. I thought that may have falsified ntp's drift file
> and/or hwclock's /etc/adjtime).
> 
> All this is with a 2.6.15 kernel.
> 
> My Alu powerbook with a 2.6.15 kernel does not show this problem.

Could be several things... the clock calibration data from the
device-tree incorrect, or a rouding bug we fixed recently... I'd expect
2.6.16 to be good.

Ben
