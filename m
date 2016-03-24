Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVzVt4S68zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 19:04:54 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVzVt1KM5z9sC3
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 19:04:53 +1100 (AEDT)
Date: Thu, 24 Mar 2016 09:04:49 +0100
From: Torsten Duwe <torsten@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using
 odd TOC
Message-ID: <20160324080449.GA13139@lst.de>
References: <20160323155858.GB27110@lst.de> <56F34F85.7020408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56F34F85.7020408@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 24, 2016 at 01:23:01PM +1100, Balbir Singh wrote:
> On 24/03/16 02:58, Torsten Duwe wrote:
> >
> > 1. Heuristics are bad. The better they are, the more subtly the
> >    way they might fail.
[...]
> I missed this yesterday, not on cc, but caught it on the list today

I replied to Michael's last post and removed the back reference to start
a new thread. The list is rather long... sorry I didn't notice.

> Thanks for working on this. I did a quick look, so the CR+4 code

Yes. It's only a proof of concept. That idea is yours, no doubt, and
should be mentioned in the final submission. I already wrote it in my
previous version, where I also have changed the arithmetic to produce
small positive deltas.

> plus heuristics for global/local call detection?

Nope, definitely not! I flag global entries unambiguously.
I had a version with R12/LR heuristics on Monday which I dumped.

>  I'll review this soon - hopefully tonight, but we have a long weekend coming up, so there might be delays. In the meanwhile feel free to add my signed-off-by for the CR+4 code. I am also looking at a different approach -- per thread lr0 stack.

This CR+4 code leaves only 1 slot, so sibling calls are extremely dangerous,
as I mentioned. But with a little attention, this patch works very well.

I mostly wanted to hear opinions about a transient odd TOC value
before I start polishing.

	Torsten
