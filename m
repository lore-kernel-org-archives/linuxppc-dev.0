Return-Path: <josh@joshtriplett.org>
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r9J4V3yx7zDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 14:29:30 +1000 (AEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by slow1-d.mail.gandi.net (Postfix) with ESMTP id 695C94B6070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 06:23:27 +0200 (CEST)
Date: Wed, 18 May 2016 21:23:10 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] rcutorture: Make -soundhw a x86 specific option
Message-ID: <20160519042309.GA18252@x>
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
 <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463629344-20471-4-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 11:42:23AM +0800, Boqun Feng wrote:
> The option "-soundhw pcspk" gives me a error on PPC as follow:
> 
> qemu-system-ppc64: ISA bus not available for pcspk
> 
> , which means this option doesn't work on ppc by default. So simply make
> this an x86-specific option via identify_qemu_args().
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

The emulated system for RCU testing does not need sound hardware at all.
Paul added this option in commit
16c77ea7d0f4a74e49009aa2d26c275f7f93de7c to disable the default sound
hardware, saying that '"-soundhw pcspk" makes the script a bit less
dependent on odd audio libraries being installed'.  Unfortunately, it
looks like there isn't a "-soundhw none".  As far as I can tell,
currently the only way to completely eliminate sound hardware is to pass
"-nodefaults" and then explicitly specify each desired device; while
that would solve the issue, it would likely introduce *more*
hardware-specific command-line options...

I've filed two feature requests on upstream qemu to make this simpler:
https://bugs.launchpad.net/qemu/+bug/1583420 and
https://bugs.launchpad.net/qemu/+bug/1583421 .

Paul, what did you mean by "dependent on odd audio libraries"?  Did you
mean in the guest or the host?  And either way, is this something that
could potentially be solved another way?

- Josh Triplett
