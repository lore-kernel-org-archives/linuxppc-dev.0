Message-ID: <3A54BBE7.27A35C8F@mvista.com>
Date: Thu, 04 Jan 2001 13:07:35 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gary Thomas <gthomas@redhat.com>
CC: Rolf Liu <rolfl@sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: separate kernel as code segment and data segment for linux p
References: <XFMail.20010103201404.gthomas@redhat.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:

> This method is called XIP (for execute in place) and is available on
> some other architectures.  I don't know what it would take for the PPC,

We have it running on a couple of MPC8xx systems.  It requires some
careful memory mapping of the rom and the kernel, but almost no
code changes in the kernel.  Lots of hacking in the vmlinux.lds file :-).
It is only XIP for the kernel, not any applications.

One cool performance hack it allows on the MPC8xx is using a
dedicated 8M TLB entry to map the kernel text, so no TLB misses when
running in the kernel (although, no one should be running in the
kernel anyway :-).

I don't understand the cost tradeoff, but I have been told that in
high volume consumer products that can use a masked rom it is actually
less expensive than RAM.  You can also put lots of the filesystem
in there as well.  In one case it saved just enough ram that the
product didn't have to include the next larger increment.  Pennies
counted.

I have not yet found a way to make this build "automatically".  You
need some addressing knowledge prior to building the kernel, then
some "hand waving" magic you manually code into 'head.S', then you
can make vmlinux.  Once I am able to simply set some configuration
variables and 'make romxip', I'll check it into the mainstream
kernel sources.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
