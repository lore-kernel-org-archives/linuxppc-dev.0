Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE()
Date: Wed, 12 Sep 2007 10:47:04 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<f5fe712aef37d925902f3f6183f024b916cc89db.1189583010.git.michael@ellerman.id.au>
	<1189583353.17835.22.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1189583353.17835.22.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709121047.05471.arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Michael Ellerman wrote:
> On Wed, 2007-09-12 at 17:43 +1000, Michael Ellerman wrote:
> > This patch adds DEFINE_SPUFS_ATTRIBUTE(), a wraper around
> > DEFINE_SIMPLE_ATTRIBUTE which does the specified locking for the get
> > routine for us.
> > 
> > Unfortunately we need two get routines (a locked and unlocked version) to
> > support the coredump code. This patch hides one of those (the locked version)
> > inside the macro foo.

> 
> jk said:
> > "Good god man!"
> 
> Yeah, I'm a bit lukewarm on this one. But the diffstat is nice, 50% code
> reduction ain't bad :)

Have you looked at the change in object code size? I would expect the
object code to actually become bigger. I also think that it hurts
readability rather than help it.

Maybe a better solution is to change the core dump code to not
require the mutex to be held in the first place. By the time
we get to call the get functions, it should already be in
saved state and no longer be able to get scheduled, so we might
not actually need all the extra tricks with avoiding the
mutex to be taken again.

	Arnd <><
