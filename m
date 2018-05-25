Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sVMD4CtkzF1dH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 12:19:50 +1000 (AEST)
Date: Thu, 24 May 2018 22:19:46 -0400 (EDT)
Message-Id: <20180524.221946.1726211556549145445.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/8] ibmvnic: Failover hardening
From: David Miller <davem@davemloft.net>
In-Reply-To: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 23 May 2018 13:37:54 -0500

> Introduce additional transport event hardening to handle
> events during device reset. In the driver's current state,
> if a transport event is received during device reset, it can
> cause the device to become unresponsive as invalid operations
> are processed as the backing device context changes. After
> a transport event, the device expects a request to begin the
> initialization process. If the driver is still processing
> a previously queued device reset in this state, it is likely
> to fail as firmware will reject any commands other than the
> one to initialize the client driver's Command-Response Queue.
> 
> Instead of failing and becoming dormant, the driver will make
> one more attempt to recover and continue operation. This is
> achieved by setting a state flag, which if true will direct
> the driver to clean up all allocated resources and perform
> a hard reset in an attempt to bring the driver back to an
> operational state.

Series applied.
