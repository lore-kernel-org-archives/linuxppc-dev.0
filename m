Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01C782C0156
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2012 10:37:05 +1100 (EST)
Received: by mail-wg0-f47.google.com with SMTP id dq11so3333211wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2012 15:37:02 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH -next] TTY: hvsi: use for_each_compatible_node() macro
To: Wei Yongjun <weiyj.lk@gmail.com>, gregkh@linuxfoundation.org,
 rob.herring@calxeda.com
In-Reply-To: <CAPgLHd-bpkWo6PeKrB1VqCiYMxCvphvMbs34Raoh89Wm0ubK-A@mail.gmail.com>
References: <CAPgLHd-bpkWo6PeKrB1VqCiYMxCvphvMbs34Raoh89Wm0ubK-A@mail.gmail.com>
Date: Wed, 05 Dec 2012 23:36:58 +0000
Message-Id: <20121205233658.5DCC23E0E22@localhost>
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Dec 2012 00:16:18 -0500, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use for_each_compatible_node() macro instead of open coding it.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/tty/hvc/hvsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
> index 5b95b4f..70e0ef7 100644
> --- a/drivers/tty/hvc/hvsi.c
> +++ b/drivers/tty/hvc/hvsi.c
> @@ -1187,9 +1187,7 @@ static int __init hvsi_console_init(void)
>  	hvsi_wait = poll_for_state; /* no irqs yet; must poll */
>  
>  	/* search device tree for vty nodes */
> -	for (vty = of_find_compatible_node(NULL, "serial", "hvterm-protocol");
> -			vty != NULL;
> -			vty = of_find_compatible_node(vty, "serial", "hvterm-protocol")) {
> +	for_each_compatible_node(vty, "serial", "hvterm-protocol") {
>  		struct hvsi_struct *hp;
>  		const uint32_t *vtermno, *irq;
>  
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
