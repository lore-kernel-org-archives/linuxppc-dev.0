Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6rSn0HldzDqgR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 17:39:52 +1000 (AEST)
Date: Wed, 12 Jul 2017 09:39:45 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Message-ID: <20170712073945.GC28912@dhcp22.suse.cz>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <20170711145246.GA11917@dhcp22.suse.cz>
 <20170711193257.GB5525@ram.oc3035372033.ibm.com>
 <20170712072337.GB28912@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712072337.GB28912@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 12-07-17 09:23:37, Michal Hocko wrote:
> On Tue 11-07-17 12:32:57, Ram Pai wrote:
[...]
> > Ideally the MMU looks at the PTE for keys, in order to enforce
> > protection. This is the case with x86 and is the case with power9 Radix
> > page table. Hence the keys have to be programmed into the PTE.
> 
> But x86 doesn't update ptes for PKEYs, that would be just too expensive.
> You could use standard mprotect to do the same...

OK, this seems to be a misunderstanding and confusion on my end.
do_mprotect_pkey does mprotect_fixup even for the pkey path which is
quite surprising to me. I guess my misunderstanding comes from
Documentation/x86/protection-keys.txt
"
Memory Protection Keys provides a mechanism for enforcing page-based
protections, but without requiring modification of the page tables
when an application changes protection domains.  It works by
dedicating 4 previously ignored bits in each page table entry to a
"protection key", giving 16 possible keys.
"

So please disregard my previous comments about page tables and sorry
about the confusion.
-- 
Michal Hocko
SUSE Labs
