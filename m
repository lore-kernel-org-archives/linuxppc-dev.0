Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9XyY6w79zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 00:10:13 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 19 May 2016 08:10:10 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 848A519D805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 08:09:50 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4JEA7XS41877698
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 14:10:07 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4JEA75Y010078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 10:10:07 -0400
Date: Thu, 19 May 2016 07:10:13 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] rcutorture: Make -soundhw a x86 specific option
Message-ID: <20160519141013.GN3528@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
 <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
 <20160519042309.GA18252@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160519042309.GA18252@x>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 09:23:10PM -0700, Josh Triplett wrote:
> On Thu, May 19, 2016 at 11:42:23AM +0800, Boqun Feng wrote:
> > The option "-soundhw pcspk" gives me a error on PPC as follow:
> > 
> > qemu-system-ppc64: ISA bus not available for pcspk
> > 
> > , which means this option doesn't work on ppc by default. So simply make
> > this an x86-specific option via identify_qemu_args().
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> The emulated system for RCU testing does not need sound hardware at all.
> Paul added this option in commit
> 16c77ea7d0f4a74e49009aa2d26c275f7f93de7c to disable the default sound
> hardware, saying that '"-soundhw pcspk" makes the script a bit less
> dependent on odd audio libraries being installed'.  Unfortunately, it
> looks like there isn't a "-soundhw none".  As far as I can tell,
> currently the only way to completely eliminate sound hardware is to pass
> "-nodefaults" and then explicitly specify each desired device; while
> that would solve the issue, it would likely introduce *more*
> hardware-specific command-line options...
> 
> I've filed two feature requests on upstream qemu to make this simpler:
> https://bugs.launchpad.net/qemu/+bug/1583420 and
> https://bugs.launchpad.net/qemu/+bug/1583421 .
> 
> Paul, what did you mean by "dependent on odd audio libraries"?  Did you
> mean in the guest or the host?  And either way, is this something that
> could potentially be solved another way?

If I remember correctly, Ubuntu 14.04 qemu refused to run the guest
without this option, but I don't recall the exact error message.
I chalked it up to my ignorance of qemu, but I would very much welcome
some way to not have to specify irrelevant hardware.  So thank you very
much for filing the bugs!

								Thanx, Paul
