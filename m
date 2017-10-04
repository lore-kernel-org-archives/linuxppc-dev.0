Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6TyG5WJ0zDqsf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 19:45:58 +1100 (AEDT)
Date: Wed, 4 Oct 2017 10:45:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v9 06/12] mm: zero struct pages during initialization
Message-ID: <20171004084554.fhxpmywtovs5umnm@dhcp22.suse.cz>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-7-pasha.tatashin@oracle.com>
 <20171003130857.vohli6lnqj4tdmhl@dhcp22.suse.cz>
 <73ea1215-7aa2-39e1-b820-30f58119183e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <73ea1215-7aa2-39e1-b820-30f58119183e@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 03-10-17 11:22:35, Pasha Tatashin wrote:
> 
> 
> On 10/03/2017 09:08 AM, Michal Hocko wrote:
> > On Wed 20-09-17 16:17:08, Pavel Tatashin wrote:
> > > Add struct page zeroing as a part of initialization of other fields in
> > > __init_single_page().
> > > 
> > > This single thread performance collected on: Intel(R) Xeon(R) CPU E7-8895
> > > v3 @ 2.60GHz with 1T of memory (268400646 pages in 8 nodes):
> > > 
> > >                          BASE            FIX
> > > sparse_init     11.244671836s   0.007199623s
> > > zone_sizes_init  4.879775891s   8.355182299s
> > >                    --------------------------
> > > Total           16.124447727s   8.362381922s
> > 
> > Hmm, this is confusing. This assumes that sparse_init doesn't zero pages
> > anymore, right? So these number depend on the last patch in the series?
> 
> Correct, without the last patch sparse_init time won't change.

THen this is just misleading.
-- 
Michal Hocko
SUSE Labs
