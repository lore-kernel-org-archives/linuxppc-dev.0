Date: Tue, 1 Oct 2002 10:32:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Location for Linux kernel module support files
Message-ID: <20021001003223.GJ10265@zax>
References: <3D9871CE.7010607@mrsl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D9871CE.7010607@mrsl.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 30, 2002 at 11:46:22AM -0400, Tim Moloney wrote:
>
> I have written a device driver (module) that needs a configuration
> file.  Where is the standard place to put such files?

There isn't.  Device drivers, being part of the kernel, should not be
reading random files from the user's file system.  If the driver needs
configuration, the normal method is for userland scripts (either
startup or hotplug) to issue commands to poke the configuration into
the driver at runtime.

> I originally put it in the same directory as the .o file but
> 'depmod -a' complains that it's not an ELF file.


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
