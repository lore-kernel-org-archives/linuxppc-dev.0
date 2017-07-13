Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7hxj4myPzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 03:04:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6DGwdRl045525
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:04:23 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3q1hj6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:04:23 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 13 Jul 2017 13:04:21 -0400
Date: Thu, 13 Jul 2017 10:04:11 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
 <8b0827c9-9fc9-c2d5-d1a5-52d9eef8965e@intel.com>
 <20170713080348.GH5525@ram.oc3035372033.ibm.com>
 <e3355a7a-8899-b69d-968a-6862c29633a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3355a7a-8899-b69d-968a-6862c29633a2@intel.com>
Message-Id: <20170713170411.GI5525@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 07:07:48AM -0700, Dave Hansen wrote:
> On 07/13/2017 01:03 AM, Ram Pai wrote:
> > On Tue, Jul 11, 2017 at 11:13:56AM -0700, Dave Hansen wrote:
> >> On 07/05/2017 02:22 PM, Ram Pai wrote:
> >>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> >>> +void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> >>> +{
> >>> +	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> >>> +}
> >>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> >>
> >> This seems like kinda silly unnecessary duplication.  Could we just put
> >> this in the fs/proc/ code and #ifdef it on ARCH_HAS_PKEYS?
> > 
> > Well x86 predicates it based on availability of X86_FEATURE_OSPKE.
> > 
> > powerpc doesn't need that check or any similar check. So trying to
> > generalize the code does not save much IMHO.
> 
> I know all your hardware doesn't support it. :)

Wow! you bring a good point which I had not considered yet. I need some
runtime checks for RPT.

But regardless, my above statement is still partially true. x86
predicates it based on availability of X86_FEATURE_OSPKE, and powerpc
should predicate it based on HPT. So we have our own
customized checks. Hence a unified function won't suffice.

> 
> So, for instance, if you are running on a new POWER9 with radix page
> tables, you will just always output "ProtectionKey: 0" in every VMA,
> regardless?
> 
> > maybe have a seperate inline function that does
> > seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > and is called from x86 and powerpc's arch_show_smap()?
> > At least will keep the string format captured in 
> > one single place.
> 
> Now that we have two architectures, is there a strong reason we can't
> just have an arch_pkeys_enabled(), and stick the seq_printf() back in
> generic code?

correct. that looks like the correct approach. Was trying to avoid
touching arch neutral code. But this approach will force me
do so. Will do.

-- 
Ram Pai
