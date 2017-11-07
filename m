Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWRvb0301zDqvq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 22:26:18 +1100 (AEDT)
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c5586546-1e7e-0f0f-a8b3-680fadb38dcf@redhat.com>
Date: Tue, 7 Nov 2017 12:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2017 12:15 PM, Kirill A. Shutemov wrote:

>> First of all, using addr and MAP_FIXED to develop our heuristic can
>> never really give unchanged ABI. It's an in-band signal. brk() is a
>> good example that steadily keeps incrementing address, so depending
>> on malloc usage and address space randomization, you will get a brk()
>> that ends exactly at 128T, then the next one will be >
>> DEFAULT_MAP_WINDOW, and it will switch you to 56 bit address space.
> 
> No, it won't. You will hit stack first.

That's not actually true on POWER in some cases.  See the process maps I 
posted here:

   <https://marc.info/?l=linuxppc-embedded&m=150988538106263&w=2>

Thanks,
Florian
