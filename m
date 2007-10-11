Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 99026DDFB7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:54:24 +1000 (EST)
Date: Thu, 11 Oct 2007 00:59:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
Message-ID: <20071011055941.GA1783@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
	<20071010000815.GB7875@lixom.net>
	<20071010101826.186f1f24.sfr@canb.auug.org.au>
	<20071010003824.GA8477@lixom.net>
	<18189.47620.466515.645055@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18189.47620.466515.645055@cargo.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, linuxppc-dev@ozlabs.org,
	tgall.foo@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 03:52:04PM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Don't allow cpu hotplug on systems lacking XICS interrupt controller,
> > since current code is hardcoded for it.
> ...
> > +	for (np = NULL; (np = of_find_node_by_name(np,
> > +						   "interrupt-controller"));) {
> 
> Looks like for_each_node_by_name would be nicer here.
> 
> If you agree, I'll hand-edit your patch to do that and apply it.

Go for it, I just stole that out of the detection code. That
could be changed accordingly as well at some point (I'm guessing
for_each_node_by_name didn't exist when that was written).

> Of course, ultimately we should implement the necessary mpic bits to
> support cpu hotplug.

Yep. I'll leave that to people who have hardware access. :-)


Thanks,

-Olof
