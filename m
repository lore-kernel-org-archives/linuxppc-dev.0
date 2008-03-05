Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AED14DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 13:28:17 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m252S9L1028170
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 07:58:09 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m252S9IM1073242
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 07:58:09 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m252SEkP013613
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 02:28:15 GMT
Message-ID: <47CE0537.3010907@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2008 07:58:07 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com>
	<20080304103636.3e7b8fdd.akpm@linux-foundation.org>
	<47CDA081.7070503@cs.helsinki.fi> <20080304193532.GC9051@csn.ul.ie>
	<84144f020803041141x5bb55832r495d7fde92356e27@mail.gmail.com>
	<Pine.LNX.4.64.0803041151360.18160@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0803042200410.8545@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0803041205370.18277@schroedinger.engr.sgi.com>
	<47CDAC58.6090207@cs.helsinki.fi>
In-Reply-To: <47CDAC58.6090207@cs.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pekka Enberg wrote:
> Christoph Lameter wrote:
>> I think this is the correct fix.
>>
>> The NUMA fallback logic should be passing local_flags to kmem_get_pages() 
>> and not simply the flags.
>>
>> Maybe a stable candidate since we are now simply 
>> passing on flags to the page allocator on the fallback path.
>>
>> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Indeed, good catch. I spotted the same thing just few seconds ago.
> 
> Reviewed-by: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Was it you Kamalesh that reported this? Can you please re-test?

Thanks the patch fixes the kernel bug.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
