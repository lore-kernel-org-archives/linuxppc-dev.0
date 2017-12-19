Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Njg0ybmzDx63
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:32:38 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBJGWPHN135041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:32:36 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ey63rgw2s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:32:36 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Dec 2017 11:32:34 -0500
Date: Tue, 19 Dec 2017 08:32:25 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com,
 akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de,
 linux-arch@vger.kernel.org, ebiederm@xmission.com,
 linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys:
 Add sysfs interface
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
 <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
 <877etj9ekv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877etj9ekv.fsf@concordia.ellerman.id.au>
Message-Id: <20171219163225.GC5481@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2017 at 09:50:24PM +1100, Michael Ellerman wrote:
> Dave Hansen <dave.hansen@intel.com> writes:
> 
> > On 11/06/2017 12:57 AM, Ram Pai wrote:
> >> Expose useful information for programs using memory protection keys.
> >> Provide implementation for powerpc and x86.
> >> 
> >> On a powerpc system with pkeys support, here is what is shown:
> >> 
> >> $ head /sys/kernel/mm/protection_keys/*
> >> ==> /sys/kernel/mm/protection_keys/disable_access_supported <==
> >> true
> >
> > This is cute, but I don't think it should be part of the ABI.  Put it in
> > debugfs if you want it for cute tests.  The stuff that this tells you
> > can and should come from pkey_alloc() for the ABI.
> 
> Yeah I agree this is not sysfs material.
> 
> In particular the total/usable numbers are completely useless vs other
> threads allocating pkeys out from under you.

The usable number is the minimum number of keys available for use by the
application, not the number of keys **currently** available.  Its a
static number.

I am dropping this patch. We can revisit this when a clear request for
such a feature emerges.

> 
> >
> >>        Any application wanting to use protection keys needs to be able to
> >>        function without them.  They might be unavailable because the
> >>        hardware that the application runs on does not support them, the
> >>        kernel code does not contain support, the kernel support has been
> >>        disabled, or because the keys have all been allocated, perhaps by a
> >>        library the application is using.  It is recommended that
> >>        applications wanting to use protection keys should simply call
> >>        pkey_alloc(2) and test whether the call succeeds, instead of
> >>        attempting to detect support for the feature in any other way.
> >
> > Do you really not have standard way on ppc to say whether hardware
> > features are supported by the kernel?  For instance, how do you know if
> > a given set of registers are known to and are being context-switched by
> > the kernel?
> 
> Yes we do, we emit feature bits in the AT_HWCAP entry of the aux vector,
> same as some other architectures.

Ah. I was not aware of this.
Thanks,
RP
