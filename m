Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87980DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 05:12:02 +1100 (EST)
Message-Id: <3A41A734-8709-4AC6-ADFD-430D3C1E5DC8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0812212154240.3635@ask.diku.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] arch/powerpc/platforms/85xx: Add local_irq_restore in
	error handling code
Date: Tue, 30 Dec 2008 12:11:51 -0600
References: <Pine.LNX.4.64.0812212154240.3635@ask.diku.dk>
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 21, 2008, at 2:54 PM, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
>
> There is a call to local_irq_restore in the normal exit case, so it  
> would
> seem that there should be one on an error return as well.
>
> The semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
>
> // <smpl>
> @@
> expression l;
> expression E,E1,E2;
> @@
>
> local_irq_save(l);
> ... when != local_irq_restore(l)
>    when != spin_unlock_irqrestore(E,l)
>    when any
>    when strict
> (
> if (...) { ... when != local_irq_restore(l)
>               when != spin_unlock_irqrestore(E1,l)
> +   local_irq_restore(l);
>    return ...;
> }
> |
> if (...)
> +   {local_irq_restore(l);
>    return ...;
> +   }
> |
> spin_unlock_irqrestore(E2,l);
> |
> local_irq_restore(l);
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
>
> ---
> arch/powerpc/platforms/85xx/smp.c |    1 +
> 1 file changed, 1 insertion(+)

applied.

- k
