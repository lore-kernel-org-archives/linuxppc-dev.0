Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id 12A3767A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 10:54:40 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so361959wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 17:54:39 -0700 (PDT)
Message-ID: <c3d0340b050518175411c484e3@mail.gmail.com>
Date: Wed, 18 May 2005 17:54:39 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: DMA consistent allocation is limited to 2MB on 2.6.11 for ppc440?
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

Hi,

The page table 'consistent_pte' covers the uncached DMA consistent
allocation space. Its size is only one page, each page has 512 PTEs.
That means only 2MB memory are available for DMA. For some
applications this is not enough. So how to eliminate this limitation?

I noticed that there are two configuration macros related to this
issue: CONFIG_CONSISTENT_START and CONFIG_CONSISTENT_SIZE. The current
value for CONFIG_CONSISTENT_SIZE is 2MB, which is exactly able to be
covered by one page. I guess that's why consistent_pte is initialized
to just one page. So simply changing CONFIG_CONSISTENT_SIZE cannot
remove the 2MB limitation. dma_alloc_init() has to be modified to
initialize consisten_pte to some pages which are enough to cover
CONFIG_CONSISTENT_SIZE memory space. Right?

Does increasing CONSISTENT_SIZE have any side effects?

Thanks,
-Shawn.
