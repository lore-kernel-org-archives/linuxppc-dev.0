Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28EB91A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 22:14:28 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7168140783
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 22:14:27 +1100 (AEDT)
Date: Tue, 8 Mar 2016 12:14:23 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160308111423.GB16502@lst.de>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <20160304124247.GA20914@lst.de> <20160304130137.GC3166@pathway.suse.cz>
 <20160304181657.GA30434@lst.de> <20160304192222.GA31341@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160304192222.GA31341@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2016 at 08:22:22PM +0100, Torsten Duwe wrote:
> On Fri, Mar 04, 2016 at 07:16:57PM +0100, Torsten Duwe wrote:
> > On Fri, Mar 04, 2016 at 02:01:37PM +0100, Petr Mladek wrote:
> > > 
> > > Do I understand it correctly that we could not patch functions that
> > > pass arguments on the stack with this implementation? If yes, how hard
> > > would be to get it working, please? At least, it would be great to
> > > catch this problem and handle it with grace. Otherwise, it might
> > > be hard to debug.
> > 
> > No, those functions only require special attention.
> 
> So far it's correct. It's been a while since I wrote that code.
> 
> > I needed _any_ location to store the caller's TOC;
> > and the stack is thread-safe and recursion-safe.
> > The current caller's frame is already full so I had
> > to create a new one.
> 
> Correction: the TOC can be stored in the caller's stack frame at
> the usual location. Only the restore instruction is a problem.

Another correction :-( This is true only for local calls

    -*> Which become *global* calls due to live patching <*-

For callers that made a global call to the patched function originally,
they already _have_ stored their TOC value there, and the r2 they enter
ftrace caller with is bogus.

I see no way to determine which is the case, so my code preserves both:
24(r1) in the caller's frame is left untouched. R2, as it came, is saved in
the mini stack frame, as well as the caller's return address (LR,
shifted 1 frame). Remember, LR got modified to point to klp_return_helper.

Removing this auxiliary stack frame causes even more problems than it solves.

> So one solution could be to call the patch function via a small
> trampoline or pre-prologue that just pops that frame, and have
> the patch function restore R2 manually at the end.

I'll try to demonstrate that. It's not so hard. And klp_return_helper will
do the right thing for >90% of all function replacements automatically.

> Sorry for the confusion,

Once more.

	Torsten
