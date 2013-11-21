Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BB9282C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 11:02:08 +1100 (EST)
Message-ID: <1384992102.26969.120.camel@pasglop>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 21 Nov 2013 11:01:42 +1100
In-Reply-To: <20131120232337.GT16735@n2100.arm.linux.org.uk>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
 <20131120232337.GT16735@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 23:23 +0000, Russell King - ARM Linux wrote:
> Li Zong's patch works around the issue of a failing dma_set_mask(),
> but as I've already said elsewhere, the real fix is to get whatever
> created the struct device to initialise the dev->dma_mask with a
> bus default.
> 
> Using dma_coerce_xxx() merely makes the problem "go away" papering
> over the issue - it's fine to do it this way, but someone should still
> fix the broken code creating these devices...

Ok, they are created by the vio bus core, so it should be doing the
job here of setting the dma_mask pointer to a proper value.

Li, can you take care of that ? Look at other bus types we have in
there such as the macio bus etc...

Cheers,
Ben.
