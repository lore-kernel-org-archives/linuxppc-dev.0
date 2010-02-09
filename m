Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 526E3B7D5D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:14:28 +1100 (EST)
Date: Tue, 9 Feb 2010 22:14:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] of/gpio: Introduce of_put_gpio(), add ref counting
	for OF GPIO chips
Message-ID: <20100209191427.GA18263@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205045.GC4178@oksana.dev.rtsoft.ru>
	<fa686aa41002090928o6911d095ydca1e1e670a0fc22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa41002090928o6911d095ydca1e1e670a0fc22@mail.gmail.com>
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

On Tue, Feb 09, 2010 at 10:28:15AM -0700, Grant Likely wrote:
[...]
> Rather than having a lock at the device tree data pointer level which
> mixes usage with potentially many other drivers; wouldn't it make more
> sense to use a mutex at the of_gc subsystem context?

I don't think so.

of_gc = np->data;
lock(of_gc); (or lock(devtree))
<do something with of_gc>

doesn't provide us what we need, i.e. it doesn't guarantee that
np->data (of_gc) is still alive.

And here:

lock(np->data); (or lock(devtree))
of_gc = np->data;
lock(of_gc);
<do something with of_gc>

The second lock becomes useless (unless you also refcount np->data
usage and can drop the devtree/np->data lock, and grab some other
kind of lock, e.g. mutex, but this is silly).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
