Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id ECCE167A05
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:36:10 +1000 (EST)
To: Shirley Ma <xma@us.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
References: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 May 2006 11:36:07 -0700
In-Reply-To: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
	(Shirley Ma's message of "Tue, 9 May 2006 11:27:29 -0700")
Message-ID: <adar733avvs.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Shirley> I have done some patch like that on top of splitting
    Shirley> CQ. The problem I found that hardware interrupt favors
    Shirley> one CPU. Most of the time these two threads are running
    Shirley> on the same cpu according to my debug output. You can
    Shirley> easily find out by cat /proc/interrupts and
    Shirley> /proc/irq/XXX/smp_affinity.  ehca has distributed
    Shirley> interrupts evenly on SMP, so it gets the benefits of two
    Shirley> threads, and gains much better throughputs.

Yes, an interrupt will likely be delivered to one CPU.

But there's no reason why the two threads can't be pinned to different
CPUs or given exclusive CPU masks, exactly the same way that ehca
implements it.

 - R.
