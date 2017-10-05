Return-Path: <dzickus@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Hwd39nrzDr9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 03:17:19 +1100 (AEDT)
Date: Thu, 5 Oct 2017 12:17:14 -0400
From: Don Zickus <dzickus@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Nicholas Piggin <npiggin@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Ulrich Obergfell <uobergfe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 22/29] lockup_detector: Make
 watchdog_nmi_reconfigure() two stage
Message-ID: <20171005161714.nlmmqhrqkqzc3gst@redhat.com>
References: <20170912193654.321505854@linutronix.de>
 <20170912194147.862865570@linutronix.de>
 <87d165dqew.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710030848210.2281@nanos>
 <87o9pocvjq.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1710031411440.2281@nanos>
 <alpine.DEB.2.20.1710031451590.2281@nanos>
 <alpine.DEB.2.20.1710032124320.2278@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1710032124320.2278@nanos>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2017 at 07:27:01PM +0000, Thomas Gleixner wrote:
> On Tue, 3 Oct 2017, Thomas Gleixner wrote:
> > On Tue, 3 Oct 2017, Thomas Gleixner wrote:
> > > On Tue, 3 Oct 2017, Michael Ellerman wrote:
> > > > Hmm, I tried that patch, it makes the warning go away. But then I
> > > > triggered a deliberate hard lockup and got nothing.
> > > > 
> > > > Then I went back to the existing code (in linux-next), and I still get
> > > > no warning from a deliberate hard lockup.
> > > > 
> > > > So seems there may be some more gremlins. Will test more in the morning.
> > > 
> > > Hrm. That's weird. I'll have a look and send a proper patch series on top
> > > of next.
> > 
> > The major difference is that the reworked code utilizes
> > watchdog_nmi_reconfigure() for both init and the sysctl updates, but I
> > can't for my life figure out why that doesn't work.
> 
> I collected the changes which Linus requested along with the nmi_probe()
> one and pushed them into:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/urgent
> 
> That's based on 4.13 final so it neither contains 4.14 nor -next material.

Tested your changes on 4.14-rc3 and it passes my tests.  Thanks!

Tested-and-Reviewed-by: Don Zickus <dzickus@redhat.com>
