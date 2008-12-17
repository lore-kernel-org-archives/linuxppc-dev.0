Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD40DDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 08:30:06 +1100 (EST)
Message-Id: <F29CCE3A-BCCC-4DA2-A0C8-F221F1248D24@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054534.4C5A4DDFD4@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 7/16] powerpc/mm: Rework context management for CPUs with
	no hash table v2
Date: Wed, 17 Dec 2008 15:30:00 -0600
References: <20081215054534.4C5A4DDFD4@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2008, at 11:44 PM, Benjamin Herrenschmidt wrote:

> This reworks the context management code used by 4xx,8xx and
> freescale BookE. It adds support for SMP by implementing a
> concept of stale context map to lazily flush the TLB on
> processors where a context may have been invalidated. This
> also contains the ground work for generalizing such lazy TLB
> flushing by just picking up a new PID and marking the old one
> stale. This will be implemented later.
>
> This is a first implementation that uses a global spinlock.
>
> Ideally, we should try to get at least the fast path (context ID
> already assigned) lockless or limited to a per context lock,
> but for now this will do.
>
> I tried to keep the UP case reasonably simple to avoid adding
> too much overhead to 8xx which does a lot of context stealing
> since it effectively has only 16 PIDs available.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> v2. remove some bugs with active tracking on SMP

I'd personally like a bit more commentary on how the stale map  
addresses the SMP issues in the commit message.

Also, Paul had a comment that we've kept around related to 8xx/4xx SMP  
as well as LRU.. is that still relevant?

- k
