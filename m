Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 735BA1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 02:50:54 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:50:50 -0400 (EDT)
Message-Id: <20150420.125050.2036067807685492178.davem@davemloft.net>
To: linux@roeck-us.net
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make
 sparc64 use scalable lib/iommu-common.c functions)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150420164431.GA30837@roeck-us.net>
References: <55348BE1.4010305@roeck-us.net>
 <20150420.122519.1661605449214047938.davem@davemloft.net>
 <20150420164431.GA30837@roeck-us.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
 sowmini.varadhan@oracle.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Apr 2015 09:44:31 -0700

> On Mon, Apr 20, 2015 at 12:25:19PM -0400, David Miller wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>> Date: Sun, 19 Apr 2015 22:17:21 -0700
>> 
>> > The debug option is intended for all _other_ architectures, to
>> > ensure that changes made for those don't break alpha/s390
>> > builds. alpha/s390 have ARCH_NEEDS_WEAK_PER_CPU and don't need the
>> > debug option.
>> 
>> Ironically this would not create a build failure for the architectures
>> where this matters, because only powerpc has the like named percpu
>> symbol.
>> 
>> So it's not really meeting the stated objective in this case.
> 
> Yes, that is correct; it can only find problems in non-architecture
> code, and on the downside produces false positives and thus build errors
> like this one.
> 
> Which makes the fix a bit philosophical. Rename iommu_pool_hash in
> iommu-common, or drop DEBUG_FORCE_WEAK_PER_CPU. I would rename
> iommu_pool_hash, but that is just me. Ultimately, I don't really
> care one way or another, as long as the problem gets fixed.

If nightly builds of s390 and alpha, the two platforms where this
matters, are being done as reported in this thread, then I really
don't see the value in DEBUG_FORCE_WEAK_PER_CPU.

But I guess that's a more involved longer-term discussion and I guess
I'll apply Sowmini's patches for now.

Thanks.
