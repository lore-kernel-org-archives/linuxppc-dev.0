Return-Path: <computersforpeace@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A627D1400A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 05:44:43 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so1509678pbb.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:44:40 -0700 (PDT)
Date: Thu, 15 May 2014 12:44:37 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: roundup_pow_of_two() may not handle 64-bit integers
Message-ID: <20140515194437.GM28907@ld-irv-0074>
References: <20140515022238.GL28907@ld-irv-0074>
 <29314.1400166189@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29314.1400166189@warthog.procyon.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 15, 2014 at 04:03:09PM +0100, David Howells wrote:
> Brian Norris <computersforpeace@gmail.com> wrote:
> > I'm looking to use roundup_pow_of_two() (actually, order_base_2())
> > from <linux/log2.h>, but it seems that it only supports 64-bit integers
> > if your toolchain uses a 64-bit 'unsigned long' type. This is strange,
> > considering that ilog2() is explicitly designed for 32-bit or 64-bit
> > compatibility.
> 
> ilog2() was explicitly designed for use with 'unsigned long'.  See the commit
> description (f0d1b0b30d250a07627ad8b9fbbb5c7cc08422e8).  It may work with
> unsigned long long, however...

That's another confusing point; the commit description says 'unsigned
long', but the code shows nothing of that sort, and the comments say
nearly the reverse (mentioning '32-bit and 64-bit', not 'unsigned
long'). The code only referenes ULL constants, and it selects a 32-bit
or 64-bit runtime version based on the type. To me, this demonstrates an
explicit design for "32-bit or 64-bit", regardless of the dimensions of
your 'long'.

So this leaves me with 2 main issues:

(1) Can we make <linux/ilog2.h> have some sense of consistency? If so,
    how?
     - Enforce the 'unsigned long' design (i.e., don't support
       ilog2(u64) when sizeof(unsigned long) == 4)?
     - Make all high-level macros automatically support 32-bit or 64-bit,
       regardless of type?
     - Split out 32-bit vs. 64-bit functions for everything?

    Obviously some of these options are sillier than others.

(2) Powerpc (and maybe some of SH's PCI) code has a potential bug, due
    to using roundup_pow_of_two() on type phys_addr_t, which could
    overflow for LPAE systems with large physical memory ranges. Is this
    a legitimate concern?

Brian
