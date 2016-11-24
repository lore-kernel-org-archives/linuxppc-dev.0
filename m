Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPLbC6qfHzDvxg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 12:04:55 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 144so1162977pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 17:04:55 -0800 (PST)
Date: Thu, 24 Nov 2016 12:04:36 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] minor build fixes
Message-ID: <20161124120436.4d0fa257@roar.ozlabs.ibm.com>
In-Reply-To: <20161123230320.GQ11815@bubble.grove.modra.org>
References: <20161123130209.1667-1-npiggin@gmail.com>
 <20161123230320.GQ11815@bubble.grove.modra.org>
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

On Thu, 24 Nov 2016 09:33:20 +1030
Alan Modra <amodra@gmail.com> wrote:

> On Thu, Nov 24, 2016 at 12:02:06AM +1100, Nicholas Piggin wrote:
> > I was building BookE and big endian with a little endian cross
> > compiler and it stopped working. My BookS BE tests must have been
> > building using the ELFv2 ABI. After this, the build sometimes still
> > strangely fails with dot symbols in syscall table unable to be found,
> > but that's looking like it may be a linker bug (Alan is going to take
> > a look).  
> 
> Yes it is a bug.  In compatibility code that was supposed to handle
> mixing old object files that use dot-symbols on function entry with
> newer object files that don't.  Here, "old" means mid 2004 or
> earlier.
> 
> As you can imagine, I'm not hugely concerned about the ld bug..
> 
> Since every binutils back to at least 2.17 has the bug, what changed
> in the kernel to expose it?  Are you building without -mcall-aixdesc?
> 

Yeah, it's my attempt to get powerpc64le compiler to build big endian
with -mabi=elfv2, so I'd have missed -mcall-aixdesc somewhere.

Thanks,
Nick
