Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id C3C1CB7D57
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 06:24:07 +1000 (EST)
Received: by bwz9 with SMTP id 9so262478bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 13:24:06 -0700 (PDT)
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
	<1270573233.2081.47.camel@edumazet-laptop>
	<bf8eac92-5008-4c1f-9b99-0199e62436fa@SG2EHSMHS010.ehs.local>
	<k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Apr 2010 22:24:01 +0200
Message-ID: <1270585441.2091.65.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	John Tyner <jtyner@cs.ucr.edu>, michal.simek@petalogix.com,
	John Linn <John.Linn@xilinx.com>, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mardi 06 avril 2010 à 12:53 -0600, Grant Likely a écrit :

> Hold on.... BUFFER_ALIGN is being used to align the DMA buffer on a
> cache line boundary.  I don't think netdev_alloc_skb() makes any
> guarantees about how the start of the IP header lines up against cache
> line boundaries.  The amount of padding needed is not known until an
> skbuff is obtained from netdev_alloc_skb(), and
> netdev_alloc_skb_ip_align() can only handle a fixed size padding,
> 
> It doesn't look like netdev_alloc_skb_ip_align() is the right thing in
> this regard.
> 

OK, time to have a long explanation :

netdev_alloc_skb_ip_align() is doing the right thing, but it seems you
guys insist to invent a new private stuff.

I am only wondering if you really know why you do this. 

Many drivers do have same requirements, so every driver should reinvent
the wheel ? Really this is beyond me.

Original code was aligning the buffer on a 32 bytes boundary (because of
a hardware requirement on NIC, I only trust original code on this).

Then you want to change this to align buffer on this 32 bytes boundary
PLUS 2. What is this kind of new requirement ? 

1) Hardware requirement really changed that much. (firmware changed on
NIC). If not using this new alignement, NIC doesnt work at all.

2) or Microblaze arch requires that IP header is aligned on a word
boundary to avoid unaligned traps in IP stack ? (like many arches)

If this is the latest requirement, then use standard mechanism.
skb data is naturally aligned on L1_CACHE_SIZE + SKB_PAD boundaries.
(32 bytes alignment)

netdev_alloc_skb_ip_align()() then skips 2 bytes to make skb data
aligned so that 2 + 14 (sizeof eth header) = 16 : IP header is aligned
(modulo 16)

It just works. If not, we should correct it, please fill a bug report.

Thanks
