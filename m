Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Matt Porter" <porter@cox.net>
Cc: "Andrew May" <acmay@acmay.homeip.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: very minor 405GP and 405GPr PCI difference
Date: Mon, 7 Oct 2002 23:19:31 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEPEDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20021008041419.GF32555@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> As Matt says, this would fall out naturally from a better control
> structure.  Howeever, I tend to think that leaving things like this to
> the bootloader/firmware is a bad idea:
>
> The kernel has to know how PCI addresses are mapped anyway, so this
> becomes yet another point at which the kernel and firmware are bound
> together.  Why should the kernel have code to deal with umpteen
> different cases of how PCI might have been set up, or not set up by
> the firmware/bootloader, when it can just take control of the host
> bridge and reprogram it how it wants?  Once the debugging cruft comes
> out, it should only be a couple of hundred bytes of code.

I believe that there are many cases where the kernel code is much too
aggressive with configuration. Personally I believe that all BIOS code
should totally initialize the processor state so you always have a known
starting point. (whether you boot Linux or not) Many times I have had to
track down where the kernel thinks it "knows" the proper configuration and
unravels the work done by the BIOS. I am not sure how to solve this problem
but I believe the kernel should attempt to detect and use a configuration
before reconfiguring any hardware. I have implemented this technique in our
UART and Ethernet configuration stuff on the 8260 with good success.

Only a suggestion...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
