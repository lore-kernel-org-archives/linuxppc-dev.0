Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416Mb51TkmzF1Cq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 10:59:44 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5F0xeWu049022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:59:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jkyka7hpp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:59:40 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 15 Jun 2018 01:59:05 +0100
Date: Thu, 14 Jun 2018 17:58:54 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v13 00/24] selftests, powerpc, x86 : Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <c5c119b0-f5ca-4ddc-43c0-a6b597173973@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c5c119b0-f5ca-4ddc-43c0-a6b597173973@redhat.com>
Message-Id: <20180615005854.GA5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2018 at 10:19:11PM +0200, Florian Weimer wrote:
> On 06/14/2018 02:44 AM, Ram Pai wrote:
> >Test
> >----
> >Verified for correctness on powerpc. Need help verifying on x86.
> >Compiles on x86.
> 
> It breaks make in tools/testing/selftests/x86:
> 
> make: *** No rule to make target `protection_keys.c', needed by
> `/home/linux/tools/testing/selftests/x86/protection_keys_64'.  Stop.

Ah.. it has to be taken out from the Makefile of
/home/linux/tools/testing/selftests/x86/

The sources have been moved to /home/linux/tools/testing/selftests/mm/

> 
> The generic implementation no longer builds 32-bit binaries.  Is
> this the intent?

No. But building it 32-bit after moving it to a the new directory 
needs some special code in the Makefile. 

> 
> It's possible to build 32-bit binaries with “make CC='gcc -m32'”, so
> perhaps this is good enough?

Dave Hansen did mention it, but he did not complain too much. So I kept
quite.

> 
> But with that, I get a warning:
> 
> protection_keys.c: In function ‘dump_mem’:
> protection_keys.c:172:3: warning: format ‘%lx’ expects argument of
> type ‘long unsigned int’, but argument 4 has type ‘uint64_t’
> [-Wformat=]
>    dprintf1("dump[%03d][@%p]: %016lx\n", i, ptr, *ptr);
>    ^
> 
> I suppose you could use %016llx and add a cast to unsigned long long
> to fix this.

yes.

> 
> Anyway, both the 32-bit and 64-bit tests fail here:
> 
> assert() at protection_keys.c::943 test_nr: 12 iteration: 1
> running abort_hooks()...
> 
> I've yet checked what causes this.  It's with the kernel headers
> from 4.17, but with other userspace headers based on glibc 2.17.  I
> hope to look into this some more before the weekend, but I
> eventually have to return the test machine to the pool.

I wish I could get a x86 machine which could do memory keys. Had a AWS
instance, but struggled to boot my kernel. Can't get to the console...
gave up.  If someone can give me a ready-made machine with support for
memkeys, I can quickly fix all the outstanding x86 issues.  But if
someone can just fix it for me, ....  ;)

RP
