Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B334B67C22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:27:17 +1000 (EST)
In-Reply-To: <op.thcr4fbjes1gi5@laurie.liewenthal.ee>
References: <20061012173231.56756.qmail@web34703.mail.mud.yahoo.com>
	<op.thcr4fbjes1gi5@laurie.liewenthal.ee>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CDCE6FAC-2DA9-4D94-8BB6-C26622DF6685@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Problems with DMA from user space on MPC834x (Cache coherency?)
Date: Fri, 13 Oct 2006 10:27:21 -0500
To: Lauri Ehrenpreis <lauri.ehrenpreis@liewenthal.ee>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2006, at 4:18 AM, Lauri Ehrenpreis wrote:

>
> Thank you!
>
> I added following before starting DMA:
>
> kaddr = (unsigned long)kmap(pages[i]);
> flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
> kunmap(pages[i]);
>
> ...and everything works now. As I understand this now, dma_map_page is
> not flushing caches on MPS834x because the processor should snoop the
> memory transactions and flush cache automatically if needed
> (__dma_sync_page
> is defined as do { } while (0) in kernel). But there exists an errata
> (PCI5) which states that there may be some problems with this  
> automatic
> flushing. So the caches must be flushed with flush_dcache_range.

What silicon version are you using.  PCI5 should be fixed in rev1.1  
and newer.  You can be taking a big perf hit having to flush all the  
time.

- k
