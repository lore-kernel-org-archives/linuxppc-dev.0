Return-Path: <eric.dumazet@gmail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A895B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 05:56:23 +1100 (EST)
Received: by wgbds10 with SMTP id ds10so766009wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 11:56:19 -0700 (PDT)
Subject: Re: [REGRESSION][PATCH V4 1/3] bpf jit: Make the
 filter.c::__load_pointer helper non-static  for the jits
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Jan Seiffert <kaffeemonster@googlemail.com>
In-Reply-To: <4F75CC63.10405@googlemail.com>
References: <4F75CA89.4010709@googlemail.com> <4F75CC63.10405@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Mar 2012 20:56:15 +0200
Message-ID: <1333133775.2325.2426.camel@edumazet-glaptop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Matt Evans <matt@ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-30 at 17:08 +0200, Jan Seiffert wrote:
> The function is renamed to make it a little more clear what it does.
> It is not added to any .h because it is not for general consumption, only for
> bpf internal use (and so by the jits).
> 
> Signed-of-by: Jan Seiffert <kaffeemonster@googlemail.com>
> 

Missing "---" line separator (check Documentation/SubmittingPatches line
490)

You can check http://patchwork.ozlabs.org/patch/149683/ and see there is
a problem, compared to http://patchwork.ozlabs.org/patch/149441/ for
example

> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -40,8 +40,12 @@
>  #include <linux/reciprocal_div.h>
>  #include <linux/ratelimit.h>
>  
> -/* No hurry in this branch */
> -static void *__load_pointer(const struct sk_buff *skb, int k, unsigned int size)
> +/*
> + * No hurry in this branch
> + *
> + * Exported for the bpf jit load helper.
> + */

Seems good to me, maybe add a strong warning in the comment to say that
function prototype can NOT change without major surgery in ASM files,
since assembler wont catch the prototype change for us.

Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
