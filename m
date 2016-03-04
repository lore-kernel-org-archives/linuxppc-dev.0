Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E89111A0615
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 06:22:26 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 616D8140291
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2016 06:22:25 +1100 (AEDT)
Date: Fri, 4 Mar 2016 20:22:22 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160304192222.GA31341@lst.de>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <20160304124247.GA20914@lst.de> <20160304130137.GC3166@pathway.suse.cz>
 <20160304181657.GA30434@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160304181657.GA30434@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2016 at 07:16:57PM +0100, Torsten Duwe wrote:
> On Fri, Mar 04, 2016 at 02:01:37PM +0100, Petr Mladek wrote:
> > 
> > Do I understand it correctly that we could not patch functions that
> > pass arguments on the stack with this implementation? If yes, how hard
> > would be to get it working, please? At least, it would be great to
> > catch this problem and handle it with grace. Otherwise, it might
> > be hard to debug.
> 
> No, those functions only require special attention.

So far it's correct. It's been a while since I wrote that code.

> I needed _any_ location to store the caller's TOC;
> and the stack is thread-safe and recursion-safe.
> The current caller's frame is already full so I had
> to create a new one.

Correction: the TOC can be stored in the caller's stack frame at
the usual location. Only the restore instruction is a problem.

> A patch function could e.g. grab that TOC value in a
> prologue and then pop that stack frame. Or it could
> add those 32 bytes to the assumed arguments' stack offsets.

So one solution could be to call the patch function via a small
trampoline or pre-prologue that just pops that frame, and have
the patch function restore R2 manually at the end.

Sorry for the confusion,

	Torsten
