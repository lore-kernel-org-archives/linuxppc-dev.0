Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FCB7DEE55
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:57:14 +1000 (EST)
Message-Id: <73E7C622-5CB1-4C40-B417-98433F15D4C4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <12081878182664-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Make rheap safe for spinlocks
Date: Thu, 17 Apr 2008 09:57:05 -0500
References: <12081878182664-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 14, 2008, at 10:43 AM, Timur Tabi wrote:
> The rheap allocation function, rh_alloc, could call kmalloc with  
> GFP_KERNEL.
> This can sleep, which means you couldn't hold a spinlock while  
> called rh_alloc.
> Change all kmalloc calls to use GFP_ATOMIC so that it won't sleep.   
> This is
> safe because only small blocks are allocated.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch is for 2.6.26.
>
> arch/powerpc/lib/rheap.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied.

- k
