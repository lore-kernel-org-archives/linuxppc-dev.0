Return-Path: <cxie@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id BCF012C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 13:57:18 +1000 (EST)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: The MAX high_addr for `mmap` on PPC64
References: <op.wjr9i6t4xxpu98@localhost.localdomain>
 <20120829034258.GF5723@truffula.fritz.box>
Date: Wed, 29 Aug 2012 11:57:06 +0800
MIME-Version: 1.0
From: madper <cxie@redhat.com>
Message-ID: <op.wjsalgstxxpu98@localhost.localdomain>
In-Reply-To: <20120829034258.GF5723@truffula.fritz.box>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Aug 2012 11:42:58 +0800, David Gibson  
<david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 29, 2012 at 11:34:08AM +0800, madper wrote:
>> Hi every one,
>>     I use the ltp (Linux-Test-Project) and run it on both ppc64 and  
>> x86_64.
>>     There is a code like follows in
>> `ltp/testcase/kernel/mem/hugetbl/hugemmap/hugemmap03.c`:
>> `code`
>>         #define HIGH_ADDR       (void *)(0x1000000000000)
>> 	/* Attempt to mmap into highmem addr, should get ENOMEM */
>> 	addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
>> 	            MAP_SHARED | MAP_FIXED, fildes, 0);
>> `code ends`
>>     It return ENOMEM on x86_64 as well as we expected. But return
>> EINVAL on ppc64. So I want to know the MAX high addr for PPC64.
>
> That's a pretty bogus test, since the max address is not specified
> strictly.  It's currently 4T on ppc64, but patches that are in the
> works will change it to 16T.
>
Hi, I tested it for rhel6. Also I change the high_addr to `0x7ffffffffff`  
but it got EINVAL again.
So, I nearly certain that rhel6 can only support for 4T.
So, do you think that I should change the high_addr to `0x3ffffffffff`?

> Also I'm not convinced that "highmem addr" has any meaning in the
> context of userspace addresses.
>
I think may be the coder want to test kernel by userspace program?    :-(


Thank you very very much, David.

--
Thanks,
Madper Xie.
