Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVFym5sKxzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Nov 2017 23:54:56 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so5688222pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Nov 2017 04:54:56 -0800 (PST)
Date: Sun, 5 Nov 2017 23:54:43 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <20171105235443.045fb4b7@roar.ozlabs.ibm.com>
In-Reply-To: <919a1cb5-c3b5-ddee-d6a6-0994c282ae84@redhat.com>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <919a1cb5-c3b5-ddee-d6a6-0994c282ae84@redhat.com>
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

On Sun, 5 Nov 2017 13:35:40 +0100
Florian Weimer <fweimer@redhat.com> wrote:

> On 11/05/2017 01:18 PM, Nicholas Piggin wrote:
> 
> > There was a recent change to move to 128TB address space by default,
> > and option for 512TB addresses if explicitly requested.  
> 
> Do you have a commit hash for the introduction of 128TB by default?  Thanks.

I guess this one

f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")

> 
> > Your brk request asked for > 128TB which the kernel gave it, but the
> > address limit in the paca that the SLB miss tests against was not
> > updated to reflect the switch to 512TB address space.
> > 
> > Why is your brk starting so high? Are you trying to test the > 128TB
> > case, or maybe something is confused by the 64->128TB change? What's
> > the strace look like if you run on a distro or <= 4.10 kernel?  
> 
> I think it is a consequence of running with an explicit loader 
> invocation.  With that, the heap is placed above ld.so, which can be 
> quite high in the address space.
> 
> I'm attaching two runs of cat, one executing directly as /bin/cat, and 
> one with /lib64/ld64.so.1 /bin/cat.
> 
> Fortunately, this does *not* apply to PIE binaries (also attached). 
> However, explicit loader invocations are sometimes used in test suites 
> (not just for glibc), and these sporadic test failures are quite annoying.
> 
> Do you still need the strace log?  And if yes, of what exactly?

Thanks, that should be quite helpful. I'll spend a bit more time to
study it, I'll let you know if I need any other traces.

> 
> > Something like the following patch may help if you could test.  
> 
> Okay, this will take some time.

It's no rush, there will probably be a revision to come.

Thanks,
Nick
