Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 254B91A0615
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 05:17:02 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A0F0140273
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2016 05:17:00 +1100 (AEDT)
Date: Fri, 4 Mar 2016 19:16:57 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160304181657.GA30434@lst.de>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <20160304124247.GA20914@lst.de> <20160304130137.GC3166@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160304130137.GC3166@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2016 at 02:01:37PM +0100, Petr Mladek wrote:
> 
> Do I understand it correctly that we could not patch functions that
> pass arguments on the stack with this implementation? If yes, how hard
> would be to get it working, please? At least, it would be great to
> catch this problem and handle it with grace. Otherwise, it might
> be hard to debug.

No, those functions only require special attention.
I needed _any_ location to store the caller's TOC;
and the stack is thread-safe and recursion-safe.
The current caller's frame is already full so I had
to create a new one.

A patch function could e.g. grab that TOC value in a
prologue and then pop that stack frame. Or it could
add those 32 bytes to the assumed arguments' stack offsets.

> 
> > Where shall we put this warning?
> 
> Sadly, we do not have any Documentation/livepatch/ yet/.
> I still hope that we could handle it somehow in the code.

I really think some documentation would be good, a live patch
howto for a start...

	Torsten
