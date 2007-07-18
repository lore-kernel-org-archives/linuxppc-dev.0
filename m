Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0EDD9DE3DE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:20:57 +1000 (EST)
In-Reply-To: <20070718013308.GI15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>,
	<20070718013308.GI15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8bb8e703f6590987f6bb4f425b4d75c4@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 10/61] bootwrapper: flatdevtree fixes
Date: Wed, 18 Jul 2007 11:20:47 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jul 18 11:33:08 EST 2007, Scott Wood wrote:
> 1. ft_create_node was returning the internal pointer rather than a 
> phandle.
> 2. ft_find_device_rel was treating lookups relative to root as an 
> error.

No, it is treating lookups relative to NULL as an error.

Your patch changes it to treat lookups relative to the NULL phandle as 
relative to root.

I've no objections to the other part, can you split these?

>
> Signed-off-by: Scott Wood <scottwood at freescale.com>
> ---
>  arch/powerpc/boot/flatdevtree.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/boot/flatdevtree.c 
> b/arch/powerpc/boot/flatdevtree.c
> index b732644..5b69aeb 100644
> --- a/arch/powerpc/boot/flatdevtree.c
> +++ b/arch/powerpc/boot/flatdevtree.c
> @@ -659,9 +659,13 @@ void *ft_find_device_rel(struct ft_cxt *cxt, 
> const void *top,
>  {
>         char *node;
>
> -       node = ft_node_ph2node(cxt, top);
> -       if (node == NULL)
> -               return NULL;
> +       if (top) {
> +               node = ft_node_ph2node(cxt, top);
> +               if (node == NULL)
> +                       return NULL;
> +       } else {
> +               node = ft_root_node(cxt);
> +       }
>

milton
