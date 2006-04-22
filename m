Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BA75679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 11:03:25 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3M13MWA015403
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 21:03:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3M0xdhE273792
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 18:59:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3M13LY4016438
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 19:03:22 -0600
Date: Fri, 21 Apr 2006 20:03:21 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060422010321.GO7242@austin.ibm.com>
References: <20060421232942.GG7242@austin.ibm.com>
	<20060421234551.GI7242@austin.ibm.com>
	<20060422001140.GA12826@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060422001140.GA12826@gate.ebshome.net>
From: linas@austin.ibm.com (Linas Vepstas)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 05:11:40PM -0700, Eugene Surovegin wrote:
> On Fri, Apr 21, 2006 at 06:45:51PM -0500, Linas Vepstas wrote:
> > Prevent a potential race. If two threads are both calling
> > the transmit routine, both can potentially try to grab the
> > same dma descriptor. Serialize access to the head of the
> > tx ring with spinlocks.
> 
> Two threads cannot be in spider_net_xmit() simultaneosuly because 
> hard_start_xmit entry point is already protected by net_device 
> xmit_lock, see Documentation/net/netdevices.txt

Ahh, thank you. I was wondering why I never semmed to see this
this happen in "real life".

--linas
