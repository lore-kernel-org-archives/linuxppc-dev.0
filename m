Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C171DE154
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:41:29 +1100 (EST)
Message-Id: <EA08C942-E156-410D-8ADA-7A4812B20221@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1206664759.19368.11.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/5] [PPC] update lmb for hotplug memory add/remove
Date: Thu, 27 Mar 2008 21:40:52 -0500
References: <1206664406.19368.2.camel@dyn9047017100.beaverton.ibm.com>
	<1206664759.19368.11.camel@dyn9047017100.beaverton.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>,
	Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 27, 2008, at 7:39 PM, Badari Pulavarty wrote:
> ppc kernel maintains information about logical memory blocks in
> lmb.memory structure at the boot time. Its not updated for
> hotplug memory add/remove. hotplug memory notifier for memory
> add/remove now updates lmb.memory.
>
> This information is useful for eHEA driver to find out the memory
> layout and holes.
>
> NOTE: No special locking is needed for lmb_add() and lmb_remove().
> Calls to these are serialized by caller. (pSeries_reconfig_chain).
>
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> ---
> arch/powerpc/platforms/pseries/hotplug-memory.c |   43 +++++++++++++++
> include/linux/lmb.h                             |    3 -
> lib/lmb.c                                       |   66 ++++++++++++++ 
> ++++++----
> 3 files changed, 102 insertions(+), 10 deletions(-)

How is lmb_remove different than lmb_alloc?

- k
