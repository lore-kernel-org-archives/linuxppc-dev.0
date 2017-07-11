Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6bwt11tPzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 08:14:53 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BM9SF4139862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 18:14:51 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mvf66c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 18:14:51 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 11 Jul 2017 16:14:50 -0600
Date: Tue, 11 Jul 2017 15:14:34 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
 linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a
 key at creation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
 <1499808577.2865.30.camel@kernel.crashing.org>
 <20170711215105.GA5542@ram.oc3035372033.ibm.com>
 <3bdd9083-ef2a-d1da-802c-c6822cf818b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3bdd9083-ef2a-d1da-802c-c6822cf818b3@intel.com>
Message-Id: <20170711221434.GB5542@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 11, 2017 at 02:57:30PM -0700, Dave Hansen wrote:
> On 07/11/2017 02:51 PM, Ram Pai wrote:
> > On Wed, Jul 12, 2017 at 07:29:37AM +1000, Benjamin Herrenschmidt wrote:
> >> On Tue, 2017-07-11 at 11:11 -0700, Dave Hansen wrote:
> >>> On 07/05/2017 02:21 PM, Ram Pai wrote:
> >>>> Currently sys_pkey_create() provides the ability to disable read
> >>>> and write permission on the key, at  creation. powerpc  has  the
> >>>> hardware support to disable execute on a pkey as well.This patch
> >>>> enhances the interface to let disable execute  at  key  creation
> >>>> time. x86 does  not  allow  this.  Hence the next patch will add
> >>>> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> >>>> specified.
> >>
> >> That leads to the question... How do you tell userspace.
> >>
> >> (apologies if I missed that in an existing patch in the series)
> >>
> >> How do we inform userspace of the key capabilities ? There are at least
> >> two things userspace may want to know already:
> >>
> >>  - What protection bits are supported for a key
> > 
> > the userspace is the one which allocates the keys and enables/disables the
> > protection bits on the key. the kernel is just a facilitator. Now if the
> > use space wants to know the current permissions on a given key, it can
> > just read the AMR/PKRU register on powerpc/intel respectively.
> 
> Let's say I want to execute-disable a region.  Can I use protection
> keys?  Do I do
> 
> 	pkey_mprotect(... PKEY_DISABLE_EXECUTE);
> 
> and assume that the -EINVAL is because PKEY_DISABLE_EXECUTE is
> unsupported, or do I do:
> 
> #ifdef __ppc__
> 	pkey = pkey_aloc();
> 	pkey_mprotect(... PKEY_DISABLE_EXECUTE);
> #else
> 	mprotect();
> #endif

on ppc you could do either
pkey = pkey_alloc(..,PKEY_DISABLE_EXECUTE);
pkey_mprotect(...,pkey);

or you can just do the x86 way
mprotect();

> 
> >>  - How many keys exist
> > 
> > There is no standard way of finding this other than trying to allocate
> > as many till you fail.  A procfs or sysfs file can be added to expose
> > this information.
> 
> It's also dynamic.  On x86, you lose a key if you've used the
> execute-only support.  We also reserve the right to steal more in the
> future if we want.

total number of key supported on the architecture is a constant.
How many are reserved by the architecture is also probably known in
advance.
Now how many does the kernel use to reserve for itself is something
the kernel knows too and hence can expose it, though the information
may change dynamically as the kernel reserves and releases the key
based on its internal needs. 

So i think we can expose this informaton through procfs/sysfs and let
the application decide how it wants to use the information.

> 
> >>  - Which keys are available for use by userspace. On PowerPC, the
> >> kernel can reserve some keys for itself, so can the hypervisor. In
> >> fact, they do.
> > 
> > this information can be exposed through /proc or /sysfs
> > 
> > I am sure there will be more demands and requirements as applications
> > start leveraging these feature.
> 
> For 5 bits, I think just having someone run pkey_alloc() in a loop is
> fine.  I don't think we really need to enumerate it in some other way.

-- 
Ram Pai
