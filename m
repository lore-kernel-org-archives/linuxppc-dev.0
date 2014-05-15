Return-Path: <hughd@google.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 361311400DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 03:29:38 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so1364488pbb.22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 10:29:34 -0700 (PDT)
Date: Thu, 15 May 2014 10:28:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
In-Reply-To: <537479E7.90806@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com,
 paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 May 2014, Madhavan Srinivasan wrote:
> 
> Hi Ingo,
> 
> 	Do you have any comments for the latest version of the patchset. If
> not, kindly can you pick it up as is.
> 
> 
> With regards
> Maddy
> 
> > Kirill A. Shutemov with 8c6e50b029 commit introduced
> > vm_ops->map_pages() for mapping easy accessible pages around
> > fault address in hope to reduce number of minor page faults.
> > 
> > This patch creates infrastructure to modify the FAULT_AROUND_ORDER
> > value using mm/Kconfig. This will enable architecture maintainers
> > to decide on suitable FAULT_AROUND_ORDER value based on
> > performance data for that architecture. First patch also defaults
> > FAULT_AROUND_ORDER Kconfig element to 4. Second patch list
> > out the performance numbers for powerpc (platform pseries) and
> > initialize the fault around order variable for pseries platform of
> > powerpc.

Sorry for not commenting earlier - just reminded by this ping to Ingo.

I didn't study your numbers, but nowhere did I see what PAGE_SIZE you use.

arch/powerpc/Kconfig suggests that Power supports base page size of
4k, 16k, 64k or 256k.

I would expect your optimal fault_around_order to depend very much on
the base page size.

Perhaps fault_around_size would provide a more useful default?

Hugh
