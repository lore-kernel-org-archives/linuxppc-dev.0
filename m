Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id 76239B7D27
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 03:00:41 +1000 (EST)
Received: by bwz9 with SMTP id 9so98542bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 10:00:39 -0700 (PDT)
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: Eric Dumazet <eric.dumazet@gmail.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Apr 2010 19:00:33 +0200
Message-ID: <1270573233.2081.47.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	John Tyner <jtyner@cs.ucr.edu>, michal.simek@petalogix.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mardi 06 avril 2010 à 10:12 -0600, John Linn a écrit :
> > -----Original Message-----
> > From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
> > Sent: Monday, April 05, 2010 3:30 PM
> > To: John Linn
> > Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca;
> > jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com; michal.simek@petalogix.com; John Tyner
> > Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
> > 
> > Le lundi 05 avril 2010 à 15:11 -0600, John Linn a écrit :
> > > This patch adds support for using the LL TEMAC Ethernet driver on
> > > non-Virtex 5 platforms by adding support for accessing the Soft DMA
> > > registers as if they were memory mapped instead of solely through the
> > > DCR's (available on the Virtex 5).
> > >
> > > The patch also updates the driver so that it runs on the MicroBlaze.
> > > The changes were tested on the PowerPC 440, PowerPC 405, and the
> > > MicroBlaze platforms.
> > >
> > > Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
> > > Signed-off-by: John Linn <john.linn@xilinx.com>
> > >
> > > ---
> > 
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
> This is trying to align for a cache line (32 bytes) before my change.
> 
> My change was then also making it align the IP data on a word boundary. 
> 
> > 
> > Because of the % 32, this is equivalent to :
> > 
> > #define BUFFER_ALIGN(adr) ((2 - ((u32) adr)) % XTE_ALIGN)
> > 
> 
> Yes, but I'm not sure that's clearer IMHO.
> 
> > But wait, dont we recognise the magic constant NET_IP_ALIGN ?
> 
> Yes it could be used.  I'm struggling with how to make this all be clearer.
> 

I am not saying its clearer, I am saying we have a standard way to
handle this exact problem (aligning rcvs buffer so that IP header is
aligned)

There is no need to invent new ones, this makes reviewing of this driver
more difficult.


> How about this?
> #define BUFFER_ALIGN(adr) (((XTE_ALIGN + NET_IP_ALIGN) - ((u32) adr)) % XTE_ALIGN)
> 

Sorry, I still dont understand why you need XTE_ALIGN + ...

((A + B) - C) % A   is equal to (B - C) % A

Which one is more readable ?

Please take a look at existing and clean code, no magic macro, and we
can understand the intention.

find drivers/net | xargs grep -n netdev_alloc_skb_ip_align
