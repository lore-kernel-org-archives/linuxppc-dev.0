Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 926A8679E9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 10:11:43 +1000 (EST)
Date: Fri, 21 Apr 2006 17:11:40 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060422001140.GA12826@gate.ebshome.net>
References: <20060421232942.GG7242@austin.ibm.com>
	<20060421234551.GI7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060421234551.GI7242@austin.ibm.com>
Cc: Maxim Shchetynin <maxim@de.ibm.com>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 06:45:51PM -0500, Linas Vepstas wrote:
> Prevent a potential race. If two threads are both calling
> the transmit routine, both can potentially try to grab the
> same dma descriptor. Serialize access to the head of the
> tx ring with spinlocks.

Two threads cannot be in spider_net_xmit() simultaneosuly because 
hard_start_xmit entry point is already protected by net_device 
xmit_lock, see Documentation/net/netdevices.txt

-- 
Eugene
