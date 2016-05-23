Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDBKz3LwVzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 07:21:10 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 23 May 2016 15:21:08 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4768A19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 15:20:49 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4NLL6mN35193048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 21:21:06 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4NLL65W023897
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 17:21:06 -0400
Date: Mon, 23 May 2016 14:21:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] rcutorture: Make -soundhw a x86 specific option
Message-ID: <20160523212105.GP3825@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
 <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
 <20160519042309.GA18252@x>
 <20160519141013.GN3528@linux.vnet.ibm.com>
 <20160519154042.GA1049@jtriplet-mobl2.jf.intel.com>
 <20160519162339.GU3528@linux.vnet.ibm.com>
 <20160519193847.GA13746@linux.vnet.ibm.com>
 <20160519202412.GA20469@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519202412.GA20469@cloud>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 01:24:12PM -0700, Josh Triplett wrote:
> On Thu, May 19, 2016 at 12:38:47PM -0700, Paul E. McKenney wrote:
> > On Thu, May 19, 2016 at 09:23:39AM -0700, Paul E. McKenney wrote:
> > > On Thu, May 19, 2016 at 08:40:42AM -0700, Josh Triplett wrote:
> > > > On Thu, May 19, 2016 at 07:10:13AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, May 18, 2016 at 09:23:10PM -0700, Josh Triplett wrote:
> > > > > > On Thu, May 19, 2016 at 11:42:23AM +0800, Boqun Feng wrote:
> > > > > > > The option "-soundhw pcspk" gives me a error on PPC as follow:
> > > > > > > 
> > > > > > > qemu-system-ppc64: ISA bus not available for pcspk
> > > > > > > 
> > > > > > > , which means this option doesn't work on ppc by default. So simply make
> > > > > > > this an x86-specific option via identify_qemu_args().
> > > > > > > 
> > > > > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > > > 
> > > > > > The emulated system for RCU testing does not need sound hardware at all.
> > > > > > Paul added this option in commit
> > > > > > 16c77ea7d0f4a74e49009aa2d26c275f7f93de7c to disable the default sound
> > > > > > hardware, saying that '"-soundhw pcspk" makes the script a bit less
> > > > > > dependent on odd audio libraries being installed'.  Unfortunately, it
> > > > > > looks like there isn't a "-soundhw none".  As far as I can tell,
> > > > > > currently the only way to completely eliminate sound hardware is to pass
> > > > > > "-nodefaults" and then explicitly specify each desired device; while
> > > > > > that would solve the issue, it would likely introduce *more*
> > > > > > hardware-specific command-line options...
> > > > > > 
> > > > > > I've filed two feature requests on upstream qemu to make this simpler:
> > > > > > https://bugs.launchpad.net/qemu/+bug/1583420 and
> > > > > > https://bugs.launchpad.net/qemu/+bug/1583421 .
> > > > > > 
> > > > > > Paul, what did you mean by "dependent on odd audio libraries"?  Did you
> > > > > > mean in the guest or the host?  And either way, is this something that
> > > > > > could potentially be solved another way?
> > > > > 
> > > > > If I remember correctly, Ubuntu 14.04 qemu refused to run the guest
> > > > > without this option, but I don't recall the exact error message.
> > > > > I chalked it up to my ignorance of qemu, but I would very much welcome
> > > > > some way to not have to specify irrelevant hardware.  So thank you very
> > > > > much for filing the bugs!
> > > > 
> > > > According to qemu upstream, qemu doesn't enable any sound hardware by
> > > > default, so I can't think of any obvious reason why adding "-soundhw
> > > > pcspkr" would make the rcutorture VM boot.  Did qemu refuse to run at
> > > > all, or did the VM start but fail during the boot process?
> > > > 
> > > > Could you check if you can currently run without this option?  If so,
> > > > perhaps we should just drop it for now.
> > > 
> > > Will do!  As soon as the current test completes.
> > 
> > And it now works just fine without the "-soundhw pcspkr".  Search me!
> 
> In that case, can you replace the patch in this series making "-soundhw
> pcspkr" target-specific with one removing "-soundhw pcspkr"?

Fair point!  I queued the patch below, and am now testing it.

							Thanx, Paul

------------------------------------------------------------------------

commit d6126c701fe19c965cbb54cd5221da0db3287135
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon May 23 14:18:48 2016 -0700

    rcutorture: Drop "-soundhw pcspkr" from x86 boot arguments
    
    Because recent testing shows that "-soundhw pcspkr" is no longer required
    in the kernel boot arguments, this commit drops this qemu argument.
    
    Reported-by: Josh Triplett <josh@joshtriplett.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 56ac202859eb..1426a9b97494 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -171,7 +171,6 @@ identify_qemu_append () {
 identify_qemu_args () {
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-		echo -soundhw pcspk
 		;;
 	qemu-system-ppc64)
 		echo -enable-kvm -M pseries -nodefaults
