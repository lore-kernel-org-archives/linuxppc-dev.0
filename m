Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8D8B0DDF05
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 09:58:12 +1000 (EST)
Date: Tue, 9 Oct 2007 19:03:18 -0500
From: Olof Johansson <olof@lixom.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [stable] [patch 09/12] Fix SMP poweroff hangs
Message-ID: <20071010000318.GA7875@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
Cc: Mark Lord <mlord@pobox.com>, Theodore Ts'o <tytso@mit.edu>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>, Justin Forbes <jmforbes@linuxtx.org>,
	linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Domenico Andreoli <cavokz@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, stable@kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>,
	Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 09, 2007 at 04:27:06PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 10 Oct 2007, Thomas Gleixner wrote:
> > 
> > Wrapping it into a #ifdef CONFIG_X86 would be sufficient.
> 
> Well, the ppc oops seems to be a ppc bug regardless.
> 
> If CPU_HOTPLUG isn't defined, the thing does nothing. And if it is 
> defined, I don't see why/how ppc can validly oops. So I think the first 
> thing to do is to try to figure out why it oopses, not to disable it for 
> ppc.

The machine Paul tried on most likely has MPIC interrupt controller, and
the oops was when the pseries_cpu_disable tried calling XICS code instead.
It's not surprising that it failed, I don't think IBM has (traditionally)
cared about cpu hotplug on those machines.

So the PPC-side fix is to not enable cpu hotplug on mpic-based
systems. I'll follow up with a patch, but I have no way to test it since
I only have one POWER5 machine, no other IBM hardware. I'd appreciate
it if someone with hardware could verify it.


-Olof
