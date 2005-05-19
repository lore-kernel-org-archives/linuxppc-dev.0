Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4325067A39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 11:24:07 +1000 (EST)
Date: Wed, 18 May 2005 18:24:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050519012404.GA11587@gate.ebshome.net>
References: <c3d0340b050518175411c484e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050518175411c484e3@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 18, 2005 at 05:54:39PM -0700, Shawn Jin wrote:
> The page table 'consistent_pte' covers the uncached DMA consistent
> allocation space. Its size is only one page, each page has 512 PTEs.
> That means only 2MB memory are available for DMA. For some
> applications this is not enough. So how to eliminate this limitation?

No, _all_ physical memory is available for DMA. "consistent" pool is 
used for small non-cached allocations, e.g. buffer descriptors, etc. 
Don't use it for actual data buffers.

-- 
Eugene
