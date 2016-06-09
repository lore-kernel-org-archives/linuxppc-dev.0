Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQN514Vf4zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 21:15:17 +1000 (AEST)
Message-ID: <1465470910.31662.10.camel@ellerman.id.au>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Darren Stevens
 <darren@stevens-zone.net>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <michaele@au1.ibm.com>,  Julian Margetson <runaway@candw.ms>, Adrian Cox
 <adrian@humboldt.co.uk>, "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson"
 <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,  Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman
 <matthew@a-eon.biz>,  luigi burdo <intermediadc@hotmail.com>, Christian
 Zigotzky <info@xenosoft.de>
Date: Thu, 09 Jun 2016 21:15:10 +1000
In-Reply-To: <bab57839-0160-ae01-3cfb-6950067652c0@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
 <87r3c71zs9.fsf@skywalker.in.ibm.com>
 <d3753fa2-d88b-2e31-7d0d-d8952c29a12b@xenosoft.de>
 <bab57839-0160-ae01-3cfb-6950067652c0@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-09 at 10:48 +0200, Christian Zigotzky wrote:

> Shall I modify the workaround? Is the workaround for lack of the device 
> tree the problem?

I don't think so.

You could try this patch to try and isolate it:

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 88a5ecaa157b..ae2f2705e8a0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -251,7 +251,7 @@ extern unsigned long ioremap_bot;
  *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
  * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
  */
-#define KERN_IO_START	(KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
+#define KERN_IO_START	(H_KERN_VIRT_START + (H_KERN_VIRT_SIZE >> 1))
 #define FULL_IO_SIZE	0x80000000ul
 #define  ISA_IO_BASE	(KERN_IO_START)
 #define  ISA_IO_END	(KERN_IO_START + 0x10000ul)


cheers
