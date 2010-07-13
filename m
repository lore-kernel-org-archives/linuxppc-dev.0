Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 365D2B6F06
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:29:00 +1000 (EST)
Message-ID: <4C3C6A24.3000906@grandegger.com>
Date: Tue, 13 Jul 2010 15:29:08 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Netdev@vger.kernel.org
Subject: High process latencies due to MPC5200 FEC hard- soft-irq processing
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

we realized, that multiple ping floods (ping -f) can cause very large
high-priority process latencies (up to a many seconds) on a MPC5200
PowerPC system with FEC NAPI support. The latencies are measured with

  # cyclictest -p 80 -n

The problem is that processing of the ICMP pakets in the Hard-Irq and
Soft-IRQ context can last for a long time without returning to the
scheduler. Reducing MAX_SOFTIRQ_RESTART from 10 to 2 helps - the latency
goes down to 35 ms with 2 "ping -f" - but it's not a configurable
parameter, even if it somehow depends on the CPU power. And using the
-rt patches seems overkill to me. Any other ideas or comments on how to
get rid of such high process latencies?

Wolfgang.
