Return-Path: <timur.tabi@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99CAAB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 11:15:30 +1100 (EST)
Received: by fxm5 with SMTP id 5so2961120fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 04 Feb 2011 16:15:25 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
From: Timur Tabi <timur@freescale.com>
Date: Fri, 4 Feb 2011 18:14:44 -0600
Message-ID: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
Subject: minimum guaranteed alignment of dma_alloc_coherent?
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is there any official statement on what the minimum alignment is for
memory returned by dma_alloc_coherent?  I know that since it uses a
page allocator to do the actual allocation, that the memory is page
aligned (at least on PowerPC).  Is this something I can rely on?

Would anyone have a complaint if I did this:

vaddr = dma_alloc_coherent(dev, ssize, &paddr, GFP_DMA | __GFP_ZERO);
BUG_ON(paddr & (alignment - 1));

'alignment' will always be 32 or less.

The reason I ask is that I currently have code that ensures an
alignment, but it does so by allocating extra memory, and that seems
wasteful.

On a side note, do I really need to pass GFP_DMA when calling
dma_alloc_coherent?  That seems redundant, but I don't see the code
force it to be set.  Should it be forced on?

-- 
Timur Tabi
Linux kernel developer at Freescale
