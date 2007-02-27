Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE020DDD0D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 17:42:28 +1100 (EST)
Subject: Re: [PATCH] ehea: NAPI multi queue TX/RX path for SMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200702261700.51220.ossthema@de.ibm.com>
References: <200702261700.51220.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 07:42:13 +0100
Message-Id: <1172558533.11949.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-26 at 17:00 +0100, Jan-Bernd Themann wrote:
> Hi!
> 
> This patch replaces the former posted patch
> ([PATCH] ehea: Optional TX/RX path optimized for SMP) and provides
> a functionality that allows parallel RX processing on multiple RX
> queues by using dummy netdevices as proposed by Roland Dreier.
> The fairness amongst this net devices and other network devices 
> is thus better than in our first approach.
> 
> Is there a way to avoid overloading a single CPU with multiple netdev
> receive processes using NAPI? A distribution based on CPU load might
> help to improve the throughput. Pinning interrupts shows there is 
> still some room for improvements.

You may also want to look at the patches proposed by Dave Miller for
splitting NAPI from netdevice so you can actually instanciate multiple
NAPI "pollers"

Ben.
