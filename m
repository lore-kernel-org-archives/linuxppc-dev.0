Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 648461A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:23:41 +1000 (AEST)
Date: Tue, 14 Jul 2015 14:23:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dwalker@fifo99.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org,
 Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714182336.GB3912@redhat.com>
References: <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
 <20150714154040.GA3912@redhat.com>
 <20150714154833.GA18883@fifo99.com>
 <20150714161612.GH10792@redhat.com>
 <87a8uyoeig.fsf@x220.int.ebiederm.org>
 <20150714172953.GA19135@fifo99.com>
 <20150714175527.GI10792@redhat.com>
 <87si8qmxef.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87si8qmxef.fsf@x220.int.ebiederm.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 14, 2015 at 01:01:12PM -0500, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker@fifo99.com wrote:
> >
> > [..]
> >> > >> > If a machine is failing, there are high chance it can't deliver you the
> >> > >> > notification. Detecting that failure suing some kind of polling mechanism
> >> > >> > might be more reliable. And it will make even kdump mechanism more
> >> > >> > reliable so that it does not have to run panic notifiers after the crash.
> >> > >> 
> >> > >> I think what your suggesting is that my company should change how it's hardware works
> >> > >> and that's not really an option for me. This isn't a simple thing like checking over the
> >> > >> network if the machine is down or not, this is way more complex hardware design.
> >> > >
> >> > > That means you are ready to live with an unreliable design. There might be
> >> > > cases where notifier does not get run properly and you will not do switch
> >> > > despite the fact that OS has failed. I was just trying to nudge you in
> >> > > a direction which could be more reliable mechanism.
> >> > 
> >> > Sigh I see some deep confusion going on here.
> >> > 
> >> > The panic notifiers are just that panic notifiers.  They have not been
> >> > nor should they be tied to kexec.   If those notifiers force a switch
> >> > over of between machines I fail to see why you would care if it was
> >> > kexec or another panic situation that is forcing that switchover.
> >> 
> >> Hidehiro isn't fixing the failover situation on my side, he's fixing register
> >> information collection when crash_kexec_post_notifiers is used.
> >
> > Sure. Given that we have created this new parameter, let us fix it so that
> > we can capture the other cpu register state in crash dump.
> >
> > I am little disappointed that it was not tested well when this parameter was
> > introuced. We should have atleast tested it to the extent to see if there
> > is proper cpu state present for all cpus in the crash dump.
> >
> > At that point of time it looked like a simple modification
> > to allow panic notifiers before crash_kexec().
> 
> Either that or we say no one cares enough, and it known broken so let's
> just revert the fool thing.

Masami, you introduced this option. Are you fine with the revert? Is it
really being used and tested?

> I honestly can't see how to support panic notifiers, before kexec.
> There is no way to tell what is being done and all of the pieces
> including smp_send_stop are known to be buggy.

we should be able to replace smp_send_stop() with what crash_kexec() is
doing to stop the machine? If yes, then it should be fine I guess. This
parameter description clearly says that specify it at your own risk. So
we are not issuing a big support statement for successful kdump after
panic notifiers. If it is something fixable, otherwise user needs
to deal with it.

Thanks
Vivek
