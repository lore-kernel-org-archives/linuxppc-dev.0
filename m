Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VQF91TY8zF3Hx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:08:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HG4W7q110736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:08:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k9h49fr1u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:08:42 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 17 Jul 2018 17:08:40 +0100
Date: Tue, 17 Jul 2018 09:08:28 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v13 18/24] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-19-git-send-email-linuxram@us.ibm.com>
 <55227442-a573-62b1-3206-1f3065a4b55f@intel.com>
MIME-Version: 1.0
In-Reply-To: <55227442-a573-62b1-3206-1f3065a4b55f@intel.com>
Message-Id: <20180717160828.GF5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 08:11:07AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> >  	/*
> > -	 * There are 16 pkeys supported in hardware.  Three are
> > -	 * allocated by the time we get here:
> > -	 *   1. The default key (0)
> > -	 *   2. One possibly consumed by an execute-only mapping.
> > -	 *   3. One allocated by the test code and passed in via
> > -	 *      'pkey' to this function.
> > -	 * Ensure that we can allocate at least another 13 (16-3).
> > +	 * There are NR_PKEYS pkeys supported in hardware. arch_reserved_keys()
> > +	 * are reserved. One of which is the default key(0). One can be taken
> > +	 * up by an execute-only mapping.
> > +	 * Ensure that we can allocate at least the remaining.
> >  	 */
> > -	pkey_assert(i >= NR_PKEYS-3);
> > +	pkey_assert(i >= (NR_PKEYS-arch_reserved_keys()-1));
> 
> We recently had a bug here.  I fixed it and left myself a really nice
> comment so I and others wouldn't screw it up in the future.
> 
> Does this kill my nice, new comment?

part of your nice comment has been moved into the header file. The arch
specific header file explains where and how the reserved keys are used.

-- 
Ram Pai
