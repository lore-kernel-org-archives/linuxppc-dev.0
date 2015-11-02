Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0153.hostedemail.com
 [216.40.44.153])
 by lists.ozlabs.org (Postfix) with ESMTP id 52F4E1A0384
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:07:17 +1100 (AEDT)
Message-ID: <1446494829.24485.63.camel@perches.com>
Subject: Re: [net-next v4 3/8] dpaa_eth: add support for S/G frames
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, scottwood@freescale.com,
 igal.liberman@freescale.com, roy.pledge@freescale.com,
 ppc@mindchasers.com,  pebolle@tiscali.nl, joakim.tjernlund@transmode.se,
 gregkh@linuxfoundation.org
Date: Mon, 02 Nov 2015 12:07:09 -0800
In-Reply-To: <1446485500-9782-4-git-send-email-madalin.bucur@freescale.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-4-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> Add support for Scater/Gather (S/G) frames. The FMan can place
> the frame content into multiple buffers and provide a S/G Table
> (SGT) into one first buffer with references to the others.

trivia: scatter

> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_common.c
[]
> @@ -1177,10 +1177,42 @@ void dpaa_eth_init_ports(struct mac_device *mac_dev,
>  			      port_fqs->rx_defq, &buf_layout[RX]);
>  }
>  
> +void dpa_release_sgt(struct qm_sg_entry *sgt)
> +{
> +	struct dpa_bp *dpa_bp;
> +	struct bm_buffer bmb[DPA_BUFF_RELEASE_MAX];

Where is "struct bm_buffer" defined?
