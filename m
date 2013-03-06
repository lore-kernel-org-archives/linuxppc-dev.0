Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 723122C035B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 15:02:08 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 09:29:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B70D3E0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 09:33:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2641ukp28836050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 09:31:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2641xF8005036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 15:01:59 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V1 06/24] powerpc: Reduce PTE table memory wastage
In-Reply-To: <1362440204.21357.20.camel@pasglop>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304045853.GB27523@drongo> <874ngr2zz1.fsf@linux.vnet.ibm.com>
 <1362440204.21357.20.camel@pasglop>
Date: Wed, 06 Mar 2013 09:31:58 +0530
Message-ID: <87ip5589c9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2013-03-04 at 16:28 +0530, Aneesh Kumar K.V wrote:
>> I added the below comment when initializing the list.
>> 
>> +#ifdef CONFIG_PPC_64K_PAGES
>> +       /*
>> +        * Used to support 4K PTE fragment. The pages are added to list,
>> +        * when we have free framents in the page. We track the whether
>> +        * a page frament is available using page._mapcount. A value of
>> +        * zero indicate none of the fragments are used and page can be
>> +        * freed. A value of FRAG_MASK indicate all the fragments are used
>> +        * and hence the page will be removed from the below list.
>> +        */
>> +       INIT_LIST_HEAD(&init_mm.context.pgtable_list);
>> +#endif
>> 
>> I am not sure about why you say there is no consistent rule. Can you
>> elaborate on that ?
>
> Do you really need that list ? I assume it's meant to allow you to find
> free frags when allocating but my worry is that you'll end up losing
> quite a bit of node locality of PTE pages....
>
> It may or may not work but can you investigate doing things differently
> here ? The idea I want you to consider is to always allocate a full
> page, but make the relationship of the fragments to PTE pages fixed. IE.
> the fragment in the page is a function of the VA.
>
> Basically, the algorithm for allocation is roughly:
>
>  - Walk the tree down to the PMD ptr (* that can be improved with a
> generic change, see below)
>
>  - Check if any of the neighbouring PMDs is populated. If yes, you have
> your page and pick the appropriate fragment based on the VA
>
>  - If not, allocate and populate
>
> On free, similarly, you checked if all neighbouring PMDs have been
> cleared, in which case you can fire off the page for RCU freeing.
>
> (*) By changing pte_alloc_one to take the PMD ptr (which the call side
> has right at hand) you can avoid the tree lookup.
>

Will try this.

-aneesh
