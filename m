Return-Path: <josh@joshtriplett.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:c:538::194])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Zz914nqzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 01:40:52 +1000 (AEST)
Date: Thu, 19 May 2016 08:40:42 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] rcutorture: Make -soundhw a x86 specific option
Message-ID: <20160519154042.GA1049@jtriplet-mobl2.jf.intel.com>
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
 <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
 <20160519042309.GA18252@x>
 <20160519141013.GN3528@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519141013.GN3528@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 07:10:13AM -0700, Paul E. McKenney wrote:
> On Wed, May 18, 2016 at 09:23:10PM -0700, Josh Triplett wrote:
> > On Thu, May 19, 2016 at 11:42:23AM +0800, Boqun Feng wrote:
> > > The option "-soundhw pcspk" gives me a error on PPC as follow:
> > > 
> > > qemu-system-ppc64: ISA bus not available for pcspk
> > > 
> > > , which means this option doesn't work on ppc by default. So simply make
> > > this an x86-specific option via identify_qemu_args().
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > The emulated system for RCU testing does not need sound hardware at all.
> > Paul added this option in commit
> > 16c77ea7d0f4a74e49009aa2d26c275f7f93de7c to disable the default sound
> > hardware, saying that '"-soundhw pcspk" makes the script a bit less
> > dependent on odd audio libraries being installed'.  Unfortunately, it
> > looks like there isn't a "-soundhw none".  As far as I can tell,
> > currently the only way to completely eliminate sound hardware is to pass
> > "-nodefaults" and then explicitly specify each desired device; while
> > that would solve the issue, it would likely introduce *more*
> > hardware-specific command-line options...
> > 
> > I've filed two feature requests on upstream qemu to make this simpler:
> > https://bugs.launchpad.net/qemu/+bug/1583420 and
> > https://bugs.launchpad.net/qemu/+bug/1583421 .
> > 
> > Paul, what did you mean by "dependent on odd audio libraries"?  Did you
> > mean in the guest or the host?  And either way, is this something that
> > could potentially be solved another way?
> 
> If I remember correctly, Ubuntu 14.04 qemu refused to run the guest
> without this option, but I don't recall the exact error message.
> I chalked it up to my ignorance of qemu, but I would very much welcome
> some way to not have to specify irrelevant hardware.  So thank you very
> much for filing the bugs!

According to qemu upstream, qemu doesn't enable any sound hardware by
default, so I can't think of any obvious reason why adding "-soundhw
pcspkr" would make the rcutorture VM boot.  Did qemu refuse to run at
all, or did the VM start but fail during the boot process?

Could you check if you can currently run without this option?  If so,
perhaps we should just drop it for now.

- Josh Triplett
