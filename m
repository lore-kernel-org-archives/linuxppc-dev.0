Return-Path: <akepner@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id F0A65DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 01:38:09 +1000 (EST)
From: akepner@sgi.com
Date: Fri, 24 Aug 2007 08:37:03 -0700
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824153703.GN5592@sgi.com>
References: <200708241559.17055.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200708241559.17055.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
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

On Fri, Aug 24, 2007 at 03:59:16PM +0200, Jan-Bernd Themann wrote:
> .......
> 3) On modern systems the incoming packets are processed very fast. Especially
>    on SMP systems when we use multiple queues we process only a few packets
>    per napi poll cycle. So NAPI does not work very well here and the interrupt 
>    rate is still high. What we need would be some sort of timer polling mode 
>    which will schedule a device after a certain amount of time for high load 
>    situations. With high precision timers this could work well. Current
>    usual timers are too slow. A finer granularity would be needed to keep the
>    latency down (and queue length moderate).
> 

We found the same on ia64-sn systems with tg3 a couple of years 
ago. Using simple interrupt coalescing ("don't interrupt until 
you've received N packets or M usecs have elapsed") worked 
reasonably well in practice. If your h/w supports that (and I'd 
guess it does, since it's such a simple thing), you might try 
it.

-- 
Arthur
