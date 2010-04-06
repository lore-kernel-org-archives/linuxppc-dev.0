Return-Path: <prvs=1712771c50=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 700D2B7D43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 06:03:50 +1000 (EST)
Received: from [10.10.6.102] by digidescorp.com (Cipher SSLv3:RC4-MD5:128)
	(MDaemon PRO v10.1.1) with ESMTP id md50001246939.msg
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 15:03:47 -0500
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<2fefb2a2-d0dc-461d-ac8c-3e7d177b7cf8@VA3EHSMHS032.ehs.local>
	<1270573233.2081.47.camel@edumazet-laptop>
	<bf8eac92-5008-4c1f-9b99-0199e62436fa@SG2EHSMHS010.ehs.local>
	<k2mfa686aa41004061153q3d065924o9172b1cf6038d917@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 Apr 2010 15:03:43 -0500
Message-Id: <1270584223.3949.57.camel@iscandar.digidescorp.com>
Mime-Version: 1.0
Cc: Eric Dumazet <eric.dumazet@gmail.com>, michal.simek@petalogix.com,
	netdev@vger.kernel.org, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	john.williams@petalogix.com
Reply-To: steve@digidescorp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-06 at 12:53 -0600, Grant Likely wrote:

> Hold on.... BUFFER_ALIGN is being used to align the DMA buffer on a
> cache line boundary.  I don't think netdev_alloc_skb() makes any
> guarantees about how the start of the IP header lines up against cache
> line boundaries.  The amount of padding needed is not known until an
> skbuff is obtained from netdev_alloc_skb(), and
> netdev_alloc_skb_ip_align() can only handle a fixed size padding,
> 
> It doesn't look like netdev_alloc_skb_ip_align() is the right thing in
> this regard.

__netdev_alloc_skb reserves NET_SKB_PAD bytes which gets us cacheline
alignment on Microblaze. From include/linux/skbuff.h:

/*
 * The networking layer reserves some headroom in skb data (via
 * dev_alloc_skb). This is used to avoid having to reallocate skb data
when
 * the header has to grow. In the default case, if the header has to
grow
 * 32 bytes or less we avoid the reallocation.
 *
 * Unfortunately this headroom changes the DMA alignment of the
resulting
 * network packet. As for NET_IP_ALIGN, this unaligned DMA is expensive
 * on some architectures. An architecture can override this value,
 * perhaps setting it to a cacheline in size (since that will maintain
 * cacheline alignment of the DMA). It must be a power of 2.
 *
 * Various parts of the networking layer expect at least 32 bytes of
 * headroom, you should not reduce this.
 */
#ifndef NET_SKB_PAD
#define NET_SKB_PAD     32
#endif

If this doesn't work for some of the PPC variants with larger cache
lines, maybe one of the PPC header files needs to define NET_SKB_PAD?
And if we want to guard against possible future changes to the default
NET_SKB_PAD breaking Microblaze operation, maybe one of its headers
should define NET_SKB_PAD as well?

------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
 www.digidescorp.com              Earthling, return my space modulator!"

 #include <standard.disclaimer>
