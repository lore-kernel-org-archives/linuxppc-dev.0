Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRZ6j31lHzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 22:52:12 +1000 (AEST)
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
To: Will Deacon <will.deacon@arm.com>, ard.biesheuvel@linaro.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
 <20170808123042.GG13355@arm.com>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <a777718a-00b5-fb3a-75d6-03cc7ad181d9@oracle.com>
Date: Tue, 8 Aug 2017 08:49:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170808123042.GG13355@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Will,

 > Damn, I actually prefer the flag :)
 >
 > But actually, if you look at our implementation of vmemmap_populate, 
then we
 > have our own version of vmemmap_populate_basepages that terminates at the
 > pmd level anyway if ARM64_SWAPPER_USES_SECTION_MAPS. If there's 
resistance
 > to do this in the core code, then I'd be inclined to replace our
 > vmemmap_populate implementation in the arm64 code with a single 
version that
 > can terminate at either the PMD or the PTE level, and do zeroing if
 > required. We're already special-casing it, so we don't really lose 
anything
 > imo.

Another approach is to create a new mapping interface for kasan only. As 
what Ard Biesheuvel wrote:

 > KASAN uses vmemmap_populate as a convenience: kasan has nothing to do
 > with vmemmap, but the function already existed and happened to do what
 > KASAN requires.
 >
 > Given that that will no longer be the case, it would be far better to
 > stop using vmemmap_populate altogether, and clone it into a KASAN
 > specific version (with an appropriate name) with the zeroing folded
 > into it.

I agree with this statement, but I think it should not be part of this 
project.

Pasha
