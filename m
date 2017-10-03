Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y62qg4L85zDqnN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 02:23:43 +1100 (AEDT)
Subject: Re: [PATCH v9 06/12] mm: zero struct pages during initialization
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-7-pasha.tatashin@oracle.com>
 <20171003130857.vohli6lnqj4tdmhl@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <73ea1215-7aa2-39e1-b820-30f58119183e@oracle.com>
Date: Tue, 3 Oct 2017 11:22:35 -0400
MIME-Version: 1.0
In-Reply-To: <20171003130857.vohli6lnqj4tdmhl@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/03/2017 09:08 AM, Michal Hocko wrote:
> On Wed 20-09-17 16:17:08, Pavel Tatashin wrote:
>> Add struct page zeroing as a part of initialization of other fields in
>> __init_single_page().
>>
>> This single thread performance collected on: Intel(R) Xeon(R) CPU E7-8895
>> v3 @ 2.60GHz with 1T of memory (268400646 pages in 8 nodes):
>>
>>                          BASE            FIX
>> sparse_init     11.244671836s   0.007199623s
>> zone_sizes_init  4.879775891s   8.355182299s
>>                    --------------------------
>> Total           16.124447727s   8.362381922s
> 
> Hmm, this is confusing. This assumes that sparse_init doesn't zero pages
> anymore, right? So these number depend on the last patch in the series?

Correct, without the last patch sparse_init time won't change.

Pasha
