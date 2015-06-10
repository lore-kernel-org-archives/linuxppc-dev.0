Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com
 [IPv6:2607:f8b0:4001:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 088BE1A0E02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 03:56:08 +1000 (AEST)
Received: by iesa3 with SMTP id a3so39771502ies.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:56:04 -0700 (PDT)
Message-ID: <1433958961.27504.15.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [RFC,v3 02/10] dpaa_eth: add support for DPAA Ethernet
From: Eric Dumazet <eric.dumazet@gmail.com>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2015 10:56:01 -0700
In-Reply-To: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
References: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-29 at 17:56 +0300, Madalin Bucur wrote:
> This introduces the Freescale Data Path Acceleration Architecture
> (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> the Freescale DPAA QorIQ platforms.
...

> +	/* We're going to store the skb backpointer at the beginning
> +	 * of the data buffer, so we need a privately owned skb
> +	 */
> +
> +	/* Code borrowed from skb_unshare(). */
> +	if (skb_cloned(skb)) {
> +		struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
> +
> +		/* Finally, create a contig FD from this skb */
> +		skb_to_contig_fd(priv, skb, &fd, countptr, &offset);
> +
> +		kfree_skb(skb);
> +		skb = nskb;
> +		/* skb_copy() has now linearized the skbuff. */
> +	}
> +

You know that TCP packets are clones, right ?
This code is killing performance.

TCP allows the headers part being modified by a driver if needed.

You should use skb_header_cloned() instead.
