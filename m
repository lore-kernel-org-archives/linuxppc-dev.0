Message-ID: <38D6E781.884AA846@embeddededge.com>
Date: Mon, 20 Mar 2000 22:07:45 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>
CC: Steve Rossi <srossi@ccrl.mot.com>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question on QSPAN Driver
References: <NCBBKJKKGDLPHKDPAFFMMEIPCDAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jason Wohlgemuth wrote:

> The way we got the qspan up and running was to check a GPIO pin to see
> whether or not the Qspan was present, inside pci_init or pcibios_init (I did
> this a while ago), and if it was present we intialized the qspan and scanned
> the bus then,

We could (should) probably investigate some other options.  The 8240
Sandpoint had the same challenge, and I followed Cort's example from
the Gemini.....Just do everything in the xxx_pci.c functions.

It used to be the Linux kernel relied heavily on the PCI already
initialized (which is normally OK in a desktop world).  With the number
of "patches" due to desktops not even doing this correctly, I wonder
if we shouldn't find some place to perform this initialization.  The
current "fixup" functions are too late for embedded systems that don't
do anything prior to kernel boot.

I'll experiment with the new Embedded Planet Classic and QSpan II.  If
someone with real PCI knowledge has some suggestions, that would
really help.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
