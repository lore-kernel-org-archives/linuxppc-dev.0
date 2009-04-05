Return-Path: <hugh@veritas.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23863DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 04:52:15 +1000 (EST)
Date: Sun, 5 Apr 2009 19:51:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Resend: /proc/<pid>/maps offset output broken in 2.6.29
In-Reply-To: <49D523FB.2020504@nortel.com>
Message-ID: <Pine.LNX.4.64.0904051944100.27448@blonde.anvils>
References: <49CA8501.1000000@nortel.com>  <49D3F662.4050100@nortel.com>
	<1238659491.9041.133.camel@localhost>
	<Pine.LNX.4.64.0904021324070.16207@blonde.anvils>
	<49D4FB89.4070101@nortel.com>
	<Pine.LNX.4.64.0904021938270.25731@blonde.anvils>
	<49D523FB.2020504@nortel.com>
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
> 
> > This is a cosmetic matter, not worth more than a couple of lines of
> > code: I suggested masking off the high bits in the display, but when
> > KAMEZAWA-san suggested just showing 0, it was hard to argue against
> > his brutal simplicity.
> 
> <snip>
> 
> > Consider this change a fix: it used to show 00000000 before 2.6.7.
> > 
> > See http://lkml.org/lkml/2009/1/13/331 for one of the threads
> > on the subject - but you've not tempted me to reopen it!
> 
> Okay, fair enough.  I'll change my code to deal with it.  Thanks for the
> explanation.

Oh, I thought you were arguing hypotheticals.  This is more serious,
that you have some userspace code which depended on the 2.6.8-2.6.29
way of filling that field, and now we're about to break it.

Please, would you share what you were doing with the vm_pgoff of an
anonymous area?  I won't pretend: I am indeed hoping to show that
what you were doing before was already broken, so that we can safely
go ahead and break it some more!

Hugh
