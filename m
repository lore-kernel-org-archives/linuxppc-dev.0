Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 457E2B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 07:35:59 +1000 (EST)
Received: from mail61-tx2 (localhost.localdomain [127.0.0.1])	by
	mail61-tx2-R.bigfish.com (Postfix) with ESMTP id 8ADF81B881D1	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 21:35:42 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.246])	by
	mail61-tx2.bigfish.com (Postfix) with ESMTP id 242DBCC805E	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 21:35:41 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8LLZJM0008966	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 14:35:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8LLZPl5019331	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 16:35:25 -0500 (CDT)
Date: Tue, 21 Sep 2010 16:34:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Message-ID: <20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 16:24:10 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Tue, Sep 21, 2010 at 7:55 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Sep 21, 2010, at 5:57 AM, Li Yang wrote:
> >
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> >> ---
> >
> > We really should have a sentence about how or why this works to address 36-bit addressing.
> 
> For example, I would like to know which memory is going to be
> allocated above 4GB.  I don't know much about the kernel's async
> library, but my understanding is that fsldma does not allocate any of
> the memory buffers that it copies data to/from.

This doesn't control allocation (it probably should with
dma_alloc_coherent, though I don't see it in the code), it controls
whether swiotlb will create a bounce buffer -- defeating the point of
using DMA to accelerate a memcpy.

-Scott
