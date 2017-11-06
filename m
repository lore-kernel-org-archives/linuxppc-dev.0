Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVj6d4N5tzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 17:18:16 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA66ECpZ104545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 01:18:14 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e26e0xapj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 01:18:13 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 06:18:12 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
In-Reply-To: <20171105231850.5e313e46@roar.ozlabs.ibm.com>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
Date: Mon, 06 Nov 2017 11:48:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871slcszfl.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri, 3 Nov 2017 18:05:20 +0100
> Florian Weimer <fweimer@redhat.com> wrote:
>
>> We are seeing an issue on ppc64le and ppc64 (and perhaps on some arm 
>> variant, but I have not seen it on our own builders) where running 
>> localedef as part of the glibc build crashes with a segmentation fault.
>> 
>> Kernel version is 4.13.9 (Fedora 26 variant).
>> 
>> I have only seen this with an explicit loader invocation, like this:
>> 
>> while I18NPATH=. /lib64/ld64.so.1 /usr/bin/localedef 
>> --alias-file=../intl/locale.alias --no-archive -i locales/nl_AW -c -f 
>> charmaps/UTF-8 
>> --prefix=/builddir/build/BUILDROOT/glibc-2.26-16.fc27.ppc64 nl_AW ; do : 
>> ; done
>> 
>> To be run in the localedata subdirectory of a glibc *source* tree, after 
>> a build.  You may have to create the 
>> /builddir/build/BUILDROOT/glibc-2.26-16.fc27.ppc64/usr/lib/locale 
>> directory.  I have only reproduced this inside a Fedora 27 chroot on a 
>> Fedora 26 host, but there it does not matter if you run the old (chroot) 
>> or newly built binary.
>> 
>> I filed this as a glibc bug for tracking:
>> 
>>    https://sourceware.org/bugzilla/show_bug.cgi?id=22390
>> 
>> There's an strace log and a coredump from the crash.
>> 
>> I think the data shows that the address in question should be writable.
>> 
>> The crossed 0x0000800000000000 binary is very suggestive.  I think that 
>> based on the operation of glibc's malloc, this write would be the first 
>> time this happens during the lifetime of the process.
>> 
>> Does that ring any bells?  Is there anything I can do to provide more 
>> data?  The host is an LPAR with a stock Fedora 26 kernel, so I can use 
>> any diagnostics tool which is provided by Fedora.
>
> There was a recent change to move to 128TB address space by default,
> and option for 512TB addresses if explicitly requested.
>
> Your brk request asked for > 128TB which the kernel gave it, but the
> address limit in the paca that the SLB miss tests against was not
> updated to reflect the switch to 512TB address space.

We should not return that address, unless we requested with a hint value
of > 128TB. IIRC we discussed this early during the mmap interface
change and said, we will return an address > 128T only if the hint
address is above 128TB (not hint addr + length). I am not sure why
we are finding us returning and address > 128TB with paca limit set to
128TB?


>
> Why is your brk starting so high? Are you trying to test the > 128TB
> case, or maybe something is confused by the 64->128TB change? What's
> the strace look like if you run on a distro or <= 4.10 kernel?
>
> Something like the following patch may help if you could test.
>
> Thanks,
> Nick
>

-aneesh
