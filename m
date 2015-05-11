Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A88B1A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 05:12:07 +1000 (AEST)
Date: Mon, 11 May 2015 12:12:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-Id: <20150511121204.2af73429ad3c29b6d67f1345@linux-foundation.org>
In-Reply-To: <20150511143618.GA30570@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150508200610.GB29933@akamai.com>
 <20150508131523.f970d13a213bca63bd6f2619@linux-foundation.org>
 <20150511143618.GA30570@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuahkh@osg.samsung.com>, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 May 2015 10:36:18 -0400 Eric B Munson <emunson@akamai.com> wrote:

> On Fri, 08 May 2015, Andrew Morton wrote:
> ...
>
> > 
> > Why can't the application mmap only those parts of the file which it
> > wants and mlock those?
> 
> There are a number of problems with this approach.  The first is it
> presumes the program will know what portions are needed a head of time.
> In many cases this is simply not true.  The second problem is the number
> of syscalls required.  With my patches, a single mmap() or mlockall()
> call is needed to setup the required locking.  Without it, a separate
> mmap call must be made for each piece of data that is needed.  This also
> opens up problems for data that is arranged assuming it is contiguous in
> memory.  With the single mmap call, the user gets a contiguous VMA
> without having to know about it.  mmap() with MAP_FIXED could address
> the problem, but this introduces a new failure mode of your map
> colliding with another that was placed by the kernel.
> 
> Another use case for the LOCKONFAULT flag is the security use of
> mlock().  If an application will be using data that cannot be written
> to swap, but the exact size is unknown until run time (all we have a
> build time is the maximum size the buffer can be).  The LOCKONFAULT flag
> allows the developer to create the buffer and guarantee that the
> contents are never written to swap without ever consuming more memory
> than is actually needed.

What application(s) or class of applications are we talking about here?

IOW, how generally applicable is this?  It sounds rather specialized.
