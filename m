Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18189.47620.466515.645055@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 15:52:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
In-Reply-To: <20071010003824.GA8477@lixom.net>
References: <20071008180406.052382073@mini.kroah.org>
	<20071008180633.GJ7627@kroah.com>
	<20071009151702.GA19209@lixom.net>
	<20071009222003.GA21228@kroah.com>
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>
	<alpine.LFD.0.999.0710091625520.3838@woody.linux-foundation.org>
	<20071010000815.GB7875@lixom.net>
	<20071010101826.186f1f24.sfr@canb.auug.org.au>
	<20071010003824.GA8477@lixom.net>
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

Olof Johansson writes:

> Don't allow cpu hotplug on systems lacking XICS interrupt controller,
> since current code is hardcoded for it.
...
> +	for (np = NULL; (np = of_find_node_by_name(np,
> +						   "interrupt-controller"));) {

Looks like for_each_node_by_name would be nicer here.

If you agree, I'll hand-edit your patch to do that and apply it.  Of
course, ultimately we should implement the necessary mpic bits to
support cpu hotplug.

Paul.
