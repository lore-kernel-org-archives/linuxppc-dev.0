Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 138FDB707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 21:08:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EE21DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 21:08:42 +1000 (EST)
Subject: Re: dma_ops->map_page == NULL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <200907071015.24097.markn@au1.ibm.com>
References: <4A523984.2080904@marel.com> <200907071015.24097.markn@au1.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 21:08:25 +1000
Message-Id: <1246964905.6066.41.camel@pasglop>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-07 at 10:15 +1000, Mark Nelson wrote:
> 
> When the 32 and 64bit DMA code was merged in .28 , map_/unmap_page() was
> added in favour of map_/unmap_single() (which was later removed in .29)
> so you'll have to replace your calls to dma_map_single() with
> dma_map_page(). Just pass it the page and offset rather than the address.

Wait a minute ... dma_map_single() should still work, it will just call
dma_map_page() underneath. All dma_ops should have a ->map page
callback.

Do you have any dma_ops set for your device at all ? I wonder how we
set the dma_ops for platform devices nowadays ... We use to have this
fallback to direct ops when the dma_ops are NULL but that is gone and
I see no suitable replacement to set them on platform devices for
embedded archs ... oops...

Kumar, Becky, what's the situation there ?

Cheers,
Ben.
