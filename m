Return-Path: <hugh@veritas.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AFE7DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 06:11:50 +1100 (EST)
Date: Thu, 2 Apr 2009 20:10:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Resend: /proc/<pid>/maps offset output broken in 2.6.29
In-Reply-To: <49D4FB89.4070101@nortel.com>
Message-ID: <Pine.LNX.4.64.0904021938270.25731@blonde.anvils>
References: <49CA8501.1000000@nortel.com>  <49D3F662.4050100@nortel.com>
	<1238659491.9041.133.camel@localhost>
	<Pine.LNX.4.64.0904021324070.16207@blonde.anvils>
	<49D4FB89.4070101@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2 Apr 2009, Chris Friesen wrote:
> Hugh Dickins wrote:
> > > > f7feb000-f7fec000 rw-p f7feb000 00:00 0
> > > > ffe6d000-ffe82000 rw-p ffffffeb000 00:00 0      [stack]
> 
> > Chris isn't the first to be concerned by that: there's a patch in
> > -mm which just shows 0 instead of anon vm_pgoff in /proc/<pid>/maps
> > output.  That patch is on akpm's list for 2.6.30 merge, but I think
> > hasn't gone to Linus yet: expect it in a later batch.
> 
> Alternately, what about just making the offset for the stack match the
> starting address of the VMA?

The rmap code for locating anonymous pages, even after the vma has
been moved meanwhile, depends on vma->vm_pgoff.  There is no point
in making that more complicated for this.

For display purposes only?  Well, yes, we could have done that,
but why bother?  It wouldn't be adding any information, and
might raise a question of identifying "the" stack to do that to.

> That way it would look the same as other anonymous areas,

The stack will be looking the same as other anonymous areas:
they'll all be showing 00000000 there.

This is a cosmetic matter, not worth more than a couple of lines of
code: I suggested masking off the high bits in the display, but when
KAMEZAWA-san suggested just showing 0, it was hard to argue against
his brutal simplicity.

> and as a bonus would look the same as previous releases.
> Arguably, /proc/<pid>/maps should count as userspace-visible API.

Consider this change a fix: it used to show 00000000 before 2.6.7.

See http://lkml.org/lkml/2009/1/13/331 for one of the threads
on the subject - but you've not tempted me to reopen it!

Hugh
