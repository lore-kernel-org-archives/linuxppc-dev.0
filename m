Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVlbr3JDnzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:10:16 +1100 (AEDT)
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <fed9e04f-e69d-df8d-a930-2f71d7814a64@redhat.com>
Date: Mon, 6 Nov 2017 09:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <871slcszfl.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2017 07:18 AM, Aneesh Kumar K.V wrote:
> We should not return that address, unless we requested with a hint value
> of > 128TB. IIRC we discussed this early during the mmap interface
> change and said, we will return an address > 128T only if the hint
> address is above 128TB (not hint addr + length). I am not sure why
> we are finding us returning and address > 128TB with paca limit set to
> 128TB?

See the memory maps I posted.  I think it was not anticipated that the 
heap could be near the 128 TiB limit because it is placed next to the 
initially mapped object.

I think this could become worse once we have static PIE support because 
static PIE binaries likely have the same memory layout.  (Ordinary PIE 
does not.)

Thanks,
Florian
