Return-Path: <pebolle@tiscali.nl>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.31])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19C5E1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 21:51:37 +1100 (AEDT)
Message-ID: <1427971444.10518.40.camel@x220>
Subject: Re: [PATCH RFC 02/10] dpaa_eth: add support for DPAA Ethernet
From: Paul Bolle <pebolle@tiscali.nl>
To: madalin.bucur@freescale.com
Date: Thu, 02 Apr 2015 12:44:04 +0200
In-Reply-To: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
References: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a few nits.

This series is posted as an RFC, so this might not be what you're
expecting right now. But as these messages got tangled up in my mail
filter anyhow, I thought I might as well bother you with these nits now.

On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
> @@ -0,0 +1,49 @@
> +menuconfig FSL_DPAA_ETH
> +	tristate "DPAA Ethernet"
> +	depends on FSL_SOC && FSL_BMAN && FSL_QMAN && FSL_FMAN
> +	select PHYLIB
> +	select FSL_FMAN_MAC
> +	---help---
> +	  Data Path Acceleration Architecture Ethernet driver,
> +	  supporting the Freescale QorIQ chips.
> +	  Depends on Freescale Buffer Manager and Queue Manager
> +	  driver and Frame Manager Driver.
> +
> +if FSL_DPAA_ETH
> +
> +config FSL_DPAA_CS_THRESHOLD_1G
> +	hex "Egress congestion threshold on 1G ports"
> +	depends on FSL_DPAA_ETH

This entry is inside the "if FSL_DPAA_ETH" block. So this line should be
superfluous.

> +	range 0x1000 0x10000000
> +	default "0x06000000"
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
> +	depends on FSL_DPAA_ETH

Ditto.

> +	range 0x1000 0x20000000
> +	default "0x10000000"
> +	---help ---
> +	  The size in bytes of the egress Congestion State notification threshold on 10G ports.
> +
> +config FSL_DPAA_INGRESS_CS_THRESHOLD
> +	hex "Ingress congestion threshold on FMan ports"
> +	depends on FSL_DPAA_ETH

Ditto.

> +	default "0x10000000"
> +	---help---
> +	  The size in bytes of the ingress tail-drop threshold on FMan ports.
> +	  Traffic piling up above this value will be rejected by QMan and discarded by FMan.
> +
> +endif # FSL_DPAA_ETH

A similar comment can be made for the entries added in 03/10, 05/10, and
09/10.

Thanks,


Paul Bolle
