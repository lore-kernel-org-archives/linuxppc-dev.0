Date: Fri, 26 Mar 2004 15:18:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: OpenPIC and the 2.6 kernel
Message-ID: <20040326221820.GA22801@smtp.west.cox.net>
References: <78197CD6-7F72-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78197CD6-7F72-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 26, 2004 at 05:11:02PM -0500, John Whitney wrote:

> I am working on upgrading a board support package from the 2.4.25
> kernel to the 2.6.5, and I noticed that it looks like the OpenPIC
> support has taken a step BACK in the 2.6 kernel.
>
> In the 2.4 tree, openpic_hookup_cascade() exists, allowing non-8259
> cascades to IRQs other than 0.  This seems to be totally missing from
> the 2.6 kernel (82c59 is the ONLY supported cascade type there).  As my
> board uses a custom PLD interrupt controller cascaded to an MPC107,
> this is a problem.
>
> Have I gotten the wrong repository for LinuxPPC 2.6?  I'm using
> ppc.bkbits.net/linuxppc-2.5, which shows up as the 2.6.5-rc1 kernel.
> If not, is there a reason this feature is now missing for the OpenPIC
> driver?

This is intentional behavior.  During 2.5 development, and I think
around when openpic_hookup_cascade() went into 2.4, I asked Paul what he
thought, and he wanted something more robust I believe.  Sadly, nothing
further happened on this front.

Paul, what do you think about re-introducing openpic_hookup_cascade(irq,
name, cascade_fn(pt_regs)) in 2.6?  Or outlining a better way to handle
the problems of aribtrared controllers on OpenPIC irqs (both the custom
board described above, and Sandpoint X2 support) need something along
these lines.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
