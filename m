Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0076.hostedemail.com
 [216.40.44.76])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEDD91A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 06:39:44 +1100 (AEDT)
Message-ID: <1454869611.3739.8.camel@perches.com>
Subject: Re: [PATCH 1/4] powerpc/ps3: gelic_udbg: use struct ethhdr from
 <linux/if_ether.h>
From: Joe Perches <joe@perches.com>
To: Luis Henriques <luis.henriques@canonical.com>, Geoff Levand
 <geoff@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1454866730-10481-2-git-send-email-luis.henriques@canonical.com>
References: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
 <1454866730-10481-2-git-send-email-luis.henriques@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sun, 07 Feb 2016 10:26:51 -0800
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-02-07 at 17:38 +0000, Luis Henriques wrote:
> Instead of defining a local version of struct ethhdr use the standard
> definition from .

trivia:

> diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
[]
> @@ -173,8 +169,8 @@ static void gelic_debug_init(void)
>  
>  	h_eth = (struct ethhdr *)dbg.pkt;
>  
> -	memset(&h_eth->dest, 0xff, 6);
> -	memcpy(&h_eth->src, &mac, 6);
> +	memset(&h_eth->h_dest, 0xff, 6);
> +	memcpy(&h_eth->h_source, &mac, 6);

Be nice to use ETH_ALEN and eth_broadcast_addr.
Maybe ether_addr_copy too.

> @@ -183,7 +179,7 @@ static void gelic_debug_init(void)
>  				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
>  				 &vlan_id, &v2);
>  	if (!result) {
> -		h_eth->type = 0x8100;
> +		h_eth->h_proto= 0x8100;

ETH_P_8021Q

>  		header_size += sizeof(struct vlantag);
>  		h_vlan = (struct vlantag *)(h_eth + 1);
> @@ -191,7 +187,7 @@ static void gelic_debug_init(void)
>  		h_vlan->subtype = 0x0800;
>  		h_ip = (struct iphdr *)(h_vlan + 1);
>  	} else {
> -		h_eth->type = 0x0800;
> +		h_eth->h_proto= 0x0800;

ETH_P_IP
