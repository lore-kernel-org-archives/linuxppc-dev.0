Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 853A1679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 11:52:53 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so375322wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 18:52:52 -0700 (PDT)
Message-ID: <c3d0340b05051818524c647e61@mail.gmail.com>
Date: Wed, 18 May 2005 18:52:52 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Shawn Jin <shawnxjin@gmail.com>, ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050519012404.GA11587@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050518175411c484e3@mail.gmail.com>
	<20050519012404.GA11587@gate.ebshome.net>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> No, _all_ physical memory is available for DMA. "consistent" pool is
> used for small non-cached allocations, e.g. buffer descriptors, etc.
> Don't use it for actual data buffers.

We used to pci_alloc_consistent() to allocate DMA buffers on 2.4.
There was no problem to allocate more than 2MB buffer. The
implementation of pci_alloc_consistent() on 2.6 differs from that on
2.4, which calls dma_alloc_coherent(). Following this, I traced down
to 'consistent_pte', which is the root cause of 2MB limitation.

Then what's your recommendation to allocate a big chunk of memory for
pci device? From this perspective, 2.6 is not compatible with 2.4,
which I think, is pretty bad.

Thanks,
-Shawn.
