Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CD32B7CFA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 22:33:47 +1100 (EST)
Date: Wed, 24 Mar 2010 11:37:21 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100324113721.008d343e@lxorguk.ukuu.org.uk>
In-Reply-To: <1269119079.8599.65.camel@pasglop>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Amit Shah <amit.shah@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 21 Mar 2010 08:04:39 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2010-03-19 at 08:18 -0700, Greg Kroah-Hartman wrote:
> > From: Amit Shah <amit.shah@redhat.com>
> > 
> > Alan pointed out a race in the code where hvc_remove is invoked. The
> > recent virtio_console work is the first user of hvc_remove().
> 
> This causes hangs during boot on pseries machines. Haven't had a chance
> to track that down yet, but please revert
> e74d098c66543d0731de62eb747ccd5b636a6f4c for now.

Its an exploitable hole so we should revert both the bug fix *and* the
submission of the virtio console that makes the flaw triggerable, not jus
tthe security fix.

Alan
