Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AF77DDEBB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:30:24 +1000 (EST)
Date: Tue, 7 Aug 2007 00:30:19 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix initialization and usage of dma_mask
Message-ID: <20070806223019.GA19389@suse.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<20070806115804.GA1734@suse.de>
	<1186436597.938.71.camel@localhost.localdomain>
	<1186437910.938.79.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1186437910.938.79.camel@localhost.localdomain>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Paul Mackerras <paulus@samba.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, Benjamin Herrenschmidt wrote:

> powerpc has a couple of bugs in the usage of dma_masks that tend to
> break when drivers explicitely try to set a 32 bits mask for example.
> 
> First the code that generates the pci devices from the OF device-tree
> doesn't initialize the mask properly, then our implementation of
> set_dma_mask() was trying to validate the -previous- mask value, not the
> one passed in as an argument.
> 
> This patch should fix these.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Does this fix the problem you've noticed ?

This patch fixes it. Thanks.
