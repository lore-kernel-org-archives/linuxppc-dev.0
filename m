Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVldT4ffRzDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:11:41 +1100 (AEDT)
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
Date: Mon, 6 Nov 2017 09:11:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171106174707.19f6c495@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2017 07:47 AM, Nicholas Piggin wrote:
> "You get < 128TB unless explicitly requested."
> 
> Simple, reasonable, obvious rule. Avoids breaking apps that store
> some bits in the top of pointers (provided that memory allocator
> userspace libraries also do the right thing).

So brk would simplify fail instead of crossing the 128 TiB threshold?

glibc malloc should cope with that and switch to malloc, but this code 
path is obviously less well-tested than the regular way.

Thanks,
Florian
