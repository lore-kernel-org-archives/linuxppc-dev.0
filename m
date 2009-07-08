Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCB7AB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 10:42:46 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id n680ebZa029809
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2009 10:40:37 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n680gjnR1343724
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2009 10:42:45 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n680gjlM009211
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2009 10:42:45 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: dma_ops->map_page == NULL
Date: Wed, 8 Jul 2009 10:44:58 +1000
References: <4A523984.2080904@marel.com> <200907071015.24097.markn@au1.ibm.com>
	<1246964905.6066.41.camel@pasglop>
In-Reply-To: <1246964905.6066.41.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907081044.59115.markn@au1.ibm.com>
Cc: =?iso-8859-1?q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	Kumar Gala <galak@gate.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 07 July 2009 21:08:25 Benjamin Herrenschmidt wrote:
> On Tue, 2009-07-07 at 10:15 +1000, Mark Nelson wrote:
> > 
> > When the 32 and 64bit DMA code was merged in .28 , map_/unmap_page() was
> > added in favour of map_/unmap_single() (which was later removed in .29)
> > so you'll have to replace your calls to dma_map_single() with
> > dma_map_page(). Just pass it the page and offset rather than the address.
> 
> Wait a minute ... dma_map_single() should still work, it will just call
> dma_map_page() underneath. All dma_ops should have a ->map page
> callback.

Sorry my mistake - I was thinking of when we removed the map/unmap_single()
from the dma_mapping_ops.

Mark.
