From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 17:07:08 -0700
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030305000708.GD4683@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com> <20030304230849.GB4683@rover.farnsworth.org> <3E6534FA.9070503@embeddededge.com> <20030304234253.GB17093@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030304234253.GB17093@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 11:42:53PM +0000, Tom Rini wrote:
> Thinking waaaay back, it was probably me doing something wrong. :)

That was my first thought, since prep/head.S starts the kernel at 0xc. :)

> The easy way to verify what really happens is to check out the MP code in
> prep/misc.c.  I would have thought that chrp smp would do the pmac thing
> of calling back to the fw, but I could be wrong here..

prep/misc.c just starts the secondary cpu at 0xc0, __secondary_hold.
It's ok for that to happen before cpu 0 runs the kernel, since
prep/head.S runs it at 0xc.

Pmacs also start the secondary at __secondary_hold, but after cpu 0 is
already running the kernel, so it's not an issue.

It looks to me like all ppc smp systems start their secondary cpus
at __secondary_hold.  (I'd like to know if I'm wrong about that.)
Since __secondary_hold writes to 0x4 and only reads 0x0 looking for
it's cpu id, I still like the "b __start" at 0x0.

Thanks,
-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
