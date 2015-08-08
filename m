Return-Path: <f.fainelli@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ED101A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2015 03:38:44 +1000 (AEST)
Received: by obbop1 with SMTP id op1so99193770obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2015 10:38:42 -0700 (PDT)
Message-ID: <55C63E9A.5010704@gmail.com>
Date: Sat, 08 Aug 2015 10:38:34 -0700
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: madalin.bucur@freescale.com, netdev@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, scottwood@freescale.com,
 igal.liberman@freescale.com, ppc@mindchasers.com, joe@perches.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se
Subject: Re: [v2 2/9] dpaa_eth: add support for DPAA Ethernet
References: <1438789289-16304-1-git-send-email-madalin.bucur@freescale.com>
 <1438789289-16304-3-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1438789289-16304-3-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 08/05/15 08:41, Madalin Bucur a écrit :
> This introduces the Freescale Data Path Acceleration Architecture
> (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> the Freescale DPAA QorIQ platforms.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> ---
[snip]
> +
> +if FSL_DPAA_ETH
> +
> +config FSL_DPAA_CS_THRESHOLD_1G
> +	hex "Egress congestion threshold on 1G ports"
> +	range 0x1000 0x10000000
> +	default "0x06000000"

This sounds like something you would want to be able to configure at
runtime, either via private sysfs attributes, or better, using ethtool
and either a newly introduced set of tunables, or creating a private
driver API for this.

> +	---help---
> +	  The size in bytes of the egress Congestion State notification threshold on 1G ports.
> +	  The 1G dTSECs can quite easily be flooded by cores doing Tx in a tight loop
> +	  (e.g. by sending UDP datagrams at "while(1) speed"),
> +	  and the larger the frame size, the more acute the problem.
> +	  So we have to find a balance between these factors:
> +	       - avoiding the device staying congested for a prolonged time (risking
> +                 the netdev watchdog to fire - see also the tx_timeout module param);
> +               - affecting performance of protocols such as TCP, which otherwise
> +	         behave well under the congestion notification mechanism;
> +	       - preventing the Tx cores from tightly-looping (as if the congestion
> +	         threshold was too low to be effective);
> +	       - running out of memory if the CS threshold is set too high.
> +
> +config FSL_DPAA_CS_THRESHOLD_10G
> +	hex "Egress congestion threshold on 10G ports"
> +	range 0x1000 0x20000000
> +	default "0x10000000"
> +	---help ---
> +	  The size in bytes of the egress Congestion State notification threshold on 10G ports.
> +
> +config FSL_DPAA_INGRESS_CS_THRESHOLD
> +	hex "Ingress congestion threshold on FMan ports"
> +	default "0x10000000"
> +	---help---
> +	  The size in bytes of the ingress tail-drop threshold on FMan ports.
> +	  Traffic piling up above this value will be rejected by QMan and discarded by FMan.

Same here.
-- 
Florian
