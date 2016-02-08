Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCEFB1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:05:11 +1100 (AEDT)
Date: Mon, 8 Feb 2016 22:04:51 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Joe Perches <joe@perches.com>
Cc: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/ps3: gelic_udbg: use struct ethhdr from
 <linux/if_ether.h>
Message-ID: <20160208220451.GA11603@charon.olymp>
References: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
 <1454866730-10481-2-git-send-email-luis.henriques@canonical.com>
 <1454869611.3739.8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1454869611.3739.8.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sun, Feb 07, 2016 at 10:26:51AM -0800, Joe Perches wrote:
> On Sun, 2016-02-07 at 17:38 +0000, Luis Henriques wrote:
> > Instead of defining a local version of struct ethhdr use the standard
> > definition from .
> 
> trivia:
> 
> > diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
> []
> > @@ -173,8 +169,8 @@ static void gelic_debug_init(void)
> >  
> >  	h_eth = (struct ethhdr *)dbg.pkt;
> >  
> > -	memset(&h_eth->dest, 0xff, 6);
> > -	memcpy(&h_eth->src, &mac, 6);
> > +	memset(&h_eth->h_dest, 0xff, 6);
> > +	memcpy(&h_eth->h_source, &mac, 6);
> 
> Be nice to use ETH_ALEN and eth_broadcast_addr.
> Maybe ether_addr_copy too.
> 
> > @@ -183,7 +179,7 @@ static void gelic_debug_init(void)
> >  				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
> >  				 &vlan_id, &v2);
> >  	if (!result) {
> > -		h_eth->type = 0x8100;
> > +		h_eth->h_proto= 0x8100;
> 
> ETH_P_8021Q
> 
> >  		header_size += sizeof(struct vlantag);
> >  		h_vlan = (struct vlantag *)(h_eth + 1);
> > @@ -191,7 +187,7 @@ static void gelic_debug_init(void)
> >  		h_vlan->subtype = 0x0800;
> >  		h_ip = (struct iphdr *)(h_vlan + 1);
> >  	} else {
> > -		h_eth->type = 0x0800;
> > +		h_eth->h_proto= 0x0800;
> 
> ETH_P_IP

Great, I'll send out v2 that will include most of these comments.  The
one I'll leave out is the usage of ether_addr_copy.

Thanks a lot for your comments.

Cheers,
--
Luís
