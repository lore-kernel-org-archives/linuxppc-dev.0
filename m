Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9DA1B7BDD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 18:19:01 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Subject: using different format for hugetlbfs
Date: Fri, 4 Dec 2009 01:18:51 -0600
Message-Id: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Gibson <dwg@au1.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, David,

If we want to support true 4G/4G split on ppc32 using the MSB of the  
address to determine of the pgd_t is for hugetlbfs isn't going to  
work.  Since every pointer in the pgd_t -> pud_t -> pmd_t is point to  
at least a 4K page I would think the low order 12-bits should always  
be 0.

Could we use something like:

addr[0:51] || shift [52:59] || flags [60:63]

with the LSB flag being 'normal pointer' vs 'hugetlbfs mangled  
pointer'.  Seems like shift will at most be 64 so 8-bits should cover  
it.

- k
