Date: Fri, 7 Sep 2001 15:46:14 -0400
From: Armando Di Cianno <armando@nycap.rr.com>
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Cardbus issues on TiBook
Message-Id: <20010907154614.293ee4f7.armando@nycap.rr.com>
In-Reply-To: <3B98F4D4.ACA03465@acm.org>
References: <3B97DA58.6894B342@acm.org>
	<20010906171002.26712d35.armando@nycap.rr.com>
	<3B98F4D4.ACA03465@acm.org>
Reply-To: diciaa@rpi.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__7_Sep_2001_15:46:14_-0400_101d0b88"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Fri__7_Sep_2001_15:46:14_-0400_101d0b88
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Sep 2001 09:24:52 -0700
Ira Weiny <iweiny@acm.org> wrote:

> Well I followed your directions.  Built the pcmcia stuff into the
> kernel, ide-cs as a module.  Got the latests pcmcia 3.1.29 package and
> built it.  And used your address.  This seems to fix the "cat
> /proc/ioports" issue.  But the machine will still lock up and turn off
> when I insert the card.  And XMON reveals I am at the same spot
> (actual_try_to_identyfy).
>
> So my questions to you are:

Firstoff, sorry to anyone on the list dislikes attachments on mailinglists, but others may find it useful as well. (it's only 4.9k gzip'd...)

> 1) could I get your .config file for the kernel.  Maybe I have some
> other thing I am missing.

Sure, enjoy. :-)

> 2) Which Microdrive and PCCard adapter are you using.  I have the 1Gig
> and am using the adapter it came with.  Maybe there is an isuue with the
> adapter I have.

IBM Microdrive (340MB):
- Model: DMDM-10340

PCCard Adaptor (Came with the Microdrive)
- P/N: 31L9315

Also, I do always call my /etc/rc.d script for stopping pcmcia services before I remove the card, but a simple eject command sent to cardmgr should hopefully do it.

When the card is inserted, and services are started, this is what gets reported by dmesg:
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0000, PCI irq58
Socket status: 30000810
cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x800fffff
hde: IBM-DMDM-10340, ATA DISK drive
ide2 at 0x100-0x107,0x10e on irq 58
hde: 700560 sectors (359 MB) w/96KiB Cache, CHS=695/16/63
 hde: hde1
ide_cs: hde: Vcc = 3.3, Vpp = 0.0

Note that Linux Kernel Card Services _can_ work with a different version of the userspace controls, but some version pairs _may not_ function together.  At least, this is what is stated in the PCMCIA package readme. :-)

Also, these are the modules found in memory when the card is happily set up:
Module                  Size  Used by
ide-cs                  3856   1
ds                      8752   1  [ide-cs]
yenta_socket           11088   1
pcmcia_core            43264   0  [ide-cs ds yenta_socket]

I hope all this helps you out.  If any other information is needed, please let me know.

__Armando Di Cianno
diciaa@rpi.edu

--Multipart_Fri__7_Sep_2001_15:46:14_-0400_101d0b88
Content-Type: application/x-gzip;
 name="dot_config-2.4.9-benh0.gz"
Content-Disposition: attachment;
 filename="dot_config-2.4.9-benh0.gz"
Content-Transfer-Encoding: base64

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

--Multipart_Fri__7_Sep_2001_15:46:14_-0400_101d0b88--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
