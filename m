Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id C4D34B7D8E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:10:55 +1100 (EST)
Date: Tue, 9 Feb 2010 22:10:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] of: Introduce safe accessors for node->data
Message-ID: <20100209191053.GA16560@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205043.GB4178@oksana.dev.rtsoft.ru>
	<fa686aa41002090925q30f362d6x4d14894a72439125@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa41002090925q30f362d6x4d14894a72439125@mail.gmail.com>
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2010 at 10:25:22AM -0700, Grant Likely wrote:
> On Fri, Feb 5, 2010 at 1:50 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Platform code use node->data to store some private information
> > associated with a node.
> >
> > Previously there was no need for any locks and accessors since we were
> > initializing the data mostly at boot time and never modified it later.
> >
> > Though, nowadays OF GPIO infrastructure supports GPIO chips detaching,
> > so to handle this correctly we have to introduce locking for the
> > node->data field.
> 
> I'm not convinced this is needed.  What's wrong with using the
> whole-tree devtree_lock?

Why are you concerned? It doesn't add much of any footprint.

$ grep -c { -r arch/powerpc/boot/dts/ | cut -d: -f2 | sort -n | tail -n1
84

So far we have max 84 nodes, so it's a few hundreds of bytes for all
the dev tree.

Anyway, yes, we can use the devtree lock. Though, this will require a
bit more modifications, and I'm not sure if it's a great idea in
general (i.e. using the global lock in contrast to fine grained
locking).

The thing is that you can't use most of the of_ functions when you
hold the devtree lock (IIRC, rwlock has the same restrictions as a
spinlock, so you can't nest these locks).

I can try to rework OF GPIO calls so that they won't require of_
calls when they hold the lock, and let's see how it'll look like.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
