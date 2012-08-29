Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2012 09:39:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: madper <cxie@redhat.com>
Subject: Re: The MAX high_addr for `mmap` on PPC64
Message-ID: <20120829233927.GK5723@truffula.fritz.box>
References: <op.wjr9i6t4xxpu98@localhost.localdomain>
 <20120829034258.GF5723@truffula.fritz.box>
 <op.wjsalgstxxpu98@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.wjsalgstxxpu98@localhost.localdomain>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2012 at 11:57:06AM +0800, madper wrote:
> On Wed, 29 Aug 2012 11:42:58 +0800, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> 
> >On Wed, Aug 29, 2012 at 11:34:08AM +0800, madper wrote:
> >>Hi every one,
> >>    I use the ltp (Linux-Test-Project) and run it on both ppc64
> >>and x86_64.
> >>    There is a code like follows in
> >>`ltp/testcase/kernel/mem/hugetbl/hugemmap/hugemmap03.c`:
> >>`code`
> >>        #define HIGH_ADDR       (void *)(0x1000000000000)
> >>	/* Attempt to mmap into highmem addr, should get ENOMEM */
> >>	addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
> >>	            MAP_SHARED | MAP_FIXED, fildes, 0);
> >>`code ends`
> >>    It return ENOMEM on x86_64 as well as we expected. But return
> >>EINVAL on ppc64. So I want to know the MAX high addr for PPC64.
> >
> >That's a pretty bogus test, since the max address is not specified
> >strictly.  It's currently 4T on ppc64, but patches that are in the
> >works will change it to 16T.
> >
> Hi, I tested it for rhel6. Also I change the high_addr to
> `0x7ffffffffff` but it got EINVAL again.

0x7ffffffffff is not page aligned, so it probably should get EINVAL.
That said, it wouldn't surprise me if we got the wront error code for
address space overflows.

> So, I nearly certain that rhel6 can only support for 4T.
> So, do you think that I should change the high_addr to `0x3ffffffffff`?
> 
> >Also I'm not convinced that "highmem addr" has any meaning in the
> >context of userspace addresses.
> >
> I think may be the coder want to test kernel by userspace program?    :-(



-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
