Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E1EE1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 15:55:50 +1100 (AEDT)
Date: Tue, 28 Oct 2014 15:55:49 +1100
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20141028155549.0430c96a@kryten>
In-Reply-To: <20140927002228.GC18404@gate.crashing.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home>
 <20140924122202.62feb950@kryten> <1411525460.4184.29.camel@pasglop>
 <20140924123307.7649bec8@kryten>
 <20140927002228.GC18404@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

> On Wed, Sep 24, 2014 at 12:33:07PM +1000, Anton Blanchard wrote:
> > We are scratching our heads trying to remember details of the issue
> > right now. In retrospect we should have linked the gcc bugzilla or
> > gcc commit details in the kernel commit message :)
> 
> There have been many GCC bugs in this area.
> 
> 30282 (for 32-bit)
> 44199 (for 64-bit)
> 52828 (for everything, and this one should finally handle things for
> good) Also a bunch of duplicates, and I'm sure I've missed some more.
> 
> The original issue as far as I remember: when using a frame pointer,
> GCC would sometimes schedule the epilogue to do the stack adjust
> before restoring all regs from the stack.  Then an interrupt comes
> in, those saved regs are clobbered, kaboom.  We cannot disable the
> frame pointer because -pg forces it (although PowerPC does not need
> it).  The -mno-sched-epilog flag is a workaround: the epilogue (and
> prologue) will not be reordered by instruction scheduling.  Slow code
> is better than blowing up fast ;-)

Thanks for explaining it! It does look like the last issue wasn't
fixed until gcc 4.8. We'll drop that patch.

Anton
