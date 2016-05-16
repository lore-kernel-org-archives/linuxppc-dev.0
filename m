Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7m8K0kR8zDq68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 02:27:28 +1000 (AEST)
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
To: Andreas Schwab <schwab@linux-m68k.org>
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
 <20160516062425.GA24091__32035.8907142237$1463379977$gmane$org@bubble.grove.modra.org>
 <m21t52xu92.fsf@linux-m68k.org>
 <adca8a90-b4ce-f386-5706-0a17b1e91441@redhat.com>
 <m2shxiwerp.fsf@linux-m68k.org>
Cc: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <92af6d3d-b55e-af9d-4a71-2014490eeabd@redhat.com>
Date: Mon, 16 May 2016 18:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <m2shxiwerp.fsf@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2016 11:09 AM, Andreas Schwab wrote:
> Florian Weimer <fweimer@redhat.com> writes:
>
>> But my test says that at least part of .bss in the main executable is
>> *not* executable.
>
> Build with -mbss-plt -Wl,--bss-plt.

This gives me:

   FAIL exec  .bss data (unexpected result)
   FAIL exec  .data (unexpected result)
   FAIL exec  malloc (small) (unexpected result)
   FAIL exec  malloc (page size) (unexpected result)

And this is somewhat expected: There is an RWX LOAD segment which covers 
.bss and .data, and it also overlaps with the heap.

So maybe we can change the kernel heap default in case there is no RWX 
LOAD segment, so that most binaries get a non-executable heap?  What do 
you think?

Thanks,
Florian
