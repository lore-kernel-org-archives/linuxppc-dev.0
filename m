Message-ID: <3A915EEE.664737E1@mvista.com>
Date: Mon, 19 Feb 2001 12:59:10 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
Cc: Subodh Nijsure <SNijsure@SkyStream.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How does one get physical address for iorempped window?
References: <B25E2E5A003CD311B61E00902778AF2A0148B711@SERVER1> <20010218092828.A14685@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> Well, the base problem is that virt_to_*/*_to_virt were only ever
> intended to work on addresses mapped to system RAM.

I know.....But, even for someone like me that works with this
on a nearly daily basis it is sometimes confusing.  It's truly
easy to have one function that can tell you virt/phys/virt mappings,
other OS implementations have done that for years.  If you want
a "fast" RAM only mapping, use __pa()/__va(), they have been around
forever.  The virt_to_*/*_to_virt functions _should_ have become
something more generic, but they are just yet another macro name
for doing the same thing.  Now, we have gone of and created some pci_*
mapping functions, which are not at all useful for highly integrated
processors because their integrated features are not PCI devices.
Yet another set of functions for integrated processors?  I don't think so.

I think that requiring knowledge of the object attributes for a VM or
physical space so you can call the proper mapping or other management
functions is just a poor design.  If you know this information and
wish to take performance enhancement shortcuts, that's fine, but it
shouldn't be required.

I'm working on it........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
