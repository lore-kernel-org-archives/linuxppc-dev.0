Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDFE72C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 18:15:26 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 15 Apr 2013 13:41:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E9D27E002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 13:47:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3F8FCJT8388878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 13:45:12 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3F8FGLT000621
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 18:15:17 +1000
Message-ID: <1366013711.12424.33.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Apr 2013 16:15:11 +0800
In-Reply-To: <1366008995.24994.25.camel@pasglop>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
 <20130415035031.GA7494@iris.ozlabs.ibm.com>
 <1366008995.24994.25.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-15 at 08:56 +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-15 at 13:50 +1000, Paul Mackerras wrote:
> > On Fri, Apr 12, 2013 at 10:16:59AM +0800, Li Zhong wrote:
> > > It seems that in kernel_unmap_linear_page(), it only checks whether there
> > > is a map in the linear_map_hash_slots array, so seems we don't need bolt
> > > the hpte.
> > 

Hi Paul, Ben

Thank you both for the comments and detailed information. I'll keep it
bolted in the next version. If you have time, please help to check
whether my understanding below is correct.

Thanks, Zhong

> > I don't exactly understand your rationale here, but I don't think it's
> > safe not to have linear mapping pages bolted.  Basically, if a page
> > will be used in the process of calling hash_page to demand-fault an
> > HPTE into the hash table, then that page needs to be bolted, otherwise
> > we can get an infinite recursion of HPT misses.  

So the infinite recursion happens like below?

        fault for PAGE A
        
        hash_page for PAGE A 
        
        some page B needed by hash_page processing removed by others,
        before inserting the HPTE
        
        fault for PAGE B 
        
        hash_page for PAGE B and recursion for ever
        

> That includes all
> > kernel stack pages, among other things, so I think we need to leave
> > the HPTE_V_BOLTED in there.
> 
> I suspect Li's confusion comes from the fact that he doesn't realizes
> that we might evict random hash slots. If the linear mapping hash
> entries could only be thrown out via kernel_unmap_linear_page() then his
> comment would make sense. However this isn't the case.
> 
> Li: When faulting something in, if both the primary and secondary
> buckets are full, we "somewhat randomly" evict the content of a slot and
> replace it. However we only do that on non-bolted slots.

So the code is implemented in ppc_md.hpte_remove(), may be called by
__hash_huge_page(), and asm code htab_call_hpte_remove?

> This is why the linear mapping (and the vmemmap) must be bolted.

If not, it would result the infinite recursion like above?

> Cheers,
> Ben.
> 
> 
