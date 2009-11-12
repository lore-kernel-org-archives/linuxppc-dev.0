Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id DCA7CB6F1E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 20:01:38 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1N8VI5-0001f2-ML
	for linuxppc-dev@ozlabs.org; Thu, 12 Nov 2009 00:44:29 -0800
Message-ID: <26315068.post@talk.nabble.com>
Date: Thu, 12 Nov 2009 00:44:29 -0800 (PST)
From: Jan Husak <jan.husak@siemens.com>
To: linuxppc-dev@ozlabs.org
Subject: High traffic from eth to cf-ata blocks other eth traffic
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I have ppc system with compactflash card connected by ata. On this system is
running process using raw socket to send and receive cyclic data each 4ms.
When I start another iptraffic - sshftp - to write to compact flash, after
certain time the IRQ-135 (mpc52xx_ata) of ata driver locks task irqs from
network card for cca 300ms. And my cyclic data transfer is broken. Any idea
how to solve this problem?

Thanks a lot for hint. Jan

Output from sched_switch trace here:

pniodhld-2516 [000] 1305.162746: 2516: 33:T ==> [000] 6: 33:R sirq-net-rx/0

sirq-net-rx/0-6 [000] 1305.162755: 6: 33:R + [000] 2516: 33:T pniodhld

sirq-net-rx/0-6 [000] 1305.162766: 6: 49:R ==> [000] 2516: 33:S pniodhld

pniodhld-2516 [000] 1305.162835: 2516: 33:D ==> [000] 6: 49:R sirq-net-rx/0

sirq-net-rx/0-6 [000] 1305.162923: 6: 49:D ==> [000] 99:115:R ata/0

ata/0-99 [000] 1305.163050: 99:115:D ==> [000] 2409:120:R sftp-server

sftp-server-2409 [000] 1305.163100: 2409:120:R + [000] 710: 49:D IRQ-135

sftp-server-2409 [000] 1305.163119: 2409:120:R ==> [000] 710: 49:R IRQ-135

IRQ-135-710 [000] 1305.163227: 710: 49:D + [000] 710: 49:D IRQ-135

IRQ-135-710 [000] 1305.163324: 710: 49:D ==> [000] 2409:120:R sftp-server

sftp-server-2409 [000] 1305.163344: 2409:120:R + [000] 710: 49:D IRQ-135

sftp-server-2409 [000] 1305.163355: 2409:120:R ==> [000] 710: 49:R IRQ-135

IRQ-135-710 [000] 1305.163448: 710: 49:D + [000] 710: 49:D IRQ-135

IRQ-135-710 [000] 1305.163543: 710: 49:D ==> [000] 2409:120:R sftp-server

sftp-server-2409 [000] 1305.163562: 2409:120:R + [000] 710: 49:D IRQ-135

sftp-server-2409 [000] 1305.163574: 2409:120:R ==> [000] 710: 49:R IRQ-135

IRQ-135-710 [000] 1305.163634: 710: 49:R + [000] 4: 49:D sirq-timer/0

IRQ-135-710 [000] 1305.163768: 710: 49:D + [000] 710: 49:D IRQ-135

IRQ-135-710 [000] 1305.163870: 710: 49:D ==> [000] 4: 49:R sirq-timer/0

sirq-timer/0-4 [000] 1305.163894: 4: 49:R + [000] 710: 49:D IRQ-135

sirq-timer/0-4 [000] 1305.163918: 4: 49:D ==> [000] 710: 49:R IRQ-135 

and another 500 similar lines till new net_rx irq task is scheduled
-- 
View this message in context: http://old.nabble.com/High-traffic-from-eth-to-cf-ata-blocks-other-eth-traffic-tp26315068p26315068.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
