Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 3D90DDDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 03:50:02 +1100 (EST)
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] ehea: Optional TX/RX path optimized for SMP
References: <200702231730.58579.ossthema@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 23 Feb 2007 08:49:59 -0800
In-Reply-To: <200702231730.58579.ossthema@de.ibm.com> (Jan-Bernd Themann's
	message of "Fri, 23 Feb 2007 17:30:58 +0100")
Message-ID: <adairdses3s.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > This patch introduces an optional alternative receive processing
 > functionality (enabled via module load parameter). The ehea adapter
 > can sort TCP traffic to multiple receive queues to be processed by
 > the driver in parallel on multiple CPUs. The hardware always puts
 > packets for an individual tcp stream on the same queue. As the
 > current NAPI interface does not allow to handle parallel receive
 > threads for a single adapter (processing on multiple CPUs in parallel)
 > this patch uses tasklets with a simple fairness algorithm instead. 
 > On the send side we also take advantage of ehea's multiple send queue
 > capabilites. A simple hash function in combination with the LL_TX
 > attribute allows to process tx-packets on multiple CPUs on different
 > queues. The hash function is needed to guarantee proper TCP packet
 > ordering. This alternative packet processing functionality leads to 
 > significant performance improvements with ehea. 

Why make this a module option that the user has to set?  Are there any
circumstances when someone wouldn't want "significant performance
improvements?"  If this approach is just better, then it should just
replace the old code.

Also, as far as the approach of using tasklets, I think it would be
better to use the "fake netdev" approach to continue to use NAPI.
Basically you create a pseudo-netdev for each receive queue and have
NAPI handle the polling for you -- you could look for
drivers/net/cxgb3 for an example of this.

 - R.
