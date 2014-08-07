Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19A5A1A0453
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 16:05:09 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 16:05:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AC5762BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 16:05:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s775fkL751380444
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 15:41:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7764ruH010299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 16:04:54 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: thp: Use tlbiel wherever possible
In-Reply-To: <1407357040.3073.93.camel@pasglop>
References: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <8738d965hf.fsf@linux.vnet.ibm.com> <1407357040.3073.93.camel@pasglop>
Date: Thu, 07 Aug 2014 11:34:45 +0530
Message-ID: <87zjfg4yyq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2014-08-06 at 20:16 +0530, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> 
>> > If we know that user address space has never executed on other cpus
>> > we could use tlbiel.
>> >
>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Now checking against flush_hash_page, I am wondering whether I need to handle
>> transcational memory in case of tlbiel ? Michael, can you let me know if
>> this is needed ?
>
> Also, beware that we have code that sets "tlbiel" in the page definition
> array to 0 on all but 4k and 64k pages...
>

Ok we use base page size to determine whether we can use tlbiel or not. 

static inline void tlbie(unsigned long vpn, int psize, int apsize,
			 int ssize, int local)
{
....
	if (use_local)
		use_local = mmu_psize_defs[psize].tlbiel;

With that we should be ok, because we are using 4k and 64k base page
size and we have

/*
 * We don't know for sure what's up with tlbiel, so
 * for now we only set it for 4K and 64K pages
 */
if (base_idx == MMU_PAGE_4K || base_idx == MMU_PAGE_64K)
	def->tlbiel = 1;
else
	def->tlbiel = 0;


-aneesh
