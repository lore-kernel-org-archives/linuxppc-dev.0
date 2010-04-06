Return-Path: <prvs=1712771c50=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65BF2B7D16
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 01:13:27 +1000 (EST)
Received: from [10.10.6.102] by digidescorp.com (Cipher SSLv3:RC4-MD5:128)
	(MDaemon PRO v10.1.1) with ESMTP id md50001246428.msg
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 10:08:08 -0500
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: "Steven J. Magnani" <steve@digidescorp.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <7a42d507-bf50-40f3-a2a0-8de682b314d7@SG2EHSMHS017.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<7a42d507-bf50-40f3-a2a0-8de682b314d7@SG2EHSMHS017.ehs.local>
Content-Type: text/plain
Date: Tue, 06 Apr 2010 10:08:02 -0500
Message-Id: <1270566482.3949.4.camel@iscandar.digidescorp.com>
Mime-Version: 1.0
Cc: Eric Dumazet <eric.dumazet@gmail.com>, michal.simek@petalogix.com,
	netdev@vger.kernel.org, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-dev@ozlabs.org, john.williams@petalogix.com
Reply-To: steve@digidescorp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-04-05 at 15:33 -0600, John Linn wrote:
> > > +/* Align the IP data in the packet on word boundaries as MicroBlaze
> > > + * needs it.
> > > + */
> > > +
> > >  #define XTE_ALIGN       32
> > > -#define BUFFER_ALIGN(adr) ((XTE_ALIGN - ((u32) adr)) % XTE_ALIGN)
> > > +#define BUFFER_ALIGN(adr) ((34 - ((u32) adr)) % XTE_ALIGN)
> > >
> > 
> > Very interesting way of doing this, but why such convoluted thing ?
> 
> Grant might have insight into why this started this way, I just updated to help with MicroBlaze alignment.
> 
> > 
> > Because of the % 32, this is equivalent to :
> > 
> > #define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)
> > 
> > But wait, dont we recognise the magic constant NET_IP_ALIGN ?
> > 
> > So, I ask, cant you use netdev_alloc_skb_ip_align() in this driver ?
> > 

That should work. I switched to that in the older xilinx_lltemac driver
without any problem. 

------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
 www.digidescorp.com              Earthling, return my space modulator!"

 #include <standard.disclaimer>
