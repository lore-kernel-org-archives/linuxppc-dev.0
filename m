Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id ED2DADDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 22:42:00 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 3680B3CC00F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 14:41:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 6A53EE39E1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 14:41:14 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 459A4E39E1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 14:41:14 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 6B8F453F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 14:40:08 +0200 (CEST)
Message-ID: <4857B113.5000300@matrix-vision.de>
Date: Tue, 17 Jun 2008 14:41:55 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: user memory access problem
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Actually we're running 2.6.26-rc6 with MPC8343 and MPC5200B based boards.

Our kernel driver implements a read functions that initiates a DMA
operation into that user memory - nothing special.
For testing purposes this memory can be touched from the kernel using
memset.

1. User memory is translated to sg by get_user_pages during read syscall.
2. walk sg entries and map each page using kmap
3. memset the kmap'ed mem
4. SetPageDirty and unmap.

Running this code leads to memory corruption and SegFaults on the
Application side.
This code worked fine on 2.6.19.

Can anybody help me out here ?


"um" is a pointer to an internal struct holding the sg_list besides
other information...

                for (i=0; i<um->page_cnt; i++) {
                        data = i & 0xff;
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
                        kva = kmap(um->sl[i].page) + um->sl[i].offset;
#else
                        kva = kmap(sg_page(&um->sl[i])) + um->sl[i].offset;
#endif
                        if (kva) {
                                /*    leads to SegFault ...   */
                                memset (kva, data, um->sl[i].length);
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
                                SetPageDirty(um->sl[i].page);
                                kunmap(sg_page(um->sl[i].page));
#else
                                SetPageDirty(sg_page(&um->sl[i]));
                                kunmap(sg_page(&um->sl[i]));
#endif
                        }
                }




regards,
Andre Schwarz
Matrix Vision



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
