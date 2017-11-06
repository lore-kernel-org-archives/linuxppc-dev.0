Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVlxb5rXczDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:25:38 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p9so7636965pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:25:38 -0800 (PST)
Date: Mon, 6 Nov 2017 19:25:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm <linux-mm@kvack.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171106192524.12ea3187@roar.ozlabs.ibm.com>
In-Reply-To: <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 6 Nov 2017 09:11:37 +0100
Florian Weimer <fweimer@redhat.com> wrote:

> On 11/06/2017 07:47 AM, Nicholas Piggin wrote:
> > "You get < 128TB unless explicitly requested."
> > 
> > Simple, reasonable, obvious rule. Avoids breaking apps that store
> > some bits in the top of pointers (provided that memory allocator
> > userspace libraries also do the right thing).  
> 
> So brk would simplify fail instead of crossing the 128 TiB threshold?

Yes, that was the intention and that's what x86 seems to do.

> 
> glibc malloc should cope with that and switch to malloc, but this code 
> path is obviously less well-tested than the regular way.

Switch to mmap() I guess you meant?

powerpc has a couple of bugs in corner cases, so those should be fixed
according to intended policy for stable kernels I think.

But I question the policy. Just seems like an ugly and ineffective wart.
Exactly for such cases as this -- behaviour would change from run to run
depending on your address space randomization for example! In case your
brk happens to land nicely on 128TB then the next one would succeed. If
not, then behaviour changes. And you didn't catch or prevent any bugs.

Thanks,
Nick
