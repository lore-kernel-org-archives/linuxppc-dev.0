Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F7BD67C6B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 22:01:06 +1100 (EST)
Subject: Re: NTP time sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
In-Reply-To: <20061123105400.GA75714@muc.de>
References: <20061122203633.611acaa8@inspiron> <20061123105400.GA75714@muc.de>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 22:00:05 +1100
Message-Id: <1164279605.5653.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Alessandro Zummo <alessandro.zummo@towertech.it>,
	lethal@linux-sh.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, rmk@arm.linux.org.uk,
	davem@davemloft.net, kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-23 at 11:54 +0100, Andi Kleen wrote:
> > [1] http://lkml.org/lkml/2006/3/28/358
> 
> What was the answer to Matt's last question in there?
> If the existing user land does it already then 
> probably.  If not then a good migration strategy would 
> be needed.

Couldn't we have a transition period by making the kernel not rely on
interrupts ? if the NTP irq code just triggers a work queue, then all of
a sudden, all of the RTC drivers can be used and the latency is small.
That might well be a good enough solution and is very simple.

Ben
