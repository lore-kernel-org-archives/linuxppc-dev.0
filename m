Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2DDEBB6F69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:19:14 +1100 (EST)
Subject: Re: [PATCH 8/9] arch/powerpc/sysdev/ehv_pic.c: add missing kfree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1312802283-9107-8-git-send-email-julia@diku.dk>
Date: Thu, 24 Nov 2011 01:16:59 -0600
Message-Id: <3C33B018-7DA9-4818-A569-E3030ED993EE@kernel.crashing.org>
References: <1312802283-9107-8-git-send-email-julia@diku.dk>
To: Julia Lawall <julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ashish Kalra <ashish.kalra@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 8, 2011, at 6:18 AM, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> At this point, ehv_pic has been allocated but not stored anywhere, so it
> should be freed before leaving the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @exists@
> local idexpression x;
> statement S,S1;
> expression E;
> identifier fl;
> expression *ptr != NULL;
> @@
> 
> x = \(kmalloc\|kzalloc\|kcalloc\)(...);
> ...
> if (x == NULL) S
> <... when != x
>     when != if (...) { <+...kfree(x)...+> }
>     when any
>     when != true x == NULL
> x->fl
> ...>
> (
> if (x == NULL) S1
> |
> if (...) { ... when != x
>               when forall
> (
> return \(0\|<+...x...+>\|ptr\);
> |
> * return ...;
> )
> }
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
> arch/powerpc/sysdev/ehv_pic.c |    1 +
> 1 file changed, 1 insertion(+)

applied to next

- k
