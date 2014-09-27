Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417E31A0163
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Sep 2014 10:22:51 +1000 (EST)
Date: Fri, 26 Sep 2014 19:22:28 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140927002228.GC18404@gate.crashing.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home> <20140924122202.62feb950@kryten>
 <1411525460.4184.29.camel@pasglop> <20140924123307.7649bec8@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140924123307.7649bec8@kryten>
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

On Wed, Sep 24, 2014 at 12:33:07PM +1000, Anton Blanchard wrote:
> We are scratching our heads trying to remember details of the issue
> right now. In retrospect we should have linked the gcc bugzilla or
> gcc commit details in the kernel commit message :)

There have been many GCC bugs in this area.

30282 (for 32-bit)
44199 (for 64-bit)
52828 (for everything, and this one should finally handle things for good)
Also a bunch of duplicates, and I'm sure I've missed some more.

The original issue as far as I remember: when using a frame pointer, GCC
would sometimes schedule the epilogue to do the stack adjust before
restoring all regs from the stack.  Then an interrupt comes in, those
saved regs are clobbered, kaboom.  We cannot disable the frame pointer
because -pg forces it (although PowerPC does not need it).  The
-mno-sched-epilog flag is a workaround: the epilogue (and prologue) will
not be reordered by instruction scheduling.  Slow code is better than
blowing up fast ;-)


Segher
