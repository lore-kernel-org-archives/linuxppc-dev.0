Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416FMb0P87zF09q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 06:19:22 +1000 (AEST)
Subject: Re: [PATCH v13 00/24] selftests, powerpc, x86 : Memory Protection Keys
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c5c119b0-f5ca-4ddc-43c0-a6b597173973@redhat.com>
Date: Thu, 14 Jun 2018 22:19:11 +0200
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2018 02:44 AM, Ram Pai wrote:
> Test
> ----
> Verified for correctness on powerpc. Need help verifying on x86.
> Compiles on x86.

It breaks make in tools/testing/selftests/x86:

make: *** No rule to make target `protection_keys.c', needed by 
`/home/linux/tools/testing/selftests/x86/protection_keys_64'.  Stop.

The generic implementation no longer builds 32-bit binaries.  Is this 
the intent?

It's possible to build 32-bit binaries with “make CC='gcc -m32'”, so 
perhaps this is good enough?

But with that, I get a warning:

protection_keys.c: In function ‘dump_mem’:
protection_keys.c:172:3: warning: format ‘%lx’ expects argument of type 
‘long unsigned int’, but argument 4 has type ‘uint64_t’ [-Wformat=]
    dprintf1("dump[%03d][@%p]: %016lx\n", i, ptr, *ptr);
    ^

I suppose you could use %016llx and add a cast to unsigned long long to 
fix this.

Anyway, both the 32-bit and 64-bit tests fail here:

assert() at protection_keys.c::943 test_nr: 12 iteration: 1
running abort_hooks()...

I've yet checked what causes this.  It's with the kernel headers from 
4.17, but with other userspace headers based on glibc 2.17.  I hope to 
look into this some more before the weekend, but I eventually have to 
return the test machine to the pool.

Thanks,
Florian
