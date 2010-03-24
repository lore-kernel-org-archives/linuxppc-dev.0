Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 0BED5B7CFC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 21:59:04 +1100 (EST)
Date: Wed, 24 Mar 2010 16:27:10 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100324105710.GD15789@amit-x200.redhat.com>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<1269427544.8599.222.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269427544.8599.222.camel@pasglop>
Cc: Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) Mar 24 2010 [21:45:44], Benjamin Herrenschmidt wrote:
> On Sun, 2010-03-21 at 08:04 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2010-03-19 at 08:18 -0700, Greg Kroah-Hartman wrote:
> > > From: Amit Shah <amit.shah@redhat.com>
> > > 
> > > Alan pointed out a race in the code where hvc_remove is invoked. The
> > > recent virtio_console work is the first user of hvc_remove().
> > 
> > This causes hangs during boot on pseries machines. Haven't had a chance
> > to track that down yet, but please revert
> > e74d098c66543d0731de62eb747ccd5b636a6f4c for now.
> 
> Linus, any chance you can revert that one for now until we figure out
> what's wrong ?

Ben, can you confirm if the lockup you see is also due to the
task_is_waking() issue I found in a kvm guest?

That'll help me debug the issue.

Thanks.

		Amit
