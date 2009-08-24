Return-Path: <hch@lst.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59A64B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 05:48:13 +1000 (EST)
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3559DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 05:48:11 +1000 (EST)
Date: Mon, 24 Aug 2009 21:48:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
Message-ID: <20090824194800.GA13503@lst.de>
References: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 24, 2009 at 11:17:14AM -0500, Becky Bruce wrote:
> Previously, this was specified as a void *, but that's not
> large enough on 32-bit systems with 36-bit physical
> addressing support.  Change the type to dma_addr_t so it
> will scale based on the size of a dma address.

This looks extreml ugly to me.  It seems like the typical use is to
store a pointer to a structure.  So what about making the direct
dma case follow that general scheme instead?

E.g. declare a

struct direct_dma_data {
	dma_addr_t	direct_dma_offset;
};

and have one normal instace of it, and one per weird cell device.
