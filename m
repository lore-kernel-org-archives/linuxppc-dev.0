Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AA1DDDEF7
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:33:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB3LX9r9019487
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 16:33:09 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB3LX9nn115744
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 16:33:09 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB3LX8LI013012
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 16:33:09 -0500
Message-ID: <47547635.7040503@linux.vnet.ibm.com>
Date: Mon, 03 Dec 2007 15:33:41 -0600
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: make 64K huge pages more reliable
References: <474CF694.8040700@us.ibm.com>
	<20071203020648.GF26919@localhost.localdomain>
In-Reply-To: <20071203020648.GF26919@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Nov 27, 2007 at 11:03:16PM -0600, Jon Tollefson wrote:
>   
>> This patch adds reliability to the 64K huge page option by making use of 
>> the PMD for 64K huge pages when base pages are 4k.  So instead of a 12 
>> bit pte it would be 7 bit pmd and a 5 bit pte. The pgd and pud offsets 
>> would continue as 9 bits and 7 bits respectively.  This will allow the 
>> pgtable to fit in one base page.  This patch would have to be applied 
>> after part 1.
>>     
>
> Hrm.. shouldn't we just ban 64K hugepages on a 64K base page size
> setup?  There's not a whole lot of point to it, after all...
>   

Banning the base and huge page size from being the same size feels like
an artificial barrier.  It is probably not the most massively useful
combination, but it shouldn't hurt performance. 

Jon
